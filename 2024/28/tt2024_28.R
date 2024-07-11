# --- TIDYTUESDAY::2024§28 --- #
# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-07-09/readme.md

# Load ----

.libPaths(c("~/.R/x86_64-pc-linux-gnu-library/4.4", .libPaths()))

# packages ----
pacman::p_load(
  data.table,           # https://cran.r-project.org/web/packages/data.table/
  ggraph,               # https://cran.r-project.org/web/packages/ggraph/
  janitor,              # https://cran.r-project.org/web/packages/janitor/
  igraph,               # https://cran.r-project.org/web/packages/igraph/
  skimr,                # https://cran.r-project.org/web/packages/skimr/
  tidyverse             # https://cran.r-project.org/web/packages/tidyverse/
)

# data ----
df <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-07-09/drob_funs.csv'
  ) |>
  clean_names()
# dictionary
# https://t.ly/U-WWB

# Wrangle ----

# names
df |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
df |>
  glimpse() |>
  skim()

# eda ----

df |> 
  filter(!pkgs %in% c("(unknown)", "matrix", "WDI")) |> 
  group_by(pkgs) |> 
  summarise(n = n()) |> 
  arrange(desc(n))

df |> 
  filter(!pkgs %in% c("(unknown)", "matrix", "WDI")) |> 
  select(pkgs, funs) |> 
  group_by(pkgs, funs) |> 
  summarise(n = n()) |> 
  arrange(pkgs, desc(n))

# Visualise ----

palette <- c('#c33027', '#26a98b', '#edb54b', '#98d1ce', '#d26939')

# graph_from_data_frame
graph_df <- df |> 
  filter(!pkgs %in% c("(unknown)", "matrix", "WDI")) |> 
  filter(pkgs %in% c(
    "base",
    "dplyr",
    "forcats",
    "ggplot",
    "plotly",
    "readr",
    "stats",
    "stringr",
    "tidyr",
    "tune"
    )
  ) |> 
  select(pkgs, funs) |> 
  group_by(pkgs, funs) |> 
  summarise(n = n()) |> 
  arrange(pkgs, desc(n)) |> 
  graph_from_data_frame()

# get the nodes from the graph
nodes <- V(graph_df)

# assign colours to nodes repetitively
node_colours <- rep(palette, length.out = length(nodes))

# add a node attribute for colour
V(graph_df)$colour <- node_colours

# Plot the graph with the specified colours
ggraph(graph_df, layout = 'circlepack') + 
  geom_node_circle(aes(fill = colour)) +
  theme_void() +
  theme(plot.background = element_rect(fill = '#d3ebe9')) +
  scale_fill_identity()

# Communicate ----

# ...
