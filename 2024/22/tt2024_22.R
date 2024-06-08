# --- TIDYTUESDAY::2024§22 --- #

# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-05-28/readme.md

# Load ----

devtools::install_github("llendway/gardenR")

# packages ----
pacman::p_load(
  data.table,
  gardenR,
  janitor,
  skimr,
  tidyverse
)

# data ----

## harvest ----
harvest_2020 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-05-28/harvest_2020.csv'
  ) |>
  clean_names()

harvest_2021 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-05-28/harvest_2021.csv'
  ) |>
  clean_names()

harvest <- bind_rows(harvest_2020, harvest_2021)

## planting ----
planting_2020 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-05-28/planting_2020.csv'
  ) |>
  clean_names()

planting_2021 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-05-28/planting_2021.csv'
  ) |>
  clean_names()

planting <- bind_rows(planting_2020, planting_2021)

## spending ----
spending_2020 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-05-28/spending_2020.csv'
  ) |>
  clean_names()

spending_2021 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-05-28/spending_2021.csv'
  ) |>
  clean_names()

spending <- bind_rows(spending_2020, planting_2021)

# dictionary
# https://t.ly/MR5tc
# rm(harvest_2020, harvest_2021, planting_2020, planting_2021, spending_2020, spending_2021)

# Wrangle ----

# eda ----

# names
harvest |> 
  slice() |> 
  glimpse()

# glimpse & skim
harvest |>
  glimpse() |>
  skim()

## planting ----

## selector
planting |> 
  filter(plot == "H") |> 
  group_by(vegetable) |> 
  summarise(sum(number_seeds_planted))

## function
sbp <- function(data) {
  # unique values by plot
  
  plots <- unique(data$plot)
  # loop through `unique_plots` and summarise by vegetable
  
  for (plot in plots) {
    summary <- data |> 
      filter(plot == !!plot) |> 
      group_by(vegetable) |> 
      summarise(seeds = sum(number_seeds_planted))
  
    # Print the result
    cat("seeds planted in", plot, "\n")
    print(summary)
    cat("\n")
  }
}

sbp(planting)

# Visualise

# how packed are these lots?
planting |> 
  group_by(plot) |> 
  summarise(total = sum(number_seeds_planted)) |> 
  arrange(desc(total))

# spatial ----

# text labels
for_labs <- 
  garden_coords |> 
  group_by(plot) |> 
  mutate(plot = str_to_lower(plot)) |> 
  summarize(x = mean(x),
            y = mean(y))

# layout
garden_coords |>
  group_by(plot) |>
  mutate(plot = str_to_lower(plot)) |>
  ggplot(aes(x = x,
             y = y,
             group = plot)) +
  geom_polygon(
    aes(fill = plot),
    color = "#282828",
    linewidth = 0.5,
    show.legend = FALSE
  ) +
  geom_text(
    data = for_labs,
    aes(x = x, y = y, label = plot),
    color = "#fbf1c7",
    family = 'Consolas',
    fontface = 'bold',
    size = 4.5
  ) +
  annotate(
    'text',
    x = 0.5,
    y = 39,
    label = "
planted seeds
per plot",
colour = "#fbf1c7",
family = 'Consolas',
fontface = 2,
size = 4.5
  ) +
  annotate(
    'text',
    x = 0,
    y = 23.5,
    label = "
l       638
p       569
m       535
g       410
h       375
j       317
c       230
e       191
a       189
b       165
k       102
o        54
d        53
i        50
n        16
f        ——
      ",
colour = "#fbf1c7",
family = 'Consolas'
  ) +
  annotate(
    "text",
    x = 0,
    y = 7.5,
    label = "
pot_b    66
front    45
wagon    40
side     31
pot_d    16
pot_a     6
pot_c     6
      ",
colour = "#fbf1c7",
family = 'Consolas'
  ) +
  scale_fill_manual(values = rep(c("#fb4934", "#83a598", "#b8bb26", "#d3869b", "#fabd2f", "#8ec07c"), length.out = length(unique(garden_coords$plot)))) +
  labs(
    title = "Lisa's garden",
    caption = "data pulled from https://t.ly/MR5tc
    by https://github.com/federicoalegria"
  ) +
  theme_void() +
  theme(
    panel.background = element_rect(fill = "#282828", color = NA),
    plot.background = element_rect(fill = "#282828", color = NA),
    panel.border = element_blank(),
    plot.margin = unit(c(2, 2, 2, 2), "cm"),  # Adjust margins as needed
    plot.title = element_text(family = "Consolas", color = "#fbf1c7", size = 16, face = "bold", hjust = 0.5, vjust = 3),
    plot.caption = element_text(family = "Consolas", color = "#fbf1c7", vjust = -3)
  )

# Communicate

