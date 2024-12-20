# --- TIDYTUESDAY::2024§48 --- #
# https://github.com/rfordatascience/tidytuesday/blob/main/data/2024/2024-11-26/readme.md

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
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2024/2024-11-26/cbp_resp.csv'
  ) |>
  clean_names()

df01 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2024/2024-11-26/cbp_state.csv'
  ) |>
  clean_names()
# dictionary
# https://t.ly/N_ezB

# Understand ----

# names
df00 |> 
  slice(0) |> 
  glimpse()

df01 |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
df00 |>
  glimpse() |>
  skim()

df01 |>
  glimpse() |>
  skim()

# transform ----

# visualise ----

# model ----

# Communicate ----

# ...
