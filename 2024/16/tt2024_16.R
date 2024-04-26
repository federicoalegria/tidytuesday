
# --- TIDYTUESDAY::2024§16 --- #

# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-04-16/readme.md

# Load ----

# packages ----
pacman::p_load(
  data.table,                     # https://www.perplexity.ai/search/what-are-the-xqCDaaVNQ8SnVOzl77krAg
  janitor,
  skimr,
  tidylog,
  tidyverse
)

# data ----
d0 <-
  fread(
   'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-04-16/shiny_revdeps.csv' 
  ) |> clean_names()

d1 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-04-16/package_details.csv'
  ) |> clean_names()
## https://shorturl.at/hntxR :: dictionary (rich)
## https://shorturl.at/cirOX :: dictionary (raw)

# Wrangle ----

# eda ----

# names
d0 |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
d0 |>
  glimpse() |>
  skim()

# tokenizer
# df |>
#   unnest_tokens(output = word, 
#                 input = variable) |>
#   anti_join(stop_words, 
#             by = "word") |>
#   group_by(word) |>
#   summarise(n = n()) |>
#   arrange(desc(n))

# Visualise ----

## https://r-graph-gallery.com/sankey-diagram.html
## https://www.perplexity.ai/search/what-kind-of-1hNplpXKQAu7gMUjg1_pgg

# raw

# rice

# Analyse ----

# unassisted

# assisted

## question
## [...]

### https://chat.openai.com/share/
### https://g.co/bard/share/

# Communicate ----

# ...
