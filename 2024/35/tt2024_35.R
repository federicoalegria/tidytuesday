# --- TIDYTUESDAY::2024§35 --- #
# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-08-27/readme.md

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
df0 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-08-27/power_rangers_episodes.csv'
  ) |>
  clean_names()

df1 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-08-27/power_rangers_seasons.csv'
  ) |>
  clean_names()
# dictionary
# https://raw.

# Understand ----

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

df0 |>
  select(
    season_title,
    episode_num,
    imdb_rating
)

# visualise ----

df0 |> 
  ggplot(aes(x = imdb_rating, y = season_title)) +
  geom_boxplot(aes(fill = season_title), alpha = 0.65) +
  labs(
    title = "IMDb rating", 
    subtitle = "Power Rangers by season",
    caption = "
    data pulled from https://t.ly/0ci94 by https://github.com/federicoalegria")
  theme_minimal() +
    theme(
      axis.text.y = element_text(size = 10),
      axis.text.x = element_text(size = 10),
      legend.position = "none")

# rice

# model ----

# Communicate ----
# ...
