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
  patchwork,            # https://cran.r-project.org/web/packages/patchwork/
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

p1 <- 
  df |>
  filter(sport == "Curling") |>
  ggplot(aes(x = height, y = weight, colour = sex)) +
  geom_jitter(alpha = 0.35) +
  geom_smooth(alpha = 0.7, method = 'lm') +
  geom_mark_hull(aes(label = sex)) +
  scale_color_manual(values = c("F" = "#D79921",
                                "M" = "#B16286")) +
  theme_ggstatsplot() +
  theme(legend.position = 'none') +
  ggtitle("height and weight relationship by sex")

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
p2 <- 
  df |>
  filter(sport == "Curling") |>
  filter(!is.na(height) & !is.na(weight) & !is.na(medal)) |>
  mutate(bmi = weight / ((height / 100) ^ 2)) |>
  select(bmi, medal) |>
  ggbetweenstats(x = medal,
                 y = bmi,
                 type = "nonparametric") +
  ggtitle("bmi according to outcome")

# Communicate ----

p1 + p2 +
  plot_annotation(
    title = "A Curling Overview",
    subtitle = "BMI data from Athens 1896 to Rio 2016
    ",
    caption = "
    data pulled from https://t.ly/5esU- by https://github.com/federicoalegria",
    theme = theme(
      plot.title = element_text(family = 'Roboto', face = 'bold', size = 18),
      plot.subtitle = element_text(family = 'Roboto', size = 15),
      plot.caption = element_text(size = 9, family = 'Mono')
    )
)

# for #tidytuesday 2024§32 i evaluated if body mass index 
# have had an influence on Olympic Curling results
# and there's not enough evidence to conclude it has
# https://github.com/federicoalegria/_tidytuesday/tree/main/2024/32
