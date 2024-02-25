
# --- TIDYTUESDAY::2024§06 --- #

# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-02-06/readme.md

# Load ----

pacman::p_load(
  gt,
  janitor,
  tidyverse
)

# Data ----

df <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-02-06/heritage.csv'
  ) |>
  clean_names()
## https://shorturl.at/jnDPZ :: dictionary (rich)
## https://shorturl.at/sxHYZ :: dictionary (raw)

# VISUALISE ----

# gt

df |>
  mutate(
    country = case_when(
      country == "Denmark" ~ "🇩🇰",
      country == "Norway" ~ "🇳🇴",
      country == "Sweden" ~ "🇸🇪"
    )
  ) |>                                                               # changes names for flag emojies
  slice(c(2, 1, 3:n())) |>                                           # switch rows for an alphabetical order
  pivot_longer(cols = starts_with("x"),
               names_to = "year",
               values_to = "value"
  ) |>                                                               # stretches the data
  pivot_wider(names_from = country, values_from = value
  ) |>                                                               # shrinks the data ## dunno why
  mutate(year = case_when(year == "x2004" ~ "2004",
                          year == "x2022" ~ "2022")
  ) |>                                                               # for cleaner values
  gt() |>                                                            # the beautiful {gt} table!
    tab_header(title = md("**number of world heritage sites**"),
               subtitle = md("**for Denmark, Norway and Sweden**")
    ) |>                                                             # header style with md()
    fmt_missing(columns = everything()
    ) |>                                                             # clueless…
    text_transform(
      locations = cells_body(columns = 1),
      fn = function(x) sprintf("<b>%s</b>", x)                       # renders variable values in bold 
  ) |> gtsave("tt2024_06.gt.png", expand = 10)        # saves table to png

# COMMUNICATE ----

# https://100.datavizproject.com/wp-content/uploads/dataset-home.png

# while looking to reproduce any of the 100 visualisations from the 100.datavizproject.com
# i noticed there are in fact 101… this was my third time properly using {gt}
# and i had a blast; the gg universe expands our visual lexicon for telling stories
# but gt pushes that expansion way further!

# . ----
