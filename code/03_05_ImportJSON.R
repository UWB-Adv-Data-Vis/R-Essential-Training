# Title:    Importing JSON data
# File:     03_05_ImportJSON.R
# Project:  R_EssT_1; R Essential Training, Part 1:
#           Wrangling and Visualizing Data

# INSTALL AND LOAD PACKAGES ################################

# Load contributed packages with pacman
pacman::p_load(pacman, tidyverse, jsonlite)
# pacman: for loading/unloading packages
# tidyverse: for so many reasons
# jsonlite: for working with JSON data

# GET JSON DATA ############################################

# Data from http://ergast.com/mrd/
# File: http://ergast.com/api/f1/1954/results/1.json
# Page shows raw, unstructured JSON data

dat <- "http://ergast.com/api/f1/1954/results/1.json" %>%
  fromJSON()  %>%  # Put data into list
  print()          # See raw data

# See nested JSON stucture
dat %>% toJSON(pretty = T)

# LOCATE DATA ##############################################

# View the structure of the dat object to see that the races
# are in a data.frame object.
str(dat)

# Race name is in:
dat$MRData$RaceTable$Races

# Create tibble
df <- dat$MRData$RaceTable$Races %>% 
  as_tibble %>%
  print()

# Unnest data and select variables; Use names_repair because
# some of the nested dataframes have the same variable names
df %<>% 
  unnest_wider(Results) %>% 
  unnest_wider(Driver, names_repair = "unique") %>% 
  unnest_wider(Constructor, names_repair = "unique") %>% 
  select(
    Race      = raceName,    # Get race name
    FirstName = givenName,   # Get first name
    LastName  = familyName,  # Get last name
    Team      = name         # Get team name
    ) %>%
  print()  # Show data

# FILTER & PRINT DATA ######################################

# Select just the Grand Prix races
df %<>% 
  filter(str_detect(Race, "Prix")) %>%
  print()

# CLEAN UP #################################################

# Clear environment
rm(list = ls()) 

# Clear packages
p_unload(all)  # Remove all add-ons

# Clear plots
graphics.off()  # Clears plots, closes all graphics devices

# Clear console
cat("\014")  # ctrl+L

# Clear mind :)
