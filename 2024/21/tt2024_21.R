# --- TIDYTUESDAY::2024§21 --- #

# https://github.com/rfordatascience/tidytuesday/tree/master/data/2024/...

# Load ----

# packages ----
pacman::p_load(
  data.table,
  easystats,
  ggthemes,
  janitor,
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
# https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-05-21/readme.md

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
  group_by(parent_entity) |> 
  summarise(n = n()) |> 
  arrange(desc(n))

df |> 
  group_by(parent_type) |> 
  summarise(n = n()) |> 
  arrange(desc(n))

df |> 
  group_by(commodity) |> 
  summarise(n = n()) |> 
  arrange(desc(n))

df |> 
  group_by(production_unit) |> 
  summarise(n = n()) |> 
  arrange(desc(n))

# Visualise ----

# vis_01
df |> 
  group_by(commodity) |>
  summarize(
    min_year = min(year),
    max_year = max(year)
  ) |>
  arrange(desc(commodity)) |> 
  ggplot() +
  geom_segment(aes(
    x = min_year,
    xend = max_year,
    y = commodity
  ), color = "#9d0006") +
  geom_point(
    aes(x = min_year, y = commodity),
    color = '#9d0006',
    alpha = 0.9,
    size = 3.5
  ) +
  geom_text(
    aes(x = min_year, y = commodity, label = min_year),
    size = 4,
    hjust = -0.45,
    vjust = -1.25,
    family = 'Consolas',
    color = '#d3ebe9'
  ) +
  theme_wsj(color = "#081F2D") +
  theme(
    axis.line.x = element_line(colour = "#d3ebe9"),
    axis.text = element_text(family = 'Consolas', colour = "#d3ebe9"),
    axis.ticks = element_line(colour = "#d3ebe9"),
    legend.text = element_text(family = 'Consolas', colour = "#d3ebe9"),
    legend.title = element_text(family = 'Consolas', size = 28, colour = "#d3ebe9"),
    panel.background = element_rect(fill = "#081F2D", colour = "#081F2D"),
    panel.grid.major.y = element_line(colour = "#d3ebe9", linetype = 'dotted'),
    plot.background = element_rect(fill = "#081F2D", colour = "#081F2D"),
    plot.caption = element_text(family = 'Consolas', size = 10, colour = "#d3ebe9"),
    plot.subtitle = element_text(family = 'Consolas', size = 13, colour = "#d3ebe9"),
    plot.title = element_text(size = 28, colour = "#d3ebe9"),
    plot.title.position = 'plot',
  ) +
  xlab("") +
  ylab("") +
  labs(title = "commodities",
       subtitle = " ",
       caption = "tidytuesday 2024§21〔https://〕"
)

# natural gas sounds green right?
# and also young when put in perspective;
# speaking if which

# vis_02
df |> 
  ggplot(aes(x = production_value,
             y = total_emissions_mt_co2e)) +
  geom_point(alpha = 0.8)  +
  geom_smooth(color = "#9d0006",
              method = 'gam',
              se = TRUE) +
  facet_wrap(production_unit ~ .) +
  labs(title = "emissions behaviour by production unit") +
  theme_wsj()

# now it looks even better
# "Bcf/yr" :: billion cubic feet per year (used for natural gas)
# "Million bbl/yr" :: million barrels per year (used for oil and natural gas liquids)
# "Million tonnes/yr" :: million tonnes per year (used for coal and cement)
# "Million Tonnes CO2" :: million tonnes of CO2 per year (used for cement)

# vis_03
df |>
  filter(production_unit == "Bcf/yr") |>
  ggplot(aes(x = production_value,
             y = total_emissions_mt_co2e)) +
  geom_point(alpha = 0.8)  +
  geom_smooth(color = "#9d0006",
              method = 'gam',
              se = TRUE) +
  labs(
    title = "emissions raise as production goes",
    x = "production value",
    y = "total emissions mt/co2e") +
  theme_wsj()

# tab_01
df |> 
  group_by(production_unit) |> 
  summarise(n = n()) |> 
  knitr::kable()

# tab_02
df |> 
  group_by(commodity) |> 
  summarise(n = n()) |> 
  knitr::kable()

# tab_03
df |> 
  group_by(parent_type, commodity) |> 
  summarise(n = n()) |> 
  knitr::kable()

# Analyse ----

df_mod <- df |> 
  filter(production_unit == "Bcf/yr")

set.seed(8080)

df_mod_sample <- df_mod[sample(100)]

# simple linear regression ----

# criteria = total_emissions_mt_co2e
# predictor = production_value
#
# which translates into the following,
# something of the change in production_value
# might explain a change in total_emissions_mt_co2e;
# if true, a causal relationship is highly expected

df_mod_sample |> 
  ggplot(aes(x = production_value,
             y = total_emissions_mt_co2e)) +
  geom_point(alpha = 0.8)  +
  geom_smooth(color = "#9d0006",
              method = 'auto',
              se = TRUE) +
  theme_wsj()

## check assumptions ----

### normality ----

# analytical

# according to https://youtu.be/sDrAoR17pNM
# ks.test() and shapiro.test() can be used;
# if p-value >= 0.05,
# there's no deviation of the data from the normal distribution
# so we can assume data is normally distributed
#
# ks.test and shapiro.test become significant
# very quickly with a large sample
# ---
# set.seed(8080)
# 
# df_mod_sample <- df_mod[sample(10)]
# 
# shapiro.test(df_mod_sample$total_emissions_mt_co2e)
# ---

# graphical

qqplot(
  x = df_mod_sample$production_value,
  y = df_mod_sample$total_emissions_mt_co2e,
  main = "normal q-q plot",
  xlab = "theoretical quantiles",
  ylab = "sample quantiles"
)

### homoscedasticity ----

# https://t.ly/mayoK

model <- lm(total_emissions_mt_co2e ~ production_value, data = df_mod_sample)

summary(model)

plot(fitted(model), resid(model), xlab = "fitted values", ylab = "residuals")

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
