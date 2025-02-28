# --- tidytuesday::2505 --- #
# https://github.com/rfordatascience/tidytuesday/blob/main/data/2025/2025-02-04/readme.md

# lib/path
.libPaths(c("~/.R/x86_64-pc-linux-gnu-library/4.4", .libPaths()))

# packages
pacman::p_load(
  data.table,           # https://cran.r-project.org/web/packages/data.table/
  janitor,              # https://cran.r-project.org/web/packages/janitor/
  skimr,                # https://cran.r-project.org/web/packages/skimr/
  tidytext,             # https://cran.r-project.org/web/packages/tidytext/
  tidyverse             # https://cran.r-project.org/web/packages/tidyverse/
)

# import ----

# data
df00 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-02-04/simpsons_characters.csv'
  ) |>
  clean_names()

df01 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-02-04/simpsons_episodes.csv'
  ) |>
  clean_names()

df02 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-02-04/simpsons_locations.csv'
  ) |>
  clean_names()

df03 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-02-04/simpsons_script_lines.csv'
  ) |>
  clean_names()
# dictionary
# https://t.ly/iJOai

# understand ----

# names
df |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
df00 |>
  glimpse() |>
  skim()

df01|>
  glimpse() |>
  skim()

df02|>
  glimpse() |>
  skim()

df03|>
  glimpse() |>
  skim()

# transform ----

# visualise ----

df01 |> 
  ggplot(aes(x = imdb_rating, y = us_viewers_in_millions)) +
  geom_point() +
  geom_smooth()

# model ----

# communicate ----

# ...
