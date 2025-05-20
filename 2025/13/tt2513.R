# --- tidytuesday::2513 --- #
# https://github.com/rfordatascience/tidytuesday/blob/main/data/2025/2025-04-01/readme.md

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
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-04-01/pokemon_df.csv'
  ) |>
  clean_names()
# dictionary
# https://raw.githubusercontent.com/rfordatascience/tidytuesday/refs/heads/main/data/2025/2025-04-01/readme.md

# understand ----

View(df)

# names
df |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
df |>
  glimpse() |>
  skim()

df |> 
  select(pokemon, height, weight) |> 
  arrange(desc(weight))

# visualise ----

df |> 
  ggplot(aes(x = height, y = weight, color = type_1)) +
  geom_point()

# model ----

df |> 
  ggplot(aes(x = height, y = weight)) +
  geom_point() +
  geom_smooth()

# ...
