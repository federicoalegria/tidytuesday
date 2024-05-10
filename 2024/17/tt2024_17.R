# --- TIDYTUESDAY::2024§17 --- #

# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-04-23/readme.md

# Load ----

# packages ----
pacman::p_load(
  data.table,
  ggbump,
  ggdark,
  ggthemes,
  janitor,
  patchwork,
  skimr,
  tidylog,
  tidyverse
)

# data ----
df <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-04-23/outer_space_objects.csv'
  ) |>
  clean_names()
## https://shorturl.at/eiCR5 :: dictionary (rich)
## https://shorturl.at/bAF27 :: dictionary (raw)

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

# raw ----
df |> 
  filter(str_detect(entity, "sat")) |> 
  ggplot(aes(
    x = year,
    y = num_objects,
    colour = entity)
  ) +
  geom_bump() +
  geom_point()

## inspo

## https://github.com/federicoalegria/_tidytuesday/tree/main/2023/45
### https://www.perplexity.ai/search/with-the-following-.gxOa7QySdqrrnw23MFceg

# rice ----

# dark
df |> 
  filter(str_detect(entity, "sat")) |> 
  ggplot(aes(
    x = year,
    y = num_objects,
    colour = entity)
  ) +
  geom_point() +
  geom_bump(linewidth = 0.75) +
  scale_x_continuous(breaks = seq(1965, 2023, 2)) +
  scale_y_continuous(breaks = seq(1:4), 1) +
  coord_cartesian(
    xlim = c(1964, 2024),
    ylim = c(0.5, 5.5),
    expand = TRUE
  ) +
  theme_void(base_size = 13) +
  # theme(legend.position = "none") +
  labs(
    title = " ",
    subtitle = " ",
    caption = " "
  ) +
  scale_colour_manual(
    values = c(
      "#8Be9fd",
      "#bd93f9",
      "#ff79c6",
      "#f8f8f2"
    )
  ) +
  dark_theme_minimal() +
  theme(
    legend.title = element_text(size = 13),
    plot.caption = element_text(size = 10),
    plot.subtitle = element_text(size = 16)
)

# light
df |> 
  filter(str_detect(entity, "sat")) |> 
  ggplot(aes(
    x = year,
    y = num_objects,
    colour = entity)
  ) +
  geom_point() +
  geom_bump(linewidth = 0.75) +
  scale_x_continuous(breaks = seq(1965, 2023, 2)) +
  scale_y_continuous(breaks = seq(1:4), 1) +
  coord_cartesian(
    xlim = c(1964, 2024),
    ylim = c(0.5, 5.5),
    expand = TRUE
  ) +
  theme_void(base_size = 13) +
  # theme(legend.position = "none") +
  labs(
    title = " ",
    subtitle = " ",
    caption = " "
  ) +
  scale_colour_manual(
    values = c(
      "#458588",
      "#b16286",
      "#689d6a",
      "#7c6f64"
    )
  ) +
  theme_wsj() +
  theme(
    legend.title = element_text(size = 13),
    plot.caption = element_text(size = 10),
    plot.subtitle = element_text(size = 16)
)

# further ----

## wtf?
## patrones en la basura :: instituciones privadas de tipo "sat"
