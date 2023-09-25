
# --- TIDYTUESDAY::2023_38 --- #

# LIBRARIES ----

require(pacman)

p_load(ggthemes,
       janitor,
       skimr,
       tidyverse,
       treemap)

# DATA ----

# hhttps://github.com/rfordatascience/tidytuesday/blob/master/data/2023/2023-09-19/readme.md
cran_20230905 <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-09-19/cran_20230905.csv'
  )
package_authors <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-09-19/package_authors.csv'
  )
cran_graph_nodes <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-09-19/cran_graph_nodes.csv'
  )
cran_graph_edges <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-09-19/cran_graph_edges.csv'
  )

# EXPLORE ----

package_authors |> 
  glimpse() |> 
  skim()

package_authors |>
  group_by(Package) |>
  summarise(n = n()) |>
  arrange(desc(n))

# CLEAN ----

# VISUALISE ----

# Treemap
?treemap

package_authors |>
  group_by(Package) |>
  summarise(n = n()) |>
  arrange(desc(n)) |>
  filter(n >= 57) |>
  mutate(label = paste(Package, n, sep = "\n")) |>
  treemap(
    index = "label",
    vSize = "n",
    type = "index",
    palette = "RdYlBu",
    title = "Top 10 R packages with most authors",
    fontsize.title = 18,
    fontfamily.title = "sans bold",
    fontsize.labels = 12,
    fontfamily.labels = "mono"
  )

# playground ----

# ... ----