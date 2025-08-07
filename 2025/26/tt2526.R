# --- tidytuesday::2526 --- #
# https://github.com/rfordatascience/tidytuesday/blob/main/data/2025/2025-07-01/readme.md

# setup ----

# library path
.libPaths(c("~/.R/x86_64-pc-linux-gnu-library/4.5", .libPaths()))

# packages
pacman::p_load(
  data.table, # https://cran.r-project.org/web/packages/data.table/
  httr, # https://cran.r-project.org/web/packages/httr/
  janitor, # https://cran.r-project.org/web/packages/janitor/
  skimr, # https://cran.r-project.org/web/packages/skimr/
  styler, # https://cran.r-project.org/web/packages/styler/
  tidytext, # https://cran.r-project.org/web/packages/tidytext/
  tidyverse # https://cran.r-project.org/web/packages/tidyverse/
)

# load data
df <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-07-01/weekly_gas_prices.csv'
  ) |>
  clean_names()
# dictionary
# https://raw.githubusercontent.com/rfordatascience/tidytuesday/refs/heads/main/data/2025/2025-07-01/readme.md

# understand ----

# names
df |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
df |>
  glimpse() |>
  skim()

# transform ----

# visualise ----

df |>
  filter(fuel == "gasoline" & grade == "all") |>
  group_by(date) |>
  summarise(price = mean(price, na.rm = TRUE), .groups = "drop") |>
  ggplot(aes(date, price)) +
  geom_line() +
  theme_minimal()

# model ----

# communicate ----

# ...
