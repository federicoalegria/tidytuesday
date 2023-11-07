
# --- TIDYTUESDAY::2023_44 --- #

# Libraries ----

pacman::p_load(
  ggraph,
  ggthemes,
  glue,
  gt,
  gtExtras,
  igraph,
  janitor,
  skimr,
  tidylog,
  tidytext,
  tidyverse,
  widyr,
  wordcloud2
)

# DATA ----

df <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-10-31/horror_articles.csv'
  ) |> 
  clean_names()

df |> 
  glimpse() |> 
  skim()

# CLEAN ----

# EXPLORE ----

# VISUALISE ----

# barchart of `$rating == true`
df |>
  group_by(rating) |>
  count(rating) |>
  ggplot(aes(
    x = n,
    y = reorder(rating, desc(n)),
    fill = rating == "true"
  )) +
  geom_bar(stat = "identity",
           width = 0.65) +
  scale_fill_manual(values = c("#444444",
                               "#fbd558")) +
  guides(fill = "none") +
  labs(x = "counts",
       y = "",
       title = "spotting stories rated as true") +
  theme_clean(base_size = 14,
              base_family = "mono")

# table of `$author` & `$rating`
df |>
  filter(
    author == "Barbara Mikkelson" | author == "David Mikkelson",
    rating == "true"
  ) |>
  group_by(author, rating) |>
  summarise(n = n()) |>
  adorn_totals(where = "row") |>
  knitr::kable()

# Wordcloud of `$title`
df |>
  filter(
    author == "Barbara Mikkelson" | author == "David Mikkelson",
    rating == "true"
  ) |> 
  unnest_tokens(output = word, input = title) |>
  anti_join(stop_words, by = "word") |>
  filter(str_length(word) >= 2) |>
  group_by(word) |>
  summarise(n = n()) |>
  arrange(desc(n)) |>
  wordcloud2(
    backgroundColor = "#444444",
    color = "#fbd558",
    rotateRatio = 0
  )

# ANALYSE ----

# COMMUNICATE ----

# Assets ----

# for {glue}

count01 <- df |>
  filter(rating == "true") |>
  summarise(count = length(rating))

count02 <- df |>
  filter(
    author == "Barbara Mikkelson" | author == "David Mikkelson",
    rating == "true"
  ) |> 
  summarise(count = length(rating))

# for {{QualCoder}}

# output.txt
sink(file = "/cloud/project/TT2023_44/output.txt")

df |>
  filter(author == "Barbara Mikkelson" |
           author == "David Mikkelson",
         rating == "true") |>
  select(author, rating, title, subtitle, claim) |>
  map(glimpse)

sink(file = NULL)

## output.txt was cleaned in Sublime by using a "Find and Replace" method (ctrl + H)
## for double space strings where "∙∙" was found and replaced with a null character.

# from {{Qualcoder}}
## transform "TT2023_44.qda.frequencies.csv" to a tibble

freq <- tribble(
  ~code, ~total,
  "accidents", 15,
  "vanity", 8,
  "threats", 4,
  "animals", 3,
  "killings", 3,
  "unknown", 3,
  "health", 2,
  "foreignness", 1,
  "poisonings", 1
)

# barplot for frequencies
freq |>
  ggplot(aes(
    x = total,
    y = reorder(code, total),
    fill = code
  )) +
  geom_bar(stat = "identity",
           width = 0.65) +
  guides(fill = "none") +
  scale_fill_manual(
    values = c(
      accidents = "#405946",
      animals = "#fbd558",
      foreignness = "#fbd558",
      health = "#fbd558",
      killings = "#fbd558",
      poisonings = "#fbd558",
      threats = "#fbd558",
      unknown = "#fbd558",
      vanity = "#fbd558"
    )
  ) +
  labs(x = "Counts",
       y = "",
       title = "Frequency") +
  theme_clean(base_size = 14,
              base_family = "mono")

# truncated strings from `claim` for table
df |>
  filter(author == "Barbara Mikkelson" |
           author == "David Mikkelson") |>
  filter(rating == "true") |>
  select(claim) |>
  map( ~ str_trunc(.x, width = 70, side = "right"))

# unused ----

# n-gram

set.seed(8000)

df |>
  filter(
    author == "Barbara Mikkelson" | author == "David Mikkelson",
    rating == "true"
  ) |> 
  slice(sample(5)) |> 
  unnest_tokens(output = word, input = title) |>
  anti_join(stop_words, by = "word") |>
  filter(str_length(word) >= 2) |>
  count(word, sort = TRUE) |>
  pairwise_cor(word, n) |> 
  filter(correlation >= 0.9) |>
  ggraph(layout = "fr") +
  geom_edge_link(aes(edge_alpha = correlation), show.legend = FALSE) +
  geom_node_point(color = "#38761d",
                  size = 5,
                  alpha = 0.5) +
  geom_node_text(aes(label = name), repel = TRUE) +
  theme_minimal()

# ... ----

# sorting stories

df |>
  filter(str_detect(title, 
                    pattern = "(image|Image|photo|Photo|video|Video)")) |> 
  View()