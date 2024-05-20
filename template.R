# --- TIDYTUESDAY::YYYY§WW --- #

# https://github.com/rfordatascience/tidytuesday/tree/master/data/2024/...

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
    'link.csv'
  ) |>
  clean_names()
# dictionary
# https://raw.

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

# tokenizer
# df |>
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

### https://chat.openai.com/share/
### https://gemini.google.com/app/
### https://www.perplexity.ai/share/

# Communicate ----

# ...
