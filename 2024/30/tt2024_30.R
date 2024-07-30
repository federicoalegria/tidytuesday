# --- TIDYTUESDAY::2024§30 --- #
# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-07-23/readme.md

# Load ----

.libPaths(c("~/.R/x86_64-pc-linux-gnu-library/4.4", .libPaths()))

# packages ----
pacman::p_load(
  data.table,           # https://cran.r-project.org/web/packages/data.table/
  janitor,              # https://cran.r-project.org/web/packages/janitor/
  skimr,                # https://cran.r-project.org/web/packages/skimr/
  styler,                # https://cran.r-project.org/web/packages/styler/
  tidyverse             # https://cran.r-project.org/web/packages/tidyverse/
)

# data ----
# auditions
df01 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-07-23/auditions.csv'
  ) |>
  clean_names()

# eliminations
df02 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-07-23/eliminations.csv'
  ) |>
  clean_names()

# finalists
df03 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-07-23/finalists.csv'
  ) |>
  clean_names()

# ratings
df04 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-07-23/ratings.csv'
  ) |>
  clean_names()

# seasons
df05 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-07-23/seasons.csv'
  ) |>
  clean_names()

# songs
df06 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-07-23/songs.csv'
  ) |>
  clean_names()
# dictionary
# https://t.ly/ObBpl

# Wrangle ----

# names
df01 |>
  slice(0) |> 
  glimpse()

df02 |>
  slice(0) |> 
  glimpse()

df03 |>
  slice(0) |> 
  glimpse()

df04 |>
  slice(0) |> 
  glimpse()

df05 |>
  slice(0) |> 
  glimpse()

df06 |>
  slice(0) |> 
  glimpse()

# glimpse & skim
df01 |>
  glimpse() |>
  skim()

df02 |>
  glimpse() |>
  skim()

df03 |>
  glimpse() |>
  skim()

df04 |>
  glimpse() |>
  skim()

df05 |>
  glimpse() |>
  skim()

df06 |>
  glimpse() |>
  skim()

# eda ----

# Visualise ----

# raw ----

plot(df04$viewers_in_millions, df04$x18_49_rating_share)

# rice ----

# Analyse ----

# Communicate ----

# ...
