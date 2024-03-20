
# --- TIDYTUESDAY::2024§10 --- #

# https://github.com/rfordatascience/tidytuesday/tree/master/data/2024/...

# Load ----

# packages
pacman::p_load(
  janitor,
  pointblank,
  skimr,
  tidylog,
  tidyverse
)

# data
tw <- 
  readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-03-05/trashwheel.csv'
  ) |> 
  clean_names()
## https://shorturl.at/abhtw :: dictionary (rich)
## https://shorturl.at/aCE48 :: dictionary (raw)

# Wrangle ----

# eda ----

# names
tw |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
tw |>
  glimpse() |>
  skim()

# summary statistics ----

# weight
w00 <- 
  tw |> 
  select(weight) |> 
  drop_na() |> 
  summarise(mean = mean(weight),
            median = median(weight),
            sd = sd(weight),
            iqr = IQR(weight),
            min = min(weight),
            max = max(weight),
            p25 = quantile(weight, 0.25),
            p75 = quantile(weight, 0.75)
) |> knitr::kable()

# volume
v00 <- 
  tw |> 
  select(volume) |> 
  drop_na() |> 
  summarise(mean = mean(volume),
            median = median(volume),
            sd = sd(volume),
            iqr = IQR(volume),
            min = min(volume),
            max = max(volume),
            p25 = quantile(volume, 0.25),
            p75 = quantile(volume, 0.75)
) |> knitr::kable()

# plastic_bottles
p00 <- 
  tw |> 
  select(plastic_bottles) |> 
  drop_na() |> 
  summarise(mean = mean(plastic_bottles),
            median = median(plastic_bottles),
            sd = sd(plastic_bottles),
            iqr = IQR(plastic_bottles),
            min = min(plastic_bottles),
            max = max(plastic_bottles),
            p25 = quantile(plastic_bottles, 0.25),
            p75 = quantile(plastic_bottles, 0.75)
) |> knitr::kable()

# polystyrene
p01 <-
  tw |> 
  select(polystyrene) |> 
  drop_na() |> 
  summarise(mean = mean(polystyrene),
            median = median(polystyrene),
            sd = sd(polystyrene),
            iqr = IQR(polystyrene),
            min = min(polystyrene),
            max = max(polystyrene),
            p25 = quantile(polystyrene, 0.25),
            p75 = quantile(polystyrene, 0.75)
) |> knitr::kable()

# cigarette_butts
c00 <-
  tw |> 
  select(cigarette_butts) |> 
  drop_na() |> 
  summarise(mean = mean(cigarette_butts),
            median = median(cigarette_butts),
            sd = sd(cigarette_butts),
            iqr = IQR(cigarette_butts),
            min = min(cigarette_butts),
            max = max(cigarette_butts),
            p25 = quantile(cigarette_butts, 0.25),
            p75 = quantile(cigarette_butts, 0.75)
) |> knitr::kable()

# glass_bottles
g00 <- 
  tw |> 
  select(glass_bottles) |> 
  drop_na() |> 
  summarise(mean = mean(glass_bottles),
            median = median(glass_bottles),
            sd = sd(glass_bottles),
            iqr = IQR(glass_bottles),
            min = min(glass_bottles),
            max = max(glass_bottles),
            p25 = quantile(glass_bottles, 0.25),
            p75 = quantile(glass_bottles, 0.75)
) |> knitr::kable()

# plastic_bags
p02 <- 
  tw |> 
  select(plastic_bags) |> 
  drop_na() |> 
  summarise(mean = mean(plastic_bags),
            median = median(plastic_bags),
            sd = sd(plastic_bags),
            iqr = IQR(plastic_bags),
            min = min(plastic_bags),
            max = max(plastic_bags),
            p25 = quantile(plastic_bags, 0.25),
            p75 = quantile(plastic_bags, 0.75)
) |> knitr::kable()

# wrappers
w01 <- 
  tw |> 
  select(wrappers) |> 
  drop_na() |> 
  summarise(mean = mean(wrappers),
            median = median(wrappers),
            sd = sd(wrappers),
            iqr = IQR(wrappers),
            min = min(wrappers),
            max = max(wrappers),
            p25 = quantile(wrappers, 0.25),
            p75 = quantile(wrappers, 0.75)
) |> knitr::kable()

# sports_balls
s00 <-
  tw |> 
  select(sports_balls) |> 
  drop_na() |> 
  summarise(mean = mean(sports_balls),
            median = median(sports_balls),
            sd = sd(sports_balls),
            iqr = IQR(sports_balls),
            min = min(sports_balls),
            max = max(sports_balls),
            p25 = quantile(sports_balls, 0.25),
            p75 = quantile(sports_balls, 0.75)
) |> knitr::kable()

# brief summary table for metric recollection data

# Open a text file for writing
sink("summary_statistics.md")

  # Print the content of each object
  print("## `weight`")
  print(w00)
  
  print("## `volume`")
  print(v00)
  
  print("## `plastic_bottles`")
  print(p00)
  
  print("## `polystyrene`")
  print(p01)
  
  print("## `cigarette_butts`")
  print(c00)
  
  print("## `glass_bottles`")
  print(g00)
  
  print("## `plastic_bags`")
  print(p02)
  
  print("## `wrappers`")
  print(w01)
  
  print("## `sports_balls`")
  print(s00)

# Close the text file
sink()

# ...
