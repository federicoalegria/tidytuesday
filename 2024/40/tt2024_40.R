# --- TIDYTUESDAY::2024§40 --- #
# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-10-01/readme.md

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
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-10-01/chess.csv'
  ) |>
  clean_names()
# dictionary
# https://t.ly/F9VqU

# Understand ----

# names
df |> 
  slice(1:3) |> 
  glimpse()

# glimpse & skim
df |>
  glimpse() |>
  skim()

# transform ----

# visualise ----

# raw
# rice

# model ----

# https://www.perplexity.ai/search/what-deos-a-variable-rated-t-f-YxqSRVF1SBqiIhElhuMMIg

# Communicate ----
# ...
