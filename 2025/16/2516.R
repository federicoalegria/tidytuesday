# --- tidytuesday::2516 --- #
# https://github.com/rfordatascience/tidytuesday/blob/main/data/2025/2025-04-22/readme.md

# library path
.libPaths(c("~/.R/x86_64-pc-linux-gnu-library/4.5", .libPaths()))

# packages
pacman::p_load(
  data.table,           # https://cran.r-project.org/web/packages/data.table/
  janitor,              # https://cran.r-project.org/web/packages/janitor/
  skimr,                # https://cran.r-project.org/web/packages/skimr/
  tidytext,             # https://cran.r-project.org/web/packages/tidytext/
  tidyverse             # https://cran.r-project.org/web/packages/tidyverse/
)

# import
df0 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-04-22/daily_accidents.csv'
  ) |>
  mutate(date = as.Date(date, format = "%Y-%m-%d")) |> 
  clean_names()

df1 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-04-22/daily_accidents_420.csv'
  ) |>
  mutate(date = as.Date(date, format = "%Y-%m-%d")) |> 
  clean_names()
# dictionary
# https://raw.githubusercontent.com/rfordatascience/tidytuesday/refs/heads/main/data/2025/2025-04-22/readme.md

# understand ----

# names
df0 |> 
  slice(0) |> 
  glimpse()

df1 |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
df0 |>
  glimpse() |>
  skim()

df1 |>
  glimpse() |>
  skim()

# transform ----

# visualise ----

set.seed(420)

df1 |> 
  sample(420, replace = TRUE) |> 
  ggplot(aes(date, fatalities_count)) +
  geom_line()

# model ----

# communicate ----

# ...
