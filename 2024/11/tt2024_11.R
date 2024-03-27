
# --- TIDYTUESDAY::2024§11 --- #

# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-03-12/readme.md

# Load ----

# packages
pacman::p_load(
  janitor,
  skimr,
  tidylog,
  tidytext,
  tidyverse
)

# data
fsp <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-03-12/fiscal_sponsor_directory.csv'
  ) |>
  clean_names() |> 
  rename(criteria = eligibility_criteria) |> 
  rename(details = details_url) |>
  rename(fee = fiscal_sponsorship_fee_description) |> 
  rename(model = fiscal_sponsorship_model) |>
  rename(types = project_types) |> 
  rename(year_sponsor = year_fiscal_sponsor)
## https://shorturl.at/ajwDW :: dictionary (rich)
## https://shorturl.at/rBTY3 :: dictionary (raw)

# Wrangle ----

# eda ----

fsp |> 
  filter(str_detect(criteria, pattern = "programming")) |> 
  select(criteria) |> 
  str_view()

# names
fsp |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
fsp |>
  glimpse() |>
  skim()

# tokenizer
fsp |>
  unnest_tokens(output = word,
                input = eligibility_criteria) |>
  anti_join(stop_words,
            by = "word") |>
  group_by(word) |>
  summarise(n = n()) |>
  arrange(desc(n))

# Visualise ----

# Cleveland dotplot
# https://r-graph-gallery.com/303-lollipop-plot-with-2-values.html
# https://www.data-to-viz.com/graph/lollipop.html

fsp |>
  arrange(desc(n_sponsored)) |>
  slice(1:35) |>
  select(name, year_501c3, year_sponsor) |>
  ggplot(y = reorder(name, (name))) +
  geom_segment(aes(
    x = name,
    xend = name,
    y = year_501c3,
    yend = year_sponsor
  ), color = "grey") +
  geom_point(aes(x = name, y = year_501c3),
             color = rgb(0.2, 0.7, 0.1, 0.5),
             size = 3) +
  geom_point(aes(x = name, y = year_sponsor),
             color = rgb(0.7, 0.2, 0.1, 0.5),
             size = 3) +
  coord_flip() +
  theme(legend.position = "none") +
  xlab("") +
  ylab("")

# Communicate ----

# ...
