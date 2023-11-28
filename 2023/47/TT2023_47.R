
# --- TIDYTUESDAY::2023_47 --- #

# Packages ----

pacman::p_load(
  ggthemes,
  geomtextpath,
  janitor,
  RColorBrewer,
  skimr,
  tidyverse
)

# DATA ----

rl <- readr::read_csv(
  'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-11-21/rladies_chapters.csv'
) |>
  clean_names() |>
  mutate(chapter = str_remove(chapter, "^rladies-"))

# glimpse & skim
rl |>
  glimpse() |> 
  skim()

# names
rl |>
  slice(0) |> 
  glimpse()

# CLEAN ----

# EXPLORE ----

rl |> 
  select(location, year) |> 
  table()

# VISUALISE ----

rl00_cols <- colorRampPalette(c("#D1AFE8","#B998DD","#9F82CE","#826DBA","#63589F"))(5)

rl00_all_cols <- rep(rl00_cols, length.out = 36)

# polar plot $ `inperson`
rl00 <- rl |> 
  filter(location == "inperson")

rl00 |>
  group_by(chapter) |>
  summarise(n = n()) |>
  arrange(desc(n)) |>
  filter(n > 21) |>
  ggplot(aes(x = chapter, y = n, fill = chapter)) +
  geom_bar(position = "stack", stat = "identity") +
  coord_polar() +
  geom_textpath(aes(
    label = chapter,
    x = chapter,
    y = n,
    angle = -90
  ),
  vjust = -1,
  size = 3) +
  scale_fill_manual(values = rl00_all_cols) +
  theme_wsj() +
  theme(axis.text.x = element_blank(),
        legend.position = "none")

# polar plot $ `online`
rl01 <- rl |> 
  filter(location == "online")

rl01_cols <- colorRampPalette(c("#89C0B6","#63A6A0","#448C8A","#287274","#0D585F"))(5)

rl01_all_cols <- rep(rl01_cols, length.out = 20)

rl01 |>
  group_by(chapter) |>
  summarise(n = n()) |>
  arrange(desc(n)) |>
  filter(n > 21) |>
  ggplot(aes(x = chapter, y = n, fill = chapter)) +
  geom_bar(position = "stack", stat = "identity") +
  coord_polar() +
  geom_textpath(aes(
    label = chapter,
    x = chapter,
    y = n,
    angle = -90
  ),
  vjust = -1,
  size = 3) +
  scale_fill_manual(values = rl01_all_cols) +
  theme_wsj() +
  theme(axis.text.x = element_blank(),
        legend.position = "none")

# ANALYSE ----

# COMMUNICATE ----

# ... ----


