
# --- TIDYTUESDAY::2023_40 --- #

# LIBRARIES ----

pacman::p_load(
  janitor,
  MoMAColors, # https://github.com/BlakeRMills/MoMAColors
  skimr,
  tidyverse,
  tidytext,
  wordcloud2 # https://github.com/lchiffon/wordcloud2
)

# DATA ----

grants <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-10-03/grants.csv'
  )
grant_opportunity_details <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-10-03/grant_opportunity_details.csv'
  )

# EXPLORE ----

grants |> 
  skim() |> 
  glimpse()

# Group by ---- 

# `$opportunity_title` towards !unique values
grants |> 
  group_by(opportunity_title) |> 
  summarise(n = n()) |> 
  filter(n != 1) |> 
  arrange(desc(n))

# VISUALISE ----

# Wordcloud of `$opportunity_title`
grants |>
  select(opportunity_title) |>
  sample_n(250) |>
  unnest_tokens(output = word, input = opportunity_title) |>
  anti_join(stop_words, by = "word") |>
  filter(str_length(word) >= 2,
         word != "program") |>
  group_by(word) |>
  summarise(n = n()) |>
  arrange(desc(n)) |>
  wordcloud2(
    backgroundColor = "#e0d8d3",
    color = moma.colors("Panton", 5),
    rotateRatio = 0
  )

# ANALYSE ----

# COMMUNICATE ----

# ... ----
