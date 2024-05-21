# --- TIDYTUESDAY::2024§19 --- #

# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-05-07/readme.md

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
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-05-07/rolling_stone.csv'
  ) |> 
  clean_names()
# dictionary
# https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-05-07/readme.md

# Wrangle ----

# eda ----

# names
df |> 
  slice(0) |> 
  glimpse()

glimpse & skim
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
### https://g.co/bard/share/
### https://www.perplexity.ai/search/i-have-this-9nsDJ9I.QAOCALk0_yxW5g

# Communicate ----

# ...

df |> 
  filter(clean_name == "Pink Floyd")

df |> 
  filter(str_detect(genre, pattern = "Jazz"))

## ggbump
# terminal :: find . -type f -exec grep -l "ggbump" {} \;
# terminal :: find . -type f -exec grep --color=auto -C 2 "ggbump" {} \;
