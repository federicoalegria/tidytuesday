# --- tidytuesday::2533 --- #
# https://github.com/rfordatascience/tidytuesday/blob/main/data/2025/2025-08-19/readme.md

# setup ----

# library path
.libPaths(c("~/.local/share/R/x86_64-pc-linux-gnu-library/4.5", .libPaths()))

# replicate on posit.cloud

# packages
pacman::p_load(
  data.table, # https://cran.r-project.org/web/packages/data.table/
  janitor, # https://cran.r-project.org/web/packages/janitor/
  leaflet, # https://cran.r-project.org/web/packages/leaflet/
  sf, # https://cran.r-project.org/web/packages/sf/
  skimr, # https://cran.r-project.org/web/packages/skimr/
  styler, # https://cran.r-project.org/web/packages/styler/
  tidytext, # https://cran.r-project.org/web/packages/tidytext/
  tidyverse # https://cran.r-project.org/web/packages/tidyverse/
)

# import
df <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-08-19/scottish_munros.csv'
  ) |>
  clean_names()
# dictionary
# https://raw.githubusercontent.com/rfordatascience/tidytuesday/refs/heads/main/data/2025/2025-08-19/readme.md

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

df_clean <- df[!is.na(df$xcoord) & !is.na(df$ycoord), ]

# convert xcoord and ycoord to a spatial object in the British National Grid (OSGB36) projection (EPSG:27700)
sf_data <- st_as_sf(df_clean,
                    coords = c("xcoord", "ycoord"),
                    crs = 27700)

# transform to lat/lon (WGS84 - EPSG:4326)
sf_data_wgs <- st_transform(sf_data, crs = 4326)

# extract latitude and longitude from the transformed object
df_transformed <- st_coordinates(sf_data_wgs) |>
  as.data.frame() |>
  rename(longitude = X, latitude = Y)

# visualise ----

df_transformed |> 
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

# ...
