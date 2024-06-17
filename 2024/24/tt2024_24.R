# --- TIDYTUESDAY::2024§24 --- #

# https://github.com/rfordatascience/tidytuesday/tree/master/data/2024/...

# Load ----

# packages ----
pacman::p_load(
  data.table,
  janitor,
  skimr,
  tidyverse
)

# data ----
df_pi <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-06-11/pride_index.csv'
  ) |>
  clean_names()

df_pit <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-06-11/pride_index_tags.csv'
  ) |>
  clean_names()
# dictionary
# https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-06-11/readme.md

df <- 
  full_join(df_pi, 
            df_pit, 
            by = c("campus_name", "campus_location")
)

rm(df_pi, df_pit)

# Wrangle ----

# recode lgl as binary
df_bin <- 
  df |> 
  mutate(across(6:21, ~if_else(is.na(.x), FALSE, .x) %>% as.numeric()))
  # mutate(rating = ifelse(rating >= 3.0, 1, 0))

# eda ----

# names
df |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
df |>
  glimpse() |>
  skim()

# quick-summaries
qs <- function(df_bin, start, end) {
  for (i in start:end) {
    print(df_bin |> group_by(!!sym(names(df_bin)[i])) |> summarise(n = n()))
  }
}

# look for high 1-count
qs(df_bin, 6, 21)

# Analyse ----

# model

model <- glm(residential ~ rating,
             data = df_bin,
             family = 'binomial')

summary(model)

# Visualise ----

df_bin |> 
  ggplot(aes(x = rating,
             y = residential)) +
  geom_jitter(height = .05,
              alpha = .5) + 
  geom_smooth(method = 'glm',
              method.args = list('binomial'),
              se = FALSE) + 
  labs(y = " ") + 
  theme_minimal()

# Communicate ----

# ...

# https://www.youtube.com/watch?v=E7J3M1oYVlc
