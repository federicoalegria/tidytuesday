# --- TIDYTUESDAY::YYYY§WW --- #
# https://github.com/rfordatascience/tidytuesday/tree/master/data/2024/...

# Load ----

.libPaths(c("~/.R/x86_64-pc-linux-gnu-library/4.4", .libPaths()))

# packages ----
pacman::p_load(
  data.table,           # https://cran.r-project.org/web/packages/data.table/
  janitor,              # https://cran.r-project.org/web/packages/janitor/
  skimr,                # https://cran.r-project.org/web/packages/skimr/
  tidyverse             # https://cran.r-project.org/web/packages/tidyverse/
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

# names
df |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
df |>
  glimpse() |>
  skim()

# eda ----

# tokenize ----

# df |>
#   unnest_tokens(output = word, 
#                 input = variable) |>
#   anti_join(stop_words, 
#             by = "word") |>
#   group_by(word) |>
#   summarise(n = n()) |>
#   arrange(desc(n))

# Visualise ----

# raw ----
# rice ----

# Analyse ----

# Communicate ----

# ...
