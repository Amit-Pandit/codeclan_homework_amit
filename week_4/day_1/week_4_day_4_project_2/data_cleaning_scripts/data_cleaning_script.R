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
candy_2015_year <- candy_2015_clean_names %>%
  mutate(year = 2015)

view(candy_2015_year)

# Pivoting data and creating two new columns candy and emotion and storing in the data set pivoted
candy_2015_pivoted <- candy_2015_year %>%
  pivot_longer(butterfinger:york_peppermint_patties, names_to = "candy_name", values_to = "emotion")

View(candy_2015_pivoted)

# dropping variables which are not required and selecting only 5 variables required for analysis
candy_2015_dropped <- candy_2015_pivoted %>%
   select(year, how_old_are_you, are_you_going_actually_going_trick_or_treating_yourself, candy_name, emotion)

View(candy_2015_dropped)

# re-naming the Variables with appropriate names
names(candy_2015_dropped) <- c("year", "age", "trick_or_treat_yourself", "candy_name", "emotion")

View(candy_2015_dropped)

# sorting out the age variable
candy_2015_clean <- candy_2015_dropped %>%
                      mutate(age = as.integer(age),
                             age = ifelse(age < 1 | age >= 100, NA_real_, age))

View(candy_2015_clean)



# Primary-Cleaning candy_2016
# Step 1 : checing dimentions / variable names
dim(candy_2016)
names(candy_2016)
View(candy_2016)

# Cleaning Variable names
candy_2016_clean_names <- clean_names(candy_2016)

# Adding Person_year
candy_2016_year <- candy_2016_clean_names %>%
  mutate(year = 2016)

# Pivoting data and creating two new columns candy and emotion and storing in the data set pivoted
candy_2016_pivoted <- candy_2016_year %>%
  pivot_longer( x100_grand_bar :york_peppermint_patties, names_to = "candy_name", values_to = "emotion")

# Reference : distinct(candy_2016_pivoted , york_peppermint_patties_ignore)

# dropping variables which are not required and selecting only variables required for analysis
candy_2016_clean <- candy_2016_pivoted %>%
  select(year, how_old_are_you, are_you_going_actually_going_trick_or_treating_yourself, candy_name, emotion,your_gender, which_country_do_you_live_in)

# changing string name from DESPARE to 
# re-naming the Variables with appropriate names
names(candy_2016_clean) <- c("year", "age", "trick_or_treat_yourself", "candy_name", "emotion", "gender", "country")
View(candy_2016_clean)

# Primary-Cleaning candy_2017
# Step 1 : checing dimentions / variable names
dim(candy_2017)
names(candy_2017)
View(candy_2017)

# Cleaning Variable names
candy_2017_clean_names <- clean_names(candy_2017)

# Adding year
candy_2017_year <- candy_2017_clean_names %>%
  mutate(year = 2017)
View(candy_2017_year)

# Removing the Question tag added before all the variable names

names(candy_2017_year) <- str_remove(names(candy_2017_year), "q[0-9]+_")

View(candy_2017_year)

names(candy_2017_year) <- str_replace(names(candy_2017_year), "100_grand_bar", "x100_grand_bar")

View(candy_2017_year)

names(candy_2017_year) <- str_replace(names(candy_2017_year), "going_out", "trick_or_treat_yourself")

View(candy_2017_year)

# Pivoting data and creating two new columns candy and emotion and storing in the data set pivoted
candy_2017_pivoted <- candy_2017_year %>%
  pivot_longer( x100_grand_bar :york_peppermint_patties, names_to = "candy_name", values_to = "emotion")

View(candy_2017_pivoted)

#distinct(candy_2017_pivoted, x114)

# dropping variables which are not required and selecting only variables required for analysis
candy_2017_clean <- candy_2017_pivoted %>%
  select(year, trick_or_treat_yourself, gender, age, country, candy_name, emotion)

View(candy_2017_clean)

distinct(candy_2017_clean , age)


# Now lets look in detail at the Business Requirements i.e the analysis questions and start deep cleaning
# the data as per the questions asked

#Analysis questions

# 1> What is the total number of candy ratings given across the three years. 
#     (number of candy ratings, not number of raters. Don’t count missing values)

# distinct(candy_2015_clean, candy_name)

#Ans : On the face of it we have 93 different types of candy in 2015, 100 in 2016 and 103 in 2017, so approx
#the answer to this question should be somewhere between 100 to 110 keeping in mind most of the cancy have been repeated.

# 2> What was the average age of people who are going out trick or treating and the average age of people 
#3. not going trick or treating?
#Answer :
#  First we need to see to that the the variable names match , which is done, then we need to check all the unique 
# items in the variable names.
# So now we know,2015 has yes / no , same with 2016 and 2017 has yes/no/NA, hence data is good to go
  distinct(candy_2017_clean,trick_or_treat_yourself)

# 3> For each of joy, despair and meh, which candy bar revived the most of these ratings?
# Answer : In 2017 emotion has only NA / MEH / DISPAIR / JOY same with 2016, in 2015 there are only 3 JOY/ NA/DISPARE,which 
# is fine, so data is good to go.

  distinct(candy_2017_clean,emotion)
  
  
# 4> How many people rated Starburst as despair?
# data is clean enugh to answer this
  distinct( candy_2015_clean, candy_name)

#For the next three questions, count despair as -1, joy as +1 and meh as 0.

# 5> What was the most popular candy bar by this rating system for each gender in the dataset?
  distinct( candy_2015_clean, gender)
  
# 6> What was the most popular candy bar in each year?
#probably to answer this question wil have to add 3 more columns for candy_name_2015 / candy_name_2016 / candy_name_2017
  
# 7> What was the most popular candy bar by this rating for people in US, Canada, UK and all other countries?
# to answer this question, all country names will have to be cleaned first

#BINDING THE 3 DATA-SETS
  
candy_all_years_primary_clean <- bind_rows(candy_2015_clean, candy_2016_clean, candy_2017_clean)

candy_all_years_primary_clean <- candy_all_years_primary_clean %>%
                                    mutate(age = as.numeric(age))

View(candy_all_years_primary_clean)

# Writing .csv file into clean data for further analysis

write_csv(here(candy_all_years_primary_clean,'clean_data/candy_all_years_primary_clean1.csv'))

