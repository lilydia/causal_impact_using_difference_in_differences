#### Preamble ####
# Purpose: Clean the full indicator data downloaded from OECD --https://data.oecd.org/gdp/investment-by-sector.htm#indicator-chart
# Author: Youjing Li
# Email: youjing.li@utoronto.ca
# Date: 23 April 2021
# License: MIT
# Pre-requisites: 
# - Need to have downloaded the full indicator investment data from OECD and saved it to inputs/data as raw data.
# Issues: I want to know how the %investment changed over the years in Canada and in neighbouring countries.
# To do: 
# - Load and filter raw files downloaded from OECD directly
# - Save the reduced data


#### Workspace setup ####
library(haven)
library(tidyverse)
library(dplyr)

# Read in the raw data. 
table <- readr::read_csv("inputs/data/raw_data.csv")

#### Column Reduction ####                     
# Keeping variables of interests
names(table) #before column reduction

reduced_data <- 
  table %>% 
  select(LOCATION, 
         SUBJECT,
         TIME,
         Value)
rm(table)

names(reduced_data) #after column reduction

#### Row Reduction ####     
# Keeping timeframe to 4 years before and after 1985
reduced_data <- subset(reduced_data, TIME < "1989")
reduced_data <- subset(reduced_data, TIME > "1979")

#### Save the data ####
write_csv(reduced_data, "inputs/data/cleaned_data.csv")