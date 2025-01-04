# --- tidytuesday::2501 --- #
# https://github.com/rfordatascience/tidytuesday/tree/master/data/2024/...

# library path
.libPaths(c("~/.R/x86_64-pc-linux-gnu-library/4.4", .libPaths()))

# packages
pacman::p_load(
  data.table,           # https://cran.r-project.org/web/packages/data.table/
  haven,                # https://cran.r-project.org/web/packages/haven/
  janitor,              # https://cran.r-project.org/web/packages/janitor/
  skimr,                # https://cran.r-project.org/web/packages/skimr/
  tidytext,             # https://cran.r-project.org/web/packages/tidytext/
  tidyverse             # https://cran.r-project.org/web/packages/tidyverse/
)

# import
df <-
  read_sav(
    '/home/arch/Documents/binder/datasets/sav/eut_2022.sav'
  ) |> 
  clean_names()
# dictionary
# https://onec.bcr.gob.sv/observatorio.genero/uso_tiempo/

# understand ----

# names
df |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
df |>
  glimpse() |>
  skim()

# transform ----

# visualise ----

# model ----

# communicate ----

# ...
