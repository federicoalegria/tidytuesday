# --- TIDYTUESDAY::2024§27 --- #
# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-07-02/readme.md

# Load ----

.libPaths(c("~/.R/x86_64-pc-linux-gnu-library/4.4", .libPaths()))

# packages ----
pacman::p_load(
  data.table,           # https://cran.r-project.org/web/packages/data.table/
  janitor,              # https://cran.r-project.org/web/packages/janitor/
  skimr,                # https://cran.r-project.org/web/packages/skimr/
  tidyverse             # https://cran.r-project.org/web/packages/tidyverse/
)

# data ----
tt_data <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-07-02/tt_datasets.csv'
  ) |> clean_names()
# dictionary
# https://t.ly/nm1Jr

# Wrangle ----

# eda ----

# names
df |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
df |>
  glimpse() |>
  skim()

# head-count
head(tt_data)

# making-sense
tt_data |> 
  arrange(desc(variables))

tt_data |> 
  arrange(desc(observations))

# Visualise ----

# raw ----

tt_data |>
  select(dataset_name, observations) |>
  mutate(observations = as.integer(observations)) |>
  arrange(desc(observations)) |>
  filter(observations >= 600000) |>
  mutate(dataset_name =
           fct_reorder(dataset_name,
                       dataset_name,
                       .desc = TRUE)) |>
  ggplot(aes(x = dataset_name,
             y = observations)) +
  geom_bar(stat = 'identity') +
  scale_y_continuous(labels = scales::comma) +
  labs(
    title = "",
    subtitle = "",
    x = "",
    y = ""
  ) +
  coord_flip() +
  ggthemes::theme_wsj()

# rice ----

# Communicate ----

# ...
