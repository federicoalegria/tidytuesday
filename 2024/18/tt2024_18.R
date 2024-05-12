# --- TIDYTUESDAY::2024§18 --- #

# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-04-30/readme.md

# Load ----

# packages ----
pacman::p_load(
  data.table,
  janitor,
  skimr,
  tidylog,
  tidyverse
)

# data ----
df0 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-04-30/wwbi_data.csv'
  ) |>
  clean_names()

df1 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-04-30/wwbi_series.csv'
  ) |>
  clean_names()

df2 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-04-30/wwbi_country.csv'
  ) |>
  clean_names()

## https://shorturl.at/motC2 :: dictionary (rich)
## https://shorturl.at/nCQR7 :: dictionary (raw)

# Wrangle ----

# eda ----

# names
df |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
df |>
  glimpse() |>
  skim()

# Visualise ----

# raw

# rice

# ...

df2 |>
  select(
    short_name,
    latest_population_census_year
  ) |>
  arrange(latest_population_census_year) |>
  slice(1:11) |>
  knitr::kable()

df2 |>
  select(
    short_name,
    latest_population_census_year
  ) |>
  arrange(desc(latest_population_census_year)) |>
  filter(latest_population_census_year >= 2020) |> 
  knitr::kable()
