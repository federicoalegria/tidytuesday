# --- TIDYTUESDAY::2024§22 --- #

# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-05-28/readme.md

# Load ----

# packages ----
pacman::p_load(
  data.table,
  gt,
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
  gardenR::garden_coords |> 
  group_by(plot) |> 
  mutate(plot = str_to_lower(plot)) |> 
  summarize(x = mean(x),
            y = mean(y))

# layout
gardenR::garden_coords |>
  group_by(plot) |>
  mutate(plot = str_to_lower(plot)) |>
  mutate(packed = case_when(
    plot == "l" ~ TRUE,
    plot == "p" ~ TRUE,
    plot == "m" ~ TRUE,
    plot == "g" ~ TRUE,
    plot == "h" ~ TRUE,
    TRUE ~ FALSE)
    ) |>
  ggplot(aes(x = x,
             y = y,
             group = plot)) +
  geom_polygon(
    aes(fill = packed),
    color = "#282828",
    linewidth = 0.5,
    show.legend = FALSE
  ) +
  geom_text(
    data = for_labs,
    aes(x = x, y = y, label = plot),
    color = "#ffffff",
    family = 'Consolas',
    fontface = 'bold',
    size = 4.5
  ) +
  annotate(
    'text',
    x = 1,
    y = 37,
    label = "
planted seeds
per plot",
    colour = "#ffffff",
    family = 'Consolas',
    fontface = 2,
    size = 4.5
  ) +
  annotate(
    'text',
    x = 1,
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
    colour = "#ffffff",
    family = 'Consolas'
  ) +
  annotate(
    "text",
    x = 1,
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
    colour = "#ffffff",
    family = 'Consolas'
  ) +
  scale_fill_manual(values = c("FALSE" = "#98971a", "TRUE" = "#8f3f71")) +
  theme_void() +
  theme(panel.background = element_rect(fill = "#282828"))

# Communicate
