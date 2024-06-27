# --- TIDYTUESDAY::2024§26 --- #

# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-06-25/readme.md

# Load ----

# packages ----
pacman::p_load(
  data.table,
  janitor,
  skimr,
  tidyverse,
  tidytext              # https://juliasilge.github.io/tidytext/
)

# data ----
df <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-06-25/lgbtq_movies.csv'
  ) |>
  clean_names()
# dictionary
# https://t.ly/8wEVH

# Wrangle ----

# eda ----

# names
df |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
df |> 
  select(!release_date) |> 
  glimpse() |> 
  skim()

# Analyse ----

# logistic ----

# numeric_explainer = vote_average
# logical_response = adult

df_mod <- 
  df |> 
  mutate(adult_binary = if_else(adult, 1, 0)) |> 
  select(vote_average, adult_binary)

model <- glm(adult_binary ~ vote_average,
             data = df_mod,
             family = 'binomial')

summary(model)

df |>
  mutate(adult_binary = if_else(adult, 1, 0)) |>
  select(vote_average, adult_binary) |>
  ggplot(aes(x = vote_average,
             y = adult_binary)) +
  geom_jitter(alpha = .1,
              height = .05) +
  geom_smooth(
    method = 'glm',
    method.args = list(family = 'binomial'),
    se = FALSE
)

# numeric_explainer = vote_count
# logical_response = adult

df_mod <- 
  df |> 
  mutate(adult_binary = if_else(adult, 1, 0)) |> 
  select(vote_count, adult_binary)

model <- glm(adult_binary ~ vote_count,
             data = df_mod,
             family = 'binomial')

summary(model)

df |>
  mutate(adult_binary = if_else(adult, 1, 0)) |>
  select(vote_count, adult_binary) |>
  ggplot(aes(x = vote_count,
             y = adult_binary)) +
  geom_jitter(alpha = .1,
              height = .05) +
  geom_smooth(
    method = 'glm',
    method.args = list(family = 'binomial'),
    se = FALSE
)

# numeric_explainer = popularity
# logical_response = adult

df_mod <- 
  df |> 
  mutate(adult_binary = if_else(adult, 1, 0)) |> 
  select(popularity, adult_binary)

model <- glm(adult_binary ~ popularity,
             data = df_mod,
             family = 'binomial')

summary(model)

df |>
  mutate(adult_binary = if_else(adult, 1, 0)) |>
  select(popularity, adult_binary) |>
  filter(popularity <= 10) |>
  ggplot(aes(x = popularity,
             y = adult_binary)) +
  geom_jitter(alpha = .1,
              height = .05) +
  geom_smooth(
    method = 'glm',
    method.args = list(family = 'binomial'),
    se = FALSE
)

# numeric_explainer = video_binary
# logical_response = adult

df_mod <- 
  df |> 
  mutate(adult_binary = if_else(adult, 1, 0)) |> 
  mutate(video_binary = if_else(video, 1, 0)) |> 
  select(adult_binary, video_binary)

model <- glm(adult_binary ~ video_binary,
             data = df_mod,
             family = 'binomial')

summary(model)

df |>
  mutate(adult_binary = if_else(adult, 1, 0)) |>
  mutate(video_binary = if_else(video, 1, 0)) |>
  select(adult_binary, video_binary) |>
  ggplot(aes(x = video_binary,
             y = adult_binary)) +
  geom_jitter(alpha = .1,
              height = .05) +
  geom_smooth(
    method = 'lm',
    method.args = list(family = 'binomial'),
    se = FALSE
)

# numeric_explainer = vote_average
# logical_response = yay_nay_bin

df_mod <-
  df |>
  select(vote_average) |>
  mutate(
    yay_nay = case_when(
      vote_average > 7 ~ "yay",
      vote_average < 6.99 ~ "nay",
      TRUE ~ NA_character_
    ),
    yay_nay_bin = case_when(yay_nay == "yay" ~ 1,
                            yay_nay == "nay" ~ 0,
                            TRUE ~ NA_integer_)
)

model <- glm(yay_nay_bin ~ vote_average,
             data = df_mod,
             family = 'binomial')

summary(model)

df |>
  select(vote_average) |>
  mutate(
    yay_nay = case_when(
      vote_average > 7 ~ "yay",
      vote_average < 6.99 ~ "nay",
      TRUE ~ NA_character_
    ),
    yay_nay_bin = case_when(yay_nay == "yay" ~ 1,
                            yay_nay == "nay" ~ 0,
                            TRUE ~ NA_integer_)
  ) |>
  ggplot(aes(x = vote_average,
             y = yay_nay_bin)) +
  geom_jitter(alpha = .1,
              height = .05) +
  geom_smooth(
    method = 'glm',
    method.args = list(family = 'binomial'),
    se = FALSE
)

# sentiment ----
df |>
  unnest_tokens(output = word,
                input = overview) |>
  anti_join(stop_words,
            by = "word") |>
  group_by(word) |>
  summarise(n = n()) |>
  arrange(desc(n))

# Communicate ----

# ...
