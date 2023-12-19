
# --- TIDYTUESDAY::2023_50 --- #

# Packages ----

pacman::p_load(
  easystats,
  ggridges,
  ggthemes,
  janitor,
  skimr,
  tidyverse
)

# DATA ----

hm <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-12-12/holiday_movies.csv'
  ) |> clean_names()

# CLEAN ----

# EXPLORE ----

# glimpse & skim
hm |>
  glimpse() |> 
  skim()

# names
hm |>
  slice(0) |> 
  glimpse()

hm |> 
  group_by(genres) |> 
  summarise(n = n()) |> 
  arrange(desc(n)) |> 
  print(n = 204)

hm |>
  filter(title_type == "movie") |>
  mutate(genres = str_replace(
    genres, ",(.*)", "")
  ) |>
  group_by(genres) |>
  summarise(n = n()) |>
  arrange(desc(n)) |> 
  filter(n >= 13) |> 
  filter(genres != "NA")

# titles
hm |> 
  filter(title_type == "movie") |> 
  filter(str_detect(primary_title, pattern = "ccoon"))

# VISUALISE ----

# Histograms ----

hm |>
  filter(title_type == "movie") |>
  ggplot(aes(x = num_votes)) +
  geom_histogram()

hm |>
  filter(title_type == "movie") |>
  ggplot(aes(x = average_rating)) +
  geom_histogram()

hm |>
  filter(title_type == "movie") |>
  ggplot(aes(x = runtime_minutes)) +
  geom_histogram()

# Boxplot ----

hm |>
  filter(title_type == "movie") |>
  ggplot(aes(x = num_votes,
             y = average_rating)) +
  geom_boxplot(
    notch = TRUE,
    outlier.colour = "#2f4241",
    outlier.alpha = 0.5
  )

# Ridgeplot ----

rp <- 
  hm |>
  filter(title_type == "movie" & !is.na(genres)) |>
  mutate(genres = str_replace(genres, ",(.*)", "")) |>
  filter(
    genres %in% c(
      "Action",
      "Adventure",
      "Animation",
      "Biography",
      "Comedy",
      "Crime",
      "Documentary",
      "Drama",
      "Family",
      "Fantasy",
      "Horror",
      "Music",
      "Musical",
      "Romance",
      "Thriller"
    )
  ) |>
  ggplot(aes(x = average_rating, y = reorder(genres, desc(genres)))) +
  geom_density_ridges(aes(fill = genres, colour = genres), alpha = 0.7) +
  scale_fill_manual(
    values = c(
      "#828d8d",
      "#d6001c",
      "#458a0e",
      "#828d8d",
      "#d6001c",
      "#458a0e",
      "#828d8d",
      "#d6001c",
      "#458a0e",
      "#828d8d",
      "#d6001c",
      "#458a0e",
      "#828d8d",
      "#d6001c",
      "#458a0e"
    )
  ) +
  scale_colour_manual(
    values = c(
      "#272a2a",
      "#55000b",
      "#1b3705",
      "#272a2a",
      "#55000b",
      "#1b3705",
      "#272a2a",
      "#55000b",
      "#1b3705",
      "#272a2a",
      "#55000b",
      "#1b3705",
      "#272a2a",
      "#55000b",
      "#1b3705"
    )
  ) +
  labs(
    title = "Holiday Movies:",
    subtitle = "rating's density ~ genre",
    caption = "ridges are sorted in alphabetical order 
    {tidytuesday 2023_50} -> https://shorturl.at/dtEOY",
    x = "average rating",
    y = "genres"
  ) +
  theme_minimal() +
  scale_y_discrete() +
  theme(legend.position = "none") +
  theme(
    plot.title = element_text(
      family = "Consolas",
      face = "bold",
      size = 18
    ),
    plot.subtitle = element_text(
      family = "Consolas", 
      size = 12
    ),
    plot.caption = element_text(
      family = "Consolas"
    ),
    axis.text = element_text(
      family = "Consolas",
      face = "bold"
    ), 
    axis.title = element_text(
      family = "Consolas",
      face = "bold",
      size = 10
    ),
    text = element_text(color = "#2f4241"),
    plot.margin = margin(
      15,
      15, 
      15, 
      15, 
      "pt")
  )

# Scatterplot ----

sp <- 
  hm |>
  mutate(votes = cut(
    num_votes,
    breaks = c(0, 100000, 20000, Inf),
    labels = c("few", "some", "several")
  )) |>
  filter(title_type == "movie") |>
  ggplot(aes(x = runtime_minutes,
             y = average_rating)) +
  geom_jitter(aes(size = num_votes,
                  colour = votes),
              alpha = 0.5) +
  scale_colour_manual(values = c("#828d8d",
                                 "#458a0e",
                                 "#d6001c"),
                      guide = guide_legend(title = NULL)) +
  geom_text(
    aes(label = primary_title),
    data = . %>% filter(votes == "several"),
    check_overlap = TRUE,
    vjust = 2.5,
    hjust = 0.5,
    size = 3,
    family = "Noto Sans",
    alpha = 0.8
  ) +
  labs(
    title = "Holiday movies:",
    subtitle = "runtime in minutes ~ average rating",
    caption = "data-points' size correspond to the amount of votes per movie
    {tidytuesday 2023_50} -> https://shorturl.at/dtEOY",
    x = "runtime in minutes",
    y = "average rating"
  ) +
  theme_minimal() +
  scale_size_continuous(labels = scales::number_format(
    scale = 1, 
    suffix = ""),
    guide = FALSE
  ) +
  theme(
    legend.position = "right",
    legend.justification = "right",
    legend.box = "vertical",
    legend.margin = margin(
      t = 1,
      r = 1,
      b = 1,
      l = 1
    ),
    plot.title = element_text(
      family = "Consolas",
      face = "bold",
      size = 18
    ),
    plot.subtitle = element_text(
      family = "Consolas", 
      size = 12
    ),
    plot.caption = element_text(
      family = "Consolas"
    ),
    axis.text = element_text(
      family = "Consolas",
      face = "bold"
    ), 
    axis.title = element_text(
      family = "Consolas",
      face = "bold",
      size = 10
    ),
    text = element_text(color = "#2f4241"),
    plot.margin = margin(
      15,
      15, 
      15, 
      15, 
      "pt")
  ) +
  guides(colour = guide_legend(
    order = 1,
    title = NULL),
    size = "none"
  )

# Interactive ----

plotly::ggplotly(sp)

# ANALYSE ----

# check normality ----

ks.test(hm$runtime_minutes, "pnorm")
ks.test(hm$average_rating, "pnorm")

# model ----

cor.test(hm$runtime_minutes,
         hm$average_rating,
         method = "spearman")
## interpretation = https://www.perplexity.ai/search/how-can-I-xxWF6TlPRuqSDovpg9dBmw

# COMMUNICATE ----

## Let's see how average rating behaves in holiday movies according to IMDB

# ... ----

# discards ----

# facet
hm |>
  ggplot(aes(x = runtime_minutes,
             y = average_rating)) +
  geom_jitter(colour = "#2f4241",
              alpha = 0.3) +
  geom_smooth(colour = "#e64b11",
              linewidth = 0.5,
              method = "lm") +
  facet_wrap(~ title_type,
             ncol = 1,
             scales = "free_y") +
  labs(x = "Runtime in minutes",
       y = "Average Rating")

# single
hm |>
  filter(title_type == "movie") |>
  ggplot(aes(x = runtime_minutes,
             y = average_rating)) +
  geom_jitter(aes(size = num_votes),
              colour = "#2f4241",
              alpha = 0.3) +
  geom_smooth(colour = "#e64b11",
              linewidth = 0.5,
              method = "lm") +
  labs(x = "Runtime in minutes",
       y = "Average Rating")

# further ----

# questions ----

# which are the worst rated holiday movies?
hm |>
  filter(title_type == "movie") |>
  select(average_rating,
         num_votes,
         primary_title,
         year,
         runtime_minutes,
         genres) |>
  arrange(average_rating) |>
  print(n = 100)
## do you agree with this top 100?

# logistic regression ----

hm |> 
  select(christmas, hanukkah, kwanzaa, holiday)
