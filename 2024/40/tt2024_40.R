# --- TIDYTUESDAY::2024§40 --- #
# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-10-01/readme.md

# library path
.libPaths(c("~/.R/x86_64-pc-linux-gnu-library/4.4", .libPaths()))

# packages
pacman::p_load(
  data.table,           # https://cran.r-project.org/web/packages/data.table/
  janitor,              # https://cran.r-project.org/web/packages/janitor/
  skimr,                # https://cran.r-project.org/web/packages/skimr/
  styler,               # https://cran.r-project.org/web/packages/styler/
  tidymodels             # https://cran.r-project.org/web/packages/tidymodels/
)

# Import ----
df <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-10-01/chess.csv'
  ) |>
  clean_names()
# dictionary
# https://t.ly/F9VqU

# Understand ----

# names
df |> 
  slice(1:3) |> 
  glimpse()

# glimpse & skim
df |>
  glimpse() |>
  skim()

# transform ----

dfs <- 
  df |> 
  mutate(
    draw = as.integer(victory_status == "draw"),
    mate = as.integer(victory_status == "mate"),
    outoftime = as.integer(victory_status == "outoftime"),
    resign = as.integer(victory_status == "resign")
  ) |> 
  select(turns, draw:resign) |> 
  filter(turns <= 200)

# model ----

# https://www.youtube.com/watch?v=_yNWzP5HfGw
# https://www.perplexity.ai/search/what-deos-a-variable-rated-t-f-YxqSRVF1SBqiIhElhuMMIg

# split

set.seed(2)

split <- initial_split(
  dfs,
  prop = .8,
  strata = outoftime
)

dfs_train <- training(split)

dfs_test <- testing(split)

View(dfs_train)

# visualise ----

ggplot(dfs_train, aes(
  x = turns,
  y = outoftime
  )) +
  geom_jitter(
    height = .05,
    alpha = .5) +
  geom_smooth(
    method = 'glm',
    method.args = list(family = 'binomial'),
    se = FALSE
  ) + 
  theme_minimal()

# data looks like not a good candidate for building a logistic regression model
# with for a binary response variable y with a quantitative explainer x

# Communicate ----
# ...
