#Reading Data

#The following data type is in excel format and hence we have used the read_excel function to read the .xls file,
#Please note that the read_excel command only reads the first page of the data set provided, however there are a total of 4 sheers in the data set seabords.xls , to read the 2nd sheet we have to specify the sheet number, specifying the column type allows will allow the function to extract the data in a particular type i.e "skip","guess","date","logical","numeric","text" or as a "list".
#So now we have the 4 excel sheets read as 4 vectors.
  1.ship_data_by_record_id
  2.bird_data_by_recrd_id
  3.ship_data_codes
  4.bird_data_codes

# load in libraries
library(tidyverse)
library(readxl)
library(openxlsx)
install.packages("here")
library(here)

# load in data
ship_data_by_record_id <- read_excel(here("raw_data/seabirds.xls"))
bird_data_by_recrd_id <- read_excel(here("raw_data/seabirds.xls", col_types = "guess" ,  sheet = 2))
ship_data_codes <- read_excel(here("raw_data/seabirds.xls",skip = 1, sheet = 3))
bird_data_codes <- read_excel(here("raw_data/seabirds.xls",skip =1, sheet = 4))

# Reading the data
# Looking at the dimentions / names / head / tail to analyse the data
View(bird_data_by_recrd_id)
names(ship_data_by_record_id)
dim(ship_data_by_record_id)
head(ship_data_by_record_id)
tail(ship_data_by_record_id)

# Cleaning the data

#Loading the library
library(janitor)

#Step 1: cleaning the column names and giving them a more meaningfull name for ship_data
# Please note : clean_names would have automatically corrected the way in which the data whic is represented, however i have first manually changed a few names and only to be doiubly sure have used the clean_names later, however this is not a must.

names(ship_data_by_record_id) <- c("record", "record_id", "date", "time", "latitude", "longitude", " east_west_hemisphere", "ship_activity", " ship_speed", "ship_direction", "cloud_cover", "precipitation", "wind_speed", "wind_dicertion", "air_temperature", "sea_level_pressure", "sea_state", "sea_surface_temp", "sea_surface_salinity", "sea_floor_depth", "observer_name", "bird_count", "month", "sount_hemisphere_season","longitude_360", "latitude_cell_center", "longitude_cell_360")
ship_data_by_record_id <- clean_names(ship_data_by_record_id)

#Step 2: cleaning the column names and giving them a more meaningfull name for bird_data by looking at the bird data codes excel sheet...

# Looking at the dimentions / names / head / tail to analyse the data
View(bird_data_by_recrd_id)
names(bird_data_by_recrd_id)
dim(bird_data_by_recrd_id)
head(bird_data_by_recrd_id)
tail(bird_data_by_recrd_id)

names(bird_data_by_recrd_id) <- c("record", "record_id","bird_common_name", "bird_scientific_name", "bird_abbreviation", "age", "wandering_albertos_plumage_phase", "plumage_phase", "sex", "count", "feeding_num", "feeding_ocurance", "sitting_on_water_num", "sitting_on_water_ocur", " sitting on ice no", "stiiting on ice ocr", "sitting on ship ocur", "in hand ocur", "flying past num", "flying past ocr", "accompanying num", "accompanying occurances", "ship follow in wake num", "ship follow in wake occurances", "occurance of moult", "naturally feeding occurance")

bird_data_by_record_id <- clean_names(bird_data_by_recrd_id)

#Step 3:

#Dropping / Deleating columns which are not required , checking for repetations in data, missing data, and terating them as required.


bird_data_by_record_id_cleaned <- bird_data_by_record_id %>%
  select(record_id, bird_common_name,bird_scientific_name,bird_abbreviation, count)

ship_data_by_record_id_cleaned <- ship_data_by_record_id %>%
  select(record_id, latitude, longitude, bird_count, month,sount_hemisphere_season )

#Step 4:
#Checking String Variables
#Setting string to lower case across all

bird_data_by_record_id_lower <- mutate_all(bird_data_by_record_id_cleaned, .funs=tolower)

ship_data_by_record_id_lower <- mutate_all(ship_data_by_record_id_cleaned, .funs = tolower)

#Step 5:
#Merging of the two tables 
#scored_policies<-merge(x=policies,y=limits,by="State",all.x=TRUE) - source internet http://www.programmingr.com/tutorial/left-join-in-r/

bird_ship_data_record_id <- merge(x=bird_data_by_record_id_lower, y=ship_data_by_record_id_lower,by="record_id",all.x = TRUE)
  
bird_ship_data_record_id

#Step 6:
#Saving the table as a .csv file to the clean_data folder
# Source https://datatofish.com/export-dataframe-to-csv-in-r/
# write.csv(Your DataFrame,"Path where you'd like to export the DataFrame\\File Name.csv", row.names = FALSE)

write_csv(bird_ship_data_record_id, 'clean_data/bird_ship_data_record_id.csv')


