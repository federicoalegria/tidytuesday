# --- TIDYTUESDAY::2024§23 --- #

# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-06-04/readme.md

# Load ----

# packages ----
pacman::p_load(
  data.table,
  janitor,
  skimr,
  tidyverse
)

# data ----
df <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-06-04/cheeses.csv'
  ) |>
  clean_names()
# dictionary
# https://t.ly/XRWHS

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
