
# --- TIDYTUESDAY::2024§11 --- #

# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-03-12/readme.md

# Load ----

# packages
pacman::p_load(
  ggthemes,
  janitor,
  skimr,
  tidylog,
  tidytext,
  tidyverse
)

# data
fsp <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-03-12/fiscal_sponsor_directory.csv'
  ) |>
  clean_names() |>
  mutate(name = factor(name, levels = rev(sort(unique(
    name
  ))))) |>
  rename(criteria = eligibility_criteria) |>
  rename(details = details_url) |>
  rename(fee = fiscal_sponsorship_fee_description) |>
  rename(model = fiscal_sponsorship_model) |>
  rename(types = project_types) |>
  rename(year_sponsor = year_fiscal_sponsor)
## https://shorturl.at/ajwDW :: dictionary (rich)
## https://shorturl.at/rBTY3 :: dictionary (raw)

# Wrangle ----

# eda ----

# names
fsp |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
fsp |>
  glimpse() |>
  skim()

# Visualise ----

# Cleveland dotplot

fsp |>
  filter(year_501c3 != year_sponsor) |>          # filter sponsors which waited over a year 
  arrange(desc(n_sponsored)) |>                  # arrange for top sponsors
  slice(1:25) |>                                 # top 25
  select(name, year_501c3, year_sponsor) |>      # select variables of interest
  ggplot(y = reorder(name, (name))) +            # sort names alphabetically
  geom_segment(aes(
    x = name,
    xend = name,
    y = year_501c3,
    yend = year_sponsor
  ),
  color = "#3c3836") +
  geom_point(
    aes(x = name, y = year_501c3),
    color = '#3c3836',
    alpha = 0.9,
    size = 3.5
  ) +
  geom_point(
    aes(x = name, y = year_sponsor),
    color = '#98971a',
    alpha = 0.9,
    size = 3.5
  ) +
  geom_text(
    aes(x = name, y = year_501c3, label = year_501c3),
    hjust = 1.5,
    nudge_x = 0,
    nudge_y = 0,
    size = 3,
    family = 'Consolas'
  ) +
  geom_text(
    aes(x = name, y = year_sponsor, label = year_sponsor),
    hjust = -0.5,
    nudge_x = 0,
    nudge_y = 0,
    size = 3,
    family = 'Consolas'
  ) +
  coord_flip() +
  theme_minimal() +
  theme(
    legend.position = 'none',
    text = element_text(family = 'Roboto Mono'),
    plot.title = element_text(face = 'bold'),
    plot.subtitle = element_text(family = 'Consolas'),
    plot.caption = element_text(family = 'Consolas')
  ) +
  xlab("") +
  ylab("") +
  labs(title = "top fiscal sponsors",
       subtitle = "comparison between 501(c)(3) affiliation year and first sponsorship year",
       caption = "tidytuesday 2024§11〔https://shorturl.at/euxVW〕"
)

# ...
