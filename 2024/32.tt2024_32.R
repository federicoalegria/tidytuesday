# --- TIDYTUESDAY::2024§32 --- #
# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-08-06/readme.md

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
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-08-06/olympics.csv'
  ) |>
  clean_names()
# dictionary
# https://t.ly/5esU-

# Understand ----

# names
df |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
df |>
  glimpse() |>
  skim()

# transform ---

# visualise ----

# raw
# rice

# model ----

# Communicate ----
# ...

df |> 
  filter(sport == "Curling") |>
  ggplot(aes(x = height, y = weight, colour = sex)) +
  geom_point() +
  scale_color_brewer(palette = 'Accent')
