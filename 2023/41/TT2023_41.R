
# --- TIDYTUESDAY::2023_41 --- #

# LIBRARIES ----

pacman::p_load(ggalt,
               ggdark,
               ggraph,
               ggstatsplot,
               gt,
               gtExtras,
               igraph,
               leaflet,
               rcompanion,
               skimr,
               stringr,
               tidytext,
               tidyverse,
               widyr,
               wordcloud2)

# DATA ----

haunted_places <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-10-10/haunted_places.csv'
  )

# CLEAN ----

# EXPLORE ----

# names
haunted_places |>
  slice(0) |>
  glimpse()

# glimpse & skim
haunted_places |>
  glimpse() |>
  skim()

# TRANSFORM ----

# `$region`
haunted_places <- 
  haunted_places |> 
  mutate(region = case_when(
    state %in% c("Michigan", "Pennsylvania", "Ohio", "Indiana", "Illinois", "Wisconsin") ~ "Midwest",
    state %in% c("California", "Oregon", "Washington", "Nevada", "Hawaii", "Alaska") ~ "West",
    state %in% c("New York", "New Jersey", "Connecticut", "Rhode Island", "Massachusetts", "Vermont", "New Hampshire", "Maine", "Pennsylvania") ~ "Northeast",
    state %in% c("Maryland", "Delaware", "Virginia", "West Virginia", "Kentucky", "North Carolina", "South Carolina", "Tennessee", "Georgia", "Florida", "Washington DC", "Arizona", "New Mexico") ~ "South",
    state %in% c("North Dakota", "South Dakota", "Nebraska", "Kansas", "Minnesota", "Iowa", "Missouri", "Montana", "Wyoming", "Colorado", "Utah", "Idaho", "Oklahoma", "Texas", "Arkansas", "Louisiana", "Mississippi", "Alabama") ~ "Central"
    )
  )

haunted_places |> 
  group_by(region) |> 
  summarise(freq = n()) |> 
  mutate(prop = round(freq/sum(freq), 3)) |> 
  knitr::kable()

# `$description_brief`
## undefined
### where `$short_description` would be TRUE for defined phenomena
### and FALSE for undefined
#### defined is understood as ghosts
haunted_places <-
  haunted_places |>
  mutate(
    description_brief =
      str_detect(
        description,
        pattern = "(apparition|banshee|daemon|demon|devil|eidolon|
      ethereal being|ghost|incorporeal being|kelpie|manes|phantasm|phantom|
      poltergeist|revenant|shade|specter|spook|vampire|wraith)"
      ),
    description_brief = ifelse(
      description_brief,
      "Defined", # as ghostly apparitions
      "Not defined" # as ghostly apparitions
    )
  )

# `$location_type`
haunted_places <-
  haunted_places |>
  mutate(location_type = str_split(location, " ") |>  sapply(tail, 1)) |>
  mutate(
    location_type = case_when(
      location_type %in% c("Cemetery", "cemetery") ~ "Cemetery",
      location_type %in% c("Road", "Rd.") ~ "Road",
      location_type %in% c("School", "school", "School)") ~ "School",
      location_type %in% c("Theater", "Theatre") ~ "Theater",
      TRUE ~ location_type
    )
  )

# VISUALISE ----

# Map ----
## https://github.com/rstudio/leaflet.providers

# Clustered map-graph
haunted_places |>
  filter(!is.na(city_latitude) | !is.na(city_longitude)) |>
  leaflet() |>
  addTiles() |>
  addProviderTiles("CartoDB.DarkMatter") |>
  addCircleMarkers(
    lng = ~ city_longitude,
    lat = ~ city_latitude,
    radius = 0.5,
    clusterOptions = markerClusterOptions(),
    fillOpacity = 0.05
  )

# Non-clustered map
haunted_places |>
  filter(!is.na(city_latitude) | !is.na(city_longitude)) |> 
  leaflet() |>
  addTiles() |>
  addProviderTiles("CartoDB.DarkMatter") |>
  addCircleMarkers(
    lng = ~ city_longitude,
    lat = ~ city_latitude,
    radius = 0.5,
    color = c(
      "#606072",
      "#9c305a",
      "#ff7600",
      "#ffa900",
      "#88b969"
    ),
    fillOpacity = 0.05
  )

# Wordcloud of `$description`
haunted_places |>
  select(description) |>
  sample_n(375) |>
  unnest_tokens(output = word, input = description) |>
  anti_join(stop_words, by = "word") |>
  filter(str_length(word) >= 2) |>
  group_by(word) |>
  summarise(n = n()) |>
  arrange(desc(n)) |>
  wordcloud2(
    backgroundColor = "#000000",
    color = "#bac121",
    rotateRatio = 0
  )

# Lollipop of `$description_brief`
haunted_places |>
  group_by(description_brief) |>
  count(description_brief) |>
  ggplot(aes(x = n, y = reorder(description_brief, desc(n)))) +
  geom_lollipop(colour = "#bac121", horizontal = TRUE) +
  geom_text(
    aes(label = n),
    color = "#bac121",
    hjust = -1,
    size = 3.0,
    family = "consolas"
  ) +
  labs(
    title = "Ghostly Apparitions",
    x = " ",
    y = " ",
    caption = "DATA SOURCE {Tidy Tuesday 2023_41}

    https://github.com/rfordatascience/tidytuesday/blob/master/data/2023/2023-10-10/readme.md"
  ) +
  dark_theme_gray() +
  theme(
    plot.margin = margin(20, 35, 20, 35),
    plot.title = element_text(
      colour = "#bac121",
      family = "consolas",
      size = 20
    ),
    axis.text.y = element_text(
      colour = "#bac121",
      family = "consolas",
      size = 10
    ),
    axis.title.x = element_text(
      colour = "#bac121",
      family = "consolas",
      size = 16
    ),
    axis.text.x = element_text(
      colour = "#bac121",
      family = "consolas",
      size = 10
    ),
    plot.caption = element_text(colour = "#bac121", family = "consolas")
  ) +
  scale_x_continuous(limits = c(0, 10000))

# Lollipop of `$location_type`
haunted_places |>
  group_by(location_type) |>
  count(location_type) |>
  arrange(desc(n)) |>
  filter(n >= 58) |>
  ggplot(aes(x = n, y = reorder(location_type, n))) +
  geom_lollipop(colour = "#bac121", horizontal = TRUE) +
  geom_text(
    aes(label = n),
    color = "#bac121",
    hjust = -1,
    size = 3.0,
    family = "consolas"
  ) +
  labs(
    title = "Top 25 Haunted Location Types",
    subtitle = "reported across the US",
    x = " ",
    y = " ",
    caption = "DATA SOURCE {Tidy Tuesday 2023_41}

    https://github.com/rfordatascience/tidytuesday/blob/master/data/2023/2023-10-10/readme.md"
  ) +
  dark_theme_gray() +
  theme(
    plot.margin = margin(20, 35, 20, 35),
    plot.title = element_text(
      colour = "#bac121",
      family = "consolas",
      size = 20
    ),
    plot.subtitle = element_text(
      colour = "#bac121",
      family = "consolas",
      size = 16
    ),
    axis.text.y = element_text(
      colour = "#bac121",
      family = "consolas",
      size = 10
    ),
    axis.text.x = element_text(
      colour = "#bac121",
      family = "consolas",
      size = 10
    ),
    plot.caption = element_text(colour = "#bac121", family = "consolas")
  )  +
  scale_x_continuous(limits = c(0, 1200))

# ANALYSE ----

# facet wrapped barplot for ghostly apparitions
haunted_places |> 
  ggplot(aes(x = region)) +
  geom_bar(fill = "#bac121", width = 0.75) +
  labs(
    title = "Ghostly Apparitions by Region",
    x = " ",
    y = " ",
    caption = "DATA SOURCE {Tidy Tuesday 2023_41}

    https://github.com/rfordatascience/tidytuesday/blob/master/data/2023/2023-10-10/readme.md"
  ) +
  dark_theme_gray() +
  theme(
    plot.margin = margin(20, 35, 20, 35),
    plot.title = element_text(
      colour = "#bac121",
      family = "consolas",
      size = 20
    ),
    plot.subtitle = element_text(
      colour = "#bac121",
      family = "consolas",
      size = 16
    ),
    axis.title.y = element_text(
      colour = "#bac121",
      family = "consolas",
      size = 16
    ),
    axis.text.y = element_text(
      colour = "#bac121",
      family = "consolas",
      size = 10
    ),
    axis.title.x = element_text(
      colour = "#bac121",
      family = "consolas",
      size = 16
    ),
    axis.text.x = element_text(
      colour = "#bac121",
      family = "consolas",
      size = 10
    ),
    plot.caption = element_text(colour = "#bac121", family = "consolas")
  ) +
  facet_wrap( ~ description_brief) +
  coord_flip()

# tab
table(x = haunted_places$description_brief, 
      y = haunted_places$region) |> 
  knitr::kable(caption = "Table 02: Defined and Not defined ghostly apparitions by region")

# chi square test of independence
chisq.test(x = haunted_places$description_brief, 
           y = haunted_places$region)

# rcompanion::cramerV
cramerV(x = haunted_places$description_brief,
        y = haunted_places$region,
        bias.correct = TRUE)

# word correlation graph
haunted_places |>
  select(description) |>
  sample_n(10) |>
  unnest_tokens(output = word, input = description) |>
  anti_join(stop_words, by = "word") |>
  filter(str_length(word) >= 2) |>
  count(word, sort = TRUE) |>
  pairwise_cor(word, n) |>
  filter(correlation > 0.8) |>
  ggraph(layout = "fr") +
  geom_edge_link(aes(edge_alpha = correlation), show.legend = FALSE) +
  geom_node_point(color = "#38761d",
                  size = 5,
                  alpha = 0.5) +
  geom_node_text(aes(label = name), repel = TRUE) +
  theme_minimal()

# COMMUNICATE ----

# ggstatsplot::ggbarstats
## https://indrajeetpatil.github.io/ggstatsplot/articles/web_only/faq.html#how-can-i-modify-the-fill-colors-with-custom-values
haunted_places |> 
  ggbarstats(description_brief, region, type = "nonparametric")

# ... ----

# Assets

# seed for samples
set.seed(8000)

# temp ----
