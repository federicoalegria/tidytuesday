# --- tidytuesday::2519 --- #
# https://github.com/rfordatascience/tidytuesday/blob/main/data/2025/2025-05-13/readme.md

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
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-05-13/vesuvius.csv'
  ) |>
  clean_names()
# dictionary
# https://raw.githubusercontent.com/rfordatascience/tidytuesday/refs/heads/main/data/2025/2025-05-13/readme.md

# understand ----

# names
df |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
df |>
  glimpse() |>
  skim()

# transform ----

# visualise ----

df |> 
  filter(depth_km <= 5.5) |> 
  ggplot(aes(depth_km, duration_magnitude_md)) +
  geom_jitter(alpha = 0.2) +
  geom_smooth(colour = '#689d6a') +
  geom_smooth(colour = '#cc241d', method = 'lm') +
  theme_minimal()

# model ----

# communicate ----

# ...
