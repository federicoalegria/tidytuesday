# --- tidytuesday::2518 --- #
# https://github.com/rfordatascience/tidytuesday/blob/main/data/2025/2025-05-06/readme.md

# library path
.libPaths(c("~/.R/x86_64-pc-linux-gnu-library/4.5", .libPaths()))

# packages
pacman::p_load(
  data.table,           # https://cran.r-project.org/web/packages/data.table/
  janitor,              # https://cran.r-project.org/web/packages/janitor/
  skimr,                # https://cran.r-project.org/web/packages/skimr/
  tidytext,             # https://cran.r-project.org/web/packages/tidytext/
  tidyverse             # https://cran.r-project.org/web/packages/tidyverse/
)

# import
df <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-05-06/nsf_terminations.csv'
  ) |>
  clean_names()
# dictionary
# https://raw.githubusercontent.com/rfordatascience/tidytuesday/refs/heads/main/data/2025/2025-05-06/readme.md

# understand ----

# names
df |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
df |>
  mutate(in_cruz_list = as.character(in_cruz_list)) |> 
  glimpse() |>
  skim()

# tokenize
df |>
  unnest_tokens(output = word, input = abstract) |>
  anti_join(stop_words, by = "word") |>
  group_by(word) |>
  summarise(n = n()) |>
  arrange(desc(n))

# visualise ----

# communicate ----

# ...

df |>
  select(usaspending_obligated) |> 
  drop_na() |> 
  summarise(sum = sum(usaspending_obligated))
