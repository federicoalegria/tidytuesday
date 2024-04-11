
# --- TIDYTUESDAY::2024§14 --- #

# https://github.com/rfordatascience/tidytuesday/tree/master/data/2024/...

# Load ----

# packages
pacman::p_load(
  janitor,
  skimr,
  tidylog,
  tidyverse
)

# data
dw <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-04-02/dubois_week10.csv'
  ) |>
  clean_names()
## https://shorturl.at/ :: dictionary (rich)
## https://shorturl.at/ :: dictionary (raw)

# Visualise ----

"#e31b23"
"#000000"
"#00853f"

# waffle




# ...
