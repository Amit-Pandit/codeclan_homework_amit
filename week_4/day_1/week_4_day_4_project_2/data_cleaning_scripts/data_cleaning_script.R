# Reading the Clean Data

# Load in Libraries
library(tidyverse)
library(here)
library(readxl)
library(janitor)

# load in data
candy_2015 <- read_excel(here("raw_data/boing-boing-candy-2015.xlsx"))
candy_2016 <- read_excel(here("raw_data/boing-boing-candy-2016.xlsx"))
candy_2017 <- read_excel(here("raw_data/boing-boing-candy-2017.xlsx"))

#chacking the structure of the data
candy_2015
dim(candy_2015)
names(candy_2015)
View(candy_2015)

dim(candy_2016)
names(candy_2016)
View(candy_2016)

dim(candy_2017)
names(candy_2017)
View(candy_2017)


# Primary-Cleaning candy_2015

# Cleaning names of Variables
candy_2015_clean_names <- clean_names(candy_2015)

# Adding Person_ID
candy_2015_id <- candy_2015_clean_names %>%
  mutate(person_id = row_number())

# Pivoting data and creating two new columns candy and emotion and storing in the data set pivoted
candy_2015_pivoted <- candy_2015_id %>%
  pivot_longer(butterfinger:york_peppermint_patties, names_to = "candy_name", values_to = "emotion")


# dropping variables which are not required and selecting only 5 variables required for analysis
candy_2015_clean <- candy_2015_pivoted %>%
   select(person_id, how_old_are_you, are_you_going_actually_going_trick_or_treating_yourself, candy_name, emotion)


# re-naming the Variables with appropriate names
names(candy_2015_clean) <- c("person_id", "age", "trick_or_treat_yourself", "candy_name", "emotion")

View(candy_2015_clean)

# Primary-Cleaning candy_2016
# Step 1 : checing dimentions / variable names
dim(candy_2016)
names(candy_2016)
View(candy_2016)

# Cleaning Variable names
candy_2016_clean_names <- clean_names(candy_2016)

# Adding Person_ID
candy_2016_id <- candy_2016_clean_names %>%
  mutate(person_id = row_number())

# Pivoting data and creating two new columns candy and emotion and storing in the data set pivoted
candy_2016_pivoted <- candy_2016_id %>%
  pivot_longer( x100_grand_bar :york_peppermint_patties, names_to = "candy_name", values_to = "emotion")

# Reference : distinct(candy_2016_pivoted , york_peppermint_patties_ignore)

# dropping variables which are not required and selecting only variables required for analysis
candy_2016_clean <- candy_2016_pivoted %>%
  select(person_id, how_old_are_you, are_you_going_actually_going_trick_or_treating_yourself, candy_name, emotion,your_gender, which_country_do_you_live_in)

# re-naming the Variables with appropriate names
names(candy_2016_clean) <- c("person_id", "age", "trick_or_treat_yourself", "candy_name", "emotion", "gender", "country")

# Primary-Cleaning candy_2017
# Step 1 : checing dimentions / variable names
dim(candy_2017)
names(candy_2017)
View(candy_2017)

# Removing the Question tag added before all the variable names

