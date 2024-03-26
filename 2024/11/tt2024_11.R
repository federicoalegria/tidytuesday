
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
  clean_names()
## https://shorturl.at/ajwDW :: dictionary (rich)
## https://shorturl.at/rBTY3 :: dictionary (raw)

# Wrangle ----

fsp |> 
  rename(fee_description = fiscal_sponsorship_fee_description) |> 
  rename(criteria = eligibility_criteria) |> 
  rename(types = project_types) |> 
  rename(sponsorship_model = fiscal_sponsorship_model) |> 
  glimpse() |>
  skim()

fsp |> 
  rename(criteria = eligibility_criteria) |> 
  filter(str_detect(criteria, pattern = "programming")) |> 
  select(criteria) |> 
  str_view()

# eda ----

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

# Communicate ----

# ...
