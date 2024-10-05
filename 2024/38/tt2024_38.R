# --- TIDYTUESDAY::2438 --- #
# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-09-17/readme.md

# lib
.libPaths(c("~/.R/x86_64-pc-linux-gnu-library/4.4", .libPaths()))

# packages
pacman::p_load(
  data.table,           # https://cran.r-project.org/web/packages/data.table/
  ggdark,               # https://cran.r-project.org/web/packages/ggdark/
  janitor,              # https://cran.r-project.org/web/packages/janitor/
  patchwork,            # https://cran.r-project.org/web/packages/patchwork/
  skimr,                # https://cran.r-project.org/web/packages/skimr/
  tidyverse,            # https://cran.r-project.org/web/packages/tidyverse/
  tidytext,             # https://cloud.r-project.org/web/packages/tidytext/
  udpipe                # https://cran.r-project.org/web/packages/udpipe/
)

# Import ----
df_00 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-09-17/hamlet.csv'
  ) |>
  clean_names()

df_01 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-09-17/macbeth.csv'
  ) |>
  clean_names()

df_02 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-09-17/romeo_juliet.csv'
  ) |>
  clean_names()
# dictionary
# https://t.ly/Nc67T

# Understand ----

# names
df_00 |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
df_00 |>
  glimpse() |>
  skim()

# tokenize
# df |>
#   unnest_tokens(output = word, input = variable) |>
#   anti_join(stop_words, by = "word") |>
#   group_by(word) |>
#   summarise(n = n()) |>
#   arrange(desc(n))

# transform ----

df <- 
  bind_rows(
    df_00 |> mutate(play = "Hamlet"),
    df_01 |> mutate(play = "Macbeth"),
    df_02 |> mutate(play = "Romeo and Juliet")
)

df |> 
  glimpse() |> 
  skim()

# visualise ----

# raw
# rice

# model ----

# Communicate ----
# ...
