
# --- TIDYTUESDAY::2023_47 --- #

# Packages ----

pacman::p_load(
  ggthemes,
  geomtextpath,
  janitor,
  patchwork,
  RColorBrewer,
  skimr,
  tidyverse
)

# DATA ----

rl <- readr::read_csv(
  'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-11-21/rladies_chapters.csv'
) |>
  clean_names() |>
  mutate(chapter = str_remove(chapter, "^rladies-"))

# EXPLORE ----

# glimpse & skim
rl |>
  glimpse() |> 
  skim()

# names
rl |>
  slice(0) |> 
  glimpse()

rl |> 
  select(location, year) |> 
  table()

# VISUALISE ----

# Patchwork ----

# polar plot $ `inperson`

rl00 <- rl |> 
  filter(location == "inperson")

p1 <- 
  rl00 |> 
  group_by(chapter) |> 
  summarise(n = n()) |> 
  arrange(desc(n)) |> 
  mutate(top = row_number() <= 10) |> 
  ggplot(aes(x = chapter, y = n)) +
  geom_bar(position = "stack", stat = "identity", fill = "#5d275f") +
  coord_polar() +
  geom_text(aes(
    label = ifelse(top, as.character(chapter), ""),
    y = n
  ),
  angle = 15,
  nudge_x = 1,
  hjust = 1.5,
  size = 3
  ) +
  labs(
    title = "occurrence found in the R-Ladies meetup-archive",
    subtitle = "away from keyboard gatherings (2012::2023)",
    caption = "each bar represents a distinct R-Ladies chapter",
    x = "",
    y = ""
  ) +
  theme_wsj() +
  theme(axis.text.x = element_blank(),
        legend.position = "none",
        plot.title = element_text(size = 12),
        plot.subtitle = element_text(size = 10),
        plot.caption = element_text(face = "bold", size = 10),
  )

# polar plot $ `online`

rl01 <- rl |> 
  filter(location == "online")

p2 <- 
  rl01 |> 
  group_by(chapter) |> 
  summarise(n = n()) |> 
  arrange(desc(n)) |> 
  mutate(top = row_number() <= 10) |> 
  ggplot(aes(x = chapter, y = n)) +
  geom_bar(position = "stack", stat = "identity", fill = "#0d585f") +
  coord_polar() +
  geom_text(aes(
    label = ifelse(top, as.character(chapter), ""),
    y = n
  ),
  angle = 15,
  nudge_x = 1,
  hjust = 1.5,
  size = 3
  ) +
  labs(
    title = "",
    subtitle = "online global encounters (2020::2023)",
    caption = "{tidytuesday 2023∙47}
    https://github.com/rfordatascience/tidytuesday/blob/master/data/2023/2023-11-21/readme.md",
    x = "",
    y = ""
  ) +
  theme_wsj() +
  theme(axis.text.x = element_blank(),
        legend.position = "none",
        plot.title = element_text(size = 12),
        plot.subtitle = element_text(size = 10),
        plot.caption = element_text(size = 8)
  )

patch <- 
  p1 + p2

# ... ----

# Further

## linegraph for how r-ladies chapters behave during and after covid-19
