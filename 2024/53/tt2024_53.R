# --- TIDYTUESDAY::2024§53 --- #
# https://github.com/rfordatascience/tidytuesday/blob/main/data/2024/2024-12-31/readme.md

# library path
.libPaths(c("~/.R/x86_64-pc-linux-gnu-library/4.4", .libPaths()))

# packages
pacman::p_load(
  data.table,           # https://cran.r-project.org/web/packages/data.table/
  janitor,              # https://cran.r-project.org/web/packages/janitor/
  skimr,                # https://cran.r-project.org/web/packages/skimr/
  styler,               # https://cran.r-project.org/web/packages/styler/
  tidyverse             # https://cran.r-project.org/web/packages/tidyverse/
)

# Import ----
df00 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2024/2024-12-31/book.csv'
  ) |>
  clean_names()

df01 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2024/2024-12-31/broadcast_media.csv'
  ) |>
  clean_names()

df02 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2024/2024-12-31/journalism.csv'
  ) |>
  clean_names()

df03 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2024/2024-12-31/leadership.csv'
  ) |>
  clean_names()

df04 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2024/2024-12-31/restaurant_and_chef.csv'
  ) |>
  clean_names()
# dictionary
# https://t.ly/WrBOn

# Understand ----

# names
df00 |> 
  slice(0) |> 
  glimpse()

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

# glimpse & skim
df04 |>
  glimpse() |>
  skim()

# visualise ----

df04 |> 
  filter(rank == "Winner", year >= 2020) |> 
  select(name, rank, restaurant, year)

# ...
