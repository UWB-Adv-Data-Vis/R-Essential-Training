# Title:    Importing XML data
# File:     03_04_ImportXML.R
# Project:  R_EssT_1; R Essential Training, Part 1:
#           Wrangling and Visualizing Data

# INSTALL AND LOAD PACKAGES ################################

# Load contributed packages with pacman
pacman::p_load(pacman, tidyverse, XML2R)
# pacman: for loading/unloading packages
# tidyverse: for so many reasons
# XML2R: for working with XML data

# GET DATA & RESTRUCTURE ###################################

# Data from http://ergast.com/mrd/
# File: http://ergast.com/api/f1/1954/results/1.xml
# Right click to "View page source" and see raw XML

# Import XML data from web (must be online)
df <- "http://ergast.com/api/f1/1954/results/1.xml" %>%
  XML2Obs() %>%
  collapse_obs() %>%
  print()

# See variable (node) names and IDs
df %>%
  names() %>%
  print()

# EXTRACT & COMBINE DATA ###################################

# Extract data and save as tibble
df %<>%  # %<>% is the compound assignment pipe operator
  as_tibble() %>%                        # Save as tibble
  select(                                # Select data
    Race = matches("RaceName"),          # Get race name
    FirstName = matches("GivenName"),    # Get first name
    LastName = matches("FamilyName"),    # Get last name
    Team = matches("Constructor//Name")  # Get team name
  ) %>% 
  print()  # Each column is a list with two values (oops)

# Alternative view doesn't show URLs
df %>% view()

# Rewrite columns to keep just the "XML_value"
df %<>%  # %<>% is the compound assignment pipe operator
  mutate_all(~ (.[,"XML_value"])) %>%  
  print()

# FILTER & PRINT DATA ######################################

# Select just the Grand Prix races.
df %<>% 
  filter(str_detect(Race,"Prix")) %>%
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
