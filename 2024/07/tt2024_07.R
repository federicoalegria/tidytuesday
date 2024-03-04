
# --- TIDYTUESDAY::2024§07 --- #

# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-02-13/readme.md

# Load ----

pacman::p_load(
  janitor,
  patchwork,
  skimr,
  tidyverse
)

# Data ----

hs <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-02-13/historical_spending.csv'
  ) |> 
  clean_names() |> 
  mutate(year = as.character(year))

## https://shorturl.at/bejnR :: dictionary (rich)
## https://shorturl.at/ivJM7 :: dictionary (raw)

# EXPLORE ----

# names
hs |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
hs |>
  glimpse() |>
  skim()

# VISUALISE ----

# patchwork ----

p0 <- 
  hs |> 
  ggplot(aes(x = year,
             y = per_person,
             group = 1)) +
  geom_line(colour = "#400303") +
  labs(
    title = "individual spending for St. Valentine's enthusiasts",
    subtitle = "",
    y = "spending per person"
  ) +
  theme_minimal() +
  theme(text = element_text(family = "Roboto"),
        plot.title = element_text(face = "bold")
)

p1 <- 
  hs |> 
  ggplot(aes(x = year,
             y = candy,
             group = 1)) +
  geom_line(colour = "#b38468") +
  labs(
    title = "candy",
    subtitle = "",
    y = "spending per person"
  ) +
  theme_minimal() +
  theme(text = element_text(family = "Roboto"),
        plot.title = element_text(face = "bold")
)

p2 <- 
  hs |> 
  ggplot(aes(x = year,
             y = flowers,
             group = 1)) +
  geom_line(colour = "#b38468") +
  labs(
    title = "flowers",
    subtitle = "",
    y = "spending per person"
  ) +
  theme_minimal() +
  theme(text = element_text(family = "Roboto"),
        plot.title = element_text(face = "bold")
)

p3 <- 
  hs |> 
  ggplot(aes(x = year,
             y = greeting_cards,
             group = 1)) +
  geom_line(colour = "#b38468") +
  labs(
    title = "greeting cards",
    subtitle = "",
    y = "spending per person"
  ) +
  theme_minimal() +
  theme(text = element_text(family = "Roboto"),
        plot.title = element_text(face = "bold")
)

p4 <- 
  hs |> 
  ggplot(aes(x = year,
             y = evening_out,
             group = 1)) +
  geom_line(colour = "#b38468") +
  labs(
    title = "evenings out",
    subtitle = "",
    y = "spending per person"
  ) +
  theme_minimal() +
  theme(text = element_text(family = "Roboto"),
        plot.title = element_text(face = "bold")
)

p5 <- 
  hs |> 
  ggplot(aes(x = year,
             y = clothing,
             group = 1)) +
  geom_line(colour = "#b38468") +
  labs(
    title = "clothing",
    subtitle = "",
    y = "spending per person"
  ) +
  theme_minimal() +
  theme(text = element_text(family = "Roboto"),
        plot.title = element_text(face = "bold")
)

p6 <- 
  hs |> 
  ggplot(aes(x = year,
             y = gift_cards,
             group = 1)) +
  geom_line(colour = "#b38468") +
  labs(
    title = "gift cards",
    subtitle = "",
    y = "spending per person"
  ) +
  theme_minimal() +
  theme(text = element_text(family = "Roboto"),
        plot.title = element_text(face = "bold")
)

# rice ----

p0 / ((p1 + p2 + p3)/(p4 + p5 + p6))

# COMMUNICATE ----

# how much does the average st. valentine enthusiast spend?

# . ----

# Assets

# palettes
## https://taylor.wjakethompson.com/reference/album_palettes

"#b1532a" 
"#84697f"
"#cbb593"
"#a88f92"
"#e8eadf"
"#43475b"

"#400303"
"#731803"
"#967862"
"#b38468"
"#C7C5B6"

# ... ----

# ~
