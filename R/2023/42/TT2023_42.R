
# --- TIDYTUESDAY::2023_42 --- #
# https://github.com/rfordatascience/tidytuesday/blob/master/data/2023/2023-10-17/readme.md

# libraries ----

pacman::p_load(
  easystats,
  ggridges,
  ggstatsplot,
  ggthemes,
  janitor,
  patchwork,
  skimr,
  tidyverse
)

# https://asteves.github.io/tayloRswift/index.html
# https://taylor.wjakethompson.com/
# https://taylor.wjakethompson.com/reference/album_palettes
# https://pmassicotte.github.io/paletteer_gallery/

# DATA ----

taylor_album_songs <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-10-17/taylor_album_songs.csv'
  ) |> 
  clean_names()

# CLEAN ----

# Transform ----

# album names
taylor_album_songs <-
  taylor_album_songs |>
  mutate(album_name = gsub("\\(Taylor's Version\\)", "", album_name) |>
           str_trim() |>
           str_to_title())

# EXPLORE ----

# names
taylor_album_songs|>
  slice(0) |>
  glimpse()

# glimpse & skim
taylor_album_songs |>
  glimpse() |>
  skim()

# VISUALISE ----

# Categorical & Metric ----

# box plot
taylor_album_songs |>
  mutate(album_name = reorder(album_name, valence)) |>
  ggplot(aes(x = album_name,
             y = valence)) +
  geom_boxplot(aes(fill = album_name), alpha = 0.7) +
  scale_fill_manual(
    values = c(
      "#400303",
      "#731803",
      "#967862",
      "#b38468",
      "#c7c5b6",
      "#160e10",
      "#421e18",
      "#d37f55",
      "#85796d",
      "#e0d9d7"
    )
  ) +
  geom_jitter(color = "#1D4737", alpha = 0.4) +
  labs(
    title = "Taylor Swift's valence by albums",
    subtitle = "box plots based on data pulled from Spotify's Web API with spotifyr",
    caption = "{tidytuesday 2023∙42}
    https://github.com/rfordatascience/tidytuesday/blob/master/data/2023/2023-10-17/readme.md",
    x = "Valence",
    y = "Album Name"
  ) +
  theme_solarized() +
  theme(legend.position = "none") +
  coord_flip()

# ridges plot
taylor_album_songs |>
  mutate(album_name = reorder(album_name, valence)) |>
  ggplot(aes(x = valence, y = album_name)) +
  geom_density_ridges(aes(fill = album_name), alpha = 0.7) +
  scale_fill_manual(
    values = c(
      "#400303",
      "#731803",
      "#967862",
      "#b38468",
      "#c7c5b6",
      "#160e10",
      "#421e18",
      "#d37f55",
      "#85796d",
      "#e0d9d7"
    )
  ) +
  labs(
    title = "Taylor Swift's valence by albums",
    subtitle = "ridge plots based on data pulled from Spotify's Web API with spotifyr",
    caption = "{tidytuesday 2023∙42}
    https://github.com/rfordatascience/tidytuesday/blob/master/data/2023/2023-10-17/readme.md",
    x = "Valence",
    y = "Album Name",
    fill = "Album Name"
  ) +
  theme_solarized() +
  theme(legend.position = "none")

# ANALYSE ----

# Modeling

# multiple linear regression analysis

lm(
  valence ~ danceability + energy + mode + speechiness + acousticness + instrumentalness + liveness,
  data = taylor_album_songs
) |> 
  summary()

taylor_album_songs |>
  select(valence, energy, danceability, acousticness) |> # ordered from smallest to largest 
  correlation(redundant = TRUE) |> 
  summary()
  
lm(
  valence ~ energy + danceability + acousticness,
  data = taylor_album_songs
) |> 
  check_model()

lm(
  valence ~ energy + danceability + acousticness,
  data = taylor_album_songs
) |> 
  summary()
# https://g.co/bard/share/e59b45b94b4f

lm(
  valence ~ energy + danceability + acousticness,
  data = taylor_album_songs
) |> 
  report()

# scatter plot
## metric & metric
### Amasement

taylor_album_songs |>
  mutate(amasement = (energy + danceability + acousticness) / 3) |>
  ggplot(aes(x = valence,
             y = amasement)) +
  geom_point(aes(colour = album_name, size = duration_ms)) +
  scale_color_manual(
    values = c(
      "#400303",
      "#731803",
      "#967862",
      "#b38468",
      "#c7c5b6",
      "#160e10",
      "#421e18",
      "#d37f55",
      "#85796d",
      "#e0d9d7"
    )
  ) +
  labs(
    title = "Predictor model for valence in Taylor Swift songs",
    subtitle = "analysis based on data from Spotify's Web API with {spotifyr}",
    caption = "{tidytuesday 2023∙42}
    https://github.com/rfordatascience/tidytuesday/blob/master/data/2023/2023-10-17/readme.md",
    x = "Valence",
    y = "Amasement",
    fill = "Album Name",
    colour = "Album Name"
  ) +
  geom_smooth(colour = "#1D4737", method = "lm") +
  theme_solarized() +
  guides(size = "none")

# ... ----