# --- tidytuesday::2523 --- #
# https://github.com/rfordatascience/tidytuesday/blob/main/data/2025/2025-06-10/readme.md

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
## load data
df00 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-10/judges_appointments.csv'
  ) |>
  clean_names()

df01 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-10/judges_people.csv'
  ) |>
  clean_names()
# dictionary
# https://raw.githubusercontent.com/rfordatascience/tidytuesday/refs/heads/main/data/2025/2025-06-10/readme.md

# understand ----

# names
df00 |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
df01 |>
  glimpse() |>
  skim()

# transform ----

# visualise ----

# model ----

# communicate ----

# ...

df00 |> 
  group_by(termination_reason) |> 
  summarise(n = n())

df00 |> 
  group_by(president_party) |> 
  summarise(n = n())

df01 |> 
  group_by(race) |> 
  summarise(n = n())
