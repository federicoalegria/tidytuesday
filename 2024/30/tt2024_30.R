# --- TIDYTUESDAY::2024§30 --- #
# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-07-23/readme.md

# library path
.libPaths(c("~/.R/x86_64-pc-linux-gnu-library/4.4", .libPaths()))

# packages
pacman::p_load(
  data.table,           # https://cran.r-project.org/web/packages/data.table/
  ggthemes,             # https://cran.r-project.org/web/packages/ggthemes/
  janitor,              # https://cran.r-project.org/web/packages/janitor/
  skimr,                # https://cran.r-project.org/web/packages/skimr/
  styler,               # https://cran.r-project.org/web/packages/styler/
  tidyverse             # https://cran.r-project.org/web/packages/tidyverse/
)

# Import ----

# ratings
df <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-07-23/ratings.csv'
  ) |>
  clean_names()
# dictionary
# https://raw.

# Understand ----

# names
df |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
df |>
  glimpse() |>
  skim()

# missing values
sum(is.na(df$x18_49_rating_share))
sum(is.na(df$viewers_in_millions))

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

plot(df$viewers_in_millions, df$x18_49_rating_share)

# rice

df |>
  mutate(x18_49_rating_share = as.double(x18_49_rating_share)) |>
  filter(!is.na(x18_49_rating_share)) |>
  filter(x18_49_rating_share <= 10) |> 
  ggplot(aes(x = viewers_in_millions, y = x18_49_rating_share)) +
  geom_point(alpha = 0.75) +
  geom_smooth(colour = '#9d0006', fill = '#9d0006', alpha = 0.35) +
  theme(axis.text.y = element_text(angle = 0, hjust = 1)) +
  theme_wsj()

# model ----

# https://chatgpt.com/c/ebdee2ae-53d7-4721-9da8-578473413caf

# Communicate ----
# ...
