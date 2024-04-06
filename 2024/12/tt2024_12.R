
# --- TIDYTUESDAY::2024§12 --- #

# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-03-19/readme.md

# Load ----

# packages
pacman::p_load(
  janitor,
  skimr,
  tidylog,
  tidyverse,
  waffle
)

# data
mm <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-03-19/mutant_moneyball.csv'
  ) |>
  clean_names()
## https://shorturl.at/gqxW0 :: dictionary (rich)
## https://shorturl.at/gkzK4 :: dictionary (raw)

# Wrangle ----

# eda ----

# names
mm |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
mm |>
  glimpse() |>
  skim()

# members ~ value
mm |> 
  select(member, total_value_heritage) |> 
  arrange(desc(total_value_heritage)) |> 
  print(n = Inf)

# Visualise ----

# Waffle ----

mm |> select(member, 8:12) |>
  rename(
    c(
      "total" = "total_value_heritage",
      "sixties" = "total_value60s_heritage",
      "seventies" = "total_value70s_heritage",
      "eighties" = "total_value80s_heritage",
      "nineties" = "total_value90s_heritage"
    )
  ) |>
  arrange(desc(total)) |>
  pivot_longer(cols = sixties:nineties,
               names_to = "decade",
               values_to = "value") |>
  filter(member == "scottSummers") |>
  mutate(prop_total = (total / total)) |>
  mutate(proportion = round(value / total, 3))

# Communicate ----

# ...
