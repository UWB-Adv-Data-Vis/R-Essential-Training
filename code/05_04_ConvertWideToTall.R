# Title:    Converting data from wide to tall and from tall
#           to wide
# File:     05_04_ConvertWideToTall.R
# Project:  R_EssT_1; R Essential Training, Part 1:
#           Wrangling and Visualizing Data

# INSTALL AND LOAD PACKAGES ################################

# Load base packages manually
# library(datasets)  # For example datasets

# Install pacman ("package manager") if needed
if (!require("pacman")) install.packages("pacman")

# pacman must already be installed; then load contributed
# packages (including pacman) with pacman
pacman::p_load(pacman, MASS, tidyverse)
# pacman: for loading/unloading packages
# MASS: for sample dataset
# tidyverse: for so many reasons

# LOAD AND PREPARE DATA ####################################

# Load data (from MASS package)
?housing  # Get info

# Original data
df <- housing %>%
	as_tibble() %>%
	print()

# From tall to wide with "spread"
df_wide <- spread(df, 
	  key = Sat,          # Category to split into columns
	  value = Freq) %>%   # Values for each category
	print()

# From wide to tall with "gather"
df_tall <- gather(df_wide,
	  'Low','Medium','High',  # Columns to be combined
	  key = 'Sat',            # New variable for columns
	  value = 'Freq') %>%     # Variable to hold values
	print()

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
