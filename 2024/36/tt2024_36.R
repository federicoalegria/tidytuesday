# --- TIDYTUESDAY::2024§36 --- #
# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-09-03/readme.md

# library path
.libPaths(c("~/.R/x86_64-pc-linux-gnu-library/4.4", .libPaths()))

# packages
pacman::p_load(
  data.table,           # https://cran.r-project.org/web/packages/data.table/
  ggstatsplot,          # https://cran.r-project.org/web/packages/ggstatsplot/
  janitor,              # https://cran.r-project.org/web/packages/janitor/
  skimr,                # https://cran.r-project.org/web/packages/skimr/
  styler,               # https://cran.r-project.org/web/packages/styler/
  tidyverse             # https://cran.r-project.org/web/packages/tidyverse/
)

# Import ----
df_qlsrc <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-09-03/qname_levels_single_response_crosswalk.csv'
  ) |> clean_names()

df_ssq <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-09-03/stackoverflow_survey_questions.csv'
  ) |> clean_names()

df_sssr <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-09-03/stackoverflow_survey_single_response.csv'
  ) |> clean_names()

# dictionary
# https://t.ly/kaRZn

# Understand ----

# names
df_qlsrc |> 
  slice(0) |> 
  glimpse()

df_ssq |> 
  slice(0) |> 
  glimpse()

df_sssr |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
df_qlsrc |>
  glimpse() |>
  skim()

df_ssq |>
  glimpse() |>
  skim()

df_sssr |>
  glimpse() |>
  skim()

df_qlsrc |> 
  filter(qname == "dev_type")

df_sssr |> 
  filter(dev_type == 1, !is.na(country)) |> 
  group_by(country) |> 
  summarise(n = n(), .groups = 'drop') |> 
  arrange(desc(n)) |> 
  print(n = Inf)

df_sssr |> 
  filter(country %in% c(
    "Germany",
    "United States of America"
    )
  ) |> 
  filter(dev_type == 1, !is.na(comp_total)) |> 
  group_by(country) |> 
  summarise(
    mean = mean(comp_total),
    median = median(comp_total),
    iqr = IQR(comp_total),
    min = min(comp_total),
    max = max(comp_total),
    total = sum(comp_total)
  )

# Analyse ----

# check for normality

## analitically
df_sssr |>
  filter(country %in% c("Germany",
                        "United States of America")) |>
  pull(comp_total) |>
  ks.test("pnorm")

# nonparametric way
df_sssr |>
  filter(country %in% c("Germany",
                        "United States of America")) |>
  filter(dev_type == 1,!is.na(comp_total)) |>
  ggbetweenstats(x = country,
                 xlab = " ",
                 y = comp_total,
                 ylab = "compensation",
                 type = 'nonparametric')

# Communicate ----

# for tt2024_36, i explored total compensation for academic researchers between Germany & USA
