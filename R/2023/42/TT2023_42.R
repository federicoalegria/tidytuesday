
# --- TIDYTUESDAY::2023_42 --- #
# https://github.com/rfordatascience/tidytuesday/blob/master/data/2023/2023-10-17/readme.md

# libraries ----

pacman::p_load(
  easystats,
  ggridges,
  ggstatsplot,
  ggthemes,
  janitor,
  patchwork,
  skimr,
  tidyverse
)

# https://asteves.github.io/tayloRswift/index.html
# https://taylor.wjakethompson.com/
# https://taylor.wjakethompson.com/reference/album_palettes
# https://pmassicotte.github.io/paletteer_gallery/

# DATA ----

taylor_album_songs <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-10-17/taylor_album_songs.csv'
  ) |> 
  clean_names()

# CLEAN ----

# Transform ----

# album names
taylor_album_songs <-
  taylor_album_songs |>
  mutate(album_name = gsub("\\(Taylor's Version\\)", "", album_name) |>
           str_trim() |>
           str_to_title())

# EXPLORE ----

# names
taylor_album_songs|>
  slice(0) |>
  glimpse()

# glimpse & skim
taylor_album_songs |>
  glimpse() |>
  skim()

# VISUALISE ----

# Categorical & Metric ----

# box plot
taylor_album_songs |>
  mutate(album_name = reorder(album_name, valence)) |>
  ggplot(aes(x = album_name,
             y = valence)) +
  geom_boxplot(aes(fill = album_name), alpha = 0.7) +
  scale_fill_manual(
    values = c(
      "#400303",
      "#731803",
      "#967862",
      "#b38468",
      "#c7c5b6",
      "#160e10",
      "#421e18",
      "#d37f55",
      "#85796d",
      "#e0d9d7"
    )
  ) +
  geom_jitter(color = "#1D4737", alpha = 0.4) +
  labs(
    title = "Taylor Swift's valence by albums",
    subtitle = "box plots based on data pulled from Spotify's Web API with spotifyr",
    caption = "{tidytuesday 2023∙42}
    https://github.com/rfordatascience/tidytuesday/blob/master/data/2023/2023-10-17/readme.md",
    x = "Valence",
    y = "Album Name"
  ) +
  theme_solarized() +
  theme(legend.position = "none") +
  coord_flip()

# ridges plot
taylor_album_songs |>
  mutate(album_name = reorder(album_name, valence)) |>
  ggplot(aes(x = valence, y = album_name)) +
  geom_density_ridges(aes(fill = album_name), alpha = 0.7) +
  scale_fill_manual(
    values = c(
      "#400303",
      "#731803",
      "#967862",
      "#b38468",
      "#c7c5b6",
      "#160e10",
      "#421e18",
      "#d37f55",
      "#85796d",
      "#e0d9d7"
    )
  ) +
  labs(
    title = "Taylor Swift's valence by albums",
    subtitle = "ridge plots based on data pulled from Spotify's Web API with spotifyr",
    caption = "{tidytuesday 2023∙42}
    https://github.com/rfordatascience/tidytuesday/blob/master/data/2023/2023-10-17/readme.md",
    x = "Valence",
    y = "Album Name",
    fill = "Album Name"
  ) +
  theme_solarized() +
  theme(legend.position = "none")

# ANALYSE ----

# Modeling

# multiple linear regression analysis
## https://www.perplexity.ai/search/f03b99ef-9cd1-40a7-b791-7c96946fccf4

# There are several assumptions that must be met when performing a multiple
# linear regression analysis. These are important to ensure that the model is
# correctly specified and that the results are reliable. The key assumptions of
# multiple linear regression are:
#   
# - **Linearity**: There must be a linear relationship between the dependent
# variable and the independent variables. This can be checked using
# scatterplots showing a linear or curvilinear relationship[1][2][3][4].
# 
# - **Normality**: The residual values must be normally distributed. This can be
# checked using a normal probability plot or a histogram[1][2][3][4].
# 
# - **Homoscedasticity**: The variance of the residual errors must be similar
# across the value of each independent variable. This can be checked
# through a plot of the predicted values against the standardized residual
# values to see if the points are equally distributed across all the values
# of the independent variables[1][3].
# 
# - **Multicollinearity**: The independent variables must not be highly
# correlated with each other. Multicollinearity makes it difficult to
# identify which variables better explain the dependent variable. This
# assumption is verified by computing a matrix of Pearson’s bivariate
# correlations among all the independent variables. If there is no
# collinearity in the data, then all the values should be less than 0.8[1]
# [2].
# 
# It is important to note that these assumptions are not always met in practice,
# and there are techniques to deal with violations of these assumptions. For
# example, transformations of the variables or using robust regression methods
# can help to address violations of the normality and homoscedasticity
# assumptions[3].
# 
# Citations:
#   
# [1] https://www.datacamp.com/tutorial/multiple-linear-regression-r-tutorial
# [2] https://www.statisticssolutions.com/free-resources/directory-of-statistical-analyses/assumptions-of-multiple-linear-regression/
# [3] http://www.sthda.com/english/articles/39-regression-model-diagnostics/161-linear-regression-assumptions-and-diagnostics-in-r-essentials/
# [4] https://www.reddit.com/r/spss/comments/uawa33/assumptions_multiple_linear_regression_with/
# [5] https://stats.stackexchange.com/questions/582725/making-my-linear-regression-model-meet-assumptions-causes-a-large-increase-in-me
# [6] https://godatadrive.com/blog/basic-guide-to-test-assumptions-of-linear-regression-in-r

# The `performance()` function from the `easystats` package can be helpful for
# checking on assumptions of data before doing a multiple linear regression
# analysis. The `performance()` function computes indices of model performance
# for regression models, such as R-squared, root mean squared error (RMSE), or
# intraclass correlation coefficient (ICC)[1]. However, it is important to note
# that the `performance()` function does not directly check the assumptions of
# the model. Instead, the `check_model()` function from the same package can be
# used to check the assumptions of the model, such as linearity, normality,
# homoscedasticity, and multicollinearity[1][2][3][4]. The `check_model
# ()` function provides a visual check of various model assumptions, such as
# normality of residuals, normality of random effects, linear relationship,
# homogeneity of variance, and multicollinearity[6]. Therefore, the `easystats`
# package can be a useful tool for checking the assumptions of a multiple
# linear regression model in R.
# 
# Citations:
# 
# [1] https://easystats.github.io/performance/
# [2] https://www.r-bloggers.com/2021/07/easystats-quickly-investigate-model-performance/
# [3] https://www.business-science.io/r/2021/07/13/easystats-performance-check-model.html
# [4] https://rforpoliticalscience.com/2022/05/19/check-model-assumptions-with-easystats-package-in-r/
# [5] https://youtube.com/watch?v=Bi8sHIo3s1Y
# [6] https://rdrr.io/github/easystats/performance/man/check_model.html

lm(
  valence ~ danceability + energy + mode + speechiness + acousticness + instrumentalness + liveness,
  data = taylor_album_songs
) |> 
  summary()

taylor_album_songs |>
  select(valence, energy, danceability, acousticness) |> # ordered from smallest to largest 
  correlation(redundant = TRUE) |> 
  summary()
  
lm(
  valence ~ energy + danceability + acousticness,
  data = taylor_album_songs
) |> 
  check_model()

lm(
  valence ~ energy + danceability + acousticness,
  data = taylor_album_songs
) |> 
  summary()
# https://g.co/bard/share/e59b45b94b4f

lm(
  valence ~ energy + danceability + acousticness,
  data = taylor_album_songs
) |> 
  report()

# https://bard.google.com/chat/973fe81d45d628c2?hl=en

# scatter plot
## metric & metric
### Amasement
#### https://www.perplexity.ai/search/58ada70b-f668-4cd6-9e23-ae5c56eaf886?s=u
taylor_album_songs |>
  mutate(amasement = (energy + danceability + acousticness) / 3) |>
  ggplot(aes(x = valence,
             y = amasement)) +
  geom_point(aes(colour = album_name, size = duration_ms)) +
  scale_color_manual(
    values = c(
      "#400303",
      "#731803",
      "#967862",
      "#b38468",
      "#c7c5b6",
      "#160e10",
      "#421e18",
      "#d37f55",
      "#85796d",
      "#e0d9d7"
    )
  ) +
  labs(
    title = "Predictor model for valence in Taylor Swift songs",
    subtitle = "analysis based on data from Spotify's Web API with {spotifyr}",
    caption = "{tidytuesday 2023∙42}
    https://github.com/rfordatascience/tidytuesday/blob/master/data/2023/2023-10-17/readme.md",
    x = "Valence",
    y = "Amasement",
    fill = "Album Name",
    colour = "Album Name"
  ) +
  geom_smooth(colour = "#1D4737", method = "lm") +
  theme_solarized() +
  guides(size = "none")

# COMMUNICATE ----

# ... ----

# https://www.youtube.com/watch?v=FvVnP8G6ITs

