
# --- TIDYTUESDAY::2024§13 --- #

# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-03-26/readme.md

# Load ----

# packages
pacman::p_load(
  gt,
  janitor,
  skimr,
  tidylog,
  tidyverse
)

# data
tr <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-03-26/team-results.csv'
  ) |> 
  clean_names()

pp <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-03-26/public-picks.csv'
  ) |> 
  clean_names()
## https://shorturl.at/akOPR :: dictionary (rich)
## https://shorturl.at/bw357 :: dictionary (raw)

# Wrangle ----

tr |> 
  select(c(2, 7:9, 11:18)) |> 
  arrange(desc(champ))

# eda ----

# names
tr |> 
  slice(1) |> 
  glimpse()

# glimpse & skim
tr |>
  glimpse() |>
  skim()

# Visualise ----

# raw

tr |> 
  select(c(2, 7:9, 11:18)) |> 
  plot()

# rice

# Analyse ----

# unassisted

# assisted

## question
## https://www.perplexity.ai/search/i-have-the-C6Ycn.noR8C.PI5bTuMQBg



# Communicate ----

# ... 

# https://easystats.github.io/performance/
