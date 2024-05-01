
# --- TIDYTUESDAY::2024§16 --- #

# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-04-16/readme.md

# Load ----

# packages ----
pacman::p_load(
  data.table,                     # https://www.perplexity.ai/search/what-are-the-xqCDaaVNQ8SnVOzl77krAg
  ggraph,
  igraph,
  janitor,
  skimr,
  tidylog,
  tidytext,
  tidyverse
)

# data ----
# d0 <-
#   fread(
#    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-04-16/shiny_revdeps.csv' 
#   ) |> clean_names()

d1 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-04-16/package_details.csv'
  ) |> clean_names()
## https://shorturl.at/hntxR :: dictionary (rich)
## https://shorturl.at/cirOX :: dictionary (raw)

# Wrangle ----

# eda ----

# names
d1 |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
d1 |>
  glimpse() |>
  skim()

# selective glimpse & skim
d1 |>
  select(
    author,
    copyright,
    date,
    date_publication,
    description,
    license,
    license_is_foss,
    license_restricts_use,
    note,
    package
  ) |>
  glimpse() |>
  skim()

# tokenize
d1 |>
  select(
    author,
    copyright,
    date,
    date_publication,
    description,
    license,
    license_is_foss,
    license_restricts_use,
    note,
    package
  ) |>
  unnest_tokens(
    output = word,
    input = description
  ) |>
  anti_join(
    stop_words,
    by = "word"
  ) |>
  group_by(word) |>
  summarise(n = n()) |>
  arrange(desc(n))

# top 10 authors
d1 |> 
  group_by(author) |> 
  summarise(n = n()) |> 
  arrange(desc(n)) |> 
  head(10)

# descriptions by top 10 authors
d1 |>
  select(author, description) |>
  group_by(author) |>
  summarise(n = n()) |>
  arrange(desc(n)) |>
  slice_max(n, n = 10) |>
  left_join(d1, by = "author") |>
  select(author, description)
## https://www.perplexity.ai/search/after-the-last-GV78wDlGRIuUiD8oEQ68pQ

# description tokens by top 10 authors
d1 |>
  select(author, description) |>
  group_by(author) |>
  summarise(n = n()) |>
  arrange(desc(n)) |>
  slice_max(n, n = 10) |>
  left_join(d1, by = "author") |>
  select(author, description) |>
  unnest_tokens(
    output = word,
    input = description
  ) |>
  anti_join(
    stop_words,
    by = "word"
  ) |>
  group_by(word) |>
  summarise(n = n()) |>
  arrange(desc(n))

# longest and shortest descriptions
d1 |> 
  select(description) |> 
  arrange(desc(str_length(description)))
## https://www.perplexity.ai/search/help-me-sort-e4z7LapTT8Ci7UNzQ9JTTg

# shortest descriptions
d1 |>
  select(description) |>
  arrange(desc(str_length(description))) |>
  tail(25)

# Visualise ----

# bi-gram ----

d1 |>
  select(author, description) |>
  group_by(author) |>
  summarise(n = n()) |>
  arrange(desc(n)) |>
  slice_max(n, n = 10) |>
  left_join(d1, by = "author") |>
  select(author, description) |> 
  unnest_ngrams(word, description, n = 2) |> 
  anti_join(stop_words, by = "word") |> 
  group_by(word) |> 
  summarise(n = n()) |> 
  arrange(desc(n)
)

## bi-gram objects ----

d1_bigrams <- d1 |> 
  select(author, description) |>
  group_by(author) |>
  summarise(n = n()) |>
  arrange(desc(n)) |>
  slice_max(n, n = 10) |>
  left_join(d1, by = "author") |>
  select(author, description) |> 
  unnest_ngrams(word, description, n = 2) |> 
  anti_join(stop_words, by = "word")

d1_bigrams_sep <- d1_bigrams |> 
  separate(word, c("word1", "word2"), sep = " ")

d1_bigrams_filtered <- d1_bigrams_sep |> 
  filter(!word1 %in% stop_words$word) |> 
  filter(!word2 %in% stop_words$word)

d1_bigram_counts <- d1_bigrams_filtered |> 
  count(word1, word2, sort = TRUE)

## graph ----

d1_bigram_graph <- d1_bigram_counts |> 
  filter(n > 3) |> 
  igraph::graph_from_data_frame()

d1_bigram_graph

set.seed(1110)

a <- grid::arrow(type = "closed", length = unit(.15, "inches"))

ggraph(d1_bigram_graph, layout = "fr") +
  geom_edge_link(
    aes(edge_alpha = n),
    show.legend = FALSE,
    arrow = a,
    end_cap = circle(.07, 'inches')
  ) +
  geom_node_point(color = "#cc241d",
                  alpha = 0.85,
                  size = 3.5) +
  geom_node_text(aes(label = name, family = "Consolas"), size = 3, vjust = 1, hjust = 1) +
  labs(
    title = "common bigrams in descriptions",
    subtitle = "given by top authors contribuiting to Shiny",
    caption = "tidytuesday 2024§16〔https://shorturl.at/xBKL8〕"
  ) +
  theme(text = element_text(family = "Consolas"),
        plot.title = element_text(face = "bold"),
        panel.background = element_rect(fill = "#ffffff"),
        plot.background = element_rect(fill = "#ffffff")
)
