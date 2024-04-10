
# --- TIDYTUESDAY::2024§13 --- #

# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-03-26/readme.md

# Load ----

# packages
pacman::p_load(
  # easystats,
  gt,
  ggradar,                                                 # https://github.com/ricardo-bion/ggradar
  janitor,
  scales,
  skimr,
  tidylog,
  tidyverse
)

# data
tr <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-03-26/team-results.csv'
  ) |> 
  clean_names()
## https://shorturl.at/akOPR :: dictionary (rich)
## https://shorturl.at/bw357 :: dictionary (raw)

# Wrangle ----

# eda ----

# names
tr |> 
  slice(1:5) |> 
  glimpse()

# glimpse & skim
tr |>
  glimpse() |>
  skim()

# hands-on ----

tr |> 
  select(c(2, 7:9, 13:17)) |>                              # `games`, `w`, `l`, `s16m`, `e8`, `f4`, `f2`, `champ`
  mutate(across(where(is.double), as.integer)) |>
  arrange(desc(champ)) |> 
  filter(champ >= 2)
  # plot()

# Visualise ----

# stacked bar-plot ----

# total count for each team
tr <- tr |>
  mutate(count = w + l + s16 + e8 + f4 + f2 + champ) |>
  arrange(desc(count))

# stacked bars - v.0.0
ggplot(as.data.frame(tr), aes(x = reorder(team, -count), y = count)) +
  geom_bar(aes(y = r64, fill = "r64"), stat = "identity", position = "stack") +
  geom_bar(aes(y = r32, fill = "r32"), stat = "identity", position = "stack") +
  geom_bar(aes(y = s16, fill = "s16"), stat = "identity", position = "stack") +
  geom_bar(aes(y = e8, fill = "e8"), stat = "identity", position = "stack") +
  geom_bar(aes(y = f4, fill = "f4"), stat = "identity", position = "stack") +
  geom_bar(aes(y = f2, fill = "f2"), stat = "identity", position = "stack") +
  geom_bar(aes(y = champ, fill = "champ"), stat = "identity", position = "stack") +
  labs(title = "Stacked Bar Chart",
       y = "Count",
       x = "Team") +
  theme_minimal() +
  theme(legend.position = "top") +
  scale_fill_manual(name = "Category",
                    values = c("r64" = "#7c6f64",
                               "r32" = "#689d6a",
                               "s16" = "#b16286",
                               "e8" = "#458588",
                               "f4" = "#d79921",
                               "f2" = "#98971a",
                               "champ" = "#cc241d")) +
  guides(x = guide_axis(angle = 90),
         fill = guide_legend(title = "Category"))

# stacked bars - v.0.1
tr |>
  select(c(2, 7:9, 13:17)) |>
  mutate(across(where(is.double), as.integer)) |>
  pivot_longer(
    cols = c(w, l, s16, e8, f4, f2, champ),
    names_to = "round",
    values_to = "count"
  ) |>
  select(team, round, count) |>
  filter(round != "w" & round != "l" & count != 0) |>
  ggplot(aes(x = team, y = count, fill = round)) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  labs(x = "Team", y = "Count", fill = "Round") +
  theme(legend.position = "top",
        axis.text.x = element_text(angle = 90, hjust = 0))

tr |>  # Original data frame
  select(c(2, 7:9, 13:17)) |>  # Select specific columns
  mutate(across(where(is.double), as.integer)) |>  # Convert doubles to integers
  pivot_longer(
    cols = c(w, l, s16, e8, f4, f2, champ),
    names_to = "round",
    values_to = "count"
  ) |>  # Reshape data
  select(team, round, count) |>  # Select relevant columns
  filter(round != "w" & round != "l" & count != 0) |>  # Filter data
  group_by(team, round) |>  # Group by team and round to maintain round information
  summarise(stacked_count = sum(count)) |>  # Calculate stacked count per team and round
  arrange(team, desc(stacked_count)) |>  # Sort by team then descending stacked count
  ggplot(aes(x = team, y = stacked_count, fill = round)) +  # Define aesthetics
  geom_bar(stat = "identity") +  # Create stacked bar chart
  scale_fill_manual(values = c("red", "blue", "green", "orange", "purple", "brown", "grey")) +  # Define color palette
  theme_minimal() +  # Set theme
  labs(x = "Team", y = "Count", fill = "Round") +  # Set labels
  theme(legend.position = "top",
        # Set legend position
        axis.text.x = element_text(angle = 90, hjust = 0))  # Rotate x-axis labels

# gt ----

tr |> 
  select(c(2, 7:9, 13:17)) |>                              # `games`, `w`, `l`, `s16m`, `e8`, `f4`, `f2`, `champ`
  mutate(across(where(is.double), as.integer)) |>
  arrange(desc(champ)) |> 
  filter(champ >= 2) |> 
  gt()

# radar -----

tr |> 
  select(c(2, 7:9, 13:17)) |>                              # `games`, `w`, `l`, `s16m`, `e8`, `f4`, `f2`, `champ`
  mutate(across(where(is.double), as.integer)) |>
  arrange(desc(champ)) |> 
  filter(champ >= 2) |> 
  mutate_at(vars(-team), rescale) |> 
  ggradar(
    axis.label.size = 3,
    grid.label.size = 3,
    grid.line.width = .75,
    font.radar = ('Roboto Mono'),
    legend.text.size = 8
)
## https://rstudio-pubs-static.s3.amazonaws.com/5795_e6e6411731bb4f1b9cc7eb49499c2082.html

# ... 

# https://easystats.github.io/performance/
# https://r-graph-gallery.com/spider-or-radar-chart.html

# Analyse ----

# unassisted

# assisted

## question
## https://www.perplexity.ai/search/i-have-the-C6Ycn.noR8C.PI5bTuMQBg

## Performance :: model evaluation

lm(w ~ l + r64 + r32 + s16 + e8 + f4 + f2, data = tr) |>
  check_model()

## Trend Analysis

## ...

# Further ----

## gt
## https://github.com/natrivera/tidytuesday/tree/main/2024/2024-03-26
