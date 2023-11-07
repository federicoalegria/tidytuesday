
# --- TIDYTUESDAY::2023_39 --- #

# LIBRARIES ----

pacman::p_load(car,
               effectsize,
               janitor,
               ggstatsplot,
               grid,
               kableExtra,
               patchwork,
               png,
               skimr,
               tidyverse)

# DATA ----

richmondway <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-09-26/richmondway.csv'
  ) |> 
  clean_names()

# EXPLORE ----

richmondway |> 
  glimpse() |> 
  skim()

# Reclass
richmondway <- richmondway %>%
  mutate(across(
    c(
      episode_order,
      episode,
      f_count_rk,
      f_count_total,
      cum_rk_season,
      cum_total_season,
      cum_rk_overall,
      cum_total_overall
    ),
    as.integer
  ),
  season = as.factor(season)
  )

# Explore the notion that fictional characters behave in line with their surroundings.

# Check normality ----

# `$f_count_rk`

# Plot
plot(richmondway$f_count_rk)

# Histogram
richmondway |> 
  ggplot(aes(f_count_rk)) +
  geom_histogram(binwidth = 0.5)

# Test
## H0: data follows a normal distribution
## H1: data not follows a normal distribution
### https://chat.openai.com/share/af22f461-230e-414e-b7ae-f74fc4a2fce5
shapiro.test(richmondway$f_count_rk)

### For a significance level of 0.05, the p-value 0.01242 indicates that the null 
### hypothesis for this data to be normally distributed should be rejected in favour 
### of the alternative hypothesis, meaning the data is not normally distributed.
#### https://www.perplexity.ai/search/1a9242be-a01d-4372-ae29-49f839776149

## http://www.sthda.com/english/wiki/normality-test-in-r
qqPlot(
  richmondway$f_count_rk,
  main = "QQ Plot for Roy Kent's F-bombs",
  xlab = "Norm Quantiles",
  ylab = "F**k Bomb Count",
  col = "#000000",
  col.lines = "#ffA500"
)
## https://g.co/bard/share/a8f4c2a14ded
### The strength of the correlation is relatively weak, as the points are not 
### very tightly clustered around the line. There is some curvature in the line,
### which suggests that the relationship between the two variables is not perfectly linear.

# ANALYSE ----

# F**k bombs in line with dating status ----

# Summary
richmondway |> 
  group_by(dating_flag) |> 
  summarise(
    mean = mean(f_count_rk),
    median = median(f_count_rk),
    min = min(f_count_rk),
    max = max(f_count_rk),
    range = IQR(f_count_rk),
    n = n()
  ) |> 
  knitr::kable(digits = 2)

# Boxplot
richmondway |> 
  ggplot(aes(x = dating_flag, y = f_count_rk)) +
  geom_boxplot() +
  labs(
    x = "Roy Kent's Dating Status",
    y = "F**k Bomb Count"
  )

# test the measured and observed difference
## H0: Mdn1 = Mdn2
## H1: Mdn1 ≠ Mdn2
### https://chat.openai.com/share/3718353c-8c97-4e0f-b4ac-bd277880a497
wilcox.test(
  f_count_rk ~ dating_flag,
  data = richmondway,
  mu = 0,
  alternative = "two.sided",
  conf.int = TRUE,
  conf.level = 0.95,
  exact = FALSE,
  correct = FALSE,
  paired = FALSE
)
## https://www.perplexity.ai/search/In-R-I-I.HC4.bqTiKEpTPj2XjbTQ?s=c
### The output from the stats::wilcox.test() function is W = 157.5 with a p-value
### = 0.6013, which is greater than the established threshold of 0.05.
### Therefore, the null hypothesis is not rejected in favor of the alternative
### hypothesis; meaning there's no significant difference between the two groups 
### being compared at the 5% significance level.

# {ggstatsplot::ggbetweenstats()}
ggbetweenstats(data = richmondway,
               x = dating_flag,
               y = f_count_rk,
               type = "nonparametric")
# {effectsize::interpret_rank_biserial()}
# https://easystats.github.io/effectsize/reference/interpret_r.html
# interpret_rank_biserial(0.11)
## Very small (Lovakov, 2021)
### Lovakov, A., & Agadullina, E. R. (2021). Empirically Derived Guidelines for
### Effect Size Interpretation in Social Psychology. European Journal of Social
### Psychology. DOI: 10.1002/ejsp.2752

# F**k bombs in line with coaching status

# Summary
richmondway |> 
  group_by(coaching_flag) |> 
  summarise(
    mean = mean(f_count_rk),
    median = median(f_count_rk),
    min = min(f_count_rk),
    max = max(f_count_rk),
    range = IQR(f_count_rk),
    n = n()
  ) |> 
  knitr::kable(digits = 2)

# Boxplot
richmondway |> 
  ggplot(aes(x = coaching_flag, y = f_count_rk)) +
  geom_boxplot() +
  labs(
    x = "Roy Kent's Coaching Status",
    y = "F**k Bomb Count"
  )

# test the measured and observed difference
## H0: Mdn1 = Mdn2
## H1: Mdn1 ≠ Mdn2
### https://chat.openai.com/share/3718353c-8c97-4e0f-b4ac-bd277880a497
wilcox.test(
  f_count_rk ~ coaching_flag,
  data = richmondway,
  mu = 0,
  alternative = "two.sided",
  conf.int = TRUE,
  conf.level = 0.95,
  exact = FALSE,
  correct = FALSE,
  paired = FALSE
)
## https://www.perplexity.ai/search/In-R-I-UpkbCqH7SbueQojl3.MvCQ?s=c
### The output from the stats::wilcox.test() function is W = 63.5 with a p-value
### = 0.007169, which is less than the established threshold of 0.05. 
### Therefore, the null hypothesis can rejected in favor of the alternative
### hypothesis; and conclude that there is a significant difference 
### between both groups.

# {ggstatsplot::ggbetweenstats()}
ggbetweenstats(data = richmondway,
               x = coaching_flag,
               y = f_count_rk,
               type = "nonparametric")
# {effectsize::interpret_rank_biserial()}
# https://easystats.github.io/effectsize/reference/interpret_r.html
# interpret_rank_biserial(-0.55)
## Large (Lovakov, 2021).
### The negative sign in front of the r value
### indicates the direction of the relationship between the two variables being
### correlated. In this case, a negative r value of -0.55 indicates a negative
### relationship between the variables. The absolute value of the r value (0.55)
### would be used to determine the magnitude of the correlation, which as
### mentioned earlier, would be considered a large effect size (Lovakov, 2021:20).
#### Lovakov, A., & Agadullina, E. R. (2021). Empirically Derived Guidelines for
#### Effect Size Interpretation in Social Psychology. European Journal of Social
#### Psychology.

# F**k bombs in line with season

# Summary
richmondway |> 
  group_by(season) |> 
  summarise(
    mean = mean(f_count_rk),
    median = median(f_count_rk),
    min = min(f_count_rk),
    max = max(f_count_rk),
    range = IQR(f_count_rk),
    n = n()
  ) |> 
  knitr::kable(digits = 2)

# Boxplot
richmondway |> 
  ggplot(aes(x = season, y = f_count_rk)) +
  geom_boxplot() +
  labs(
    x = "Season",
    y = "F**k Bomb Count"
  )

# test the measured and observed difference
## H0: μ1 = μ2 = μ3 … = μk
## H1: μ1 ≠ μ2 | μ1 ≠ μ3 | … | μk-1 ≠ μk
### https://chat.openai.com/share/f4d55d32-0567-48c9-88d7-4649b0af002f
kruskal.test(
  richmondway$f_count_rk,
  richmondway$season,
  mu = 0,
  alternative = "two.sided",
  conf.int = TRUE,
  conf.level = 0.95,
  exact = FALSE,
  correct = FALSE,
  paired = FALSE
)
## https://www.perplexity.ai/search/In-R-I-oPnZ1p8UQ2.OjBqsLlY0lg?s=c
### The output from the stats::kruskal.test() function is is a chi-squared value 
### of 8.4674 with 2 degrees of freedom and a p-value = 0.0145; less than the established 
### threshold of 0.05. Therefore, the null hypothesis can rejected in favor of the 
### alternative hypothesis; and conclude that there is a significant difference 
### between between the groups being compared.

# {ggstatsplot::ggbetweenstats()}
ggbetweenstats(data = richmondway,
               x = season,
               y = f_count_rk,
               type = "nonparametric")
# interpret_interpret_epsilon_squared(0.26)
## Large (Field, 2013).
### Field, A (2013) Discovering statistics using IBM SPSS Statistics.
### Fourth Edition. Sage:London.

# COMMUNICATE ----

# Patchwork ----

# p0
png("Tidy Tuesday/img-01.png",
    width = 1080,
    height = 720)

qqPlot(
  richmondway$f_count_rk,
  main = "QQ Plot for Roy Kent's F-bombs",
  xlab = "Norm Quantiles",
  ylab = "F**k Bomb Count",
  col = "#000000",
  col.lines = "#ffA500"
)

dev.off()

img_grob <-
  rasterGrob(png::readPNG("Tidy Tuesday/img-01.png"), 
             interpolate = TRUE)

p <- ggplot() + 
  xlim(0, 10) + 
  ylim(0, 10) + 
  theme_void()

p0 <- p +
  annotation_custom(
    img_grob,
    xmin = 0,
    xmax = 10,
    ymin = 0,
    ymax = 10
  )

# p1
p1 <- ggbetweenstats(
  data = richmondway,
  x = dating_flag,
  y = f_count_rk,
  type = "nonparametric",
  xlab = "Dating Status",
  ylab = "F**k Bomb Count"
)

# p2
p2 <- ggbetweenstats(
  data = richmondway,
  x = coaching_flag,
  y = f_count_rk,
  type = "nonparametric",
  xlab = "Coaching Status",
  ylab = " "
)

# p3
p3 <- ggbetweenstats(
  data = richmondway,
  x = season,
  y = f_count_rk,
  type = "nonparametric",
  xlab = "Season",
  ylab = " "
)

p1 + p2 + p3

# ... ----

# imdb_rating

richmondway |> 
  ggplot(aes(x = imdb_rating,
             y = f_count_rk)) +
  geom_point() +
  geom_smooth(col = "#ffA500")