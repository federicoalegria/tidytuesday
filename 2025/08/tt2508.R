# --- tidytuesday::2508 --- #
# https://github.com/rfordatascience/tidytuesday/blob/main/data/2025/2025-02-25/readme.md

# library path
.libPaths(c("~/.R/x86_64-pc-linux-gnu-library/4.4", .libPaths()))

# packages
pacman::p_load(
  data.table,           # https://cran.r-project.org/web/packages/data.table/
  janitor,              # https://cran.r-project.org/web/packages/janitor/
  skimr,                # https://cran.r-project.org/web/packages/skimr/
  tidytext,             # https://cran.r-project.org/web/packages/tidytext/
  tidyverse             # https://cran.r-project.org/web/packages/tidyverse/
)

# import
df00 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-02-25/article_dat.csv'
  ) |>
  clean_names()

df01 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-02-25/model_dat.csv'
  ) |>
  clean_names()
# dictionary
# https://raw.githubusercontent.com/rfordatascience/tidytuesday/refs/heads/main/data/2025/2025-02-25/readme.md

# understand ----

# names
df |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
df |>
  glimpse() |>
  skim()

# tokenize
df00 |>
  unnest_tokens(output = word, input = variable) |>
  anti_join(stop_words, by = "word") |>
  group_by(word) |>
  summarise(n = n()) |>
  arrange(desc(n))

df01 |>
  unnest_tokens(output = word, input = variable) |>
  anti_join(stop_words, by = "word") |>
  group_by(word) |>
  summarise(n = n()) |>
  arrange(desc(n))

# transform ----

# visualise ----

# model ----

# communicate ----

# ...
