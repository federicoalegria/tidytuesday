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
  filter(sport == "Curling") |>
  slice(0) |> 
  glimpse()

# glimpse & skim
df |>
  filter(sport == "Curling") |>
  glimpse() |>
  skim()

# visualise ----

# raw

## violin plot
df |> 
  filter(!is.na(height) & !is.na(weight) & !is.na(medal)) |>         # filter na values
  mutate(bmi = weight / ((height / 100) ^ 2)) |>     # calculate bmi
  select(bmi, medal) |> 
  ggplot(aes(x = medal, y = bmi)) +
  geom_violin()

# model ----

## scatter plot
df |> 
  filter(sport == "Curling") |>
  ggplot(aes(x = height, y = weight, colour = sex)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  scale_color_brewer(palette = 'Accent')

# Communicate ----

# ...

# does bmi influence the outcomes?
