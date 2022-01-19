# Title:    Creating tidy data
# File:     05_01_TidyData.R
# Project:  R_EssT_1; R Essential Training, Part 1:
#           Wrangling and Visualizing Data

# INSTALL AND LOAD PACKAGES ################################

# Load base packages manually
# library(datasets)  # For example datasets

# Install pacman ("package manager") if needed
if (!require("pacman")) install.packages("pacman")

# pacman must already be installed; then load contributed
# packages (including pacman) with pacman
pacman::p_load(datasets, pacman, tidyverse, tsibble, 
	lubridate, XML)
# datasets: for demonstration purposes
# pacman: for loading/unloading packages
# tidyverse: for so many reasons
# tsibble: for time series
# lubridate: for working with dates
# XML: for reading and parsing XML data

# ESSENTIALS OF TIDY DATA ##################################

# 1. Column == Variable/field/attribute
# 2. Row    == Case/observation
# 3. Cell   == Single value encoded with text or numbers
# 4. File   == One level of observation/abstraction

# UNTIDY DATA ##############################################

# Aside from obvious problems with spreadsheets, scraped
# data, and so on, there are many other datasets that don't
# meet the structured, rectangular norms of tidy data.

# Time series data
# XML/JSON data (hierarchically structured and labeled)
# Compound values (i.e., cells with two variables)

# TIME SERIES DATA #########################################

# About the "sunspots" dataset
?sunspots       # Get info on "sunspots" dataset
sunspots        # See full dataset in time series format
head(sunspots)  # Show first few observations
plot(sunspots)  # Plot data using base graphics

# Tidy the data
tidy_ts <- sunspots %>%  
  as_tsibble() %>%        # Convert to timeseries tibble
  mutate(                 # Create new variables
  	year = year(index),   # Create a year column
    month = month(index)  # Create a month column
  ) %>%
	select(                 # Select, reorder, rename vars
		date = index,         # Rename "index" to "date"
		year,                 # Use "year" as second variable
		month,                # Use "month" as third variable
		spots = value         # Rename "value" as "spots"
	) %>%
	print()                 # Show data

# Graph the tidy data by decade
tidy_ts %>%
  index_by(                            # By decade
    decade = ~ floor_date(tidy_ts$date, years(10))
  ) %>%
  summarise(mean_s = mean(spots)) %>%  # Mean for decade
  ggplot(aes(decade, mean_s)) +        # Plot means
  geom_point() +                       # Scatterplot
  geom_smooth() +                      # Smoother
  ylab("Sunspots: Mean by Decade")     # Label

# XML/JSON DATA ############################################

# Parse data
tidy_xml <- xmlParse("data/XMLdata.xml")

# Convert data to tidy format
tidy_xml <- XML:::xmlAttrsToDataFrame(getNodeSet(tidy_xml,
	  path='//Row')) %>%                # Read data
  as_tibble() %>%                     # Save as tibble
  mutate_all(as.character) %>%        # Save as characters
  `colnames<-` (.[1,]) %>%            # Import var names
  slice(-1) %>%                       # Remove first line
  mutate(birthdate = mdy(birthdate))  # Format birthdate

# Show data
tidy_xml

# Graph birthdates
tidy_xml %>%
  ggplot(aes(birthdate)) +
  geom_histogram()

# COMPOUND VALUES ##########################################

# Saving four (very simple) names to "names"
names <- c("Angela Ng", 
           "Samuel Leeds", 
           "Joseph Hernandez", 
           "Michelle Howell")

# Tidy the names
tidy_names <- names %>%
  enframe() %>%          # Convert vector to tibble
  separate(value,        # Separate "value" into columns
  	c("First", "Last")   # Names of new columns
  ) %>%
	print()                # Show data

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