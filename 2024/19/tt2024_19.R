# --- TIDYTUESDAY::2024§19 --- #

# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-05-07/readme.md

# Load ----

# packages ----
pacman::p_load(
  data.table,
  ggridges,
  ggthemes,
  janitor,
  skimr,
  tidylog,
  tidyverse,
  viridis
)

# data ----
df <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-05-07/rolling_stone.csv'
  ) |> 
  clean_names()
# dictionary
# https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-05-07/readme.md

# Wrangle ----

# eda ----

# names
df |> 
  slice(0) |> 
  glimpse()

glimpse & skim
df |>
  glimpse() |>
  skim()

df |> 
  select(genre) |> 
  group_by(genre) |> 
  summarise(n = n()) |> 
  arrange(desc(n)) |> 
  filter(!(genre %in% c(
    "", "Punk/Post-Punk/New Wave/Power Pop")                    # filter unlabelled and oddly labelled
  )
  )

df |>
  mutate(genre = factor(genre,
                        levels = unique(genre))) |>
  filter(!(genre %in% c(
    "", "Punk/Post-Punk/New Wave/Power Pop"))) |> 
  group_by(genre) |> 
  summarise(n = n()) |> 
  filter(n >= 10)

# Visualise ----

df |>
  mutate(genre = factor(genre,
                        levels = unique(genre))) |>
  filter((
    genre %in% c(
      "Big Band/Jazz",
      "Blues/Blues Rock",
      "Country/Folk/Country Rock/Folk Rock",
      "Electronic",
      "Funk/Disco ",
      "Hard Rock/Metal",
      "Hip-Hop/Rap",
      "Indie/Alternative Rock",
      "Rock n' Roll/Rhythm & Blues",
      "Singer-Songwriter/Heartland Rock",
      "Soul/Gospel/R&B"
    )
  )) |>
  arrange(genre) |>
  ggplot(aes(x = ave_age_at_top_500,
             y = genre)) +
  geom_density_ridges(aes(fill = genre),
                      alpha = 0.75) +
  scale_fill_manual(values = mako(13)) +
  labs(
    title = "Rolling Stone Album Rankings",
    subtitle = "average age in years inside top 500 by popular genres
    
    ",
    caption = "tidytuesday 2024§19〔https://t.ly/GEuCP〕",
    x = "average years",
    y = ""
  ) +
  theme_wsj(color = 'gray') +
  theme(
    axis.text = element_text(color = "#282828", family = 'Roboto'),
    axis.title = element_text(color = "#282828", family = 'Roboto', size = 11),
    legend.position = 'none',
    plot.title = element_text(color = "#282828", family = 'Roboto Bold', size = 18),
    plot.subtitle = element_text(color = "#282828", family = 'Roboto', size = 13),
    plot.caption = element_text(color = "#282828", family = 'Roboto Mono', size = 9),
    text = element_text(color = "#282828"),
)

# ...

## ggridges
# terminal :: find . -type f -exec grep -l "Dwali" {} \;
# terminal :: find . -type f -exec grep -l "ggridges" {} \;
# terminal :: find . -type f -exec grep --color=auto -C 2 "ggridges" {} \;
