
# --- TIDYTUESDAY::2024§11 --- #

# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-03-12/readme.md

# Load ----

# packages
pacman::p_load(
  janitor,
  skimr,
  tidylog,
  tidyverse
)

# data
fsp <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-03-12/fiscal_sponsor_directory.csv'
  ) |>
  clean_names()
## https://shorturl.at/ajwDW :: dictionary (rich)
## https://shorturl.at/rBTY3 :: dictionary (raw)

# Wrangle ----

fsp |> 
  rename(criteria = eligibility_criteria) |> 
  rename(types = project_types) |> 
  glimpse() |>
  skim()

# eda ----

# names
fsp |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
fsp |>
  glimpse() |>
  skim()

# tokenizer
# fsp |>
#   unnest_tokens(output = word, 
#                 input = variable) |>
#   anti_join(stop_words, 
#             by = "word") |>
#   group_by(word) |>
#   summarise(n = n()) |>
#   arrange(desc(n))

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
