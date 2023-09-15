
# LIBRARIES ----

require(pacman)

p_load(ggthemes,
       janitor,
       skimr,
       tidyverse)

# DATA ----

# https://github.com/rfordatascience/tidytuesday/blob/master/data/2023/2023-09-12/readme.md
all_countries <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-09-12/all_countries.csv'
  )

# EXPLORE ----

all_countries |>
  clean_names() |> 
  glimpse() |>
  skim()

# CLEAN ----

# Filter El Salvador (SLV) from `$country_iso3`, and everything else
# but bed time (Sleep & bedrest) from `$subcategory`
slv <- all_countries |>
  clean_names() |> 
  filter(country_iso3 == "SLV" &
           subcategory != "Sleep & bedrest")

# VISUALISE ----

# Lollipop plot
slv |>
  arrange(desc(hours_per_day_combined)) |>
  ggplot(aes(x = hours_per_day_combined,
             y = subcategory)) +
  geom_segment(aes(
    x = 0,
    xend = hours_per_day_combined,
    y = subcategory,
    yend = subcategory
  )) +
  geom_point(
    aes(fill = category),
    alpha = 1,
    shape = 21,
    size = 3,
    stroke = 1
  ) +
  scale_y_discrete(limits = rev(as.character(sort(
    unique(slv$subcategory)
  )))) +
  theme_wsj() +
  scale_fill_manual(
    values = c(
      "#855C75",
      "#D9AF6B",
      "#AF6458",
      "#736F4C",
      "#526A83",
      "#625377",
      "#68855C",
      "#9C9C5E"
    )
  ) +
  labs(
    title = "beyond bed",
    subtitle = "time usage in El Salvador after sleeping & resting
    ",
    caption = "
    {tidytuesday 2023∙37}
    https://github.com/rfordatascience/tidytuesday/blob/master/data/2023/2023-09-12",
    x = "Hours per Day",
    y = "Sub-categories"
  ) +
  theme(
    legend.title = element_text(size = 14),
    plot.caption = element_text(size = 10),
    plot.subtitle = element_text(size = 18)
  ) +
  guides(fill = guide_legend(override.aes = list(size = 5)))

# ----