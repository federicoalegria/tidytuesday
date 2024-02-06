
# --- TIDYTUESDAY::2024§04 --- #

# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-01-23/readme.md

# Load ----

pacman::p_load(
  janitor,
  skimr,
  tidyquant,
  tidyverse
)

# Data ----

ee <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-01-23/english_education.csv'
  ) |>
  clean_names()
## https://shorturl.at/dlNO3
### https://shorturl.at/ilpu0

# VISUALISE ----

# jitter plot
ee |>
  mutate(
    size_flag = case_when(
      size_flag == "Inner London BUA" ~ "London",
      size_flag == "Not BUA" ~ "London",
      size_flag == "Outer london BUA" ~ "London",
      size_flag == "Other Small BUAs" ~ "London",
      TRUE ~ as.character(size_flag)
    )
  ) |>
  ggplot(aes(x = education_score,
             y = fct_rev(fct_infreq(size_flag)))) +
  geom_jitter(
    aes(colour = coastal),
    alpha = 0.55,
    width = 0.2,
    height = 0.2
  ) +
  scale_color_manual(values = c(
    "Coastal" = "#2c6e49",
    "Non-coastal" = "#dea36a"
  )) +
  guides(color = guide_legend(title = NULL)) +
  theme_tq() +
  labs(
    title = "Educational Attainment",
    subtitle = "of young people in English coastal and non-coastal towns",
    caption = "tidytuesday 2024§04 [https://shorturl.at/cerU2]",
    x = "Education score",
    y = ""
  ) +
  theme(
    plot.caption = element_text(family = "Consolas", size = 8)
  )

# COMMUNICATE ----

# for this week, an unsuccessful replica of a beautiful graph available at https://shorturl.at/aFKN6
