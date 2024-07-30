# --- TIDYTUESDAY::2024§30 --- #
# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-07-23/readme.md

# library path
.libPaths(c("~/.R/x86_64-pc-linux-gnu-library/4.4", .libPaths()))

# packages
pacman::p_load(
  data.table,           # https://cran.r-project.org/web/packages/data.table/
  janitor,              # https://cran.r-project.org/web/packages/janitor/
  skimr,                # https://cran.r-project.org/web/packages/skimr/
  styler,               # https://cran.r-project.org/web/packages/styler/
  tidyverse             # https://cran.r-project.org/web/packages/tidyverse/
)

# Import ----

# ratings
df04 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-07-23/ratings.csv'
  ) |>
  clean_names()
# dictionary
# https://raw.

# Understand ----

# names
df04 |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
df04 |>
  glimpse() |>
  skim()

# missing values
sum(is.na(df04$x18_49_rating_share))
sum(is.na(df04$viewers_in_millions))

# tokenize
# df |>
#   unnest_tokens(output = word, input = variable) |>
#   anti_join(stop_words, by = "word") |>
#   group_by(word) |>
#   summarise(n = n()) |>
#   arrange(desc(n))

# transform ---

# visualise ----

# raw

plot(df04$viewers_in_millions, df04$x18_49_rating_share)

# rice

# model ----

# https://www.perplexity.ai/search/in-r-i-want-to-conduct-a-simpl-L3PN2ss3T8mQDq3lT3J7SA

model <- lm(x18_49_rating_share ~ viewers_in_millions, data = df04)

plot(model)

# Communicate ----
# ...
