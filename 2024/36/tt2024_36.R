# --- TIDYTUESDAY::2024§36 --- #
# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-09-03/readme.md

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
df_qlsrc <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-09-03/qname_levels_single_response_crosswalk.csv'
  ) |> clean_names()

df_ssq <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-09-03/stackoverflow_survey_questions.csv'
  ) |> clean_names()

df_sssr <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-09-03/stackoverflow_survey_single_response.csv'
  ) |> clean_names()

# dictionary
# https://t.ly/kaRZn

# Understand ----

# names
df_qlsrc |> 
  slice(0) |> 
  glimpse()

df_ssq |> 
  slice(0) |> 
  glimpse()

df_sssr |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
df_qlsrc |>
  glimpse() |>
  skim()

df_ssq |>
  glimpse() |>
  skim()

df_sssr |>
  glimpse() |>
  skim()

# transform ----

# visualise ----

# raw
# rice

# model ----

# Communicate ----
# ...
