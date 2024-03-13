
# --- TIDYTUESDAY::2024§W09 --- #

# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-02-27/readme.md

# Load ----

# packages
pacman::p_load(
  gt,
  janitor,
  skimr,
  tidyverse
)

# data
events <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-02-27/events.csv'
  ) |>
  clean_names()

## https://shorturl.at/qtFK0 :: dictionary (rich)
## https://shorturl.at/mtTV6 :: dictionary (raw)

# Wrangle ----

# eda ----

# names
events |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
events |>
  glimpse() |>
  skim()

# Analyse ----

# assisted

## prompt :: help me translating each sentence into a one-word category, 
## they can repeat since the purpose of this is to present data in a bar form:
## {paste from events$event}
## {...}
## definitive_answer ::

events$keyword <- c(
  "coronation", "deception", "voyage", "conflict", "calendar",
  "transition", "rebellion", "treaty", "incorporation", "foundation",
  "collapse", "annexation", "labor", "adoption", "incident",
  "milestone", "negotiations", "recognition", "invasion", "disaster",
  "withdrawal", "achievement", "transition", "arrest", "disclosure",
  "referendum", "tragedy", "conflict", "conflict", "coup",
  "withdrawal", "fraud", "agreement", "attack", "election",
  "conflict", "agreement"
)

### https://chat.openai.com/share/cff3eb5c-0ee9-487c-802f-3f3ec5a9bfa8

# Visualise ----

# raw
events |> 
  group_by(keyword) |> 
  summarise(n = n()) |> 
  arrange(desc(n)) |> 
  knitr::kable()

# rice
events |> 
  group_by(keyword) |> 
  summarise(n = n()) |> 
  arrange(desc(n)) |> 
  slice(1:10) |> 
  gt() |>
  tab_header(
    title = md("**keyword count excerpt**"),
    subtitle = md("ai assisted `event-to-keyword` transformation")
  ) |>
  tab_source_note(
    source_note = "tidytuesday 2024§09〔https://shorturl.at/qtFK0〕"
  ) |> 
  tab_source_note(
    source_note = "ai assistance:〔https://shorturl.at/anwK5〕"
  ) |>
  tab_style(
    style = cell_text(font = system_fonts(name = "monospace-code")),     # https://gt.rstudio.com/reference/opt_table_font.html
    locations = cells_body()
  ) |> 
  opt_table_lines(extent = "all") |>                                     # https://gt.rstudio.com/reference/opt_table_lines.html
  opt_stylize(style = 6, color = "pink")                                 # https://gt.rstudio.com/reference/opt_stylize.html

# . ----

# --- TIDYTUESDAY::2024§W09 --- #
