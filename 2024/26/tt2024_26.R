# --- TIDYTUESDAY::2024§26 --- #

# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-06-25/readme.md

# Load ----

# packages ----
pacman::p_load(
  data.table,
  ggraph,               # https://cloud.r-project.org/web/packages/ggraph/index.html
  igraph,               # https://cloud.r-project.org/web/packages/igraph/index.html
  janitor,
  skimr,
  tidyverse,
  tidytext              # https://cloud.r-project.org/web/packages/tidytext/index.html
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

df |> 
  group_by(original_language) |> 
  summarise(n = n()) |> 
  arrange(desc(n))

df |> 
  group_by(vote_average) |> 
  summarise(n = n()) |> 
  arrange(desc(n)) |> 
  print(n = 250)

# Analyse ----

# visual ----

df |> 
  ggplot(aes(x = vote_average)) +
  geom_histogram(bins = 20, binwidth = .1)

# logistic ----

## numeric_explainer = vote_average
## logical_response = adult

# df_mod <- 
#   df |> 
#   filter(vote_average != 0) |> 
#   mutate(adult_binary = if_else(adult, 1, 0)) |> 
#   select(vote_average, adult_binary)
# 
# model <- glm(adult_binary ~ vote_average,
#              data = df_mod,
#              family = 'binomial')
# 
# summary(model)
# 
# df |>
#   mutate(adult_binary = if_else(adult, 1, 0)) |>
#   select(vote_average, adult_binary) |>
#   ggplot(aes(x = vote_average,
#              y = adult_binary)) +
#   geom_jitter(alpha = .1,
#               height = .05) +
#   geom_smooth(
#     method = 'glm',
#     method.args = list(family = 'binomial'),
#     se = FALSE
# )

## numeric_explainer = vote_count
## logical_response = adult

# df_mod <- 
#   df |> 
#   filter(vote_average != 0) |> 
#   mutate(adult_binary = if_else(adult, 1, 0)) |> 
#   select(vote_count, adult_binary)
# 
# model <- glm(adult_binary ~ vote_count,
#              data = df_mod,
#              family = 'binomial')
# 
# summary(model)
# 
# df |>
#   mutate(adult_binary = if_else(adult, 1, 0)) |>
#   select(vote_count, adult_binary) |>
#   ggplot(aes(x = vote_count,
#              y = adult_binary)) +
#   geom_jitter(alpha = .1,
#               height = .05) +
#   geom_smooth(
#     method = 'glm',
#     method.args = list(family = 'binomial'),
#     se = FALSE
# )

## numeric_explainer = popularity
## logical_response = adult

# df_mod <- 
#   df |> 
#   filter(vote_average != 0) |> 
#   mutate(adult_binary = if_else(adult, 1, 0)) |> 
#   select(popularity, adult_binary)
# 
# model <- glm(adult_binary ~ popularity,
#              data = df_mod,
#              family = 'binomial')
# 
# summary(model)
# 
# df |>
#   mutate(adult_binary = if_else(adult, 1, 0)) |>
#   select(popularity, adult_binary) |>
#   filter(popularity <= 10) |>
#   ggplot(aes(x = popularity,
#              y = adult_binary)) +
#   geom_jitter(alpha = .1,
#               height = .05) +
#   geom_smooth(
#     method = 'glm',
#     method.args = list(family = 'binomial'),
#     se = FALSE
# )

## numeric_explainer = video_binary
## logical_response = adult

# df_mod <- 
#   df |> 
#   filter(vote_average != 0) |> 
#   mutate(adult_binary = if_else(adult, 1, 0)) |> 
#   mutate(video_binary = if_else(video, 1, 0)) |> 
#   select(adult_binary, video_binary)
# 
# model <- glm(adult_binary ~ video_binary,
#              data = df_mod,
#              family = 'binomial')
# 
# summary(model)
# 
# df |>
#   mutate(adult_binary = if_else(adult, 1, 0)) |>
#   mutate(video_binary = if_else(video, 1, 0)) |>
#   select(adult_binary, video_binary) |>
#   ggplot(aes(x = video_binary,
#              y = adult_binary)) +
#   geom_jitter(alpha = .1,
#               height = .05) +
#   geom_smooth(
#     method = 'lm',
#     method.args = list(family = 'binomial'),
#     se = FALSE
# )

# numeric_explainer = vote_average
# logical_response = yay_nay_bin

# df_mod <-
#   df |>
#   filter(vote_average != 0) |> 
#   select(vote_average) |>
#   mutate(
#     yay_nay = case_when(
#       vote_average > 7 ~ "yay",
#       vote_average < 6.99 ~ "nay",
#       TRUE ~ NA_character_
#     ),
#     yay_nay_bin = case_when(yay_nay == "yay" ~ 1,
#                             yay_nay == "nay" ~ 0,
#                             TRUE ~ NA_integer_)
# )
# 
# model <- glm(yay_nay_bin ~ vote_average,
#              data = df_mod,
#              family = 'binomial')
# 
# summary(model)
# 
# df |>
#   select(vote_average) |>
#   mutate(
#     yay_nay = case_when(
#       vote_average > 7 ~ "yay",
#       vote_average < 6.99 ~ "nay",
#       TRUE ~ NA_character_
#     ),
#     yay_nay_bin = case_when(yay_nay == "yay" ~ 1,
#                             yay_nay == "nay" ~ 0,
#                             TRUE ~ NA_integer_)
#   ) |>
#   ggplot(aes(x = vote_average,
#              y = yay_nay_bin)) +
#   geom_jitter(alpha = .1,
#               height = .05) +
#   geom_smooth(
#     method = 'glm',
#     method.args = list(family = 'binomial'),
#     se = FALSE
# )

# sentiment ----
df |>
  unnest_tokens(output = word,
                input = overview) |>
  anti_join(stop_words,
            by = "word") |>
  group_by(word) |>
  summarise(n = n()) |>
  arrange(desc(n))

# n-grams ----

## bi-grams ----
df_bigrams <- 
  df |>
  select(overview) |>
  unnest_ngrams(word, overview, n = 2) |> 
  anti_join(stop_words, by = "word")

df_bigrams_sep <- 
  df_bigrams |> 
  separate(word, c("wordf", "word2"), sep = " ")

df_bigrams_filtered <- 
  df_bigrams_sep |> 
  filter(!wordf %in% stop_words$word) |> 
  filter(!word2 %in% stop_words$word)

df_bigram_counts <- df_bigrams_filtered |> 
  count(wordf, word2, sort = TRUE)

## graph

df_bigram_graph <- 
  df_bigram_counts |> 
  filter(n > 14) |> 
  igraph::graph_from_data_frame()

df_bigram_graph

set.seed(111)

a <- grid::arrow(type = "closed", length = unit(.15, "inches"))

ggraph(df_bigram_graph, layout = 'kk') +
  geom_edge_link(
    aes(edge_alpha = n),
    show.legend = FALSE,
    arrow = a,
    end_cap = circle(.07, 'inches')
  ) +
  geom_node_point(color = "#cc241d",
                  alpha = 0.85,
                  size = 3.5) +
  geom_node_text(
    aes(label = name, family = 'Consolas'),
    size = 3,
    vjust = 1,
    hjust = 1
  ) +
  labs(title = "common bigrams in overviews",
       subtitle = " ",
       caption = "") +
  theme(
    text = element_text(family = 'Consolas'),
    plot.title = element_text(face = 'bold'),
    panel.background = element_rect(fill = "#ffffff"),
    plot.background = element_rect(fill = "#ffffff")
)
## https://www.perplexity.ai/search/in-R-i-v5_M2NinRmK8PF1ae8ZH.g
## https://ggraph.data-imaginist.com/articles/Layouts.html

# Communicate ----

# ...
