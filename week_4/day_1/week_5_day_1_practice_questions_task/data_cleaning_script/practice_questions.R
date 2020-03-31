library(tidyverse)
library(readr)
library(here)

# reading the files and saving them with a variable name
beer <- read_delim("raw_data/beer.txt", delim = ";")
dim(beer)
View(beer)

inmates <- read_tsv(here("raw_data/inmates.tsv"))
dim(inmates)
View(inmates)

salaries <- read_csv(here("raw_data/salaries.csv"))
dim(salaries)
View(salaries)
names(salaries)

#cleaning the names
