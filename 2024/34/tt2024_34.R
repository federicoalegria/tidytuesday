# --- TIDYTUESDAY::2024§34 --- #
# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-08-20/readme.md

# library path
.libPaths(c("~/.R/x86_64-pc-linux-gnu-library/4.4", .libPaths()))

# packages
pacman::p_load(
  data.table,           # https://cran.r-project.org/web/packages/data.table/
  janitor,              # https://cran.r-project.org/web/packages/janitor/
  skimr,                # https://cran.r-project.org/web/packages/skimr/
  styler,               # https://cran.r-project.org/web/packages/styler/
  tidyverse             # https://cran.r-project.org/web/packages/tidyverse/
)

# Import ----
df <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-08-20/english_monarchs_marriages_df.csv'
  ) |>
  clean_names() |> 
  mutate(year = as.numeric(year_of_marriage)
  ) |> 
  select(-year_of_marriage)

# dictionary
# https://t.ly/sJYmT

# Understand ----

# names
df |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
df |>
  glimpse() |>
  skim()

# transform ---

df |> 
  mutate(king_age = case_when(
    is.na(king_age) | king_age %in% c("?", "–", "") ~ NA,
    king_age == "50(?)" ~ "50",
    TRUE ~ king_age
  )) |> 
  mutate(king_age = as.numeric(king_age)) |> 
  mutate(consort_age = case_when(
    is.na(consort_age) | consort_age %in% c("?", "–") ~ NA,
    TRUE ~ consort_age
  )) |> 
  mutate(consort_age = as.numeric(consort_age)) |> 
  select(king_age, consort_age) |> 
  mutate(age_diff = (king_age - consort_age)) |> 
  filter(!is.na(age_diff)) |> 
  arrange(desc(age_diff))

# historical periods

df |> 
  filter(!is.na(year)) |> 
  summarise(min = min(year), max = max(year))

df |> 
  mutate(
    period = case_when(
      year >= 856 & year <= 999 ~ "early middle age",
      year >= 1000 & year <= 1299 ~ "high middle age",
      year >= 1300 & year <= 1499 ~ "late middle age",
      year >= 1500 & year <= 1699 ~ "renaissance",
      year >= 1700 & year <= 1799 ~ "early modern period",
      year >= 1800 & year <= 1947 ~ "industrial era",
      TRUE ~ "NA"
    )
)

df |> 
  mutate(king_age = case_when(
    is.na(king_age) | king_age %in% c("?", "–", "") ~ NA,
    king_age == "50(?)" ~ "50",
    TRUE ~ king_age
  )) |> 
  mutate(king_age = as.numeric(king_age)) |> 
  mutate(consort_age = case_when(
    is.na(consort_age) | consort_age %in% c("?", "–") ~ NA,
    TRUE ~ consort_age
  )) |> 
  mutate(consort_age = as.numeric(consort_age)) |> 
  mutate(
    period = case_when(
      year >= 856 & year <= 999 ~ "early middle age",
      year >= 1000 & year <= 1299 ~ "high middle age",
      year >= 1300 & year <= 1499 ~ "late middle age",
      year >= 1500 & year <= 1699 ~ "renaissance",
      year >= 1700 & year <= 1799 ~ "early modern period",
      year >= 1800 & year <= 1947 ~ "industrial era",
      TRUE ~ "NA"
  )) |> 
  filter(!is.na(year)) |> 
  mutate(age_diff = (king_age - consort_age)) |> 
  filter(!is.na(age_diff)) |> 
  arrange(desc(age_diff))

# visualise ----

# tables

df |> 
  mutate(king_age = case_when(
    is.na(king_age) | king_age %in% c("?", "–", "") ~ NA,
    king_age == "50(?)" ~ "50",
    TRUE ~ king_age
  )) |> 
  mutate(king_age = as.numeric(king_age)) |> 
  mutate(consort_age = case_when(
    is.na(consort_age) | consort_age %in% c("?", "–") ~ NA,
    TRUE ~ consort_age
  )) |> 
  mutate(consort_age = as.numeric(consort_age)) |> 
  select(king_name, king_age, consort_name, consort_age) |> 
  mutate(age_diff = (king_age - consort_age)) |> 
  filter(!is.na(age_diff)) |> 
  arrange(desc(age_diff)) |> 
  knitr::kable()

df |> 
  mutate(king_age = case_when(
    is.na(king_age) | king_age %in% c("?", "–", "") ~ NA,
    king_age == "50(?)" ~ "50",
    TRUE ~ king_age
  )) |> 
  mutate(king_age = as.numeric(king_age)) |> 
  mutate(consort_age = case_when(
    is.na(consort_age) | consort_age %in% c("?", "–") ~ NA,
    TRUE ~ consort_age
  )) |> 
  mutate(consort_age = as.numeric(consort_age)) |> 
  select(year, king_age, consort_age) |> 
  mutate(age_diff = (king_age - consort_age)) |> 
  filter(!is.na(age_diff)) |> 
  arrange(year) |> 
  knitr::kable()

# Cleveland plot

df |> 
  mutate(
    king_age = as.numeric(replace(king_age, king_age %in% c("?", "–", "", "50(?)"), NA)),
    consort_age = as.numeric(replace(consort_age, consort_age %in% c("?", "–", ""), NA)),
    king = glue::glue("{king_name}, {king_age}"),
    consort = glue::glue("{consort_name}, {consort_age}"),
    period = case_when(
      year >= 856 & year <= 999 ~ "early middle age",
      year >= 1000 & year <= 1299 ~ "high middle age",
      year >= 1300 & year <= 1499 ~ "late middle age",
      year >= 1500 & year <= 1699 ~ "renaissance",
      year >= 1700 & year <= 1799 ~ "early modern period",
      year >= 1800 & year <= 1947 ~ "industrial era",
      TRUE ~ NA_character_
    ),
    age_diff = king_age - consort_age
  ) |> 
  filter(!is.na(year) & !is.na(age_diff)) |> 
  arrange(desc(age_diff)) |> 
  ggplot(aes(y = reorder(age_diff, age_diff))) +
    geom_segment(aes(
      x = age_diff,
      xend = age_diff,
      y = king_age,
      yend = consort_age
    ), color = "#3c3836") +
    geom_point(
      aes(x = age_diff, y = king_age),
      color = '#3c3836',
      alpha = 0.9,
      size = 3.5
    ) +
    geom_point(
      aes(x = age_diff, y = consort_age),
      color = '#a286fd',
      alpha = 0.9,
      size = 3.5
    ) +
    coord_flip() +
    theme_minimal() +
    theme(
      legend.position = 'none',
      text = element_text(family = 'Roboto Mono'),
      plot.title = element_text(family = 'Roboto Mono', face = 'bold', size = 23),
      plot.subtitle = element_text(family = 'Roboto Mono', size = 18),
      plot.caption = element_text(family = 'Roboto Mono', size = 11),
      strip.text = element_text(family = 'Roboto Mono', face = 'bold', size = 13)
    ) +
    xlab("age difference in total") +
    ylab("age difference in between") +
    labs(
      title = "English Monarchs and Marriages", 
      subtitle = "Age differences for kings and consorts by time period
      ", 
      caption = "
      Data pulled from https://t.ly/sJYmT by https://github.com/federicoalegria"
    ) +
    facet_wrap(~ period)
