
# --- TIDYTUESDAY::2024§10 --- #

# https://github.com/rfordatascience/tidytuesday/tree/master/data/2024/...

# Load ----

# packages
pacman::p_load(
  janitor,
  pointblank,
  skimr,
  tidylog,
  tidyverse
)

# data
tw <- 
  readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-03-05/trashwheel.csv'
  ) |> 
  clean_names()
## https://shorturl.at/abhtw :: dictionary (rich)
## https://shorturl.at/aCE48 :: dictionary (raw)

# Wrangle ----

# eda ----

# names
tw |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
tw |>
  glimpse() |>
  skim()

# Visualise ----

# raw

# rice

# Analyse ----

# unassisted

# pointblank validation

al <- action_levels(warn_at = 0.1, stop_at = 0.2)

agent <-
  create_agent(
    tbl = tw,
    tbl_name = "tw valid",
    label = "VALID-I Example No. 1",
    actions = al
  ) |>
  col_vals_in_set(id, set = c("mister",
                              "professor",
                              "captain",
                              "gwynnda")
  ) |>
  col_is_numeric(columns = c("weight", "volume")) |>
  col_vals_not_equal(columns = c("weight", "volume"), value = 0) |>
  interrogate()

## https://www.youtube.com/watch?v=N9kaAiuAbWo

# Communicate ----

# ...
