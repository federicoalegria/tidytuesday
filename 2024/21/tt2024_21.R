# --- TIDYTUESDAY::2024§21 --- #

# https://github.com/rfordatascience/tidytuesday/tree/master/data/2024/...

# Load ----

# packages ----
pacman::p_load(
  data.table,
  janitor,
  skimr,
  tidyverse
)

# data ----
df <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-05-21/emissions.csv'
  ) |>
  clean_names()
# dictionary
# https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-05-21/readme.md

# Wrangle ----

# eda ----

# names
df |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
df |>
  glimpse() |>
  skim()

# summarise

df |> 
  group_by(parent_entity) |> 
  summarise(n = n()) |> 
  arrange(desc(n))

df |> 
  group_by(parent_type) |> 
  summarise(n = n()) |> 
  arrange(desc(n))

df |> 
  group_by(commodity) |> 
  summarise(n = n()) |> 
  arrange(desc(n))

df |> 
  group_by(production_unit) |> 
  summarise(n = n()) |> 
  arrange(desc(n))

# Visualise ----

# raw

df |> 
  ggplot(aes(x = commodity,
             y = total_emissions_mt_co2e)) +
  geom_boxplot() +
  facet_wrap(production_unit ~ .)

# rice

# Analyse ----

# unassisted

# assisted

### https://chat.openai.com/share/
### https://gemini.google.com/app/
### https://www.perplexity.ai/share/

# Communicate ----

# ...
