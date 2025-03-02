# --- tidytuesday::2507 --- #
# https://github.com/rfordatascience/tidytuesday/blob/main/data/2025/2025-02-18/readme.md

# lib/path
.libPaths(c("~/.R/x86_64-pc-linux-gnu-library/4.4", .libPaths()))

# packages
pacman::p_load(
  data.table,           # https://cran.r-project.org/web/packages/data.table/
  janitor,              # https://cran.r-project.org/web/packages/janitor/
  leaflet,              # https://cran.r-project.org/web/packages/leaflet/
  skimr,                # https://cran.r-project.org/web/packages/skimr/
  tidytext,             # https://cran.r-project.org/web/packages/tidytext/
  tidyverse             # https://cran.r-project.org/web/packages/tidyverse/
)

# import ----

# data
df <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-02-18/agencies.csv'
  ) |>
  clean_names()
# dictionary
# https://t.ly/NNf46

# understand ----

# names
df |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
df |>
  glimpse() |>
  skim()

# group
df |> 
  group_by(agency_type) |> 
  summarise(n = n())

# visualise ----

# interactive map
df |>
  filter(!is.na(latitude) | !is.na(longitude)) |>
  leaflet() |>
  addTiles() |>
  addProviderTiles("CartoDB.DarkMatter") |>
  addCircleMarkers(
    lng = ~ longitude,
    lat = ~ latitude,
    radius = 0.5,
    clusterOptions = markerClusterOptions(),
    fillOpacity = 0.05
)

# communicate ----

# ...
