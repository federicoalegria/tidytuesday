# --- TIDYTUESDAY::2024§33 --- #
# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-08-13/readme.md

# library path
.libPaths(c("~/.R/x86_64-pc-linux-gnu-library/4.4", .libPaths()))

# packages
pacman::p_load(
  data.table,           # https://cran.r-project.org/web/packages/data.table/
  ggthemes,             # https://cran.r-project.org/web/packages/ggthemes/
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
  filter(region != "Oceania") |> 
  ggplot(aes(visitors, factor(start_year))) +
  geom_col(aes(fill = region)) +
  geom_text(aes(label = city), vjust = 0.5, hjust = -0.1, size = 3) +
  scale_x_continuous(expand = expansion(add = c(0, 12))) +
  labs(
    x = "visitors in millions",
    y = "world expo year",
    fill = "region",
    title = " ",
    caption = " "
  ) +
  scale_fill_manual(
    values = c(
      "Europe" = '#fbbc04',
      "North America" = '#4285f4',
      "Middle East" = '#34a853',
      "Far East" = '#ea4335'
    )
  ) +
  theme_wsj() +
  theme(
    text = element_text(family = 'Roboto'),
    axis.text.y = element_text(size = 8, family = 'Roboto'),
    axis.title.y = element_text(size = 10, family = 'Roboto'),
    legend.title = element_blank(),
    legend.text = element_text(size = 10, family = 'Roboto'),
    plot.title = element_text(size = 14, family = 'Roboto'),
    plot.caption = element_text(size = 10, family = 'Roboto')
)
