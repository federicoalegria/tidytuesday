
# --- TIDYTUESDAY::2024§05 --- #

# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-01-30/readme.md

# Load ----

pacman::p_load(
  ggthemes,
  janitor,
  patchwork,
  skimr,
  tidylog,
  tidyquant,
  tidyverse
)

# Data ----

gh <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-01-30/groundhogs.csv'
  ) |>
  clean_names()                           # name standardisation
  
ghp <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-01-30/predictions.csv'
  ) |>
  clean_names()                           # name standardisation

## https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-01-30/readme.md
## https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-01-30/readme.md

# EXPLORE ----

# names
ghp |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
ghp |>
  glimpse() |>
  skim()

# VISUALISE ----

# raw ----

# time-series
ghp |>
  group_by(year) |>
  summarise(count = n()) |>
  plot(type = "l")                          # argument for line

# rice ----

## geom_line()

ghp |>
  group_by(year) |>
  summarise(count = n()) |>
  ggplot(aes(x = year,
             y = count)) +
  geom_line() +
  theme_minimal() +
  labs(subtitle = "amount of groundhog predictions since 1886",
       y = "predictions' count") +
  theme(text = element_text(family = "Consolas")) +
  scale_x_continuous(breaks = seq(1886, 2022, 10))

ghp |>
  group_by(year) |>
  summarise(count = n()) |>
  filter(count <= 20) |>
  ggplot(aes(x = year,
             y = count)) +
  geom_line() +
  theme_minimal() +
  labs(subtitle = "amount of groundhog predictions from 1886 to 2000",
       y = "predictions' count") +
  theme(text = element_text(family = "Consolas")) +
  scale_x_continuous(breaks = seq(1886, 2022, 10))

ghp |>
  group_by(year) |>
  summarise(count = n()) |>
  filter(count >= 20) |>
  ggplot(aes(x = year,
             y = count)) +
  geom_line() +
  theme_minimal() +
  labs(
    subtitle = "amount of groundhog predictions since 2000",
    y = "predictions' count"
  ) + theme(text = element_text(family = "Consolas")) +
  scale_x_continuous(breaks = seq(1886, 2022, 10))

## geom_bar()

ghp |>
  na.omit() |>
  mutate(shadow = case_when(shadow ~ "yey", !shadow ~ "nay")) |>
  ggplot(aes(x = shadow, fill = shadow)) +
  geom_bar(stat = "count",
           color = "#000000",
           width = 0.35) +
  scale_fill_manual(values = c("yey" = "#000000",
                               "nay" = "#ffffff")) +
  geom_text(
    stat = "count",
    aes(label = after_stat(count), y = after_stat(count)),
    position = position_dodge(0.9),
    vjust = -0.5,
    size = 3
  ) +
  theme_minimal() +
  labs(subtitle = "gross detail for groundhogs response",
       x = "did they see their shadow?",
       y = "predictions' count") +
  theme(text = element_text(family = "Consolas"),
        legend.position = "none")

## script excerpts

### https://publicdomainclip-art.blogspot.com/

# ... ----

# https://imsdb.com/scripts/Groundhog-Day.html

# bump graph with excerpts from the movie's script