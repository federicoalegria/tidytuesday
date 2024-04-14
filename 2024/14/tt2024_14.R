
# --- TIDYTUESDAY::2024§14 --- #

# https://github.com/rfordatascience/tidytuesday/tree/master/data/2024/2024-04-02

# Load ----

# packages
pacman::p_load(
  glue,
  janitor,
  skimr,
  tidylog,
  tidyverse,
  waffle
)

# data
dw <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-04-02/dubois_week10.csv'
  ) |>
  clean_names()
## https://shorturl.at/efAQ2 :: dictionary (rich)
## https://shorturl.at/kuAV4 :: dictionary (raw)

# Visualise ----

# "#e31b23"
# "#000000"
# "#00853f"

# waffle

dw |>
  mutate(count = percentage * 100) |>
  mutate(total = sum(count),
         prop = round((count / total) * 100)) |>
  select(!"total") |>
  filter(occupation != "Other Professions") |>
  ggplot(aes(
    fill = str_to_lower(glue("{occupation}: {percentage} %")),
    values = prop
  )) +  # Use glue() to create dynamic legend label
  geom_waffle(n_rows = 5,
              size = 10) +
  scale_fill_manual(values = c("#eb5f65", "#2E2E2E", "#e31b23", "#66b58b", "#00853f")) +
  guides(fill = guide_legend(title = " ")) +
  labs(
    title = "African American occupation distribution",
    subtitle = "professions of Atlanta University graduates in 1900",
    caption = "presented for the W.E.B Du Bois Visual Legacy challenge
    tidytuesday 2024§14〔https://shorturl.at/efAQ2〕
    https://www.loc.gov/resource/ppmsca.08994/
    https://en.wikipedia.org/wiki/W._E._B._Du_Bois
    panafrican colour's variants correspond to values from https://www.color-hex.com/"
  ) +
  theme_minimal() +
  theme(
    legend.position = 'left',
    legend.direction = 'vertical',
    legend.box = 'vertical',
    text = element_text(family = 'Consolas'),
    plot.title = element_text(family = 'Roboto Mono', face = 'bold', hjust = 1),
    plot.subtitle = element_text(family = 'Consolas', hjust = 1),
    axis.text = element_text(family = 'Consolas'),
    axis.title = element_text(family = 'Consolas'),
    plot.caption = element_text(family = 'Consolas')
)

# --- TIDYTUESDAY::2024§14 --- #
