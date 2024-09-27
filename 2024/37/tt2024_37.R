# --- TIDYTUESDAY::YYYY§WW --- #
# https://github.com/rfordatascience/tidytuesday/tree/master/data/2024/...

# lib
.libPaths(c("~/.R/x86_64-pc-linux-gnu-library/4.4", .libPaths()))

# packages
pacman::p_load(
  data.table,           # https://cran.r-project.org/web/packages/data.table/
  ggthemes,             # https://cran.r-project.org/web/packages/ggthemes/
  janitor,              # https://cran.r-project.org/web/packages/janitor/
  skimr,                # https://cran.r-project.org/web/packages/skimr/
  styler,               # https://cran.r-project.org/web/packages/styler/
  tidyverse             # https://cran.r-project.org/web/packages/tidyverse/
)

# Import ----

df <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-09-10/college_admissions.csv'
  ) |>
  clean_names()
# dictionary
# https://t.ly/uoh5P

# Understand ----

# names
df |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
df |>
  glimpse() |>
  skim()

# visualise ----

df |> 
  select(par_income_lab, tier, rel_att_cond_app) |> 
  drop_na() |> 
  mutate(
    tier = case_when(
      tier %in% c("Ivy Plus", "Other elite schools (public and private)") ~ 
        "Ivy League & Elite",
      tier %in% c("Highly selective public", "Highly selective private") ~ 
        "Highly Selective",
      tier %in% c("Selective public", "Selective private") ~ 
        "Selective"
    ),
    tier = factor(tier, levels = c(
      "Ivy League & Elite",
      "Highly Selective",
      "Selective"
    ))
  ) |> 
  mutate(
    par_income_lab = factor(par_income_lab),
    par_income_lab = fct_relevel(par_income_lab, "Top 0.1", after = Inf)
  ) |> 
  group_by(par_income_lab) |> 
  ggplot(aes(x = par_income_lab, y = rel_att_cond_app), fill = tier) +
  geom_jitter(aes(col = tier)) +
  labs(
    title = "Economic Diversity and Student Outcomes",
    subtitle = "Parent household income by Attendance Rate",
    caption = "data pulled from https://t.ly/uoh5P by https://github.com/federicoalegria"
  ) +
  theme_wsj() +
  theme(
    plot.title = element_text(size = 23),
    plot.subtitle = element_text(size = 18),
    plot.caption = element_text(size = 10),
    legend.title = element_blank(),
    legend.text = element_text(size = 15, family = 'mono')
)

# Communicate ----

# for #tidytuesday 2437, i followed the early wrangling from @nrennie35's [vis](https://x.com/nrennie35/status/1835599148323590383) to achieve mine
