
# --- TIDYTUESDAY::2023_51 --- #

# This week we're exploring "holiday" TV episodes: 
# individual episodes of TV shows with "holiday", 
# "Christmas", "Hanukkah", or "Kwanzaa" 
# (or variants thereof) in their title!

# Packages ----

pacman::p_load(
  easystats,
  ggforce,
  ggthemes,
  janitor,
  magrittr,
  patchwork,
  skimr,
  tidyquant,
  tidyverse
)

# DATA ----

he <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-12-19/holiday_episodes.csv'
  ) |> 
  janitor::clean_names()
## https://shorturl.at/csKS2

# Prompting ----

# i have a dataset from IMDb, among it's columns, 
# there are two numeric variables that seem to be closely related.
# one marks the average rating for holiday-related episode'ss,
# these ratings derive from episode'ss a very specific criteria,
# therefore i argue that the selection of episode'ss can't be treated as a random sample.
# am i correct?
# [...]
# the other variable i'm interested in, shows the average rating for it's parent title,
# i.e. rating for the specific holiday-related episode's, 
# and rating for the main title this episode's comes from, 
# what kind of analysis can i conduct if i'm interested in comparing 
# how these two variables behave between each other?
# [...]
# 
# [---]
## https://chat.openai.com/share/78715082-f6c5-45be-b9d9-736e29134469
## https://g.co/bard/share/dc6d6a21fce7

# EXPLORE ----

# glimpse & skim
he |>
  glimpse() |> 
  skim()

# names
he |>
  slice(0) |> 
  glimpse()

## parent titles
he |> 
  group_by(parent_primary_title) |> 
  summarise(n = n()) |> 
  arrange(desc(n))

## finder
he |> 
  filter(str_detect(parent_primary_title, 
                    pattern = "lorem")) |> 
  glimpse()

# VISUALISE ----

# Raw ----

plot(he$parent_average_rating, he$average_rating)

boxplot(he$parent_average_rating, he$average_rating)

hist(he$parent_average_rating)
plot(density(he$parent_average_rating))
density(he$parent_average_rating)

hist(he$average_rating)
plot(density(he$average_rating))
density(he$average_rating)

# Rice ----

## typically, the iv is plotted on the x-axis and the dv on the y-axis
### parent_average_rating, average_rating ~ genres

# Scatter ----

# scatter plots for patchwork ----
p1 <-
  he |>
  ggplot(aes(x = parent_average_rating,
             y = average_rating)) +
  geom_point(alpha = 0.45) +
  geom_smooth(colour = '#ff0055',
              linewidth = 0.5,
              method = 'gam') +
  theme_wsj() +
  labs(x = "show's rating",
       y = "episode's rating") +
  theme(
    axis.text.x = element_text(family = 'Consolas', size = 10),
    axis.title = element_text(family = 'Consolas', size = 10),
    panel.background = element_rect(fill = 'transparent'),
    plot.background = element_rect(fill = 'transparent'),
    legend.background = element_rect(fill = 'transparent')
)

p2 <-
  he |>
  ggplot(aes(x = parent_average_rating,
             y = average_rating)) +
  geom_point(alpha = 0.45) +
  geom_smooth(colour = '#ff0055',
              linewidth = 0.5,
              method = 'lm') +
  theme_wsj() +
  labs(x = "show's rating",
       y = "episode's rating") +
  theme(
    axis.text.x = element_text(family = 'Consolas', size = 10),
    axis.title = element_text(family = 'Consolas', size = 10),
    panel.background = element_rect(fill = 'transparent'),
    plot.background = element_rect(fill = 'transparent'),
    legend.background = element_rect(fill = 'transparent')
)

p3 <-
  he |>
  ggplot(aes(x = parent_average_rating,
             y = average_rating)) +
  geom_jitter(alpha = 0.45) +
  geom_smooth(colour = '#ff0055',
              linewidth = 0.5,
              method = 'gam') +
  theme_wsj() +
  labs(x = "show's rating",
       y = "episode's rating") +
  theme(
    axis.text.x = element_text(family = 'Consolas', size = 10),
    axis.title = element_text(family = 'Consolas', size = 10),
    panel.background = element_rect(fill = 'transparent'),
    plot.background = element_rect(fill = 'transparent'),
    legend.background = element_rect(fill = 'transparent')
)

p4 <-
  he |>
  ggplot(aes(x = parent_average_rating,
             y = average_rating)) +
  geom_jitter(alpha = 0.45) +
  geom_smooth(colour = '#ff0055',
              linewidth = 0.5,
              method = 'lm') +
  theme_wsj() +
  labs(x = "show's rating",
       y = "episode's rating") +
  theme(
    axis.text.x = element_text(family = 'Consolas', size = 10),
    axis.title = element_text(family = 'Consolas', size = 10),
    panel.background = element_rect(fill = 'transparent'),
    plot.background = element_rect(fill = 'transparent'),
    legend.background = element_rect(fill = 'transparent')
)

# patchwork ----
(p1 + p2) / (p3 + p4) +
  plot_annotation(
    title = "shows and episodes ratings",
    subtitle = "scatterplots mapping relationship between averages",
    caption = "columns by method = 'gam' & 'lm'
    rows by geom = 'point' & 'jitter'
    tidytuesday 2023_51 [https://shorturl.at/csKS2]",
    theme = theme(plot.title = element_text(face = 'bold', size = 15),
                  plot.subtitle = element_text(face = 'plain', size = 12))
  ) & 
  theme(text = element_text(family = 'Consolas')
)

# top 9 genres ----
he |>
  mutate(genres = str_replace(
    genres, ",(.*)", "")
  ) |>
  group_by(genres) |>
  summarise(n = n()) |>
  arrange(desc(n)) |> 
  filter(n >= 55) |> 
  filter(genres != "NA") |> 
  knitr::kable(
)

# facet wrapped scatter plot ----
he |>
  mutate(genres = str_replace(genres, ",(.*)", "")) |>
  filter(
    genres %in% c(
      "Comedy",
      "Action",
      "Animation",
      "Adventure",
      "Drama",
      "Crime",
      "Reality-TV",
      "Documentary",
      "Family"
    )
  ) |>
  ggplot(aes(x = parent_average_rating,
             y = average_rating)) +
  geom_jitter(alpha = 0.15) +
  geom_smooth(colour = '#000000',
              linewidth = 0.35) +
  facet_wrap( ~ genres) +
  theme_minimal() +
  labs(
    title = "shows and episodes ratings",
    subtitle = "scatterplots mapping relationship between averages across genres",
    caption = "top genres alphabetically sorted
    geom_smooth's method by column = 'auto'
    tidytuesday 2023_51 [https://shorturl.at/csKS2]",
    x = "shows rating",
    y = "episode's rating") +
  theme(
    axis.text.x = element_text(family = 'Consolas', size = 10),
    axis.title = element_text(family = 'Consolas', size = 10),
    plot.title = element_text(face = 'bold', family = 'Consolas', size = 15),
    plot.subtitle = element_text(face = 'plain', family = 'Consolas', size = 12),
    plot.caption = element_text(face = 'plain', family = 'Consolas')
)

# Hull plot ----
## diving into genres

# broad hull plot ----
he |>
  mutate(genres = str_replace(genres, ",(.*)", "")) |>
  filter(
    genres %in% c(
      "Comedy",
      "Action",
      "Animation",
      "Adventure",
      "Drama",
      "Crime",
      "Reality-TV",
      "Documentary",
      "Family"
    )
  ) |>
  ggplot(aes(x = parent_average_rating,
             y = average_rating)) +
  geom_jitter(alpha = 0.85) +
  geom_mark_hull(aes(fill = genres, label = genres),
                 concavity = 2.8) +
  theme_minimal() +
  scale_fill_tq() +
  labs(
    title = "shows and episodes ratings",
    subtitle = "overlapped hullplots mapping the coverage of genres",
    caption = "tidytuesday 2023_51 [https://shorturl.at/csKS2]",
    x = "shows's rating",
    y = "episode's rating") +
  theme(
    axis.text.x = element_text(family = 'Consolas', size = 10),
    axis.title = element_text(family = 'Consolas', size = 10),
    plot.title = element_text(face = 'bold', family = 'Consolas', size = 15),
    plot.subtitle = element_text(face = 'plain', family = 'Consolas', size = 12),
    plot.caption = element_text(face = 'plain', family = 'Consolas'),
    legend.position = 'none'
)
## genres are scattered all over the place

# facet wrapped hull plot
he |>
  mutate(genres = str_replace(genres, ",(.*)", "")) |>
  filter(
    genres %in% c(
      "Comedy",
      "Action",
      "Animation",
      "Adventure",
      "Drama",
      "Crime",
      "Reality-TV",
      "Documentary",
      "Family"
    )
  ) |>
  ggplot(aes(x = parent_average_rating,
             y = average_rating)) +
  geom_jitter(alpha = 0.35) +
  geom_mark_hull(aes(fill = genres),
                 concavity = 2.8) +
  expand_limits(x = 10,
                y = 10) +
  theme_minimal() +
  scale_fill_tq() +
  labs(
    title = "shows and episodes ratings",
    subtitle = "faceted hullplots mapping the coverage of each genre",
    caption = "tidytuesday 2023_51 [https://shorturl.at/csKS2]",
    x = "shows's rating",
    y = "episode's rating") +
  theme(
    axis.text.x = element_text(family = 'Consolas', size = 10),
    axis.title = element_text(family = 'Consolas', size = 10),
    plot.title = element_text(face = 'bold', family = 'Consolas', size = 15),
    plot.subtitle = element_text(family = 'Consolas', size = 12),
    plot.caption = element_text(family = 'Consolas'),
    legend.position = 'none'
  ) +
  facet_wrap(~ genres
)

# focused hull plots ----

# hull plot focused on "Comedy"
he |>
  mutate(genres = str_replace(genres, ",(.*)", "")) |>
  filter(
    genres %in% c(
      "Comedy"
    )
  ) |>
  ggplot(aes(x = parent_average_rating,
             y = average_rating)) +
  geom_jitter(alpha = 0.85) +
  geom_mark_hull(concavity = 2.8) +
  geom_smooth(colour = '#194747',
              linewidth = 0.5) +
  theme_minimal() +
  labs(
    title = "shows and episodes ratings",
    subtitle = "hullplot mapping the coverage of 'Comedy' genre",
    caption = "tidytuesday 2023_51 [https://shorturl.at/csKS2]",
    x = "shows's rating",
    y = "episode's rating") +
  theme(
    axis.text.x = element_text(family = 'Consolas', size = 10),
    axis.title = element_text(family = 'Consolas', size = 10),
    plot.title = element_text(face = 'bold', family = 'Consolas', size = 15),
    plot.subtitle = element_text(family = 'Consolas', size = 12),
    plot.caption = element_text(family = 'Consolas'),
    legend.position = 'none'
)

# hull plot focused on "Reality-TV"
he |>
  mutate(genres = str_replace(genres, ",(.*)", "")) |>
  filter(
    genres %in% c(
      "Reality-TV"
    )
  ) |>
  ggplot(aes(x = parent_average_rating,
             y = average_rating)) +
  geom_jitter(alpha = 0.85) +
  geom_mark_hull(concavity = 2.8) +
  geom_smooth(colour = '#194747',
              linewidth = 0.5) +
  theme_minimal() +
  labs(
    title = "shows and episodes ratings",
    subtitle = "hullplot mapping the coverage of 'Reality-TV' genre",
    caption = "tidytuesday 2023_51 [https://shorturl.at/csKS2]",
    x = "shows's rating",
    y = "episode's rating") +
  theme(
    axis.text.x = element_text(family = 'Consolas', size = 10),
    axis.title = element_text(family = 'Consolas', size = 10),
    plot.title = element_text(face = 'bold', family = 'Consolas', size = 15),
    plot.subtitle = element_text(family = 'Consolas', size = 12),
    plot.caption = element_text(family = 'Consolas'),
    legend.position = 'none'
)

# 2d bin counts heat map plots ----

# 2d bin counts heat map plot for "Comedy"
he |>
  mutate(genres = str_replace(genres, ",(.*)", "")) |>
  filter(genres %in% c("Comedy")) |>
  ggplot(aes(x = parent_average_rating,
             y = average_rating)) +
  geom_bin_2d(bins = 50, alpha = 0.85) +
  scale_fill_viridis_c(option = 'rocket') +
  theme_minimal() +
  labs(
    title = "shows and episodes ratings",
    subtitle = "2d bin heatmap mapping counts across averages for 'Comedy'",
    caption = "tidytuesday 2023_51 [https://shorturl.at/csKS2]",
    x = "shows's rating",
    y = "episode's rating") +
  theme(
    axis.text.x = element_text(family = 'Consolas', size = 10),
    axis.title = element_text(family = 'Consolas', size = 10),
    plot.title = element_text(face = 'bold', family = 'Consolas', size = 15),
    plot.subtitle = element_text(family = 'Consolas', size = 12),
    plot.caption = element_text(family = 'Consolas')
)

# 2d bin counts heat map plot for "Reality-TV"
he |>
  mutate(genres = str_replace(genres, ",(.*)", "")) |>
  filter(genres %in% c("Reality-TV")) |>
  ggplot(aes(x = parent_average_rating,
             y = average_rating)) +
  geom_bin_2d(bins = 50, alpha = 0.85) +
  scale_fill_viridis_c(option = 'rocket') +
  theme_minimal() +
  labs(
    title = "shows and episodes ratings",
    subtitle = "2d bin heatmap mapping counts across averages for 'Reality-TV'",
    caption = "tidytuesday 2023_51 [https://shorturl.at/csKS2]",
    x = "shows's rating",
    y = "episode's rating") +
  theme(
    axis.text.x = element_text(family = 'Consolas', size = 10),
    axis.title = element_text(family = 'Consolas', size = 10),
    plot.title = element_text(face = 'bold', family = 'Consolas', size = 15),
    plot.subtitle = element_text(family = 'Consolas', size = 12),
    plot.caption = element_text(family = 'Consolas')
)

# Notched-box plot ----

# notched-box plot for "Comedy"
he |> 
  mutate(genres = str_replace(genres, ",(.*)", ""))  |>  
  filter(genres %in% c("Comedy")) |>  
  pivot_longer(
    cols = c(parent_average_rating, average_rating),
    names_to = "rating_type",
    values_to = "rating_value"
  ) |>  
  mutate(rating_type = case_when(
    rating_type == "parent_average_rating" ~ "show's rating",
    rating_type == "average_rating" ~ "episodes's rating",
    TRUE ~ rating_type
    )
  ) |> 
  ggplot(aes(x = rating_type, y = rating_value, fill = rating_type)) +
  geom_boxplot(notch = TRUE,
               outlier.shape = NA,
               varwidth = TRUE,
               width = 0.5) +
  stat_summary(
    family = 'Consolas',
    fun = 'mean',
    geom = 'text',
    aes(label = paste("Mean = ", round(after_stat(y), 2))),
    position = position_dodge(width = 0.75),
    hjust = 1.25,
    vjust = 8
  ) +
  stat_summary(
    family = 'Consolas',
    fun = 'median',
    geom = 'text',
    aes(label = paste("Median = ", round(after_stat(y), 2))),
    position = position_dodge(width = 0.75),
    hjust = 1.25,
    vjust = 10
  ) +
  labs(
    title = "Comedy",
    subtitle = "notched boxplots mapping the difference between parent and derived ratings",
    x = "rating type",
    y = "rating") +
  scale_fill_manual(values = c("#ffffff", "#ffffff")) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(family = 'Consolas', size = 10),
    axis.title = element_text(family = 'Consolas', size = 10),
    plot.title = element_text(face = 'bold', family = 'Consolas', size = 15),
    plot.subtitle = element_text(family = 'Consolas', size = 12),
    plot.caption = element_text(family = 'Consolas'),
    legend.position = 'none'
)

# notched-box plot "Reality-TV"
he  |>
  mutate(genres = str_replace(genres, ",(.*)", "")) |> 
  filter(genres %in% c("Reality-TV"))  |>  
  pivot_longer(
    cols = c(parent_average_rating, average_rating),
    names_to = "rating_type",
    values_to = "rating_value"
  ) |>  
  mutate(rating_type = case_when(
    rating_type == "parent_average_rating" ~ "show's rating",
    rating_type == "average_rating" ~ "episodes's rating",
    TRUE ~ rating_type
  )
  ) |>  
  ggplot(aes(x = rating_type, y = rating_value, fill = rating_type)) +
  geom_boxplot(notch = TRUE,
               outlier.shape = NA,
               varwidth = TRUE,
               width = 0.5) +
  stat_summary(
    family = 'Consolas',
    fun = 'mean',
    geom = 'text',
    aes(label = paste("Mean = ", round(after_stat(y), 2))),
    position = position_dodge(width = 0.75),
    hjust = 2,
    vjust = 11
  ) +
  stat_summary(
    family = 'Consolas',
    fun = 'mean',
    geom = 'text',
    aes(label = paste("Median = ", round(after_stat(y), 2))),
    position = position_dodge(width = 0.75),
    hjust = 2,
    vjust = 13
  ) +
  labs(
    title = "Reality-TV",
    subtitle = "notched boxplots mapping the difference between parent and derived ratings",
    x = "rating type",
    y = "rating") +
  scale_fill_manual(values = c("#ffffff", "#ffffff")) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(family = 'Consolas', size = 10),
    axis.title = element_text(family = 'Consolas', size = 10),
    plot.title = element_text(face = 'bold', family = 'Consolas', size = 15),
    plot.subtitle = element_text(family = 'Consolas', size = 12),
    plot.caption = element_text(family = 'Consolas'),
    legend.position = 'none'
)

# ANALYSE ----

he |>
  mutate(genres = str_replace(genres, ",(.*)", "")) |>
  filter(
    genres %in% c(
      "Comedy"
    )
  ) %$%
  length(parent_average_rating)
## enough data points for lm = TRUE

he |>
  mutate(genres = str_replace(genres, ",(.*)", "")) |>
  filter(
    genres %in% c(
      "Reality-TV"
    )
  ) %$%
  length(parent_average_rating)
## enough data points for lm = FALSE

# check normality ----

# comedy's parent_average_rating
he |>
  mutate(genres = str_replace(genres, ",(.*)", "")) |>
  filter(genres %in% c("Comedy")) %$%
  ks.test(parent_average_rating, 
          'pnorm',
          mean(parent_average_rating),
          sd(parent_average_rating)
  )

# reality-tv's parent_average_rating
he |>
  mutate(genres = str_replace(genres, ",(.*)", "")) |>
  filter(genres %in% c("Reality-TV")) %$%
  ks.test(parent_average_rating, 
          'pnorm',
          mean(parent_average_rating),
          sd(parent_average_rating)
  )

# correlation tests ----

# non-parametric
he |>
  mutate(genres = str_replace(genres, ",(.*)", "")) |>
  filter(genres %in% c("Comedy")) %$%
  cor.test(parent_average_rating, 
           average_rating, 
           method = 'spearman')
## Spearman's rank correlation coefficient, denoted by ρ, is a nonparametric
## measure of rank correlation between two variables. It assesses how well the
## relationship between two variables can be described using a monotonic
## function. The sample estimate of ρ for the given data of
## parent_average_rating and average_rating is 0.4344573, indicating a positive
## correlation between the two variables. The p-value is less than 2.2e-16,
## which is highly significant and suggests that the correlation is not due to
## chance. However, the warning message "Cannot compute exact p-value with ties"
## indicates that there may be tied ranks in the data, which can affect the
## accuracy of the p-value.
### output interpreted by https://www.perplexity.ai/

# parametric
he |>
  mutate(genres = str_replace(genres, ",(.*)", "")) |>
  filter(genres %in% c("Reality-TV")) %$%
  cor.test(parent_average_rating, 
           average_rating, 
           method = 'pearson')
## The given data presents a Pearson's product-moment correlation analysis with
## the following statistics: 
## - Parent average rating: 8.9732 
## - Alternative hypothesis: true correlation is not equal to 0 
## - p-value: 4.852e-13 95 percent
## - confidence interval: 0.6108542 to 0.8325809 
## - Sample estimates:
##   - Correlation coefficient (cor): 0.7413123
## The p-value of 4.852e-13 is a measure of the statistical significance of the
## correlation between the two variables. It represents the probability of
## observing a correlation coefficient as extreme or more extreme than the
## calculated value, assuming the null hypothesis is true. In this case, the
## p-value is much smaller than the significance level of 0.05, indicating that
## the correlation between the parent average rating and average rating is
## highly significant. The 95 percent confidence interval for the correlation
## coefficient ranges from 0.6108542 to 0.8325809. This interval represents the
## range in which the true population correlation coefficient is likely to fall,
## with 95 percent confidence. In summary, the Pearson's product-moment
## correlation analysis indicates a strong positive relationship between the
## parent average rating and average rating, with a p-value of 4.852e-13 and a
## 95 percent confidence interval of 0.6108542 to 0.8325809.
### output interpreted by https://www.perplexity.ai/

# regression analysis ----

# Comedy
he |>
  mutate(genres = str_replace(genres, ",(.*)", "")) |>
  filter(genres %in% c("Comedy")) %$%
  lm(parent_average_rating ~ average_rating) |> 
  summary()
## \[y=mx+b\] -> (y = 0.46967x + 3.83954)

he |>
  mutate(genres = str_replace(genres, ",(.*)", "")) |>
  filter(genres %in% c("Comedy")) %$%
  lm(parent_average_rating ~ average_rating) |> 
  model_performance()
## The output from the R code provides various metrics to assess the performance
## of a linear regression model. Here's a brief interpretation of each metric:
##
## - AIC (Akaike's Information Criterion): A measure of the model's relative
## quality, with lower values indicating a better fit while considering the
## model's complexity. 
## - AICc (Corrected Akaike's Information Criterion): A version
## of AIC that is adjusted for small sample sizes.
## - BIC (Bayesian Information Criterion): Similar to AIC, 
## BIC also measures the model's goodness of fit, but
## it penalizes model complexity more heavily. 
## - R-squared (R2): A measure of how well the independent variables explain 
## the variability of the dependent variable, values closer to 1 indicate a better fit.
## - Adjusted R-squared (R2 (adj.)): A version of R-squared 
## that accounts for the number of predictors in the model,
## often preferred when working with multiple independent variables.
## - RMSE (Root Mean Square Error): A measure of the differences between
## predicted values and observed values, with lower values indicating a better fit.
## - Sigma: The standard deviation of the errors in the regression model.
##
## These metrics collectively provide insights into the model's goodness of fit,
## complexity, and predictive accuracy. In the provided output, the model has
## relatively high AIC, AICc, and BIC values, a low R-squared value of 0.187, and
## relatively low RMSE and Sigma, suggesting a moderate fit of the model to the data.
### output interpreted by https://www.perplexity.ai/

# scatterplot for "Comedy"
he |>
  mutate(genres = str_replace(genres, ",(.*)", "")) |>
  filter(genres %in% c("Comedy")) |>
  ggplot(aes(x = parent_average_rating,
             y = average_rating)) +
  geom_jitter(alpha = 0.15) +
  geom_smooth(colour = '#000000',
              method = 'lm',
              linewidth = 0.5) +
  geom_text(label = "y = 0.46967x + 3.83954", 
            size = 3,
            x = 4, 
            y = 5
  ) +
  theme_minimal() +
  labs(
    title = "Comedy",
    subtitle = "scatterplot mapping relationship between averages",
    caption = "tidytuesday 2023_51 [https://shorturl.at/csKS2]",
    x = "shows's rating",
    y = "episode's rating") +
  theme(
    axis.text.x = element_text(family = 'Consolas', size = 10),
    axis.title = element_text(family = 'Consolas', size = 10),
    plot.title = element_text(face = 'bold', family = 'Consolas', size = 15),
    plot.subtitle = element_text(family = 'Consolas', size = 12),
    plot.caption = element_text(family = 'Consolas'),
    legend.position = 'none'
)

# Reality-TV
he |>
  mutate(genres = str_replace(genres, ",(.*)", "")) |>
  filter(genres %in% c("Reality-TV")) %$%
  lm(parent_average_rating ~ average_rating) |> 
  summary()
## \[y=mx+b\] -> (y = 0.89229x + 0.08132)

he |>
  mutate(genres = str_replace(genres, ",(.*)", "")) |>
  filter(genres %in% c("Reality-TV")) %$%
  lm(parent_average_rating ~ average_rating) |> 
  model_performance()
## The output from the R code represents the performance of a linear regression
## model. Here's how to interpret it: AIC, AICc, BIC: These are information
## criteria used for model selection. Lower values indicate a better fit, so the
## model with the lowest AIC, AICc, or BIC is preferred. R-squared (R2): This is
## a measure of how well the independent variables explain the variability of the
## dependent variable. It ranges from 0 to 1, with 1 indicating a perfect fit.
## Adjusted R-squared (R2 (adj.)): This is the R-squared value adjusted for the
## number of predictors in the model. It is a more reliable measure when working
## with multiple independent variables. RMSE: Root Mean Square Error is a measure
## of the differences between values predicted by a model and the actual values
## observed. It represents the sample standard deviation of the differences
## between predicted values and observed values. Sigma: This represents the
## standard deviation of the errors in the regression model. In this specific
## output, the model has a relatively low AIC, AICc, and BIC, a moderate
## R-squared value of 0.55, and a relatively low RMSE and Sigma, indicating a
## reasonably good fit of the model to the data.
### output interpreted by https://www.perplexity.ai/

# scatterplot for "Reality-TV"
he |>
  mutate(genres = str_replace(genres, ",(.*)", "")) |>
  filter(genres %in% c("Reality-TV")) |>
  ggplot(aes(x = parent_average_rating,
             y = average_rating)) +
  geom_jitter(alpha = 0.15) +
  geom_smooth(colour = '#000000',
              method = 'lm',
              linewidth = 0.5) +
  geom_text(label = "y = 0.89229x + 0.08132", 
            size = 3,
            x = 5.5, 
            y = 5
  ) +
  theme_minimal() +
  labs(
    title = "Reality-TV",
    subtitle = "scatterplot mapping relationship between averages",
    caption = "tidytuesday 2023_51 [https://shorturl.at/csKS2]",
    x = "shows's rating",
    y = "episode's rating") +
  theme(
    axis.text.x = element_text(family = 'Consolas', size = 10),
    axis.title = element_text(family = 'Consolas', size = 10),
    plot.title = element_text(face = 'bold', family = 'Consolas', size = 15),
    plot.subtitle = element_text(family = 'Consolas', size = 12),
    plot.caption = element_text(family = 'Consolas'),
    legend.position = 'none'
)

# ...