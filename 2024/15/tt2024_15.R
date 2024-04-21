
# --- TIDYTUESDAY::2024§15 --- #

# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-04-09/readme.md

# Replicate ----

# https://github.com/npechl/TidyTuesday/blob/master/R/2024-04-09/2024-04-09_2023_2024_US_Solar_Eclipses.R

# Load ----

# packages ----
pacman::p_load(
  colorspace,                          # functions for transforming between colour spaces and working with colours (https://cran.r-project.org/web/packages/colorspace/index.html)
  data.table,                          # extension of `data.frame` with efficient data manipulation capabilities (https://cran.r-project.org/web/packages/data.table/index.html)
  extrafont,                           # allows the use of additional fonts in R plots (https://cran.r-project.org/web/packages/extrafont/index.html)
  ggtext,                              # enhances text rendering in ggplot2 plots with improved support for formatting and styling (https://cran.r-project.org/web/packages/ggtext/index.html)
  janitor,                             # provides functions for cleaning and tidying datasets (https://cran.r-project.org/web/packages/janitor/index.html)
  leaflet,                             # enables interactive mapping and visualization using the Leaflet JavaScript library (https://cran.r-project.org/web/packages/leaflet/index.html)
  lubridate,                           # facilitates working with dates and times by providing convenient functions for parsing, manipulating, and formatting date-time data (https://cran.r-project.org/web/packages/lubridate/index.html)
  paletteer,                           # offers a collection of colour palettes for use in R graphics (https://cran.r-project.org/web/packages/paletteer/index.html)
  rnaturalearth,                       # provides access to global vector map data from the Natural Earth dataset (https://cran.r-project.org/web/packages/rnaturalearth/index.html)
  rnaturalearthdata,                   # contains the Natural Earth dataset in a convenient format for use with the rnaturalearth package (https://cran.r-project.org/web/packages/rnaturalearthdata/index.html)
  rnaturalearthhires,                  # provides higher resolution (hires) versions of the Natural Earth dataset (https://github.com/ropensci/rnaturalearthhires)
  sf,                                  # provides classes and methods for working with spatial data, using the Simple Features (SF) standard (https://cran.r-project.org/web/packages/sf/index.html)
  skimr,                               # offers functions for generating summary statistics and visualizations of data frame (https://cran.r-project.org/web/packages/skimr/index.html)
  tidylog,                             # enhances logging and messaging in the context of the tidyverse, making it easier to track data manipulation steps (https://cran.r-project.org/web/packages/tidylog/index.html)
  tidyverse                            # loads the tidyverse (https://cran.r-project.org/web/packages/tidyverse/index.html)
)

# data ----
df <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-04-09/eclipse_total_2024.csv'
  ) |>
  clean_names()
## https://shorturl.at/hqsHY :: dictionary (rich)
## https://shorturl.at/vNSX9 :: dictionary (raw)

# Wrangle ----

# eda ----

# names
df |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
df |>
  glimpse() |>
  skim()

# preparation ----

df <-
  df |> melt(id.vars = c("state",
                         "name",
                         "lat",
                         "lon"),       # melt function from the data.table package to reshape the df data frame from wide to long format, keeping the columns "state", "name", "lat", and "lon" as identifier variables and converting all other columns into rows
             var.factor = FALSE)       # ensures that the melted variable is treated as a character vector instead of a factor                            

df$timepoint <-                        # new column `$ timepoint`
  df$value |>
  hms() |>                             # convert the `$ value` to hms format
  as.numeric()                         # and then convert time values to numeric format

df$timepoint2 <-                       # new column `$ timepoint2`
  df$value |> 
  str_sub(1, -4)                       # extracts a substring of each value from the `value` column, it starts from the first character (1) and ends at the fourth character from the end (-4)

# replace original values with a description
df$var <-
  df$var |>
  str_replace_all("eclipse_1",
                  "time at which the moon first contacts the sun") |>
  str_replace_all("eclipse_2", 
                  "time at which the eclipse is at 50%") |>
  str_replace_all("eclipse_3", 
                  "time at which totality begins") |>
  str_replace_all("eclipse_4", 
                  "time at which totality ends") |>
  str_replace_all("eclipse_5",
                  "time at which the eclipse is back to 50%") |>
  str_replace_all("eclipse_6",
                  "time at which the moon last contacts the sun")

# convert the `var` column to a factor with levels based on unique values in the `var` column
df$var <-
  df$var |> 
  factor(levels = df$var |> unique())

# Visualise ----

# raw ----

# clustered map-graph
df |>
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

# non-clustered map
df |>
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

df_sf <-                                                   # convert the dataframe 'df' to an sf object, using 'lon' and 'lat' as coordinates and specifying the CRS as EPSG:4326
  df |>
  st_as_sf(coords = c("lon", "lat"), crs = st_crs(4326)) |>
  st_transform(crs = "+proj=laea +lat_0=45 +lon_0=-100 
               +x_0=0 +y_0=0 +a=6370997 +b=6370997
               +units=m +no_defs")                         # transform the sf object to a new coordinate reference system (CRS)

vis <- 
  ggplot() +
    geom_sf(
    data = world, 
    fill = '#f9fbfe',
    linewidth = .1, 
    color = '#282828'
  ) +                                                     # https://ggplot2.tidyverse.org/reference/ggsf.html
    geom_sf(
    data = lakes, 
    fill = '#282828',
    linewidth = .1,
    color = '#282828'
  ) +                                                      # https://ggplot2.tidyverse.org/reference/ggsf.html
    geom_sf(
    data = df_sf,
    aes(fill = timepoint),
    color = '#282828',
    shape = 21, 
    stroke = .05, 
    size = .5, 
    alpha = .5
  ) +                                                      # https://ggplot2.tidyverse.org/reference/ggsf.html
    scale_fill_stepsn(
      colors = c('#F7F7F7',
                 '#D9F0D3',
                 '#A6DBA0',
                 '#5AAE61',
                 '#1B7837',
                 '#762A83',
                 '#9970AB',
                 '#C2A5CF',
                 '#E7D4E8'),                               # PRGn (colorbrewer) from https://observablehq.com/embed/@neocartocnrs/dicopal-library@981
    labels = c("17:21", 
               "18:03",
               "18:45",
               "19:26",
               "20:08"),                                   # time-stamps labels
      guide = guide_colorbar(
      title = "Timepoint",
      barheight = unit(.5, 'lines'),
      barwidth = unit(16, 'lines')
    )                                                      # https://ggplot2.tidyverse.org/reference/guide_colourbar.html
  ) +
  coord_sf(xlim = c(-20e5, 30e5), 
           ylim = c(-20e5, 10e5)) +
  facet_wrap(
  vars(var), nrow = 3
  ) +
  theme_minimal(base_family = 'Consolas') +
  theme(
    legend.position = 'top',
    legend.title.position = 'top',
    axis.title = element_blank(),
    axis.text = element_blank(),
    panel.spacing = unit(1, 'lines'),
    panel.grid = element_blank(),
    plot.title = element_text(size = 26,
                              family = 'Consolas', 
                              face = 'bold',
                              hjust = .5),
    plot.subtitle = element_markdown(size = 9, 
                                     family = 'Consolas',
                                     margin = margin(b = 11),
                                     hjust = .5),
    plot.caption = element_markdown(size = 6,
                                    family = 'Consolas',
                                    margin = margin(t = 10),
                                    hjust = 0),
    plot.title.position = 'plot',
    plot.caption.position = 'plot',
    plot.background = element_rect(fill = "#f9fbfe", color = NA),
    plot.margin = margin(20, 20, 20, 20)
  ) +                                                      # https://ggplot2.tidyverse.org/reference/theme.html
  labs(
    title = "2024 US Solar Eclipses",
    subtitle = paste0(
      "From the moment the moon makes initial contact with the Sun",
      "in a given location until the final moment of contact,<br>marking the ",
      "end of the **2024 path of totality across the United States**."
    ),
    caption = "tidytuesday 2024§14 [https://shorturl.at/hqsHY]
    forked from [https://shorturl.at/oGLP8]"
)

ggsave(
  plot = vis, filename = "tt2024_15.map.png",
  width = 10, height = 10, units = "in", dpi = 300
)

# Communicate ----

# .for #tidytuesday 2024§15, i forked Nikos Pechlivanis' (@npechl) visualisation. while twisting it to my taste, i learned a thing or two about spatial data. OP: https://twitter.com/npechl/status/1779567698050977924/photo/1; fork: https://github.com/federicoalegria/_tidytuesday/tree/main/2024/15
