# --- tidytuesday::2520 --- #
# https://github.com/rfordatascience/tidytuesday/blob/main/data/2025/2025-05-20/readme.md

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
df00 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-05-20/water_quality.csv'
  ) |>
  clean_names()

df01 <- 
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-05-20/weather.csv'
  ) |> 
  clean_names()

# dictionary
# https://raw.githubusercontent.com/rfordatascience/tidytuesday/refs/heads/main/data/2025/2025-05-20/readme.md

# understand ----

# names
df00 |> 
  slice(0) |> 
  glimpse()

df01 |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
df |>
  glimpse() |>
  skim()

# transform ----

# visualise ----

df00 |> 
  filter(enterococci_cfu_100ml >= 1, enterococci_cfu_100ml <= 100) |> 
  ggplot(aes(enterococci_cfu_100ml)) +
  geom_boxplot()

# model ----

# communicate ----

# ...
