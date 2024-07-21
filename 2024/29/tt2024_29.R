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
df <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-07-16/ewf_appearances.csv'
  ) |>
  clean_names()
# dictionary
# https://t.ly/_MRy7

# Wrangle ----

# names
df |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
df |>
  glimpse() |>
  skim()

# eda ----

# Visualise ----

df |>
  mutate(result_binary = case_when(
    result == "Draw" ~ "draw",
    TRUE ~ "not a draw"
  )) |>
  filter(tier == 1) |>
  group_by(date, result, result_binary) |>
  summarise(
    total_attendance = sum(attendance, na.rm = TRUE), 
    .groups = 'drop') |>
  ggplot(aes(x = date, y = total_attendance)) +
  geom_col(fill = '#9d0006', width = 10.5) +
  labs(
    title = "total attendance over time",
    x = "date",
    y = "total attendance") +
  ggthemes::theme_wsj() +
  facet_wrap(~ result_binary, nrow = 2)

# Communicate ----

# ...
