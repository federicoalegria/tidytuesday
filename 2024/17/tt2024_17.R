# --- TIDYTUESDAY::2024§17 --- #

# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-04-23/readme.md

# Load ----

# packages ----
pacman::p_load(
  data.table,
  ggbump,
  ggthemes,
  janitor,
  patchwork,
  skimr,
  tidylog,
  tidyverse
)

# data ----
df <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-04-23/outer_space_objects.csv'
  ) |>
  clean_names()
## https://shorturl.at/eiCR5 :: dictionary (rich)
## https://shorturl.at/bAF27 :: dictionary (raw)

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

# Visualise ----

df |> 
  filter(str_detect(entity, "sat")) |> 
  ggplot(aes(
    x = year,
    y = num_objects,
    colour = entity)
  ) +
  geom_bump() +
  geom_point()

# inspo

# https://github.com/federicoalegria/_tidytuesday/tree/main/2023/45
## https://www.perplexity.ai/search/with-the-following-.gxOa7QySdqrrnw23MFceg

# ...

# further

## wtf?
## patrones en la basura :: instituciones privadas de tipo "sat"

df_rank <-
  df |>
  filter(entity != "World") |>
  group_by(year) |> 
  mutate(rank = rank(num_objects)) |> 
  arrange(desc(rank))

df_rank |>
  filter(rank <= 4) |>
  select(entity, year, num_objects) |>
  summarise(count = sum(num_objects), .by = c(year, entity)) |>
  filter(count >= 2) |>
  mutate(rank = row_number(desc(count)), .by = year) |>
  ggplot(aes(x = year, 
             y = rank, color = entity)) +
  geom_point() +
  geom_bump(linewidth = 0.75) +
  scale_x_continuous(breaks = seq(1960, 2022, 2)) +
  coord_cartesian(
    xlim = c(1959, 2023),
    ylim = c(0.5, 3.5),
    expand = FALSE
  ) +
  scale_y_reverse() +
  theme_void(base_size = 13) +
  theme(legend.position = "none") +
  labs(
    title = " ",
    subtitle = " ",
    caption = " "
  ) +
  scale_colour_manual(
    values = c(
      "#B0161E",
      "#cf7378",
      "#0b2443",
      "#719a67",
      "#800000",
      "#706226",
      "#ffd700",
      "#5e5e5e",
      "#CC6699",
      "#f4563b",
      "#BD0A36",
      "#F4737A"
    )
  ) +
  theme_wsj() +
  theme(
    legend.title = element_text(size = 13),
    plot.caption = element_text(size = 10),
    plot.subtitle = element_text(size = 16)
  )
