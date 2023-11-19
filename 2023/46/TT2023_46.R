
# --- TIDYTUESDAY::2023_46 --- #

# Libraries ----

pacman::p_load(
  ggforce,
  ggridges,
  ggstatsplot,
  ggthemes,
  janitor,
  patchwork,
  skimr,
  tidylog,
  tidyverse,
  viridis
)

# DATA ----

df <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-11-14/diwali_sales_data.csv'
  ) |> 
  clean_names()

# glimpse & skim
df |>
  glimpse() |> 
  skim()

# names
df |>
  slice(0) |> 
  glimpse()

# TRANSFORM ----

df$marital_status <- as.character(df$marital_status)
df$orders <- as.character(df$orders)

# EXPLORE ----

# numeric variable
df |> 
  select(amount) |> 
  drop_na() |> 
  summarise(mean = mean(amount),
            median = median(amount),
            sd = sd(amount),
            iqr = IQR(amount),
            min = min(amount),
            max = max(amount))

# VISUALISE ----

# Ridge plot
df |>
  mutate(product_category = factor(product_category,
                                   levels = unique(product_category))) |>
  ggplot(aes(x = amount,
             y = product_category)) +
  geom_density_ridges(aes(fill = product_category),
                      alpha = 0.7) +
  scale_fill_manual(values = inferno(18)) +
  labs(
    title = "Diwali sales data",
    subtitle = "amount in ₹ / product category",
    caption = "{tidytuesday 2023∙46}
    https://github.com/rfordatascience/tidytuesday/blob/master/data/2023/2023-11-14/readme.md",
    x = "Amount in ₹ (INR)",
    y = ""
  ) +
  theme_solarized(light = FALSE) +
  theme(
    legend.position = "none",
    text = element_text(color = "#d6d6d6"),
    axis.text = element_text(color = "#d6d6d6", family = "Roboto"),
    plot.title = element_text(color = "#d6d6d6", family = "Roboto Bold"),
    plot.subtitle = element_text(color = "#d6d6d6", family = "Roboto"),
    plot.caption = element_text(color = "#d6d6d6", family = "Monospace"),
    axis.title = element_text(color = "#d6d6d6", family = "Roboto")
  )

# ANALYSE ----

df_test <- df |> 
  filter(product_category == "Tupperware")

# Histogram with statistical details from one-sample test
gghistostats(
  data = df_test,
  x = amount,
  type = "nonparametric",
  bin.args = list(fill = "#fa9407",
                  alpha = 0.7),
  centrality.line.args = list(
    color = "#d6d6d6",
    linewidth = 0.5,
    linetype = "dashed"
  )
) +
  theme_solarized(light = FALSE) +
  theme(
    legend.position = "none",
    text = element_text(color = "#d6d6d6"),
    axis.text = element_text(color = "#d6d6d6", family = "Roboto"),
    plot.title = element_text(color = "#d6d6d6", family = "Roboto Bold"),
    plot.subtitle = element_text(color = "#d6d6d6", family = "Roboto"),
    plot.caption = element_text(color = "#d6d6d6", family = "Monospace"),
    axis.title = element_text(color = "#d6d6d6", family = "Roboto")
  )
## the test suggest that there is strong evidence to reject the null hypothesis
## and conclude that there is a significant difference in the distribution 
## of the amount spent in Tupperware articles during Dwali holidays.
### https://www.reddit.com/r/AskStatistics/comments/vw4qje/what_does_the_v_value_represent_in_the_wilcoxon/?rdt=54735

report::report_statistics(df_test$amount)
ks.test(df_test$amount, "pnorm")
## with a very low p-value of 4.434e-06, the null hypothesis of normality
## is rejected, indicating that the data is not normally distributed.

# United Tupperware are Us ----

p1 <-
  ggbetweenstats(
    data = df_test,
    x = age_group,
    y = amount,
    type = "nonparametric",
    centrality.point.args = list(size = 5,
                                 color = "#fa9407")
  ) +
  labs(x = "age group") +
  theme_solarized(light = FALSE) +
  theme(
    legend.position = "none",
    text = element_text(color = "#d6d6d6"),
    axis.text = element_text(color = "#d6d6d6", family = "Roboto"),
    plot.title = element_text(color = "#d6d6d6", family = "Roboto Bold"),
    plot.subtitle = element_text(color = "#d6d6d6", family = "Roboto"),
    plot.caption = element_text(color = "#d6d6d6", family = "Monospace"),
    axis.title = element_text(color = "#d6d6d6", family = "Roboto")
  )
## p = 0.59

p2 <-
  ggbetweenstats(
    data = df_test,
    x = gender,
    y = amount,
    type = "nonparametric",
    centrality.point.args = list(size = 5,
                                 color = "#fa9407")
  ) +
  theme_solarized(light = FALSE) +
  theme(
    legend.position = "none",
    text = element_text(color = "#d6d6d6"),
    axis.text = element_text(color = "#d6d6d6", family = "Roboto"),
    plot.title = element_text(color = "#d6d6d6", family = "Roboto Bold"),
    plot.subtitle = element_text(color = "#d6d6d6", family = "Roboto"),
    plot.caption = element_text(color = "#d6d6d6", family = "Monospace"),
    axis.title = element_text(color = "#d6d6d6", family = "Roboto")
  )
## p = 0.87

p3 <-
  ggbetweenstats(
    data = df_test,
    x = marital_status,
    y = amount,
    type = "nonparametric",
    centrality.point.args = list(size = 5,
                                 color = "#fa9407")
  ) +
  labs(x = "marital status") +
  theme_solarized(light = FALSE) +
  theme(
    legend.position = "none",
    text = element_text(color = "#d6d6d6"),
    axis.text = element_text(color = "#d6d6d6", family = "Roboto"),
    plot.title = element_text(color = "#d6d6d6", family = "Roboto Bold"),
    plot.subtitle = element_text(color = "#d6d6d6", family = "Roboto"),
    plot.caption = element_text(color = "#d6d6d6", family = "Monospace"),
    axis.title = element_text(color = "#d6d6d6", family = "Roboto")
  )

p4 <-
  ggbetweenstats(
    data = df_test,
    x = zone,
    y = amount,
    type = "nonparametric",
    centrality.point.args = list(size = 5,
                                 color = "#fa9407")
  ) +
  theme_solarized(light = FALSE) +
  theme(
    legend.position = "none",
    text = element_text(color = "#d6d6d6"),
    axis.text = element_text(color = "#d6d6d6", family = "Roboto"),
    plot.title = element_text(color = "#d6d6d6", family = "Roboto Bold"),
    plot.subtitle = element_text(color = "#d6d6d6", family = "Roboto"),
    plot.caption = element_text(color = "#d6d6d6", family = "Monospace"),
    axis.title = element_text(color = "#d6d6d6", family = "Roboto")
  )

# COMMUNICATE ----

# Diwali, also known as Deepavali, is a major Hindu festival celebrated in 
# India and other Indian religions. It symbolizes the spiritual victory of light
# over darkness, good over evil, and knowledge over ignorance[2]. 
# The festival gets its name from the row of clay lamps (deepa) that Indians 
# light outside their homes to symbolize the victory of good over evil[1]. 
# Diwali is celebrated during the Hindu lunisolar months of Ashvin and Kartika, 
# which generally fall between mid-September and mid-November[2]. 
# The festival lasts for five days and is marked by various rituals and traditions,
# including the lighting of diyas (small earthenware lamps filled with oil) 
# and the decoration of homes with rangolis, which are elaborate designs made 
# of colored rice, sand, or flower petals[4].

# Citations:
# [1] https://kids.nationalgeographic.com/pages/article/diwali
# [2] https://en.wikipedia.org/wiki/Diwali
# [3] https://www.natgeokids.com/uk/discover/geography/general-geography/facts-about-diwali/
# [4] https://www.britannica.com/topic/Diwali-Hindu-festival

p1 + p2 + p3 + p4

# There is not enough evidence to conclude that the medians 
# of the compared groups are different; meaning Tupperware
# items could be considered as a basic need despite social
# characteristics like age, gender, marital status & zone.

# ... ----

# Carbon ----

# colours
"#002a37"
"#ffbd00"

# text

# For TidyTuesday week 46, we received sales data for a retail store during the
# Diwali festival period in India. According to Wikipedia, Diwali (aka
# Deepavali) is a major festival that symbolizes the spiritual victory of light
# over darkness, good over evil, and knowledge over ignorance.
#
# After a quick EDA, the "Tupperware" product category caught my immediate
# attention. Some tests later, no significant evidence to support that the
# medians of the compared groups are different was found. Therefore, these items
# could be considered a basic need despite social characteristics like age,
# gender, marital status, and zone.
#
# This conclusion should not be taken for granted and serves solely to a
# self-development excercise.
