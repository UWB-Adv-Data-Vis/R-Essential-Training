# Title:    Working with XML data
# File:     05_08_XMLData.R
# Project:  R_EssT_1; R Essential Training, Part 1:
#           Wrangling and Visualizing Data

# INSTALL AND LOAD PACKAGES ################################

# Load base packages manually
# library(datasets)  # For example datasets

# Install pacman ("package manager") if needed
if (!require("pacman")) install.packages("pacman")

# pacman must already be installed; then load contributed
# packages (including pacman) with pacman
pacman::p_load(pacman, tidyverse, xml2)
# pacman: for loading/unloading packages
# tidyverse: for so many reasons
# xml2: for working with XML data

# GET XML DATA #############################################

# Data from https://data.mo.gov/  # Missouri data portal
# File: https://data.mo.gov/api/views/vpge-tj3s/rows.xml

# Import XML data
URL <- "https://data.mo.gov/api/views/vpge-tj3s/rows.xml"
dat <- URL %>%
  read_xml() %>%  
  as_list()

# Check structure
str(dat)

# EXTRACT & COMBINE DATA ###################################

# We need county name and sales tax rate.

# Create a tibble and start unnesting the list. First,
# unnest_wider to get the list of counties and taxes.
df <- tibble(taxes = dat) %>% 
  unnest_wider(taxes) %>%
  print()
  
# Then unnest_longer to get each county/tax pair in a row.
df <- df %>% 
  unnest_longer(row) %>%
  print()

# Another unnest_wider to get county and tax as separate
# variables.
df <- df %>% 
  unnest_wider(row) %>% 
  select(-row_id) %>%  # Drop unneeded ID
  print()

# Convert from lists to character and numeric. "str_squish"
# removes repeated white space in the county column.
df <- df %>% 
  unnest(county) %>% 
  unnest(salestax) %>% 
  mutate(salestax = as.numeric(salestax)) %>% 
  mutate(county = str_squish(county)) %>% 
  print()

# Graph sales tax rates
df %>%
  ggplot(aes(salestax)) +
  geom_histogram(binwidth = 0.005)

# Summary statistics for sales tax rates
df %>% select(salestax) %>% summary()

# CLEAN UP #################################################

# Clear data
rm(list = ls())  # Removes all objects from environment

# Clear packages
detach("package:datasets", unload = T)  # For base packages
p_unload(all)  # Remove all contributed packages

# Clear plots
graphics.off()  # Clears plots, closes all graphics devices

# Clear console
cat("\014")  # Mimics ctrl+L

# Clear mind :)
