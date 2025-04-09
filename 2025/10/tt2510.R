# --- tidytuesday::2510 --- #
# https://github.com/rfordatascience/tidytuesday/blob/main/data/2025/2025-03-11/readme.md

# library path
.libPaths(c("~/.R/x86_64-pc-linux-gnu-library/4.4", .libPaths()))

# packages
pacman::p_load(
  data.table,           # https://cran.r-project.org/web/packages/data.table/
  janitor,              # https://cran.r-project.org/web/packages/janitor/
  patchwork,            # https://cran.r-project.org/web/packages/patchwork/
  skimr,                # https://cran.r-project.org/web/packages/skimr/
  tidytext,             # https://cran.r-project.org/web/packages/tidytext/
  tidyverse             # https://cran.r-project.org/web/packages/tidyverse/
)

# import
df00 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-03-11/pixar_films.csv'
  ) |>
  clean_names()

df01 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-03-11/public_response.csv'
  ) |>
  clean_names()
# dictionary
# https://raw.githubusercontent.com/rfordatascience/tidytuesday/refs/heads/main/data/2025/2025-03-11/readme.md

# understand ----

# names
df01 |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
df01 |>
  glimpse() |>
  skim()

# transform ----

df01 |> 
  select(where(is.integer)) |>
    pivot_longer(
      cols = everything(),
      names_to = "critic",
      values_to = "value"
    )

# visualise ----

df01 |> 
  select(where(is.integer)) |>
    pivot_longer(
      cols = everything(),
      names_to = "critic",
      values_to = "value"
    ) |> 
  drop_na(value) |> 
  ggplot(aes(x = value, color = critic)) +
  geom_density()

# model ----

# communicate ----

# ...
