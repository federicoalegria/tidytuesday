# --- TIDYTUESDAY::2024§44 --- #
# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-10-29/readme.md

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
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-10-29/monster_movie_genres.csv'
  ) |>
  clean_names()

df01 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-10-29/monster_movies.csv'
  ) |>
  clean_names()
# dictionary
# https://t.ly/4rvTE

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

# group
df01 |> 
  group_by(title_type) |> 
  summarise(n = n())

# transform ----

# visualise ----

df01 |> 
  ggplot(aes(
    x = runtime_minutes, 
    y = average_rating)
  ) + geom_point()

# model ----

# Communicate ----

# ...

# has runtime changed through the years?
# evaluate `runtime_minutes` and `average_rating`
# evaluate `average_rating` and `num_votes`
# evaluate according to `title_type`
