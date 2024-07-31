# --- TIDYTUESDAY::2024§30 --- #
# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-07-23/readme.md

# library path
.libPaths(c("~/.R/x86_64-pc-linux-gnu-library/4.4", .libPaths()))

# packages
pacman::p_load(
  data.table,           # https://cran.r-project.org/web/packages/data.table/
  ggthemes,             # https://cran.r-project.org/web/packages/ggthemes/
  janitor,              # https://cran.r-project.org/web/packages/janitor/
  skimr,                # https://cran.r-project.org/web/packages/skimr/
  styler,               # https://cran.r-project.org/web/packages/styler/
  tidyverse             # https://cran.r-project.org/web/packages/tidyverse/
)

# Import ----

# ratings
df <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-07-23/ratings.csv'
  ) |>
  clean_names()
# dictionary
# https://raw.

# Understand ----

# names
df |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
df |>
  glimpse() |>
  skim()

# missing values
sum(is.na(df$x18_49_rating_share))
sum(is.na(df$viewers_in_millions))

# transform ----

df$x18_49_rating_share <- as.double(df$x18_49_rating_share)

# visualise ----

# raw

plot(df$viewers_in_millions, df$x18_49_rating_share)

# rice

df |>
  filter(!is.na(x18_49_rating_share)) |>
  filter(x18_49_rating_share <= 10) |> 
  ggplot(aes(x = viewers_in_millions, y = x18_49_rating_share)) +
  geom_point(alpha = 0.75) +
  geom_smooth(colour = '#9d0006', fill = '#9d0006', alpha = 0.35) +
  theme(axis.text.y = element_text(angle = 0, hjust = 1)) +
  theme_wsj() +
  ggtitle("rating ~ views")

# model ----

# checking assumptions

## visual inspection

### histogram

df |>
  ggplot(aes(x = viewers_in_millions)) +
  geom_histogram(
    aes(y = ..density..),
    binwidth = 1,
    fill = '#3c3836'
  ) +
  geom_density(color = '#d79921', size = 1) +
  theme_minimal() +
  labs(x = "viewers in millions")

df |>
  ggplot(aes(x = x18_49_rating_share)) +
  geom_histogram(
    aes(y = ..density..),
    binwidth = 1,
    fill = '#3c3836'
  ) +
  geom_density(color = '#d79921', size = 1) +
  theme_minimal() +
  labs(x = "rating share")

### q-q plot

df |> 
  ggplot(aes(sample = viewers_in_millions)) +
  stat_qq() +
  stat_qq_line() +
  ggtitle("q-q plot of viewers in millions")

df |>
  ggplot(aes(sample = x18_49_rating_share)) +
  stat_qq() +
  stat_qq_line() +
  ggtitle("q-q plot of rating share")

## statistical tests

### Shapiro-Wilk
shapiro.test(df$viewers_in_millions)

shapiro.test(df$x18_49_rating_share)

# ### Kolmogorov-Smirnov
# ks.test(
#   df$viewers_in_millions,
#   'pnorm',
#   mean(df$viewers_in_millions, na.rm = TRUE),
#   sd(df$viewers_in_millions, na.rm = TRUE)
# )

# ks.test(
#   df$x18_49_rating_share,
#   'pnorm',
#   mean(df$x18_49_rating_share, na.rm = TRUE),
#   sd(df$x18_49_rating_share, na.rm = TRUE)
# )

# ...

# https://chatgpt.com/c/ebdee2ae-53d7-4721-9da8-578473413caf
# alright, but it happens that my data shows some linearity, 
# so i would like to perform a non-parametric equivalent 
# of the simple linear regression

# Communicate ----
