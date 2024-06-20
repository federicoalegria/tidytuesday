# --- TIDYTUESDAY::2024§25 --- #

# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-06-18/readme.md
# https://en.wikipedia.org/wiki/Federal_holidays_in_the_United_States

# Load ----

# packages ----
pacman::p_load(
  janitor,
  skimr,
  stopwords,
  tidytext,
  tidyverse
)

# data ----

fh <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-06-18/federal_holidays.csv'
  ) |>
  clean_names()

pfh <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-06-18/proposed_federal_holidays.csv'
  ) |>
  clean_names()

# Wrangle ----

# eda ----

# names
fh |> 
  slice(1:5) |> 
  glimpse()

# glimpse & skim
df |>
  glimpse() |>
  skim()

tokenizer
fh |>
  unnest_tokens(output = word,
                input = details) |>
  anti_join(stop_words,
            by = "word") |>
  group_by(word) |>
  summarise(n = n()) |>
  arrange(desc(n))

# Visualise ----

# raw

# rice

# Analyse ----

# ...

# Communicate ----

# ...
