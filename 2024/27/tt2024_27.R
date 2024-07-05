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
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-07-02/tt_datasets.csv'
  ) |> clean_names()

tt_summ <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-07-02/tt_summary.csv'
  ) |> clean_names()

tt_urls <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-07-02/tt_urls.csv'
  ) |> clean_names()

tt_vars <-
  readr::read_csv(
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
  arrange(desc(observations)) |>
  filter(observations >= 600000) |>
  mutate(row_num = row_number()) |>
  ggplot(aes(
    x = 0,
    xend = observations,
    y = row_num,
    yend = row_num
  )) +
  geom_hline(yintercept = 1:10,
             size = 14,
             color = "#dfdfdf") +
  geom_hline(yintercept = 1:10,
             size = 13,
             color = "#f7f7f7") +
  geom_segment(aes(color = dataset_name), size = 14, lineend = 'round') +
  geom_segment(size = 10,
               lineend = 'round',
               color = "#f7f7f7") +
  scale_color_manual(values = rep("#bf2c23", 10)) +
  geom_point(
    aes(x = observations - 0.03 * observations, color = dataset_name),
    size = 5,
    shape = 21,
    fill = 'white'
  ) +
  geom_point(
    aes(x = observations - 0.03 * observations, color = dataset_name),
    size = 2,
    shape = 21,
    fill = 'white'
  ) +
  scale_y_continuous(
    limits = c(0, 11),
    breaks = 1:10,
    labels = tt_data %>% arrange(desc(observations)) %>% filter(observations >= 600000) %>% pull(dataset_name)
  ) +
  scale_x_continuous(limits = c(0, max(tt_data$observations))) +
  coord_polar() +
  theme_void() +
  theme(legend.position = 'none')

# rice

# Analyse ----

# ...

# Communicate ----

# ...
