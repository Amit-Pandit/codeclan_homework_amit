# Reading the Clean Data

# Load in Libraries
library(tidyverse)
library(here)
library(readxl)

# load in data
candy_2015 <- read_excel(here("raw_data/boing-boing-candy-2015.xlsx"),is.na())
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

# Adding and Fixing Variable names
# clean column names
library(janitor)
candy_2015 <- clean_names(candy_2015)
candy_2016 <- clean_names(candy_2016)
candy_2017 <- clean_names(candy_2017)

# Observations about 2015 data 
# 1> Rename ( how old are you to - age) - NA, comments, 1880 , 44.444 , >39 - only pick up age which is in double rest all drop
# 2> timestamp - not required - drop it
# 3> are you going to trick or treat yourself - This can only be Yes or No all others need to be dropped
# 4> types of candy start from here - pivot longer from butterfinger to york_peppermint_patties
# 5> Columns from there onwarys have no relevance with the data i need so dropping them.

candy_2015_id <- select(candy_2015) %>%
  mutate( id = row_number())

View(candy_2015_id)

candy_2015_id <- candy_2015_id %>%
  pivot_longer(x100_grand_bar:york_peppermint_patties, names_to = "candy_name", values_to = "description")

#names(candy_2015)

#candy_2015 <- select(candy_2015, how_old_are_you = age, are_you_going_actually_going_trick_or_treating_yourself = treat_yourself, candy_name, description) 

#View(candy_2015)



