# --- TIDYTUESDAY::2024§23 --- #

# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-06-04/readme.md

# Load ----

# packages ----
pacman::p_load(
  countrycode,
  data.table,
  ggalluvial,
  janitor,
  skimr,
  tidyverse
)

# data ----
df <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-06-04/cheeses.csv'
  ) |>
  clean_names()
# dictionary
# https://t.ly/XRWHS

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

# Visualise ----

# sankey ----
## https://corybrunson.github.io/ggalluvial/articles/ggalluvial.html

# ensure categorical axis

## continents
custom_mapping <- c(
  "England" = "Europe",
  "Middle East" = "Asia",
  "Scotland" = "Europe",
  "Wales" = "Europe"
)

df |>
  mutate(country = str_extract(country, "^[^,]+")) |>
  mutate(continent = recode(
    country,
    !!!custom_mapping,                                               # *
    .default = countrycode(country, "country.name", "continent")
    )
  )
## * splices the named vector so that each element is treated as an individual argument in the recode() function
## https://rdrr.io/github/tidyverse/rlang/f/man/rmd/topic-metaprogramming.Rmd

## continent_milk_color
df |>
  mutate(country = str_extract(country, "^[^,]+")) |>
  mutate(continent = recode(
    country,!!!custom_mapping,
    .default = countrycode(country, "country.name", "continent")
  )) |>
  mutate(milk = str_extract(milk, "^[^,]+")) |>
  mutate(color = str_extract(color, "^[^,]+")) |>
  filter(!milk %in% c("cow", "plant-based")) |>
  mutate(non_vegan = as.numeric(!vegan)) |>
  drop_na(continent, milk, color, non_vegan) |>
  ggplot(aes(
    axis1 = continent,
    axis2 = milk,
    axis3 = color,
    y = non_vegan
  )) +
  geom_alluvium(aes(fill = milk), alpha = 0.9, width = 1 / 12) +
  geom_stratum(width = 1 / 12,
               fill = "#d5ccba",
               color = "#20111b") +
  geom_text(stat = "stratum", aes(label = after_stat(stratum))) +
  scale_x_discrete(limits = c("continent", "milk", "color"),
                   expand = c(0.15, 0.05)) +
  scale_fill_manual(
    values = c(
      "buffalo" = "#be100e",
      "camel" = "#5e5252",
      "goat" = "#97522c",
      "sheep" = "#ffd7b1",
      "water buffalo" = "#426a79"
    )
  ) +
  theme_minimal() +
  labs(title = "alluvial view of cheese", x = " ", y = " ")

## continent_milk_rind
df |>
  mutate(country = str_extract(country, "^[^,]+")) |>
  mutate(continent = recode(
    country,!!!custom_mapping,
    .default = countrycode(country, "country.name", "continent")
  )) |>
  mutate(milk = str_extract(milk, "^[^,]+")) |>
  filter(!milk %in% c("cow", "plant-based")) |>
  mutate(non_vegan = as.numeric(!vegan)) |>
  drop_na(continent, milk, rind, non_vegan) |>
  ggplot(aes(
    axis1 = continent,
    axis2 = milk,
    axis3 = rind,
    y = non_vegan
  )) +
  geom_alluvium(aes(fill = milk), alpha = 0.9, width = 1 / 12) +
  geom_stratum(width = 1 / 12,
               fill = "#d5ccba",
               color = "#20111b") +
  geom_text(stat = "stratum", aes(label = after_stat(stratum))) +
  scale_x_discrete(limits = c("Continent", "Milk", "Rind"),
                   expand = c(0.15, 0.05)) +
  scale_fill_manual(
    values = c(
      "buffalo" = "#be100e",
      "camel" = "#5e5252",
      "goat" = "#97522c",
      "sheep" = "#ffd7b1",
      "water buffalo" = "#426a79"
    )
  ) +
  theme_minimal() +
  labs(title = "alluvial view of cheese", x = " ", y = " ")

## continent_milk_texture
df |>
  mutate(country = str_extract(country, "^[^,]+")) |>
  mutate(continent = recode(
    country,!!!custom_mapping,
    .default = countrycode(country, "country.name", "continent")
  )) |>
  mutate(milk = str_extract(milk, "^[^,]+")) |>
  mutate(texture = str_extract(texture, "^[^,]+")) |>
  filter(!milk %in% c("cow", "plant-based")) |>
  mutate(non_vegan = as.numeric(!vegan)) |>
  drop_na(continent, milk, texture, non_vegan) |>
  ggplot(aes(
    axis1 = continent,
    axis2 = milk,
    axis3 = texture,
    y = non_vegan
  )) +
  geom_alluvium(aes(fill = milk), alpha = 0.9, width = 1 / 12) +
  geom_stratum(width = 1 / 12,
               fill = "#d5ccba",
               color = "#20111b") +
  geom_text(stat = "stratum", aes(label = after_stat(stratum))) +
  scale_x_discrete(limits = c("continent", "milk", "texture"),
                   expand = c(0.15, 0.05)) +
  scale_fill_manual(
    values = c(
      "buffalo" = "#be100e",
      "camel" = "#5e5252",
      "goat" = "#97522c",
      "sheep" = "#ffd7b1",
      "water buffalo" = "#426a79"
    )
  ) +
  theme_minimal() +
  labs(title = "alluvial view of cheese", x = " ", y = " ")

# Communicate ----

# ...

