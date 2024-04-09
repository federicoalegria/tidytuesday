
# --- TIDYTUESDAY::2024§13 --- #

# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-03-26/readme.md

# Load ----

# packages
pacman::p_load(
  # easystats,
  gt,
  ggradar,                                                 # https://github.com/ricardo-bion/ggradar
  janitor,
  scales,
  skimr,
  tidylog,
  tidyverse
)

# data
tr <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-03-26/team-results.csv'
  ) |> 
  clean_names()

pp <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-03-26/public-picks.csv'
  ) |> 
  clean_names()
## https://shorturl.at/akOPR :: dictionary (rich)
## https://shorturl.at/bw357 :: dictionary (raw)

# Wrangle ----

# eda ----

# names
tr |> 
  slice(1:5) |> 
  glimpse()

# glimpse & skim
tr |>
  glimpse() |>
  skim()

# hands-on ----

tr |> 
  select(c(2, 7:9, 13:17)) |>                              # `games`, `w`, `l`, `s16m`, `e8`, `f4`, `f2`, `champ`
  mutate(across(where(is.double), as.integer)) |>
  arrange(desc(champ)) |> 
  filter(champ >= 2)
  # plot()

# Visualise ----

# radar -----

tr |> 
  select(c(2, 7:9, 13:17)) |>                              # `games`, `w`, `l`, `s16m`, `e8`, `f4`, `f2`, `champ`
  mutate(across(where(is.double), as.integer)) |>
  arrange(desc(champ)) |> 
  filter(champ >= 2) |> 
  mutate_at(vars(-team), rescale) |> 
  ggradar(
    axis.label.size = 3,
    grid.label.size = 3,
    grid.line.width = .75,
    font.radar = ('Roboto Mono'),
    legend.text.size = 8
)
## https://rstudio-pubs-static.s3.amazonaws.com/5795_e6e6411731bb4f1b9cc7eb49499c2082.html

# gt ----

tr |> 
  select(c(2, 7:9, 13:17)) |>                              # `games`, `w`, `l`, `s16m`, `e8`, `f4`, `f2`, `champ`
  mutate(across(where(is.double), as.integer)) |>
  arrange(desc(champ)) |> 
  filter(champ >= 2) |> 
  gt()

# ... 

# https://easystats.github.io/performance/
# https://r-graph-gallery.com/spider-or-radar-chart.html

# Analyse ----

# unassisted

# assisted

## question
## https://www.perplexity.ai/search/i-have-the-C6Ycn.noR8C.PI5bTuMQBg

## Performance :: model evaluation

lm(w ~ l + r64 + r32 + s16 + e8 + f4 + f2, data = tr) |>
  check_model()

## Trend Analysis

## ...
