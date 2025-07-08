# --- tidytuesday::yyww --- #
# https://github.com/rfordatascience/tidytuesday/tree/master/data/2024/...

# setup ----

# library path
.libPaths(c("~/.R/x86_64-pc-linux-gnu-library/4.5", .libPaths()))

# packages
pacman::p_load(
  data.table,           # https://cran.r-project.org/web/packages/data.table/
  httr,                 # https://cran.r-project.org/web/packages/httr/
  janitor,              # https://cran.r-project.org/web/packages/janitor/
  skimr,                # https://cran.r-project.org/web/packages/skimr/
  tidytext,             # https://cran.r-project.org/web/packages/tidytext/
  tidyverse             # https://cran.r-project.org/web/packages/tidyverse/
)

# import
## check size
response <- HEAD('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-05-27/monsters.csv')
bytes <- as.numeric(response$headers[["content-length"]])
size_kb <- bytes / 1024
size_mb <- size_kb / 1024
cat(sprintf("df size: %.2f KB (%.2f MB)", size_kb, size_mb))
## load data
df <-
  fread(
    'link.csv'
  ) |>
  clean_names()
# dictionary
# https://raw.

# understand ----

# names
df |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
df |>
  glimpse() |>
  skim()

# tokenize
# df |>
#   unnest_tokens(output = word, input = variable) |>
#   anti_join(stop_words, by = "word") |>
#   group_by(word) |>
#   summarise(n = n()) |>
#   arrange(desc(n))

# transform ----

# visualise ----

# model ----

# communicate ----

# ...
