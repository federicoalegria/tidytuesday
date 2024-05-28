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

# Visualise ----

# raw

# rice

# Analyse ----

# differences ----

# among caffeine preferences by political affiliation
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

table(df_sp$strength, df_sp$political_affiliation)

chisq.test(df_sp$strength, df_sp$political_affiliation)

vcd::assocstats(table(df_sp$strength, df_sp$political_affiliation))

set.seed(31416)

ggbarstats(df_sp, 
           x = strength, 
           y = political_affiliation,
           type = 'nonparametric',
           title = "differences in caffeine choices by political affiliation",
           legend.title = NULL,
           xlab = "political affiliation",
           ylab = NULL)

# Communicate ----

# submission

# ...
