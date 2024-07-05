# --- TIDYTUESDAY::2024§27 --- #

# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-07-02/readme.md

# Load ----

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

tt_summ <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-07-02/tt_summary.csv'
  ) |> clean_names()

tt_urls <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-07-02/tt_urls.csv'
  ) |> clean_names()

tt_vars <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-07-02/tt_variables.csv'
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
head(tt_summ)
head(tt_urls)
head(tt_urls)

# making-sense
tt_urls |> 
  group_by(type) |> 
  summarise(n = n())

tt_data |> 
  arrange(desc(variables))

tt_data |> 
  arrange(desc(observations))

# Visualise ----

# raw

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

# rice

# Analyse ----

# ...

# Communicate ----

# ...
