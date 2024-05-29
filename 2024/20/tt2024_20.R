# --- TIDYTUESDAY::2024§20  --- #

# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-05-14/readme.md
# Do you think participants in this survey are representative of Americans in general?

# Load ----

# packages ----
pacman::p_load(
  data.table,
  ggstatsplot,
  janitor,
  skimr,
  tidyverse
)

# data ----
df <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-05-14/coffee_survey.csv'
  ) |>
  clean_names()
# dictionary
# https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-05-14/readme.md

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

# select ----

df |> 
  select(2:19) |> 
  slice(28, 35, 50) |> 
  glimpse()

# Analyse ----

# unassisted ----

# differences among caffeine preferences by political affiliation
df_sp <- 
  df |> 
  select(strength, political_affiliation) |> 
  mutate(
    strength = case_when(
      strength == "Somewhat light" ~ "light",
      strength == "Weak" ~ "light",
      strength == "Medium" ~ "medium",
      strength == "Somewhat strong" ~ "strong",
      strength == "Very strong" ~ "strong"
    )
)

# coffee strength preferences' variation for different political affiliations
table(df_sp$strength, df_sp$political_affiliation)
chisq.test(df_sp$strength, df_sp$political_affiliation)
vcd::assocstats(table(df_sp$strength, df_sp$political_affiliation))

set.seed(31416)

ggbarstats(df_sp, 
           x = strength, 
           y = political_affiliation,
           type = 'nonparametric',
           title = "coffee strength preferences' variation for different political affiliations",
           legend.title = NULL,
           xlab = "political affiliation",
           ylab = NULL)
## https://indrajeetpatil.github.io/ggstatsplot/reference/ggbarstats.html

# assisted

## what's the null hypothesis for a chi-square test in which data comes from two categorical variables?
### https://search.brave.com/search?q=what%27s+the+null+hypothesis+for+a+chi-square+test+in+which+data+comes+from+two+categorical+variables%3F

## how should i interpret the following result?
##   
## Pearson's Chi-squared test
## 
## data:  df_sp$strength and df_sp$political_affiliation
## X-squared = 10.535, df = 6, p-value = 0.1039
### https://chatgpt.com/c/9d0a233c-1112-44d8-a50c-44906a92219b

# Communicate ----

# for tidytuesday 2024§20 
# i explored if there's any variation in coffee strength preferences'
# for different political affiliations. after shapeshifting caffeine
# preferments, there's a 10.39% probability that the observed differences in
# taste across different segments could have occurred by chance alone.

# submission
## https://github.com/federicoalegria/_tidytuesday/edit/main/2024/20/tt2024_20.R

# ...
