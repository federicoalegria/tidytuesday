
# --- TIDYTUESDAY::2023_48 --- #

# Packages ----

pacman::p_load(
  ggdark,
  ggforce,
  Hmisc,
  janitor,
  plotly,
  skimr,
  tidylog,
  tidyverse
)

# DATA ----

dwd <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-11-28/drwho_directors.csv'
  ) |> clean_names()

dwe <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-11-28/drwho_episodes.csv'
  ) |> clean_names() |> 
  mutate(season_number = as.factor(season_number))

dww <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-11-28/drwho_writers.csv'
  ) |> clean_names()

# CLEAN ----

# EXPLORE ----

# glimpse & skim
dwe |>
  glimpse() |> 
  skim()

# names
dwe |>
  slice(0) |> 
  glimpse()

# VISUALISE ----

# viz 01 ----

count_00 <- dwe |> 
  group_by(type) |> 
  count()

p1 <-
  dwe |>
  ggplot(aes(x = type,
             y = rating)) +
  geom_boxplot(
    alpha = 0.05,
    colour = "#ff9933",
    linewidth = 0.5,
    outlier.color = "#fb4d46",
    outlier.size = 2,
    outlier.shape = 18,
    notch = TRUE,
    varwidth = TRUE
  ) +
  scale_x_discrete(label = paste(count_00$type,
                                 "\n n = ",
                                 count_00$n)) +
  geom_violin(alpha = 0.05,
              colour = "#ff9933",
              linewidth = 0.5) +
  geom_sina(alpha = 0.5,
            colour = "#9999cc") +
  stat_summary(
    alpha = 0.65,
    fun.data = mean_cl_boot,
    geom = "point",
    colour = "#9999cc",
    size = 5
  ) +
  stat_summary(
    fun.data = mean_cl_boot,
    geom = "errorbar",
    colour = "#9999cc",
    size = 1,
    linewidth = 0.4
  ) +
  labs(
    title = "Dr Who's Revival",
    subtitle = "episode rating by type",
    caption = "{tidytuesday 2023∙48}
    https://github.com/rfordatascience/tidytuesday/blob/master/data/2023/2023-11-28/readme.md",
    x = "Type",
    y = "Rating"
  ) +
  dark_mode() +
  theme(
    legend.position = "none",
    text = element_text(color = "#ff9933"),
    axis.text = element_text(
      color = "#ff9933",
      family = "Noto",
      size = 12
    ),
    plot.title = element_text(
      color = "#ff9933",
      family = "Noto Bold",
      size = 22
    ),
    plot.subtitle = element_text(
      color = "#ff9933",
      family = "Noto",
      size = 16
    ),
    plot.caption = element_text(
      color = "#ff9933",
      family = "Monospace",
      size = 10
    ),
    axis.title = element_text(color = "#ff9933", family = "Noto")
  )

# viz 02 ----

count_01 <- dwe |> 
  filter(type == "episode") |> 
  group_by(season_number) |> 
  count()

p2 <-
  dwe |>
  filter(type == "episode") |>
  ggplot(aes(x = season_number,
             y = rating)) +
  geom_boxplot(
    alpha = 0.05,
    colour = "#ff9933",
    linewidth = 0.5,
    outlier.color = "#fb4d46",
    outlier.size = 2,
    outlier.shape = 18,
    notch = TRUE,
    varwidth = TRUE
  ) +
  scale_x_discrete(label = paste(count_01$season_number,
                                 "\n n = ",
                                 count_01$n)) +
  geom_violin(alpha = 0.05,
              colour = "#ff9933",
              linewidth = 0.35) +
  geom_sina(alpha = 0.5,
            colour = "#9999cc")+
  stat_summary(
    alpha = 0.65,
    fun.data = mean_cl_boot,
    geom = "point",
    colour = "#9999cc",
    size = 5
  ) +
  stat_summary(
    fun.data = mean_cl_boot,
    geom = "errorbar",
    colour = "#9999cc",
    size = 1,
    linewidth = 0.4
  ) +
  labs(
    title = "Dr Who's Revival",
    subtitle = "episode rating by season",
    caption = "{tidytuesday 2023∙48}
    https://github.com/rfordatascience/tidytuesday/blob/master/data/2023/2023-11-28/readme.md",
    x = "Season",
    y = "Rating"
  ) +
  dark_mode() +
  theme(
    legend.position = "none",
    text = element_text(color = "#ff9933"),
    axis.text = element_text(
      color = "#ff9933",
      family = "Noto",
      size = 12
    ),
    plot.title = element_text(
      color = "#ff9933",
      family = "Noto Bold",
      size = 22
    ),
    plot.subtitle = element_text(
      color = "#ff9933",
      family = "Noto",
      size = 16
    ),
    plot.caption = element_text(
      color = "#ff9933",
      family = "Monospace",
      size = 10
    ),
    axis.title = element_text(color = "#ff9933", family = "Noto")
  )

# COMMUNICATE ----

# Interactive plots ----

ggplotly(p1)
ggplotly(p2)

# ... ----

