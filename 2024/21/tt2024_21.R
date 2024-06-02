# --- TIDYTUESDAY::2024§21 --- #

# https://github.com/rfordatascience/tidytuesday/tree/master/data/2024/2024-05-21

# Load ----

# packages ----
pacman::p_load(
  car,
  caret,
  data.table,
  easystats,
  ggthemes,
  ggstatsplot,
  janitor,
  lmtest,
  skimr,
  tidyverse
)

# data ----
df <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-05-21/emissions.csv'
  ) |>
  clean_names()
# dictionary
# https://t.ly/o3ica

# Wrangle ----

# eda ----

# names
df |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
df |>
  glimpse() |>
  skim()

# summarise

df |> 
  group_by(commodity) |> 
  summarise(n = n()) |> 
  arrange(desc(n))

df |> 
  group_by(production_unit) |> 
  summarise(n = n()) |> 
  arrange(desc(n))
## cement, measured in million tonnes co2 looks interesting

# Visualise ----

# "Bcf/yr" :: billion cubic feet per year (used for natural gas)
# "Million bbl/yr" :: million barrels per year (used for oil and natural gas liquids)
# "Million tonnes/yr" :: million tonnes per year (used for coal and cement)
# "Million Tonnes CO2" :: million tonnes of CO2 per year (used for cement)

# tabular ----
df |> 
  filter(production_unit == "Million Tonnes CO2") |>
  group_by(parent_entity) |> 
  summarise(n = n()) |> 
  arrange(desc(n)) |> 
  knitr::kable()

df |> 
  filter(production_unit == "Million Tonnes CO2") |>
  group_by(parent_type) |> 
  summarise(n = n()) |> 
  arrange(desc(n)) |> 
  knitr::kable()

# graphical ----
df |>
  filter(production_unit == "Million Tonnes CO2") |>
  ggplot(aes(x = production_value,
             y = total_emissions_mt_co2e)) +
  geom_point(alpha = 0.8)  +
  geom_smooth(color = "#9d0006",
              method = 'gam',
              se = TRUE) +
  facet_wrap(parent_type ~ .) +
  labs(
    title = "MtCO2e emissions ~ production",
    x = "production value",
    y = "total emissions mt/co2e") +
  ggstatsplot::theme_ggstatsplot()
## it seems national entities from China aren't as inviting
## as investor-owned companies; which are behaving somewhat funky
## therefore more intriguing to analyse!

# Analyse ----

# simple linear regression ----

# variables ----

# criteria|dv|response = total_emissions_mt_co2e :: y
# predictor|iv|explanatory = production_value :: x

# model ----

# which translates into the following,
# something of the change in production_value
# might explain a change in total_emissions_mt_co2e;
# if true, a causal relationship is highly expected

df_mod <- df |> 
  filter(production_unit == "Million Tonnes CO2") |> 
  filter(parent_type != "Nation State")

df_mod_model <- lm(total_emissions_mt_co2e ~ production_value, data = df_mod)

summary(df_mod_model)

preds <- predict(df_mod_model, newdata = df_mod)

residuals <- df_mod$total_emissions_mt_co2e-preds

qqnorm(residuals)
qqline(residuals)

RMSE(preds, df$total_emissions_mt_co2e)

## check assumptions ----

### normality ----

#### analytical ----

# according to https://youtu.be/sDrAoR17pNM
# ks.test() and shapiro.test() can be used;
# if p-value >= 0.05,
# there's no deviation of the data from the normal distribution
# so we can assume data is normally distributed
# however ks.test() and shapiro.test() become significant
# very quickly with a large sample
# ---

ks.test(df_mod$production_value, df_mod$total_emissions_mt_co2e)

shapiro.test(df_mod$total_emissions_mt_co2e)

# https://t.ly/G5RHg
# interpretation suggests data does not exhibit a normal distribution

#### graphical ----

# histograms
hist(df_mod$production_value)
hist(df_mod$total_emissions_mt_co2e)

# qqplot
qqplot(
  x = df_mod$production_value,
  y = df_mod$total_emissions_mt_co2e,
  main = "normal q-q plot",
  xlab = "theoretical quantiles",
  ylab = "sample quantiles"
)

### homoscedasticity ----

# https://en.wikipedia.org/wiki/Homoscedasticity_and_heteroscedasticity
## tldr :: https://t.ly/Dv6_F

# https://t.ly/mayoK

#### analytical ----

ncvTest(df_mod_model)

gqtest(df_mod_model, order.by = ~ production_value, data = df_mod)

# https://t.ly/o2ubZ
# interpretation suggests a high chance of heteroscedasticity

#### graphical ----

plot(fitted(df_mod_model), 
     resid(df_mod_model), 
     xlab = "fitted values", 
     ylab = "residuals")
# observation suggests a high chance of heteroscedasticity

### multicollinearity ----

# https://t.ly/r2m74

# If you have only two metric variables, one as the criteria (dependent
# variable) and the other as the predictor (independent variable), then you do
# not need to check for multicollinearity. Multicollinearity typically arises
# when there are multiple predictor variables that are highly correlated with
# each other, which can lead to unstable regression coefficients and poor model
# performance. With only two variables, there is no possibility of
# multicollinearity because there are no other variables to be correlated with
# each other. In such a case, you can proceed with your regression analysis
# without worrying about multicollinearity.

# plot ----

ggscatterstats(
  df_mod,
  production_value,
  total_emissions_mt_co2e,
  type = 'nonparametric',
  conf.level = 0.95,
  smooth.line.args = list(
    linewidth = 0.5,
    color = "#9d0006",
    method = 'lm',
    formula = y ~ x
  ),
  xsidehistogram.args = list(
    binwidth = 5,
    fill = "#b57614",
    color = "#282828",
    na.rm = TRUE
  ),
  ysidehistogram.args = list(
    binwidth = 5,
    fill = "#8f3f71",
    color = "#282828",
    na.rm = TRUE
  ),
  xlab = "production value",
  ylab = "total emissions mt co2e",
  title = "cement's emissions according to production",
  caption = "emissions mt/co2e = -0.037196 + 0.632733 * production_value",
  ggtheme = ggstatsplot::theme_ggstatsplot(),
  ggplot.component = NULL
)

# equation ----

# get coefficients from the model summary
df_mod_model_intercept <- summary(df_mod_model)$coefficients[1, 1]
df_mod_model_slope <- summary(df_mod_model)$coefficients[2, 1]

# Construct the linear equation
df_mod_model_linear_equation <- paste("emissions mt/co2e =", round(df_mod_model_intercept, 6), "+", round(df_mod_model_slope, 6), "* production_value")

# Print the linear equation
print(df_mod_model_linear_equation)
