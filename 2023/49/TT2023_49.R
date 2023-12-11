
# --- TIDYTUESDAY::2023_49 --- #

# Packages ----

pacman::p_load(
  janitor,
  patchwork,
  skimr,
  tidyverse
)

# DATA ----

le <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-12-05/life_expectancy.csv'
  ) |> clean_names()

# leda <-
#   readr::read_csv(
#     'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-12-05/life_expectancy_different_ages .csv'
#   )
# 
# lefm <-
#   readr::read_csv(
#     'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-12-05/life_expectancy_female_male.csv'
#   )

# CLEAN ----

# EXPLORE ----

# glimpse & skim
le |>
  glimpse() |> 
  skim()

# names
le |>
  slice(0) |> 
  glimpse()

le_ca <- le |> 
  filter(
    code %in% c("BLZ", "CRI", "HND", "GTM", "NIC", "SLV")
  )

le_ca |> 
  group_by(entity) |> 
  summarise(min = min(year),
            max = max(year),
            mean = mean(life_expectancy),
            median = median(life_expectancy),
            sd = sd(life_expectancy)
  )

# VISUALISE ----

p1 <- 
le |>
  filter(code == "BLZ") |>
  ggplot(aes(x = year,
             y = life_expectancy)) +
  geom_line() +
  geom_rect(xmin = 1960, 
            xmax = 1962, 
            ymin = -Inf, 
            ymax = Inf, 
            fill = "#cc0000", 
            alpha = 0.01) +
  geom_rect(xmin = 1995, 
            xmax = 2005, 
            ymin = -Inf, 
            ymax = Inf, 
            fill = "#cc0000", 
            alpha = 0.01) +
  geom_rect(xmin = 2019, 
            xmax = 2021, 
            ymin = -Inf, 
            ymax = Inf, 
            fill = "#cc0000", 
            alpha = 0.01) +
  labs(
    title = "Life Expectancy in Central America
    ",
    subtitle = "Belize",
    x = "",
    y = ""
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(family = "Roboto", face = "bold", size = 20),
    plot.subtitle = element_text(family = "Helvetica"),
    plot.caption = element_text(family = "Consolas")
  )

p2 <- 
le |>
  filter(code == "CRI") |>
  ggplot(aes(x = year,
             y = life_expectancy)) +
  geom_line() +
  geom_rect(xmin = 2020, 
            xmax = 2021, 
            ymin = -Inf, 
            ymax = Inf, 
            fill = "#cc0000", 
            alpha = 0.01) +
  labs(
    subtitle = "Costa Rica",
    x = "",
    y = ""
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(family = "Roboto", face = "bold", size = 20),
    plot.subtitle = element_text(family = "Helvetica"),
    plot.caption = element_text(family = "Consolas")
  )

p3 <- 
le |>
  filter(code == "HND") |>
  ggplot(aes(x = year,
             y = life_expectancy)) +
  geom_line() +
  geom_rect(xmin = 1972, 
            xmax = 1975, 
            ymin = -Inf, 
            ymax = Inf, 
            fill = "#cc0000", 
            alpha = 0.01) +
  geom_rect(xmin = 1997, 
            xmax = 1999, 
            ymin = -Inf, 
            ymax = Inf, 
            fill = "#cc0000", 
            alpha = 0.01) +
  geom_rect(xmin = 2019, 
            xmax = 2021, 
            ymin = -Inf, 
            ymax = Inf, 
            fill = "#cc0000", 
            alpha = 0.01) +
  labs(
    subtitle = "Honduras",
    x = "",
    y = ""
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(family = "Roboto", face = "bold", size = 20),
    plot.subtitle = element_text(family = "Helvetica"),
    plot.caption = element_text(family = "Consolas")
  )

p4 <- 
le |>
  filter(code == "GTM") |>
  ggplot(aes(x = year,
             y = life_expectancy)) +
  geom_line() +
  geom_rect(xmin = 1975, 
            xmax = 1983, 
            ymin = -Inf, 
            ymax = Inf, 
            fill = "#cc0000", 
            alpha = 0.01) +
  geom_rect(xmin = 2019, 
            xmax = 2021, 
            ymin = -Inf, 
            ymax = Inf, 
            fill = "#cc0000", 
            alpha = 0.01) +
  labs(
    subtitle = "Guatemala",
    x = "",
    y = ""
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(family = "Roboto", face = "bold", size = 20),
    plot.subtitle = element_text(family = "Helvetica"),
    plot.caption = element_text(family = "Consolas")
  )

p5 <- 
le |>
  filter(code == "NIC") |>
  ggplot(aes(x = year,
             y = life_expectancy)) +
  geom_line() +
  geom_rect(xmin = 1950, 
            xmax = 1951, 
            ymin = -Inf, 
            ymax = Inf, 
            fill = "#cc0000", 
            alpha = 0.01) +
  geom_rect(xmin = 1970, 
            xmax = 1973, 
            ymin = -Inf, 
            ymax = Inf, 
            fill = "#cc0000", 
            alpha = 0.01) +
  geom_rect(xmin = 1977, 
            xmax = 1980, 
            ymin = -Inf, 
            ymax = Inf, 
            fill = "#cc0000", 
            alpha = 0.01) +
  geom_rect(xmin = 1982, 
            xmax = 1989, 
            ymin = -Inf, 
            ymax = Inf, 
            fill = "#cc0000", 
            alpha = 0.01) +
  geom_rect(xmin = 1997, 
            xmax = 1999, 
            ymin = -Inf, 
            ymax = Inf, 
            fill = "#cc0000", 
            alpha = 0.01) +
  geom_rect(xmin = 2019, 
            xmax = 2021, 
            ymin = -Inf, 
            ymax = Inf, 
            fill = "#cc0000", 
            alpha = 0.01) +
  labs(
    subtitle = "Nicaragua",
    x = "",
    y = ""
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(family = "Roboto", face = "bold", size = 20),
    plot.subtitle = element_text(family = "Helvetica"),
    plot.caption = element_text(family = "Consolas")
  )

p6 <- 
le |>
  filter(code == "SLV") |>
  ggplot(aes(x = year,
             y = life_expectancy)) +
  geom_line() +
  geom_rect(xmin = 1920, 
            xmax = 1930, 
            ymin = -Inf, 
            ymax = Inf, 
            fill = "#cc0000", 
            alpha = 0.01) +
  geom_rect(xmin = 1950, 
            xmax = 1952, 
            ymin = -Inf, 
            ymax = Inf, 
            fill = "#cc0000", 
            alpha = 0.01) +
  geom_rect(xmin = 1974, 
            xmax = 1991, 
            ymin = -Inf, 
            ymax = Inf, 
            fill = "#cc0000", 
            alpha = 0.01) +
  geom_rect(xmin = 2000, 
            xmax = 2002, 
            ymin = -Inf, 
            ymax = Inf, 
            fill = "#cc0000", 
            alpha = 0.01) +
  geom_rect(xmin = 2019, 
            xmax = 2021, 
            ymin = -Inf, 
            ymax = Inf, 
            fill = "#cc0000", 
            alpha = 0.01) +
  labs(
    subtitle = "El Salvador",
    caption = "
    {tidytuesday 2023∙49}
    https://github.com/rfordatascience/tidytuesday/tree/master/data/2023/2023-12-05",
    x = "",
    y = ""
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(family = "Roboto", face = "bold", size = 20),
    plot.subtitle = element_text(family = "Helvetica"),
    plot.caption = element_text(family = "Consolas")
  )

(p1 + p2) / (p3 + p4) / (p5 + p6)

# ANALYSE ----

# COMMUNICATE ----

# ... ----

