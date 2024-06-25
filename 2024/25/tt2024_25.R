# --- TIDYTUESDAY::2024§25 --- #

# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-06-18/readme.md
# https://en.wikipedia.org/wiki/Federal_holidays_in_the_United_States

# Load ----

# packages ----
pacman::p_load(
  ggthemes,
  janitor,
  skimr,
  stopwords,
  textdata,             # https://cran.r-project.org/web/packages/textdata/index.html
  tidytext,
  tidyverse
)

# data ----

fh <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-06-18/federal_holidays.csv'
  ) |>
  clean_names()

pfh <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-06-18/proposed_federal_holidays.csv'
  ) |>
  clean_names()
# dictionary
# https://t.ly/l2Pf9

# Wrangle ----

# eda ----

# names
fh |> 
  slice(1:5) |> 
  glimpse()

# glimpse & skim
fh |>
  glimpse() |>
  skim()

tokenizer
fh |>
  unnest_tokens(output = word,
                input = details) |>
  anti_join(stop_words,
            by = "word") |>
  group_by(word) |>
  summarise(n = n()) |>
  arrange(desc(n))

# Analyse ----

# sentiment ----

# lexicon
get_sentiments('afinn') |> 
  group_by(value) |> 
  summarise(n = n())

# primer
primer <- get_sentiments('afinn')

# plot
fh |>
  unnest_tokens(output = word, input = details) |>
  anti_join(stop_words, by = "word") |>
  inner_join(primer, by = "word") |>
  count(word, value, sort = TRUE) |> 
  ggplot(aes(
    x = reorder(word, n),
    y = value,
    fill = value
  )) +
  geom_col(alpha = 0.85,
           position = 'identity',
           width = 0.5) +
  labs(
    title = "celebration and commemoration",
    subtitle = "a sentiment analysis according to Federal Holidays' details",
    caption = "
    data pulled from https://t.ly/l2Pf9 by https://github.com/federicoalegria",
    x = " ",
    y = " ") +
  lims() +
  scale_fill_gradient2(
    low = "#9d0006",
    mid = "white",
    high = "#79740e",
    midpoint = 0
  ) +
  theme_wsj() +
  theme(
    axis.text.x = element_text(family = 'Roboto', size = 10),
    legend.position = 'none',
    plot.title = element_text(family = 'Roboto', size = 21),
    plot.subtitle = element_text(family = 'Roboto Mono', size = 15),
    plot.caption = element_text(family = 'Roboto Mono', size = 8)) +
  coord_cartesian(ylim = c(-4, 4))
