# --- TIDYTUESDAY::2024§24 --- #

# https://github.com/rfordatascience/tidytuesday/tree/master/data/2024/...

# Load ----

# packages ----
pacman::p_load(
  data.table,
  janitor,
  skimr,
  tidyverse
)

# data ----
df_pi <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-06-11/pride_index.csv'
  ) |>
  clean_names()

df_pit <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-06-11/pride_index_tags.csv'
  ) |>
  clean_names()
# dictionary
# https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-06-11/readme.md

# Wrangle ----

# eda ----

# names
df_pit |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
df_pit |>
  glimpse() |>
  skim()

# Visualise ----

# raw

# rice

# Analyse ----

# ...

# Communicate ----

# ...
