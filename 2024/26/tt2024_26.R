# --- TIDYTUESDAY::2024§26 --- #

# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-06-25/readme.md

# Load ----

# packages ----
pacman::p_load(
  data.table,           # https://cran.r-project.org/web/packages/data.table/
  ggdark,               # https://cran.r-project.org/web/packages/ggdark/
  janitor,              # https://cran.r-project.org/web/packages/janitor/
  patchwork,            # https://cran.r-project.org/web/packages/patchwork/
  skimr,                # https://cran.r-project.org/web/packages/skimr/
  tidyverse,            # https://cran.r-project.org/web/packages/tidyverse/
  tidytext,             # https://cloud.r-project.org/web/packages/tidytext/
  udpipe                # https://cran.r-project.org/web/packages/udpipe/
)

# data ----
df <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-06-25/lgbtq_movies.csv'
  ) |>
  clean_names()
# dictionary
# https://t.ly/8wEVH

# Wrangle ----

# eda ----

# names
df |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
df |> 
  select(!release_date) |> 
  glimpse() |> 
  skim()

# Visualise ----

primer <- 
  get_sentiments('afinn') |> 
  rename(lemma = word)

df_sub <- 
  df |>
  filter(str_detect(overview, pattern = "transgender"))

corpus <- udpipe(df_sub$overview, object = 'english')

# lesbian ----
p1 <- 
  corpus |>
  inner_join(primer, by = "lemma") |>
  count(lemma, value, sort = TRUE) |>
  ggplot(aes(
    x = reorder(lemma, n),
    y = value,
    fill = value
  )) +
  geom_col(position = 'identity',
           width = 0.5) +
  lims() +
  scale_fill_gradient2(
    # https://www.flagcolorcodes.com/lesbian-pride
    low = "#A30262",
    mid = "#FFFFFF",
    high = "#D52D00",
    midpoint = 0
  ) +
  dark_theme_void() +
  theme(
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank(),
    legend.position = 'none'
  ) +
  coord_cartesian(ylim = c(-5, 5))

# gay ----
p2 <- 
  corpus |>
  inner_join(primer, by = "lemma") |>
  count(lemma, value, sort = TRUE) |>
  ggplot(aes(
    x = reorder(lemma, n),
    y = value,
    fill = value
  )) +
  geom_col(position = 'identity',
           width = 0.5) +
  lims() +
  scale_fill_gradient2(
    # https://www.flagcolorcodes.com/gay-men
    low = "#3D1A78",
    mid = "#FFFFFF",
    high = "#078D70",
    midpoint = 0
  ) +
  dark_theme_void() +
  theme(
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank(),
    legend.position = 'none'
  ) +
  coord_cartesian(ylim = c(-5, 5))

# bisexual ----
p3 <- 
  corpus |>
  inner_join(primer, by = "lemma") |>
  count(lemma, value, sort = TRUE) |>
  ggplot(aes(
    x = reorder(lemma, n),
    y = value,
    fill = value
  )) +
  geom_col(position = 'identity',
           width = 0.5) +
  lims() +
  scale_fill_gradient2(
    # https://www.flagcolorcodes.com/bisexual
    low = "#0038A8",
    mid = "#9B4F96",
    high = "#D60270",
    midpoint = 0
  ) +
  dark_theme_void() +
  theme(
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank(),
    legend.position = 'none'
  ) +
  coord_cartesian(ylim = c(-5, 5))

# transgender ----
p4 <- 
  corpus |>
  inner_join(primer, by = "lemma") |>
  count(lemma, value, sort = TRUE) |>
  ggplot(aes(
    x = reorder(lemma, n),
    y = value,
    fill = value
  )) +
  geom_col(position = 'identity',
           width = 0.5) +
  lims() +
  scale_fill_gradient2(
    # https://www.flagcolorcodes.com/transgender
    low = "#F5A9B8",
    mid = "#FFFFFF",
    high = "#5BCEFA",
    midpoint = 0
  ) +
  dark_theme_void() +
  theme(
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank(),
    legend.position = 'none'
  ) +
  coord_cartesian(ylim = c(-5, 5))

# patchwork 
p1 / p2 / p3 / p4

## pixel peeping
## https://jspaint.app
## https://jspaint.app/#local:1596eae522bc2

# Communicate ----

# for #tidytuesday 2024§26
# i explored sentiment from lgbt movies' overviews

# https://github.com/federicoalegria/_tidytuesday/tree/main/2024/26
