
# --- TIDYTUESDAY::2024§08 --- #

# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-02-20/readme.md

# Load ----

pacman::p_load(
  ggraph,
  igraph,
  janitor,
  skimr,
  tidytext,
  tidyverse,
  wordcloud2,
  tidylog
)

# Data ----

ig <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-02-20/isc_grants.csv'
  ) |> clean_names()

## https://shorturl.at/nzQV3 :: dictionary (rich)

# EXPLORE ----

# names
ig |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
ig |>
  glimpse() |>
  skim()

# VISUALISE ----

# bi-gram ----

ig |> 
  select(summary) |> 
  unnest_ngrams(word, summary, n = 2) |> 
  anti_join(stop_words, by = "word") |> 
  group_by(word) |> 
  summarise(n = n()) |> 
  arrange(desc(n)
)

## bi-gram objects ----

ig_bigrams <- ig |> 
  select(summary) |> 
  unnest_ngrams(word, summary, n = 2) |> 
  anti_join(stop_words, by = "word")

ig_bigrams_sep <- ig_bigrams |> 
  separate(word, c("word1", "word2"), sep = " ")

ig_bigrams_filtered <- ig_bigrams_sep |> 
  filter(!word1 %in% stop_words$word) |> 
  filter(!word2 %in% stop_words$word)

ig_bigram_counts <- ig_bigrams_filtered |> 
  count(word1, word2, sort = TRUE)

### graph ----
ig_bigram_graph <- ig_bigram_counts |> 
  filter(n > 3) |> 
  graph_from_data_frame()

ig_bigram_graph

set.seed(8080)

ggraph(ig_bigram_graph, layout = "fr") +
  geom_edge_link() +
  geom_node_point(color = "#000000",
                  alpha = 0.65,
                  size = 2) +
  geom_node_text(aes(label = name, family = "Consolas"), size = 3, vjust = 1, hjust = 1) +
  labs(
    title = "common bigrams in summaries listed in the 'R Consortium ISC Grants' data-structure",
    subtitle = "showing those that occurred more than three times and where neither word was a stop word",
    caption = "data is an exploration of past grant recipients
              tidytuesday 2024§08 [https://shorturl.at/dlSUZ]"
  ) +
  theme(text = element_text(family = "Consolas"),
        plot.title = element_text(face = "bold")
)

a <- grid::arrow(type = "closed", length = unit(.15, "inches"))

set.seed(8080)

ggraph(ig_bigram_graph, layout = "fr") +
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
    title = "common bigrams in summaries listed in the 'R Consortium ISC Grants' data-structure",
    subtitle = "showing those that occurred more than three times and where neither word was a stop word",
    caption = "data is an exploration of past grant recipients
              tidytuesday 2024§08 [https://shorturl.at/dlSUZ]"
  ) +
  theme(text = element_text(family = "Consolas"),
        plot.title = element_text(face = "bold"),
        panel.background = element_rect(fill = "#ffffff"),
        plot.background = element_rect(fill = "#ffffff")
)

# ... ----
