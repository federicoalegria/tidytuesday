# --- tidytuesday::2504 --- #
# https://github.com/rfordatascience/tidytuesday/blob/main/data/2025/2025-01-28/readme.md

# library path
.libPaths(c("~/.R/x86_64-pc-linux-gnu-library/4.4", .libPaths()))

# packages
pacman::p_load(
  data.table,           # https://cran.r-project.org/web/packages/data.table/
  janitor,              # https://cran.r-project.org/web/packages/janitor/
  skimr,                # https://cran.r-project.org/web/packages/skimr/
  tidytext,             # https://cran.r-project.org/web/packages/tidytext/
  tidyverse             # https://cran.r-project.org/web/packages/tidyverse/
)

# import
df00 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-01-28/water_insecurity_2022.csv'
  ) |>
  clean_names()

df01 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-01-28/water_insecurity_2023.csv'
  ) |>
  clean_names()
# dictionary
# https://t.ly/OQPWT

# understand ----

# names
df00 |> 
  slice(1:5) |> 
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

# summarise
df00 |> 
  summarise(
    mean_pop = mean(total_pop, na.rm = TRUE),
    sd_pop = sd(total_pop, na.rm = TRUE),
    mean_plumbing = mean(plumbing, na.rm = TRUE),
    sd_plumbing = sd(plumbing, na.rm = TRUE),
    mean_percent_lacking_plumbing = mean(percent_lacking_plumbing, na.rm = TRUE)
)

df01 |> 
  summarise(
    mean_pop = mean(total_pop, na.rm = TRUE),
    sd_pop = sd(total_pop, na.rm = TRUE),
    mean_plumbing = mean(plumbing, na.rm = TRUE),
    sd_plumbing = sd(plumbing, na.rm = TRUE),
    mean_percent_lacking_plumbing = mean(percent_lacking_plumbing, na.rm = TRUE)
)

# transform ----

# visualise ----

# model ----

# communicate ----

# ...
