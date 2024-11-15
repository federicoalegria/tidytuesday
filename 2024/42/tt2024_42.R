# --- TIDYTUESDAY::2024§42 --- #
# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-10-15/readme.md

# library path
.libPaths(c("~/.R/x86_64-pc-linux-gnu-library/4.4", .libPaths()))

# packages
pacman::p_load(
  data.table,           # https://cran.r-project.org/web/packages/data.table/
  janitor,              # https://cran.r-project.org/web/packages/janitor/
  skimr,                # https://cran.r-project.org/web/packages/skimr/
  styler,               # https://cran.r-project.org/web/packages/styler/
  tidyverse             # https://cran.r-project.org/web/packages/tidyverse/
)

# Import ----
df <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-10-15/orcas.csv'
  ) |>
  clean_names()
# dictionary
# https://t.ly/9AcOx

# Understand ----

# names
df |> 
  slice() |> 
  glimpse()

# glimpse & skim
df |>
  glimpse() |>
  skim()

# tokenize
df |>
  unnest_tokens(output = word, input = encounter_summary) |>
  anti_join(stop_words, by = "word") |>
  group_by(word) |>
  summarise(n = n()) |>
  arrange(desc(n))

# transform ----

df |> 
  select(encounter_summary)

# visualise ----

# model ----

# Communicate ----

# ...
