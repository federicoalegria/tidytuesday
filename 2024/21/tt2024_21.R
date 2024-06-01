# --- TIDYTUESDAY::2024§21 --- #

# https://github.com/rfordatascience/tidytuesday/tree/master/data/2024/...

# Load ----

# packages ----
pacman::p_load(
  data.table,
  easystats,
  ggthemes,
  janitor,
  skimr,
  tidyverse
)

# data ----
df <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-05-21/emissions.csv'
  ) |>
  clean_names()
# dictionary
# https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-05-21/readme.md

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

# summarise

df |> 
  group_by(parent_entity) |> 
  summarise(n = n()) |> 
  arrange(desc(n))

df |> 
  group_by(parent_type) |> 
  summarise(n = n()) |> 
  arrange(desc(n))

df |> 
  group_by(commodity) |> 
  summarise(n = n()) |> 
  arrange(desc(n))

df |> 
  group_by(production_unit) |> 
  summarise(n = n()) |> 
  arrange(desc(n))

# Visualise ----

# for quarto slides ----

# vis_01
df |> 
  group_by(commodity) |>
  summarize(
    min_year = min(year),
    max_year = max(year)
  ) |>
  arrange(desc(commodity)) |> 
  ggplot() +
  geom_segment(aes(
    x = min_year,
    xend = max_year,
    y = commodity
  ), color = "#c33027") +
  geom_point(
    aes(x = min_year, y = commodity),
    color = '#c33027',
    alpha = 0.9,
    size = 3.5
  ) +
  geom_text(
    aes(x = min_year, y = commodity, label = min_year),
    size = 4,
    hjust = -0.45,
    vjust = -1.25,
    family = 'Consolas',
    color = '#d3ebe9'
  ) +
  theme_wsj(color = "#081F2D") +
  theme(
    axis.line.x = element_line(colour = "#d3ebe9"),
    axis.text = element_text(family = 'Consolas', colour = "#d3ebe9"),
    axis.ticks = element_line(colour = "#d3ebe9"),
    legend.text = element_text(family = 'Consolas', colour = "#d3ebe9"),
    legend.title = element_text(family = 'Consolas', size = 28, colour = "#d3ebe9"),
    panel.background = element_rect(fill = "#081F2D", colour = "#081F2D"),
    panel.grid.major.y = element_line(colour = "#d3ebe9", linetype = 'dotted'),
    plot.background = element_rect(fill = "#081F2D", colour = "#081F2D"),
    plot.caption = element_text(family = 'Consolas', size = 10, colour = "#d3ebe9"),
    plot.subtitle = element_text(family = 'Consolas', size = 13, colour = "#d3ebe9"),
    plot.title = element_text(size = 28, colour = "#d3ebe9"),
    plot.title.position = 'plot',
  ) +
  xlab("") +
  ylab("") +
  labs(title = "commodities",
       subtitle = " ",
       caption = "tidytuesday 2024§21〔https://〕"
)

# natural gas sounds green right?
# and also young when put in perspective;
# speaking if which

# vis_02
df |> 
  filter(commodity == "Natural Gas") |> 
  ggplot(aes(x = production_value,
             y = total_emissions_mt_co2e)) +
  geom_point() +
  theme_wsj()

# vis_03
df |> 
  ggplot(aes(x = production_value,
             y = total_emissions_mt_co2e)) +
  geom_point() +
  facet_wrap(production_unit ~ .) +
  theme_wsj()

# "Bcf/yr" :: billion cubic feet per year (used for natural gas)
# "Million bbl/yr" :: million barrels per year (used for oil and natural gas liquids)
# "Million tonnes/yr" :: million tonnes per year (used for coal and cement)
# "Million Tonnes CO2" :: million tonnes of CO2 per year (used for cement)

# tab_01
df |> 
  group_by(production_unit) |> 
  summarise(n = n()) |> 
  knitr::kable()

# tab_02
df |> 
  group_by(commodity) |> 
  summarise(n = n()) |> 
  knitr::kable()

# tab_03
df |> 
  group_by(parent_type, commodity) |> 
  summarise(n = n()) |> 
  knitr::kable()

# Communicate ----

# ...

df_lm <- 
  df |> 
  filter(commodity == "Natural Gas")

model <- lm(production_value ~ total_emissions_mt_co2e, data = df_lm)

check_model(model)
