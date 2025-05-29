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
  filter(!is.na(generation_id)) |> 
  mutate(generation_id = factor(generation_id, levels = unique(generation_id))) |> 
  ggplot(aes(x = height, y = weight, col = generation_id)) +
  geom_point() +
  geom_smooth() +
  facet_wrap(~ generation_id)

df |> 
  slice(1:802) |> 
  mutate(generation = case_when(
    id >= 1 & id <= 152 ~ "generation_01",
    id >= 153 & id <= 251 ~ "generation_02",
    id >= 252 & id <= 386 ~ "generation_03",
    id >= 387 & id <= 493 ~ "generation_04",
    id >= 494 & id <= 649 ~ "generation_05",
    id >= 650 & id <= 721 ~ "generation_06",
    id >= 722 & id <= 802 ~ "generation_07",
    TRUE ~ NA_character_
  ))
