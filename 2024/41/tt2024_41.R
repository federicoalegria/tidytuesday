# --- TIDYTUESDAY::2024§41 --- #
# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-10-08/readme.md

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
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-10-08/most_visited_nps_species_data.csv'
  ) |>
  clean_names()
# dictionary
# https://t.ly/-yW0s

# Understand ----

# names
df |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
df |>
  glimpse() |>
  skim()

df |> 
  filter(category_name == "Reptile") |> 
  drop_na(family) |>
  group_by(family) |>
  summarise(n = n()) |> 
  arrange(desc(n))

# transform ----

# visualise ----

# model ----

# Communicate ----

# ...
