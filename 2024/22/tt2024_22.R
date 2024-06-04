# --- TIDYTUESDAY::2024§22 --- #

# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-05-28/readme.md

# Load ----

# packages ----
pacman::p_load(
  data.table,
  janitor,
  skimr,
  tidyverse
)

# data ----

harvest_2020 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-05-28/harvest_2020.csv'
  ) |>
  clean_names()

harvest_2021 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-05-28/harvest_2021.csv'
  ) |>
  clean_names()

harvest <- bind_rows(harvest_2020, harvest_2021)

planting_2020 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-05-28/planting_2020.csv'
  ) |>
  clean_names()

planting_2021 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-05-28/planting_2021.csv'
  ) |>
  clean_names()

planting <- bind_rows(planting_2020, planting_2021)

spending_2020 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-05-28/spending_2020.csv'
  ) |>
  clean_names()

spending_2021 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-05-28/spending_2021.csv'
  ) |>
  clean_names()

spending <- bind_rows(spending_2020, planting_2021)

rm(harvest_2020, harvest_2021, planting_2020, planting_2021, spending_2020, spending_2021)

# dictionary
# https://t.ly/MR5tc

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

# Analyse ----

# ...

# Communicate ----

# ...
