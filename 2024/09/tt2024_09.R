
# --- TIDYTUESDAY::2024§W09 --- #

# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-02-27/readme.md

# Load ----

pacman::p_load(
  janitor,
  skimr,
  tidyverse
)

# Data ----

events <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-02-27/events.csv'
  ) |>
  clean_names()

births <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-02-27/births.csv'
  ) |>
  clean_names()

deaths <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-02-27/deaths.csv'
  ) |>
  clean_names()

## https://shorturl.at/qtFK0 :: dictionary (rich)
## https://shorturl.at/mtTV6 :: dictionary (raw)

# WRANGLE ----

# VISUALISE ----

# raw ----

births |> 
  group_by(year_birth) |> 
  summarise(n = n()) |> 
  plot()

deaths |> 
  group_by(year_death) |> 
  summarise(n = n()) |> 
  plot()

vents |>
  select(event) |> 
  str_view_all()

# rice ----

# ANALYSE ----

# COMMUNICATE ----

# . ----

# Assets

# names
df |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
df |>
  glimpse() |>
  skim()

# tokenizer
df |>
  unnest_tokens(output = word, 
                input = variable) |>
  anti_join(stop_words, 
            by = "word") |>
  group_by(word) |>
  summarise(n = n()) |>
  arrange(desc(n))

# --- TIDYTUESDAY::2024§W09 --- #
