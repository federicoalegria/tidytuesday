# --- TIDYTUESDAY::2024§24 --- #

# https://github.com/rfordatascience/tidytuesday/tree/master/data/2024/2024-06-11/readme.md

# Load ----

# packages ----
pacman::p_load(
  data.table,
  easystats,
  ggstatsplot,
  ggthemes,
  janitor,
  lme4,        # https://cran.r-project.org/web/packages/lme4/index.html
  sjPlot,      # https://cran.r-project.org/web/packages/sjPlot/index.html
  skimr,
  tidyverse
)

# data ----
df_pi <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-06-11/pride_index.csv'
  ) |>
  clean_names()

df_pit <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-06-11/pride_index_tags.csv'
  ) |>
  clean_names()
# dictionary
# https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-06-11/readme.md

df <- 
  full_join(df_pi, 
            df_pit, 
            by = c("campus_name", "campus_location")
)

rm(df_pi, df_pit)

# Wrangle ----

# recode lgl as binary
df_bin <- 
  df |> 
  mutate(across(6:21, ~if_else(is.na(.x), FALSE, .x) %>% as.integer())) |> 
  select(3,6:21)

# eda ----

# names
df_bin|> 
  slice(0) |> 
  glimpse()

# glimpse & skim
df_bin|>
  glimpse() |>
  skim()

# quick-summaries
qs <- function(df_bin, start, end) {
  for (i in start:end) {
    print(df_bin |> group_by(!!sym(names(df_bin)[i])) |> summarise(n = n()))
  }
}
# look for high 1-count
qs(df_bin, 2, 17)

# Analyse ----

# model

model <- glm(rating ~ ., data = df_bin[, c(1, 2:9)])

plot_model(model, type = 'pred', terms = "baccalaureate")

# Visualise ----

# raw ----

df_bin_cor <- 
  df_bin |> 
  select(1:9) |> 
  correlation()                # https://easystats.github.io/correlation/

df_bin_cor |> 
  summary(redundant = TRUE) |> 
  plot()

# rice ----

df_bin |> 
  select(1:9) |> 
  ggcorrmat(
    title    = "correlalogram",
    subtitle = "for campus pride index"
    ) + 
  theme_wsj(color = "#F8F8F8") + 
  theme(
    axis.text.x = element_text(angle = 30, family = 'Consolas', hjust = 1),
    axis.text.y = element_text(family = 'Consolas'),
    legend.position = 'none',
    plot.caption = element_text(family = 'Consolas', size = 8),
    plot.subtitle = element_text(family = 'Consolas', size = 18),
    plot.title = element_text(family = 'Consolas', size = 23)
)

# Communicate ----

summary(model)

# Call:
#   glm(formula = rating ~ ., data = df_bin[, c(1, 2:9)])
# 
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept)     3.740840   0.188716  19.823  < 2e-16 ***
#   public          0.168428   0.206856   0.814 0.416361    
# private        -0.001256   0.219501  -0.006 0.995440    
# doctoral        0.449971   0.116327   3.868 0.000143 ***
#   masters        -0.181163   0.145681  -1.244 0.214931    
# baccalaureate   0.096990   0.151771   0.639 0.523424    
# community      -0.605825   0.234838  -2.580 0.010512 *  
#   residential     0.092749   0.142771   0.650 0.516581    
# nonresidential -0.201328   0.148318  -1.357 0.175989    
# ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# (Dispersion parameter for gaussian family taken to be 0.5366769)
# 
# Null deviance: 157.93  on 237  degrees of freedom
# Residual deviance: 122.90  on 229  degrees of freedom
# AIC: 538.12
# 
# Number of Fisher Scoring iterations: 2

report(model)

# The effect of `doctoral` is statistically significant and positive
# beta = 0.45, 95% CI [0.22, 0.68], t(229) = 3.87, p < .001; Std. beta = 0.28, 95% CI [0.14, 0.42])
#
# The effect of `community` is statistically significant and negative
# beta = -0.61, 95% CI [-1.07, -0.15], t(229) = -2.58, p = 0.010; Std. beta = -0.22, 95% CI [-0.39, -0.05]
#
# Standardized parameters were obtained by fitting the model on a standardized
# version of the dataset. 95% Confidence Intervals (CIs) and p-values were
# computed using a Wald t-distribution approximation.
