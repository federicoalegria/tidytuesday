# --- TIDYTUESDAY::2024§29 --- #
# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-07-16/readme.md

# Load ----

.libPaths(c("~/.R/x86_64-pc-linux-gnu-library/4.4", .libPaths()))

# packages ----
pacman::p_load(
  data.table,           # https://cran.r-project.org/web/packages/data.table/
  janitor,              # https://cran.r-project.org/web/packages/janitor/
  skimr,                # https://cran.r-project.org/web/packages/skimr/
  tidyverse             # https://cran.r-project.org/web/packages/tidyverse/
)

# data ----
df01 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-07-16/ewf_appearances.csv'
  ) |>
  clean_names()

df02 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-07-16/ewf_matches.csv'
  ) |>
  clean_names()

df03 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-07-16/ewf_standings.csv'
  ) |>
  clean_names()
# dictionary
# https://t.ly/_MRy7

# Wrangle ----

# names
df01 |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
df01 |>
  glimpse() |>
  skim()

# eda ----

# Visualise ----

# raw ----

boxplot(df01$goals_for ~ df01$tier)

df01 |> 
  select(date, attendance) |> 
  group_by(date) |> 
  summarise(total_attendance = sum(attendance)) |> 
  ggplot(aes(x = date, y = total_attendance)) +
  geom_col(fill = '#9d0006',  width = 10.5) + 
  labs(title = "total attendance over time",
       x = "date",
       y = "total attendance") +
  theme_minimal()

# rice ----

# Analyse ----

# Communicate ----

# ...
