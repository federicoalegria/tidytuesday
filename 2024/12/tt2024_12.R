
# --- TIDYTUESDAY::2024§12 --- #

# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-03-19/readme.md

# Load ----

# packages
pacman::p_load(
  janitor,
  skimr,
  tidylog,
  tidyverse
)

# data
mm <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-03-19/mutant_moneyball.csv'
  ) |>
  clean_names()
## https://shorturl.at/gqxW0 :: dictionary (rich)
## https://shorturl.at/gkzK4 :: dictionary (raw)

# Wrangle ----

# eda ----

# names
mm |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
mm |>
  glimpse() |>
  skim()

# members ~ value
mm |> 
  select(member, total_value_heritage) |> 
  arrange(desc(total_value_heritage)) |> 
  print(n = Inf)

# Visualise ----

# raw

# rice

# Analyse ----

# unassisted

# assisted

## question
## [...]
## question
## [...]
## 
## [---]
### https://chat.openai.com/share/
### https://g.co/bard/share/

# Communicate ----

# ...
