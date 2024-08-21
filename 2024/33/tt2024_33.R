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

# count
df |> 
  count(country)

df |> 
  count(theme)

# transform ---

# duration
df |> 
  mutate(duration = 12 * (end_year - start_year) + end_month - start_month) |> 
  filter(duration != 0) |> 
  group_by(duration) |> 
  summarise(n = n()) |> 
  arrange(desc(n)) |> 
  print(n = Inf)

# ...

# fork & tweak
# https://github.com/mitsuoxv/tidytuesday/blob/main/2024_08_13_worlds_fairs.qmd

df |> 
  filter(category == "World Expo", !is.na(visitors)) |> 
  mutate(
    region = case_when(
      country %in% c("United States", "Canada") ~ "North America",
      country %in% c("Japan", "People's Republic of China") ~ "Far East",
      country == "Colony of Victoria" ~ "Oceania",
      country == "United Arab Emirates" ~ "Middle East",
      .default = "Europe"
    ),
    region = factor(region, levels = c("Europe", "North America", "Oceania", "Middle East", "Far East"))
  ) |> 
  ggplot(aes(visitors, factor(start_year))) +
  geom_col(aes(fill = region)) +
  geom_text(aes(label = city), vjust = 0.5, hjust = -0.1, size = 3) +
  scale_x_continuous(expand = expansion(add = c(0, 12))) +
  labs(x = "Number of visitors (million)", y = "World Expo Year",
       fill = "Region",
       title = "Largest visitors in 2010 Shanghai Expo",
       caption = "Source: List of world expositions (Wikipedia)") +
  theme(panel.grid.major.y = element_blank())
