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
  filter(!is.na(age_diff))

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
  arrange(year)

# Communicate ----
# ...
