# --- TIDYTUESDAY::2024§32 --- #
# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-08-06/readme.md

# library path
.libPaths(c("~/.R/x86_64-pc-linux-gnu-library/4.4", .libPaths()))

# packages
pacman::p_load(
  data.table,           # https://cran.r-project.org/web/packages/data.table/
  ggforce,              # https://cran.r-project.org/web/packages/ggforce/
  ggstatsplot,          # https://cran.r-project.org/web/packages/ggstatsplot/
  janitor,              # https://cran.r-project.org/web/packages/janitor/
  nortest,              # https://cran.r-project.org/web/packages/nortest/
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

# model ----

df |>
  filter(sport == "Curling") |>
  ggplot(aes(x = height, y = weight, colour = sex)) +
  geom_jitter(alpha = 0.35) +
  geom_smooth(alpha = 0.7, method = 'lm') +
  geom_mark_hull(aes(label = sex)) +
  scale_color_manual(values = c("F" = "#D79921",
                                "M" = "#B16286")) +
  theme_minimal() +
  theme(legend.position = 'none')

# check for normality

## visually
df |>
  filter(sport == "Curling") |>
  ggplot(aes(sample = height)) +
  stat_qq() +
  stat_qq_line() +
  theme_minimal() +
  labs(title = "Q-Q Plot of Height for Curling Athletes",
       x = "Theoretical Quantiles",
       y = "Sample Quantiles")

## analitically
df |> 
  filter(sport == "Curling") |>
  pull(height) |>
  ks.test("pnorm")

# nonparametric way
df |>
  filter(sport == "Curling") |>
  filter(!is.na(height) & !is.na(weight) & !is.na(medal)) |>
  mutate(bmi = weight / ((height / 100) ^ 2)) |>
  select(bmi, medal) |>
  ggbetweenstats(x = medal,
                 y = bmi,
                 type = "nonparametric")

# Communicate ----

# does bmi influence the outcomes?

# ...

