library(tidyverse)
library(readr)
library(here)
library(janitor)
library(tibble)

# Reading the data
decathlon_raw <- read_rds(here("raw_data/decathlon.rds"))

# Checking the dimentions / column names , etc for further analysis
dim(decathlon_raw)
names(decathlon_raw)
View(decathlon_raw)

# Converting Row names into a column
decathlon <- decathlon_raw %>%
  rownames_to_column("player_name")

# Tidying the column names
decathlon_clean <- clean_names(decathlon)

# Converting player_names to all lowercase
decathlon_lowcase <- decathlon_clean %>%
  mutate(player_name = str_to_lower(player_name))

# Dropping rows which are not required to answer the task assigned
decathlon_final <- decathlon_lowcase %>%
  select(-rank)

# writing cdv file for analysis
write_csv(decathlon_final, "clean_data/decathlon_clean.csv")
