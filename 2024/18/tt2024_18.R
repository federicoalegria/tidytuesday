# --- TIDYTUESDAY::2024§18 --- #

# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-04-30/readme.md

# Load ----

# packages ----
pacman::p_load(
  data.table,
  gt,
  janitor,
  skimr,
  tidyverse
)

# data ----
df0 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-04-30/wwbi_data.csv'
  ) |>
  clean_names()

df1 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-04-30/wwbi_series.csv'
  ) |>
  clean_names()

df2 <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-04-30/wwbi_country.csv'
  ) |>
  clean_names()

## https://t.ly/_F0Ci :: dictionary (rich)
## https://t.ly/uhFdG :: dictionary (raw)

# Wrangle ----

# eda ----

# names
df2 |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
df2 |>
  glimpse() |>
  skim()

# Visualise ----

df2 |>
  select(country = short_name,
         year = latest_population_census_year,
  ) |>
  mutate(
    country = case_when(
      country == "Lebanon" ~ "🇱🇧 Lebanon",
      country == "Afghanistan" ~ "🇦🇫 Afghanistan",
      country == "Somalia" ~ "🇸🇴 Somalia",
      country == "Uzbekistan" ~ "🇺🇿 Uzbekistan",
      country == "Iraq" ~ "🇮🇶 Iraq",
      country == "Central African Republic" ~ "🇨🇫 Central African Republic",
      country == "Haiti" ~ "🇭🇹 Haiti",
      country == "Syrian Arab Republic" ~ "🇸🇾 Syrian Arab Republic",
      country == "Yemen" ~ "🇾🇪 Yemen",
      country == "Libya" ~ "🇱🇾 Libya"
    )
  ) |> 
  arrange(year) |>
  slice(1:10) |>
  gt() |> 
  tab_header(title = md("**top ten countries**"),
             subtitle = md("**with oldest census data**")
  ) |> 
  cols_label(
    country = md("**country**"),
    year = md("**year**")
  ) |> 
  tab_source_note(source_note = "source ::〔https://t.ly/uhFdG〕") |> 
  gtsave("tt2024_18.gt.png", expand = 10)
