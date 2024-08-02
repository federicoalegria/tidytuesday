# --- TIDYTUESDAY::2024§30 --- #
# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-07-23/readme.md

# library path
.libPaths(c("~/.R/x86_64-pc-linux-gnu-library/4.4", .libPaths()))

# packages
pacman::p_load(
  data.table,           # https://cran.r-project.org/web/packages/data.table/
  easystats,            # https://cran.r-project.org/web/packages/easystats/
  ggthemes,             # https://cran.r-project.org/web/packages/ggthemes/
  janitor,              # https://cran.r-project.org/web/packages/janitor/
  mgcv,                 # https://cran.r-project.org/web/packages/mgcv/
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
# https://t.ly/gzffd

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

# model ----

# checking assumptions
## https://www.youtube.com/watch?v=sDrAoR17pNM
## https://chatgpt.com/c/ebdee2ae-53d7-4721-9da8-578473413caf

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

# non-parametric way

## Spearman's rank correlation
### https://www.perplexity.ai/search/spearman-s-rank-correlation-rh-Vyis3naNRdmCd_qVq.50zA

cor.test(
  df$viewers_in_millions, 
  df$x18_49_rating_share,
  method = 'spearman'
)

## generalized additive model (gam)

gam_model <- gam(x18_49_rating_share ~ s(viewers_in_millions), data = df)

### dataframe for predictions
dfmodel <- data.frame(viewers_in_millions = seq(min(df$viewers_in_millions, na.rm = TRUE),
  max(df$viewers_in_millions, na.rm = TRUE),
  length.out = 100
))

# predicted values from the model
dfmodel$x18_49_rating_share <- predict(gam_model, newdata = dfmodel)

# extract smooth terms
smooth_terms <- summary(gam_model)$s.table

print(smooth_terms)

# diagnostic plots for the gam model
gam.check(gam_model)

summary(gam_model)

report(gam_model)

# visualise ----

# raw

plot(df$viewers_in_millions, df$x18_49_rating_share)

# rice

df |>
  filter(!is.na(x18_49_rating_share)) |>
  filter(x18_49_rating_share <= 10) |>
  ggplot(aes(
    x = viewers_in_millions,
    y = x18_49_rating_share)
  ) +
  geom_point(alpha = 0.75) +
  geom_smooth(
    colour = '#9d0006',
    fill = '#9d0006',
    alpha = 0.35,
    method = 'loess'
  ) +
  theme_wsj() +
  labs(
    title = "American Idol",
    subtitle = "generalized additive model for rating by views
    ",
    caption = "
    data pulled from https://t.ly/gzffd by https://github.com/federicoalegria",
    x = "viewers in millions",
    y = "rating"
  ) +
  theme(
    axis.text = element_text(family = 'Roboto Mono'),
    plot.title = element_text(size = 18, family = 'Roboto Mono'),
    plot.subtitle = element_text(size = 15, family = 'Roboto Mono'),
    plot.caption = element_text(size = 10, family = 'Roboto Mono')
  ) +
  ylim(0, 10)

# ...

# Communicate ----
