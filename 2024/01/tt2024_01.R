
# --- TIDYTUESDAY::2024_01 --- #

# https://github.com/rfordatascience/tidytuesday/tree/master/data/2024
## Bring your own data from 2023!

# Packages ----

pacman::p_load(janitor,
               leaflet,
               skimr,
               tidyverse)

# DATA ----

trials <- read_csv("binder/datasets/csv/trials.csv")
## https://shorturl.at/lwIRU

# CLEAN ----

# EXPLORE ----

# names
trials |>
  slice(0) |>
  glimpse()

# glimpse & skim
trials |>
  glimpse() |>
  skim()

# VISUALISE ----

# Map ----
## https://github.com/rstudio/leaflet.providers

cs01 <- function(tried, deaths) {
  ifelse(tried > deaths, "#909a9b", "#c63d0e")
}

# Clustered map-graph
trials |>
  mutate(deaths = case_when(is.na(deaths) ~ 0,
                            TRUE ~ deaths)) |>
  filter(!is.na(lon) | !is.na(lat)) |>
  leaflet() |>
  addTiles() |>
  addProviderTiles("CartoDB.DarkMatter") |>
  addCircleMarkers(
    lng = ~ lon,
    lat = ~ lat,
    radius = 0.5,
    clusterOptions = markerClusterOptions(),
    color = ~ cs01(tried, deaths),
    fillOpacity = 0.05
)

# Non-clustered map
trials |>
  mutate(deaths = case_when(is.na(deaths) ~ 0,
                            TRUE ~ deaths)) |>
  filter(!is.na(lon) | !is.na(lat)) |>
  leaflet() |>
  addTiles() |>
  addProviderTiles("CartoDB.DarkMatter") |>
  addCircleMarkers(
    lng = ~ lon,
    lat = ~ lat,
    radius = 0.5,
    color = ~ cs01(tried, deaths),
    fillOpacity = 0.05
)

# ... ----