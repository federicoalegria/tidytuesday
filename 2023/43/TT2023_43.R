
# --- TIDYTUESDAY::2023_43 --- #

# Libraries ----

pacman::p_load(
  easystats,
  janitor,
  skimr,
  tidylog,
  tidyquant,
  tidyverse
)

# DATA ----

prf <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-10-24/patient_risk_profiles.csv'
  ) |> 
  clean_names()

# CLEAN ----

# Transform
prf <- 
  prf |>
  mutate(
    age_group = case_when(
      age_group_0_4 == 1 ~ "0-4",
      age_group_5_9 == 1 ~ "5-9",
      age_group_10_14 == 1 ~ "10-14",
      age_group_15_19 == 1 ~ "15-19",
      age_group_20_24 == 1 ~ "20-24",
      age_group_25_29 == 1 ~ "25-29",
      age_group_30_34 == 1 ~ "30-34",
      age_group_35_39 == 1 ~ "35-39",
      age_group_40_44 == 1 ~ "40-44",
      age_group_45_49 == 1 ~ "45-49",
      age_group_50_54 == 1 ~ "50-54",
      age_group_55_59 == 1 ~ "55-59",
      age_group_60_64 == 1 ~ "60-64",
      age_group_65_69 == 1 ~ "65-69",
      age_group_70_74 == 1 ~ "70-74",
      age_group_75_79 == 1 ~ "75-79",
      age_group_80_84 == 1 ~ "80-84",
      age_group_85_89 == 1 ~ "85-89",
      age_group_90_94 == 1 ~ "90-94",
      TRUE ~ NA_character_
    ),
    sex = case_when(
      sex_female == 1 ~ "female",
      sex_male == 1 ~ "male",
      TRUE ~ NA_character_
    )
  ) |>
  select(-starts_with("age_group_"),-starts_with("sex_"),-person_id) |>
  relocate(age_group, sex) |>
  mutate(age_group = as.factor(age_group)) |> 
  rename_all(~ gsub("antibiotics_|_in_prior_year", "", .)) |>
  rename_at(vars(starts_with("predicted_risk_of")),
            ~ gsub("predicted_risk_of_", "", .)) |> 
  rename(
    sudden_hearing_loss = sudden_hearing_loss_no_congenital_anomaly_or_middle_or_inner_ear_conditions,
    sudden_vision_loss = sudden_vision_loss_with_no_eye_pathology_causes,
    acute_pancreatitis = acute_pancreatitis_with_no_chronic_or_hereditary_or_common_causes_of_pancreatitis,
    treatment_resistant_depression = treatment_resistant_depression_trd,
    parkinsons_disease = parkinsons_disease_inpatient_or_with_2nd_diagnosis
  )

# EXPLORE ----

# glimpse & skim
prf |> 
  glimpse() |> 
  skim()

# names
prf |> 
  slice(0) |> 
  glimpse()

# VISUALISE ----

# `$age` ~ `predicted risks`

prf |>
  group_by(age_group) |>
  summarise(mean = mean(pulmonary_embolism)) |>
  arrange(desc(mean)) |>
  ggplot(aes(
    x = reorder(age_group, as.numeric(gsub("-", "", age_group))),
    y = mean,
    group = 1
  )) +
  geom_area(fill = "#7f1832",
            alpha = 0.4) +
  geom_hline(
    yintercept = mean(prf$pulmonary_embolism),
    color = "#2e5d4b",
    linetype = "dashed"
  ) +
  annotate(
    "text",
    x = 5,
    y = mean(prf$pulmonary_embolism) + 0.0005,
    label = paste0(round(mean(prf$pulmonary_embolism), 5)),
    color = "#2e5d4b"
  ) +
  labs(
    title = "Predicted risk of Pulmonary Embolism",
    subtitle = "for various age groups",
    caption = "{simulated data from tidytuesday 2023∙43}
    https://github.com/rfordatascience/tidytuesday/blob/master/data/2023/2023-10-24/readme.md",
    x = "age groups",
    y = 'predicted risk'
  ) +
  theme_tq(base_family = "Monospace")

# ANALYSE ----

# COMMUNICATE ----

# ... ----

# assets ----