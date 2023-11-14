
# --- TIDYTUESDAY::2023_45 --- #

# Libraries ----

pacman::p_load(
  ggbump,
  ggthemes,
  janitor,
  patchwork,
  skimr,
  tidylog,
  tidyverse
)

# DATA ----

df <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-11-07/house.csv'
  ) |> 
  clean_names()

# glimpse & skim
df |>
  glimpse() |> 
  skim()

# names
df |>
  slice(0) |> 
  glimpse()

# CLEAN ----

df$office <- str_to_title(df$office)
df$candidate <- str_to_title(df$candidate)
df$party <- str_to_title(df$party)

# EXPLORE ----

# TRANSFORM ----

# bipartisanship
dr <-
  df |>
  select(year, party, votes = candidatevotes) |>
  summarise(votes = sum(votes), .by = c(year, party)) |> 
  mutate(rank = row_number(desc(votes)), .by = year)

dr_max_rank <- 2

dr_current <-
  dr |>
  filter(year == 2022, rank <= dr_max_rank) |>
  pull(party)

dr_top <- dr |> 
  filter(party %in% dr_current)

# multipartisanship
alt <-
  df |>
  filter(party != "Republican" & party != "Democrat") |>
  select(year, party, votes = candidatevotes) |>
  summarise(votes = sum(votes), .by = c(year, party)) |> 
  mutate(rank = row_number(desc(votes)), .by = year)

alt_max_rank <- 10

alt_current <-
  alt |>
  filter(year == 2022, rank <= alt_max_rank) |>
  pull(party)

alt_top <- alt |> 
  filter(party %in% alt_current)

# VISUALISE ----

# bipartisanship ----
dr_top |>
  filter(year >= 2010) |>
  ggplot(aes(x = year,
             y = rank,
             col = party)) +
  geom_point() +
  geom_bump(linewidth = 0.75) +
  scale_x_continuous(breaks = seq(2010, 2022, 2)) +
  scale_y_continuous(breaks = seq(1, 2)) +
  coord_cartesian(
    xlim = c(2009, 2023),
    ylim = c(2.5, 0.25),
    expand = FALSE
  ) +
  theme_void(base_size = 13) +
  theme(legend.position = "none") +
  labs(
    title = "US House Election Results 2010:2022",
    subtitle = "transition between Democrat and Republican parties",
    caption = "
    https://doi.org/10.7910/DVN/IG0UN2
    MIT Election Data And Science Lab. U.S. House 1976–2022. 2017.
    {tidytuesday 2023∙45} https://github.com/rfordatascience/tidytuesday/blob/master/data/2023/2023-11-07/
    "
  ) +
  scale_colour_manual(values = c("#1d5aa8",
                                 "#e50000")) +
  theme_wsj() +
  theme(
    legend.title = element_text(size = 13),
    plot.caption = element_text(size = 10),
    plot.subtitle = element_text(size = 16)
  )

# multipartisanship ----
alt_top |>
  filter(year >= 2010) |>
  ggplot(aes(x = year,
             y = rank,
             col = party)) +
  geom_point() +
  geom_bump(linewidth = 0.75) +
  scale_x_continuous(breaks = seq(2010, 2022, 2)) +
  coord_cartesian(
    xlim = c(2009, 2023),
    ylim = c(21.5, 0.25),
    expand = FALSE
  ) +
  theme_void(base_size = 13) +
  theme(legend.position = "none") +
  labs(
    title = "US House Election Results 2010:2022",
    subtitle = "transition among alternative parties",
    caption = "
    https://doi.org/10.7910/DVN/IG0UN2
    MIT Election Data And Science Lab. U.S. House 1976–2022. 2017.
    {tidytuesday 2023∙45} https://github.com/rfordatascience/tidytuesday/blob/master/data/2023/2023-11-07/
    "
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

# Patchwork ----

p1 <- 
  dr_top |>
  filter(year >= 2010) |>
  ggplot(aes(x = year,
             y = rank,
             col = party)) +
  geom_point() +
  geom_bump(linewidth = 0.75) +
  scale_x_continuous(breaks = seq(2010, 2022, 2)) +
  scale_y_continuous(breaks = seq(1, 2)) +
  coord_cartesian(
    xlim = c(2009, 2023),
    ylim = c(2.5, 0.25),
    expand = FALSE
  ) +
  theme_void(base_size = 13) +
  theme(legend.position = "none") +
  labs(
    title = "US House Election Results 2010:2022",
    subtitle = "transition between Democrat and Republican parties"
  ) +
  scale_colour_manual(values = c("#1d5aa8",
                                 "#e50000")) +
  theme_wsj() +
  theme(
    legend.title = element_text(size = 13),
    plot.caption = element_text(size = 10),
    plot.subtitle = element_text(size = 16)
  )

p2 <- 
  alt_top |>
  filter(year >= 2010) |>
  ggplot(aes(x = year,
             y = rank,
             col = party)) +
  geom_point() +
  geom_bump(linewidth = 0.75) +
  scale_x_continuous(breaks = seq(2010, 2022, 2)) +
  coord_cartesian(
    xlim = c(2009, 2023),
    ylim = c(21.5, 0.25),
    expand = FALSE
  ) +
  theme_void(base_size = 13) +
  theme(legend.position = "none") +
  labs(
    subtitle = "transition among alternative parties",
    caption = "
    https://doi.org/10.7910/DVN/IG0UN2
    MIT Election Data And Science Lab. U.S. House 1976–2022. 2017.
    {tidytuesday 2023∙45} https://github.com/rfordatascience/tidytuesday/blob/master/data/2023/2023-11-07/
    "
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

(p1 / p2)

# ... ----
