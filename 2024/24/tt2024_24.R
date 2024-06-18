# --- TIDYTUESDAY::2024§24 --- #

# https://github.com/rfordatascience/tidytuesday/tree/master/data/2024/...

# Load ----

# packages ----
pacman::p_load(
  data.table,
  easystats,
  janitor,
  lme4,        # https://cran.r-project.org/web/packages/lme4/index.html
  sjPlot,      # https://cran.r-project.org/web/packages/sjPlot/index.html
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
  mutate(rating = ifelse(rating >= 3.5, 1, 0)) |> 
  mutate(across(6:21, ~if_else(is.na(.x), FALSE, .x) %>% as.numeric())) |> 
  select(3,6:21)
  
  # mutate(rating = ifelse(rating >= 3.0, 1, 0))

# eda ----

# names
df_bin|> 
  slice(0) |> 
  glimpse()

# glimpse & skim
df_bin|>
  glimpse() |>
  skim()

# quick-summaries
qs <- function(df_bin, start, end) {
  for (i in start:end) {
    print(df_bin |> group_by(!!sym(names(df_bin)[i])) |> summarise(n = n()))
  }
}

# look for high 1-count
qs(df_bin, 1, 17)

# Analyse ----

# model

model <- glm(rating ~ ., family = binomial, data = df_bin[, c(1, 2:17)])

summary(model)

# Visualise ----

performance(model) |> 
  gt::gt()

tab_model(model)

plot_model(model, type = 'pred', terms = 'doctoral')

p <- plot_model(model, type = 'pred')

plot_grid(p)

# Communicate ----

# ...

# https://www.youtube.com/watch?v=E7J3M1oYVlc
