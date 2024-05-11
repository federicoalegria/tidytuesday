# --- TIDYTUESDAY::2024§17 --- #

# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-04-23/readme.md

# Load ----

# packages ----
pacman::p_load(
  data.table,
  ggbump,
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

df |> 
  filter(str_detect(entity, "sat")) |> 
  ggplot(aes(
    x = year,
    y = num_objects,
    colour = entity)
  ) +
  geom_point() +
  geom_bump(linewidth = 1) +
  scale_x_continuous(breaks = seq(1965, 2023, 2)) +
  scale_y_continuous(breaks = seq(1:4), 1) +
  coord_cartesian(
    xlim = c(1964, 2024),
    ylim = c(0.5, 4),
    expand = TRUE
  ) +
  labs(
    title = "
    annual number of objects launched into space 
    by Arabsat, Eutelsat, Inmarsat and Intelsat",
    subtitle = "
     objects are defined here as satellites, probes, landers, 
     crewed spacecrafts, and space station flight elements 
     launched into Earth orbit or beyond
    ",
    caption = "
    tidytuesday 2024§17〔https://shorturl.at/cfHI0〕"
  ) +
  scale_colour_manual(
    values = c(
      "#ea6962",
      "#d8a657",
      "#458588",
      "#3c3836"
    )
  ) +
  theme_wsj() +
  theme(
    legend.title = element_text(family = 'Consolas', size = 10),
    plot.title = element_text(size = 16),
    plot.title.position = 'plot',
    plot.caption = element_text(size = 10),
    plot.subtitle = element_text(size = 13),
)
