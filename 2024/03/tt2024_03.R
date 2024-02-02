
# --- TIDYTUESDAY::2024§03 --- #

# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-01-16/readme.md

# Packages ----

pacman::p_load(
  ggthemes,
  janitor,
  skimr,
  tidyverse
)

# DATA ----

pp <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-01-16/polling_places.csv'
  ) |>
  clean_names()
## https://shorturl.at/aBDFV

# EXPLORE ----

# names
pp |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
pp |>
  glimpse() |>
  skim()

pp |> 
  group_by(state) |> 
  summarise(n = n()) |> 
  print(n = 39)

# VISUALISE ----

# Raw ----

# bar plot
pp |> 
  group_by(state) |> 
  ggplot(aes(x = state)) +
  geom_bar()

# Rice ----

# lollipop
pp |>
  group_by(state) |>
  summarise(count = n()) |>
  ggplot(aes(x = state)) +
  geom_segment(aes(
    x = state,
    xend = state,
    y = 0,
    yend = count,
    color = ifelse(count > 20000, "#4d5d53", "#d2691e")
  ),
  linewidth = 2) +
  geom_point(
    aes(
      x = state,
      y = count,
      color = ifelse(count > 20000, "#4d5d53", "#d2691e")
    ),
    alpha = 1,
    shape = 21,
    size = 3,
    stroke = 1,
    fill = "#f8f2e4"
  ) +
  geom_text(
    aes(x = state, y = count, label = count),
    family = "Consolas",
    size = 3,
    vjust = -1.5
  ) +
  scale_color_manual(values = c("#d2691e", "#4d5d53")) +
  theme_wsj() +
  labs(
    title = "US Polling Places",
    subtitle = "2012-2020",
    caption = "tidytuesday 2024§03 [https://shorturl.at/aBDFV]
    NOTE: Some states do not have data in this dataset. Several states (Colorado, Hawaii, Oregon, Washington and Utah)
    vote primarily by mail and have little or no data in this colletion, and others were not available for other reasons.
    "
  ) +
  theme(
    legend.title = element_text(size = 14),
    plot.caption = element_text(size = 10),
    plot.subtitle = element_text(size = 18),
    legend.position = "none"
  ) +
  guides(fill = guide_legend(override.aes = list(size = 5)))

# ... ----

# 20240127
# pp |>
#   select(jurisdiction_type,
#          location_type,
#          notes) |>
#   filter(notes == "CHURCH") |> 
#   glimpse() |>
#   skim()