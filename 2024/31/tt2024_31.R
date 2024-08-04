# --- TIDYTUESDAY::2024§31 --- #
# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-07-30/readme.md

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
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-07-30/summer_movie_genres.csv'
  ) |>
  clean_names()

df01 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-07-30/summer_movies.csv'
  ) |>
  clean_names()
# dictionary
# https://t.ly/B2XD8

# Understand ----

# names
df01 |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
df01 |>
  glimpse() |>
  skim()

# group
df00 |>
  group_by(genres) |>
  summarise(n = n()) |> 
  print(n = Inf)

# visualise ----

# raw
df00 |> 
  filter(!is.na(genres)) |> 
  count(genres) |> 
  arrange(desc(n)) |> 
  ggplot(aes(x = reorder(genres, n), y = n)) +
  geom_col(
    position = "identity",
    width = 0.5
  ) +
  coord_flip() +
  labs(x = "genres", y = " ")

# rice

# model ----

# Communicate ----

# ...
