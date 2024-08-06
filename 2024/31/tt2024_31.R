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
  tidyverse,            # https://cran.r-project.org/web/packages/tidyverse/
  treemap               # https://cran.r-project.org/web/packages/treemap/
)

# Import ----

df00 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-07-30/summer_movie_genres.csv'
  ) |>
  clean_names()
# dictionary
# https://t.ly/B2XD8

# Understand ----

# names
df00 |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
df00 |>
  glimpse() |>
  skim()

# group
df00 |>
  group_by(genres) |>
  summarise(n = n()) |> 
  print(n = Inf)

# visualise ----

# set up the plotting device with desired size
png(
  'binder/selfdev/dslc/tidytuesday/etc/png/2024/tt2024_31.treemap.png',
   width = 800,
   height = 800
)

# treemap
df00 |>
  filter(!is.na(genres)) |> 
  group_by(genres) |>
  summarise(n = n()) |>
  arrange(desc(n)) |>
  filter(n >= 30) |>
  mutate(label = paste(genres, n, sep = "\n")) |>
  treemap(
    index = "label",
    vSize = "n",
    type = "index",
    palette = "RdYlBu",
    title = "top genres for watching summer films",
    fontsize.title = 23,
    fontfamily.title = "sans bold",
    fontsize.labels = 18,
    fontfamily.labels = "mono"
)

# close the plotting device
dev.off()

# model ----

# Communicate ----

# ...
