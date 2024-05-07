# --- TIDYTUESDAY::2024§17 --- #

# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-04-23/readme.md

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
df <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-04-23/outer_space_objects.csv'
  ) |>
  clean_names()
## https://shorturl.at/eiCR5 :: dictionary (rich)
## https://shorturl.at/bAF27 :: dictionary (raw)

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

# inspo

# https://github.com/federicoalegria/_tidytuesday/tree/main/2023/45

# ...

# further

## wtf?
## patrones en la basura
