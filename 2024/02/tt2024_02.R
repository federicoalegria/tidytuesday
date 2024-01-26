
# --- TIDYTUESDAY::2024§02 --- #

# hhttps://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-01-09/readme.md

# Packages ----

pacman::p_load(
  ggstatsplot,
  janitor,
  skimr,
  tidyverse,
  tinytable
)

# DATA ----

# cb <-
#   readr::read_csv(
#     'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-01-09/canada_births_1991_2022.csv'
#   ) |>
#   clean_names()
# 
# nhl_pb <-
#   readr::read_csv(
#     'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-01-09/nhl_player_births.csv'
#   ) |>
#   clean_names()

nhl_r <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-01-09/nhl_rosters.csv'
  ) |>
  clean_names()

# nhl_t <-
#   readr::read_csv(
#     'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-01-09/nhl_teams.csv'
#   ) |>
#   clean_names()

## https://shorturl.at/cu689

# EXPLORE ----

# names
nhl_r |>
  slice(0) |>
  glimpse()

# glimpse & skim
nhl_r |>
  glimpse() |>
  skim()

# Body mass Index (`bmi`)
nhl_r |>
  select(
    position_type,
    position_code,
    shoots_catches,
    height_in_centimeters,
    weight_in_kilograms
  ) |>
  na.omit() |>
  rename(height = height_in_centimeters,
         weight = weight_in_kilograms) |>
  mutate(height = height / 100) |>
  mutate(bmi = weight / height ^ 2) |>
  group_by(position_type) |>
  summarise(Avg_bmi = mean(bmi)) |>
  rename("position type"  = position_type,
         "average BMI" = Avg_bmi) |>
  # summary table
  tt(theme = "striped") |> 
  save_tt("/tt2024_02.tt.png")

# TRANSFORM ----

# adding `bmi` and filtering NA values
nhl_r <-
  nhl_r |>
  na.omit() |>
  rename(height = height_in_centimeters,
         weight = weight_in_kilograms) |>
  mutate(height = height / 100) |>
  mutate(bmi = weight / height ^ 2)

# subsetting

set.seed(13)

nhl_r_subset <- nhl_r |>
  sample_frac(0.05)

# VISUALISE ----

# Check for normality

# q-q plot
qqnorm(nhl_r_subset$bmi)

# histogram + density plot
nhl_r_subset |>
  ggplot(aes(x = bmi)) +
  geom_histogram(aes(y = after_stat(density)), 
                 bins = 30, 
                 alpha = 0.5) +
  geom_density()

# ANALYSE ----

# Check for normality

# Asymptotic one-sample Kolmogorov-Smirnov test
ks.test(
  nhl_r_subset$bmi,
  pnorm,
  mean = mean(nhl_r_subset$bmi),
  sd = sd(nhl_r_subset$bmi)
)

# Shapiro-Wilk normality test
shapiro.test(nhl_r_subset$bmi)

# ggstatsbetween parametric run
ggbetweenstats(
  data = nhl_r_subset,
  x = position_type,
  y = bmi,
  type = "parametric",
  point.args = list(
    position = ggplot2::position_jitterdodge(dodge.width = 0.6),
    alpha = 0.5,
    size = 2,
    stroke = 0,
    na.rm = TRUE)
)
## given the p value of 3.81e-18, the null hypothesis 
## can be rejected and conclude that there is a statistically
## significant difference between the means of defensemen, forwards and goalies.

# ... ----
