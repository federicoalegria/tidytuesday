# --- TIDYTUESDAY::2024§39 --- #
# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-09-24/readme.md

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
df00 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-09-24/country_results_df.csv'
  ) |>
  clean_names()

df01 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-09-24/individual_results_df.csv'
  ) |>
  clean_names()

df02 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-09-24/timeline_df.csv'
  ) |>
  clean_names()
# dictionary
# https://t.ly/58MTx

dfs <- list(df00, df01, df02)

# Understand ----

# names
lapply(dfs, function(df) {
  df |>
    slice(0) |>
    glimpse()
  }
)

# glimpse & skim
lapply(dfs, function(df) {
  df |>
  glimpse() |>
  skim()
  }
)

# visualise ----

df01 |> 
  filter(
    country %in% c(
      "Costa Rica",
      "El Salvador",
      "Guatemala",
      "Honduras",
      "Nicaragua"
    )
  ) |> 
  select(year, country, total, award) |> 
  group_by(country) |> 
  summarise(total = sum(total)) |> 
  arrange(desc(total)) |> 
  knitr::kable()

# Communicate ----

# |country     | total|
# |:-----------|-----:|
# |Costa Rica  |  1072|
# |El Salvador |   610|
# |Nicaragua   |   249|
# |Honduras    |   184|
# |Guatemala   |   160|
