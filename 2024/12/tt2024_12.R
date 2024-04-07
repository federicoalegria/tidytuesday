
# --- TIDYTUESDAY::2024§12 --- #

# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-03-19/readme.md

# Load ----

# packages
pacman::p_load(
  janitor,
  patchwork,
  scales,
  skimr,
  tidylog,
  tidyverse
  # ,
  # waffle
)

# data
mm <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-03-19/mutant_moneyball.csv'
  ) |>
  clean_names()
## https://shorturl.at/gqxW0 :: dictionary (rich)
## https://shorturl.at/gkzK4 :: dictionary (raw)

# Wrangle ----

# eda ----

# names
mm |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
mm |>
  glimpse() |>
  skim()

# members ~ value
mm |> 
  select(member, total_value_heritage) |> 
  arrange(desc(total_value_heritage)) |> 
  print(n = Inf)

# Visualise ----

# vanilla grouped bar-plots ----

## top gross
mm |> select(member, 8:12) |>
  rename(
    c(
      "total" = "total_value_heritage",
      "sixties" = "total_value60s_heritage",
      "seventies" = "total_value70s_heritage",
      "eighties" = "total_value80s_heritage",
      "nineties" = "total_value90s_heritage"
    )
  ) |>
  arrange(desc(total)) |>
  pivot_longer(cols = sixties:nineties,
               names_to = "decade",
               values_to = "value") |>
  mutate(total = as.integer(total),
         value = as.integer(value),
         decade = factor(decade)) |>
  slice(1:20) |>
  mutate(prop_total = (total / total)) |>
  mutate(proportion = round(value / total, 3)) |> 
  ggplot(aes(fill = decade, y = value, x = member)) + 
  geom_bar(position = 'dodge', stat = 'identity')

## bottom gross
mm |> select(member, 8:12) |>
  rename(
    c(
      "total" = "total_value_heritage",
      "sixties" = "total_value60s_heritage",
      "seventies" = "total_value70s_heritage",
      "eighties" = "total_value80s_heritage",
      "nineties" = "total_value90s_heritage"
    )
  ) |>
  arrange(desc(total)) |>
  pivot_longer(cols = sixties:nineties,
               names_to = "decade",
               values_to = "value") |>
  mutate(total = as.integer(total),
         value = as.integer(value),
         decade = factor(decade)) |>
  slice(84:104) |>
  mutate(prop_total = (total / total)) |>
  mutate(proportion = round(value / total, 3)) |> 
  ggplot(aes(fill = decade, y = value, x = member)) + 
  geom_bar(position = 'dodge', stat = 'identity')

# a patchwork of decades ----

## the most valuable mutants

### sixties
p1 <- 
  mm |>
  select(member, 8:12) |>
  rename(
    c(
      "total" = "total_value_heritage",
      "60s" = "total_value60s_heritage",
      "70s" = "total_value70s_heritage",
      "80s" = "total_value80s_heritage",
      "90s" = "total_value90s_heritage"
    )
  ) |>
  arrange(desc(total)) |>
  pivot_longer(cols = `60s`:`90s`,
               names_to = "decade",
               values_to = "value") |>
  mutate(
    total = as.integer(total),
    value = as.integer(value),
    decade = factor(decade),
    member = str_replace_all(member, "(?<=\\p{Ll})(?=\\p{Lu})", " ")                     # regex pattern for identifying and splitting according to basic needs
  ) |>
  filter(decade == "60s") |>
  slice(1:4) |>
  mutate(
    member = str_to_title(member),                                                       # capitalise the first letter of each word
    prop_total = (total / total),
    proportion = round(value / total, 3)
  ) |>
  ggplot(aes(fill = member, y = value, x = member)) +
  geom_bar(position = 'dodge', stat = 'identity', width = 0.65) +
  geom_text(aes(label = paste0("$", value)),                                             # labels with dollar sign
            vjust = -0.5, size = 3) +                                                    # text position and size
  scale_fill_manual(values = c("#076678", "#9d0006", "#d79921", "#3c3836")) +
  scale_y_continuous(labels = dollar_format()) +                                         # format y-axis as USD currency
  theme_minimal() +
  theme(
    legend.position = 'none',
    text = element_text(family = 'Roboto Mono'),                                         # font for all text
    plot.title = element_text(face = 'bold',
                              size = 21)
  ) +
  labs(title = "
    60's",
    x = "",
    y = ""
  ) +
  guides(x = guide_axis(angle = -90))

### seventies
p2 <- 
  mm |>
  select(member, 8:12) |>
  rename(
    c(
      "total" = "total_value_heritage",
      "60s" = "total_value60s_heritage",
      "70s" = "total_value70s_heritage",
      "80s" = "total_value80s_heritage",
      "90s" = "total_value90s_heritage"
    )
  ) |>
  arrange(desc(total)) |>
  pivot_longer(cols = `60s`:`90s`,
               names_to = "decade",
               values_to = "value") |>
  mutate(
    total = as.integer(total),
    value = as.integer(value),
    decade = factor(decade),
    member = str_replace_all(member, "(?<=\\p{Ll})(?=\\p{Lu})", " ")                     # regex pattern for identifying and splitting according to basic needs
  ) |>
  filter(decade == "70s") |>
  slice(1:4) |>
  mutate(
    member = str_to_title(member),                                                       # capitalise the first letter of each word
    prop_total = (total / total),
    proportion = round(value / total, 3)
  ) |>
  ggplot(aes(fill = member, y = value, x = member)) +
  geom_bar(position = 'dodge', stat = 'identity', width = 0.65) +
  geom_text(aes(label = paste0("$", value)),                                             # labels with dollar sign
            vjust = -0.5, size = 3) +                                                    # text position and size
  scale_fill_manual(values = c("#076678", "#9d0006", "#d79921", "#3c3836")) +
  scale_y_continuous(labels = dollar_format()) +                                         # format y-axis as USD currency
  theme_minimal() +
  theme(
    legend.position = 'none',
    text = element_text(family = 'Roboto Mono'),                                         # font for all text
    plot.title = element_text(face = 'bold',
                              size = 21)
  ) +
  labs(title = "
    70's",
    x = "",
    y = ""
  ) +
  guides(x = guide_axis(angle = -90))

### eighties
p3 <- 
  mm |>
  select(member, 8:12) |>
  rename(
    c(
      "total" = "total_value_heritage",
      "60s" = "total_value60s_heritage",
      "70s" = "total_value70s_heritage",
      "80s" = "total_value80s_heritage",
      "90s" = "total_value90s_heritage"
    )
  ) |>
  arrange(desc(total)) |>
  pivot_longer(cols = `60s`:`90s`,
               names_to = "decade",
               values_to = "value") |>
  mutate(
    total = as.integer(total),
    value = as.integer(value),
    decade = factor(decade),
    member = str_replace_all(member, "(?<=\\p{Ll})(?=\\p{Lu})", " ")                     # regex pattern for identifying and splitting according to basic needs
  ) |>
  filter(decade == "80s") |>
  slice(1:4) |>
  mutate(
    member = str_to_title(member),                                                       # capitalise the first letter of each word
    prop_total = (total / total),
    proportion = round(value / total, 3)
  ) |>
  ggplot(aes(fill = member, y = value, x = member)) +
  geom_bar(position = 'dodge', stat = 'identity', width = 0.65) +
  geom_text(aes(label = paste0("$", value)),                                             # labels with dollar sign
            vjust = -0.5, size = 3) +                                                    # text position and size
  scale_fill_manual(values = c("#076678", "#9d0006", "#d79921", "#3c3836")) +
  scale_y_continuous(labels = dollar_format()) +                                         # format y-axis as USD currency
  theme_minimal() +
  theme(
    legend.position = 'none',
    text = element_text(family = 'Roboto Mono'),                                         # font for all text
    plot.title = element_text(face = 'bold',
                              size = 21)
  ) +
  labs(title = "
    80's",
    x = "",
    y = ""
  ) +
  guides(x = guide_axis(angle = -90))

### nineties
p4 <-
  mm |>
  select(member, 8:12) |>
  rename(
    c(
      "total" = "total_value_heritage",
      "60s" = "total_value60s_heritage",
      "70s" = "total_value70s_heritage",
      "80s" = "total_value80s_heritage",
      "90s" = "total_value90s_heritage"
    )
  ) |>
  arrange(desc(total)) |>
  pivot_longer(cols = `60s`:`90s`,
               names_to = "decade",
               values_to = "value") |>
  mutate(
    total = as.integer(total),
    value = as.integer(value),
    decade = factor(decade),
    member = str_replace_all(member, "(?<=\\p{Ll})(?=\\p{Lu})", " ")                     # regex pattern for identifying and splitting according to basic needs
  ) |>
  filter(decade == "90s") |>
  slice(1:4) |>
  mutate(
    member = str_to_title(member),                                                       # capitalise the first letter of each word
    prop_total = (total / total),
    proportion = round(value / total, 3)
  ) |>
  ggplot(aes(fill = member, y = value, x = member)) +
  geom_bar(position = 'dodge', stat = 'identity', width = 0.65) +
  geom_text(aes(label = paste0("$", value)),                                             # labels with dollar sign
            vjust = -0.5, size = 3) +                                                    # text position and size
  scale_fill_manual(values = c("#076678", "#9d0006", "#d79921", "#3c3836")) +
  scale_y_continuous(labels = dollar_format()) +                                         # format y-axis as USD currency
  theme_minimal() +
  theme(
    legend.position = 'none',
    text = element_text(family = 'Roboto Mono'),                                         # font for all text
    plot.title = element_text(face = 'bold',
                              size = 21)
  ) +
  labs(title = "
    90's",
    x = "",
    y = ""
  ) +
  guides(x = guide_axis(angle = -90))

# patchwork

(p1 + p2 + p3 + p4) +
  plot_layout(ncol = 4) +
  plot_annotation(
    title = "the most valuable mutants",
    subtitle = "and their decrease across the decades",
    caption = "tidytuesday 2024§12〔https://shorturl.at/gqxW0〕",
    theme = theme(plot.title = element_text(family = 'Roboto Mono', size = 16, face = 'bold'),
                  plot.subtitle = element_text(family = 'Roboto Mono', size = 12),
                  plot.caption = element_text(family = 'Consolas')))

## the least valuable mutants 🚧

### ...

# waffle - untested due computational limitations

# mm |>
#   select(member, 8:12) |>
#   rename(
#     c(
#       "total" = "total_value_heritage",
#       "sixties" = "total_value60s_heritage",
#       "seventies" = "total_value70s_heritage",
#       "eighties" = "total_value80s_heritage",
#       "nineties" = "total_value90s_heritage"
#     )
#   ) |>
#   arrange(desc(total)) |>
#   pivot_longer(cols = sixties:nineties,
#                names_to = "decade",
#                values_to = "value") |>
#   mutate(total = as.integer(total),
#          value = as.integer(value),
#          decade = factor(decade)) |> 
#   group_by(decade) |> 
#   mutate(total_value = sum(value)) |> 
#   ggplot() +
#   geom_waffle(
#     aes(fill = decade, values = total_value),
#     color = "white",
#     size = 0.25
#   ) +
#   facet_wrap(~decade, scales = "free_y") +
#   theme_minimal() +
#   theme(legend.position = "bottom")

# Communicate ----

# ...
