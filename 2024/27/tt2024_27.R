# --- TIDYTUESDAY::2024§27 --- #
# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-07-02/readme.md

# Load ----

.libPaths(c("~/.R/x86_64-pc-linux-gnu-library/4.4", .libPaths()))

# packages ----
pacman::p_load(
  data.table,           # https://cran.r-project.org/web/packages/data.table/
  ggthemes,             # https://cran.r-project.org/web/packages/ggthemes/
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
tt_data |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
tt_data |>
  glimpse() |>
  skim()

# Visualise ----

# bar_plot ----
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
  geom_text(aes(label = format(observations, big.mark = ",")),
            hjust = -0.2, 
            family = 'Roboto Mono', 
            color = '#ebdbb2',
            size = 3) +
  geom_bar(
    fill = '#ebdbb2', 
    stat = 'identity',
    width = .3) +
  scale_y_continuous(labels = scales::comma) +
  labs(
    title = "largest observations",
    subtitle = "shared throughout {tidytuesday} challenges",
    caption = "
    data pulled from https://t.ly/nm1Jr by https://github.com/federicoalegria",
    x = "",
    y = ""
  ) +
  coord_flip() +
  theme_wsj() +
  theme(
    axis.line.x = element_line(color = '#ebdbb2'),
    axis.ticks.x = element_line(color = '#ebdbb2'),
    axis.text = element_text(color = '#ebdbb2'),
    axis.title = element_text(color = '#ebdbb2'),
    panel.background = element_rect(fill = '#364355', color = '#364355'),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_line(color = '#ebdbb2'),
    plot.background = element_rect(fill = '#364355', color = '#364355'),
    plot.caption = element_text(color = '#ebdbb2', family = 'Roboto Mono', size = 11),
    plot.subtitle = element_text(color = '#ebdbb2', family = 'Roboto Mono', size = 15),
    plot.title = element_text(color = '#ebdbb2', family = 'Roboto Mono', size = 18),
    text = element_text(family = 'Roboto Mono', color = '#ebdbb2')
)

# ...
