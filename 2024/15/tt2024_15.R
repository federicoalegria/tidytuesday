
# --- TIDYTUESDAY::2024§15 --- #

# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-04-09/readme.md

# Replicate ----

# https://github.com/npechl/TidyTuesday/blob/master/R/2024-04-09/2024-04-09_2023_2024_US_Solar_Eclipses.R

# Load ----

# packages
pacman::p_load(
  colorspace,
  data.table,
  extrafont,
  ggtext,
  janitor,
  leaflet,
  lubridate,
  rnaturalearth,
  rnaturalearthdata,
  rnaturalearthhires,
  paletteer,
  sf,
  skimr,
  tidylog,
  tidyverse
)

# data
d1 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-04-09/eclipse_total_2024.csv'
  ) |>
  clean_names()
## https://shorturl.at/hqsHY :: dictionary (rich)
## https://shorturl.at/vNSX9 :: dictionary (raw)

# Wrangle ----

d1 <-
  d1 |> melt(id.vars = c("state", "name", "lat", "lon"),
             var.factor = FALSE)

d1$timepoint <- 
  d1$value |> 
  hms() |> 
  as.numeric()

d1$timepoint2 <- 
  d1$value |> 
  str_sub(1, -4)

d1$var <- 
  d1$var |>
  str_replace_all("eclipse_1", "Time at which the moon first contacts the sun in this location") |>
  str_replace_all("eclipse_2", "Time at which the eclipse is at 50% in this location") |>
  str_replace_all("eclipse_3", "Time at which totality begins in this location") |>
  str_replace_all("eclipse_4", "Time at which totality ends in this location") |>
  str_replace_all("eclipse_5", "Time at which the eclipse is back to 50% in this location") |>
  str_replace_all("eclipse_6", "Time at which the moon last contacts the sun in this location")

d1$var <-
  d1$var |> 
  factor(levels = d1$var |> unique())

# eda ----

# names
d1 |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
d1 |>
  glimpse() |>
  skim()

# Visualise ----

# raw ----
# Clustered map-graph
d1 |>
  filter(!is.na(lon) | !is.na(lat)) |>
  leaflet() |>
  addTiles() |>
  addProviderTiles("CartoDB.DarkMatter") |>
  addCircleMarkers(
    lng = ~ lon,
    lat = ~ lat,
    radius = 0.5,
    clusterOptions = markerClusterOptions(),
    fillOpacity = 0.05
)

# Non-clustered map
d1 |>
  filter(!is.na(lon) | !is.na(lat)) |>
  leaflet() |>
  addTiles() |>
  addProviderTiles("CartoDB.DarkMatter") |>
  addCircleMarkers(
    lng = ~ lon,
    lat = ~ lat,
    radius = 0.5,
    fillOpacity = 0.5,                                     # fill opacity
    color = "transparent",                                 # border colour to transparent
    fillColor = "#93003a"                                  # fill colour to desired
)

# rice ----

world <- 
  ne_countries(scale = 'large', returnclass = 'sf') |>     # load the ne_countries dataset with a large scale and return it as an sf object
  st_transform(crs = "+proj=laea +lat_0=45 +lon_0=-100 
               +x_0=0 +y_0=0 +a=6370997 +b=6370997 
               +units=m +no_defs")                         # transform the sf object to a new coordinate reference system (CRS)

lakes <- 
  ne_download(scale = 'large', 
              type = 'lakes',
              category = 'physical',
              returnclass = 'sf') |>                       # download the 'lakes' dataset at a large scale and return it as an sf object
  st_transform(crs = "+proj=laea +lat_0=45 +lon_0=-100
               +x_0=0 +y_0=0 +a=6370997 +b=6370997
               +units=m +no_defs")                         # transform the sf object to a new coordinate reference system (CRS)

d1_sf <-                                                   # convert the dataframe 'd1' to an sf object, using 'lon' and 'lat' as coordinates and specifying the CRS as EPSG:4326
  d1 |>
  st_as_sf(coords = c("lon", "lat"), crs = st_crs(4326)) |>
  st_transform(crs = "+proj=laea +lat_0=45 +lon_0=-100 
               +x_0=0 +y_0=0 +a=6370997 +b=6370997
               +units=m +no_defs")                         # transform the sf object to a new coordinate reference system (CRS)

vis <- 
  ggplot() +
    geom_sf(
    data = world, fill = "#ffffff",
    linewidth = .1, color = "#191919"
  ) +
    geom_sf(
    data = lakes, fill = "#191919",
    linewidth = .1, color = "#191919"
  ) +
    geom_sf(
    data = d1_sf, aes(fill = timepoint), color = "#191919",
    shape = 21, stroke = .05, size = .5, alpha = .5
  ) +
    scale_fill_stepsn(
    colors = c("#762A83",
               "#9970AB",
               "#C2A5CF",
               "#E7D4E8",
               "#F7F7F7",
               "#D9F0D3",
               "#A6DBA0",
               "#5AAE61",
               "#1B7837"),
    labels = c("17:21", "18:03", "18:45", "19:26", "20:08"),
      guide = guide_colorbar(
      title = "Timepoint",
      barheight = unit(.5, "lines"),
      barwidth = unit(16, "lines")
    )
  ) +
  coord_sf(xlim = c(-20e5, 30e5), ylim = c(-20e5, 10e5)) +
  facet_wrap(
  vars(var), nrow = 2
  ) +
  theme_minimal(base_family = 'Consolas') +
  theme(
    legend.position = "top",
    legend.title.position = "top",
    axis.title = element_blank(),
    axis.text = element_blank(),
    panel.spacing = unit(1, "lines"),
    panel.grid = element_blank(),
    plot.title    = element_text(size = 26, family = 'Consolas', face = "bold", hjust = .5),
    plot.subtitle = element_markdown(size = 9, family = 'Consolas', margin = margin(b = 11), hjust = .5),
    plot.caption  = element_markdown(size = 6, family = 'Consolas', margin = margin(t = 10), hjust = 0),
    plot.title.position = "plot",
    plot.caption.position = "plot",
    plot.background = element_rect(fill = "#f9fbfe", color = NA),
    plot.margin = margin(20, 20, 20, 20)
  ) +
  labs(
    title = "2024 US Solar Eclipses",
    subtitle = paste0(
      "From the moment our moon makes initial contact with the Sun",
      "in a given location until the final moment of contact,<br>marking the ",
      "end of the **2024 path of totality across the United States**."
    ),
    caption = "tidytuesday 2024§14 [https://shorturl.at/hqsHY]
    replicated from [https://shorturl.at/oGLP8]"
)

ggsave(
  plot = vis, filename = "tt2024_15.map.png",
  width = 16, height = 10, units = "in", dpi = 600
)

# Communicate ----

# ...

gc()
