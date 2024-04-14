
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
  waffle                                                        # https://cran.r-project.org/web/packages/waffle/index.html
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

# waffle

dw |>
  mutate(count = percentage * 100) |>                           # expand double values to integer values
  mutate(total = sum(count),
         prop = round((count / total) * 100)) |>                # mutate proportional values
  select(!"total") |>                                           # select all columns but `$total`
  filter(occupation != "Other Professions") |>                  # filter "Other Professions" out
  ggplot(aes(
    fill = str_to_lower(glue("{occupation}: {percentage} %")),  # use glue() to create dynamic legend label
    values = prop)                                              # glue() paste percentage values and "%" after occupation
  ) +                                                          
  geom_waffle(n_rows = 5, size = 10) +                          # geom_waffle()
  scale_fill_manual(values = c("#eb5f65",
                               "#2E2E2E",
                               "#e31b23",
                               "#66b58b",
                               "#00853f")
  ) +                                                           # Pan-African colour's variants correspond to values from https://www.color-hex.com/
  guides(fill = guide_legend(title = " ")) +
  labs(
    title = "African American occupation distribution",
    subtitle = "professions of Atlanta University graduates in 1900",
    caption = "presented for the W.E.B Du Bois Visual Legacy challenge
    tidytuesday 2024§14〔https://shorturl.at/efAQ2〕
    https://www.loc.gov/resource/ppmsca.08994/
    https://en.wikipedia.org/wiki/W._E._B._Du_Bois
    Pan-African colour's variants correspond to values from 'https://www.color-hex.com/'"
  ) +
  theme_minimal() +
  theme(
    legend.position = 'left',                                   # legend position: left side of the plot
    legend.direction = 'vertical',                              # legend direction to be displayed: vertical
    legend.box = 'vertical',                                    # legend box style: vertical
    text = element_text(family = 'Consolas'),                   # font family for general text elements
    plot.title = element_text(family = 'Roboto Mono',
                              face = 'bold',
                              hjust = 1),                       # font family, weight, and horizontal justification
    plot.subtitle = element_text(family = 'Consolas', 
                                 hjust = 1),                    # font family and horizontal justification
    axis.text = element_blank(),                                # remove text labels from the axis
    axis.title = element_blank(),                               # remove the titles from the axis
    plot.caption = element_text(family = 'Consolas')            # font family for the plot caption
)

# --- TIDYTUESDAY::2024§14 --- #
