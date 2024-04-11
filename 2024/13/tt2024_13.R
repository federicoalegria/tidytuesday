
# --- TIDYTUESDAY::2024§13 --- #

# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-03-26/readme.md

# Load ----

# packages
pacman::p_load(
  # easystats,
  gt,
  ggradar,                                                 # https://github.com/ricardo-bion/ggradar
  janitor,
  scales,
  skimr,
  tidylog,
  tidyverse
)

# data
tr <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-03-26/team-results.csv'
  ) |> 
  clean_names()
## https://shorturl.at/akOPR :: dictionary (rich)
## https://shorturl.at/bw357 :: dictionary (raw)

# Wrangle ----

# eda ----

# names
tr |> 
  slice(1:5) |> 
  glimpse()

# glimpse & skim
tr |>
  glimpse() |>
  skim()

# Visualise ----

# stacked bar-plot ----

tr |>                                                           # load data
  select(c(2, 7:9, 13:17)) |>                                   # select specific columns
  mutate(across(where(is.double), as.integer)) |>               # convert doubles to integers
  pivot_longer(
    cols = c(w, l, s16, e8, f4, f2, champ),
    names_to = "round",
    values_to = "count"
  ) |>                                                          # reshape data
  mutate(round = factor(round, levels = c("champ", 
                                          "f2", 
                                          "f4", 
                                          "e8", 
                                          "s16")
                        )
  ) |>
  mutate(
    round = case_when(
      round == "champ" ~ "champion",
      round == "f2" ~ "finals",
      round == "f4" ~ "final 4",
      round == "e8" ~ "elite 8",
      round == "s16" ~ "sweet 16",
      TRUE ~ round
    )
  ) |>
  select(team, round, count) |>                                 # select relevant columns
  filter(round != "w" & round != "l" & count != 0) |>           # filter data
  group_by(team, round) |>                                      # group by team and round to maintain round information
  summarise(stacked_count = sum(count)) |>                      # calculate stacked count per team and round
  arrange(team, desc(stacked_count)) |>                         # sort by team then descending stacked count
  ggplot(aes(x = team, 
             y = stacked_count, 
             fill = round)
         ) +                                                    # define aesthetics
  geom_bar(stat = 'identity') +                                 # stacked bar chart
  scale_fill_manual(values = c("#cc241d", 
                               "#98971a",
                               "#d79921",
                               "#458588",
                               "#b16286")
                    ) +                                         # define colour palette
  theme_minimal() +                                             # set theme
  labs(
    title = "NCAA Men's March Madness",
    subtitle = "2008 ~ 2024 // stacked counts for sweet 16 and above",
    caption = "tidytuesday 2024§13〔https://shorturl.at/akOPR〕",
    x = "",
    y = "",
    fill = ""
  ) +                                                           # set labels
  theme(
    text = element_text(family = 'Consolas'),
    plot.title = element_text(family = 'Roboto Mono', face = 'bold'),
    plot.subtitle = element_text(family = 'Consolas'),
    axis.text = element_text(family = 'Consolas'),
    axis.title = element_text(family = 'Consolas'),
    plot.caption = element_text(family = 'Consolas'),
    legend.justification = 'top',
    axis.text.x = element_text(angle = 90, hjust = 0)
)

# Further ----

## gt
### https://github.com/natrivera/tidytuesday/tree/main/2024/2024-03-26

## radar
## https://rstudio-pubs-static.s3.amazonaws.com/5795_e6e6411731bb4f1b9cc7eb49499c2082.html
## https://r-graph-gallery.com/spider-or-radar-chart.html
