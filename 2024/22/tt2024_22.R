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

# ... ----

# Visualise

# raw

# rice

# Analyse

# Communicate
