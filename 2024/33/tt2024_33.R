# --- TIDYTUESDAY::2024§33 --- #
# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-08-13/readme.md

# library path
.libPaths(c("~/.R/x86_64-pc-linux-gnu-library/4.4", .libPaths()))

# packages
pacman::p_load(
  data.table,           # https://cran.r-project.org/web/packages/data.table/
  janitor,              # https://cran.r-project.org/web/packages/janitor/
  skimr,                # https://cran.r-project.org/web/packages/skimr/
  styler,               # https://cran.r-project.org/web/packages/styler/
  tidyverse             # https://cran.r-project.org/web/packages/tidyverse/
)

# Import ----
df <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-08-13/worlds_fairs.csv'
  ) |>
  clean_names()
# dictionary
# https://t.ly/wRUcT

# Understand ----

# names
df |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
df |>
  glimpse() |>
  skim()

# group

## country
df |> 
  group_by(country) |> 
  summarise(n = n()) |> 
  arrange(desc(n)) |> 
  print(n = Inf)

## theme
df |> 
  group_by(theme) |> 
  summarise(n = n()) |> 
  arrange(desc(n)) |> 
  print(n = Inf)

# transform ---

# visualise ----

# raw
# rice

# model ----

# Communicate ----

# ...

# Does the length of a Fair depend on the month in which the fair begins? 
# How has the cost per month changed over time? How about the cost per visitor?

## https://chatgpt.com/share/255a7b6b-e404-4001-bc01-c08c3e7deae3

df |> 
  mutate(
    fair_duration = (end_year * 12 + end_month) - (start_year * 12 + start_month)) |> 
  select(country, theme, fair_duration) |> 
  glimpse() |> 
  skim()

df |> 
  mutate(
    fair_duration = (end_year * 12 + end_month) - (start_year * 12 + start_month)) |> 
  ggplot(aes(x = factor(start_month), y = fair_duration)) +
  geom_boxplot() +
  labs(x = "Start Month", y = "Fair Duration (months)", title = "Fair Duration by Start Month")

df |> 
  mutate(
    fair_duration = (end_year * 12 + end_month) - (start_year * 12 + start_month),
    cost_per_month = cost / fair_duration,
    cost_per_visitor = cost / visitors
  ) |> 
  ggplot(aes(x = start_year + start_month / 12)) +
  geom_line(aes(y = cost_per_month, color = "Cost per Month")) +
  geom_line(aes(y = cost_per_visitor, color = "Cost per Visitor")) +
  labs(x = "Year", y = "Cost", title = "Cost per Month and Cost per Visitor over Time") +
  scale_color_manual(name = "Metric", values = c("Cost per Month" = "blue", "Cost per Visitor" = "red"))
