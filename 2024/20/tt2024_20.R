# --- TIDYTUESDAY::2024§20  --- #

# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-05-14/readme.md

# Load ----

# packages ----
pacman::p_load(
  data.table,
  janitor,
  skimr,
  tidylog,
  tidyverse
)

# data ----
df <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-05-14/coffee_survey.csv'
  ) |>
  clean_names()
# dictionary
# https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-05-14/readme.md

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

# Visualise ----

# raw

# rice

# Analyse ----

# unassisted

# assisted

### https://chat.openai.com/share/
### https://gemini.google.com/app/
### https://www.perplexity.ai/share/

# Communicate ----

# ...
