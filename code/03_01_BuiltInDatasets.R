# Title:    R's built-in datasets
# File:     03_01_BuiltInDatasets.R
# Project:  R_EssT_1; R Essential Training, Part 1:
#           Wrangling and Visualizing Data

# INSTALL AND LOAD PACKAGES ################################

# The datasets package is install by default but not loaded
library(datasets)           # Load example datasets
?datasets                   # Get help on package
library(help = "datasets")  # Get list of datasets

# For list of datasets with links to descriptions:
# 1. Go to "Help" tab in RStudio
# 2. Click on "Home" icon
# 3. Click on "Packages" (under "Reference")
# 4. Click on "datasets"

# SOME SAMPLE DATASETS #####################################

# Iris data from Fisher and Anderson
?iris
iris

# Titanic survival data
?Titanic
Titanic

# Anscombe's Quartet
?anscombe
anscombe

# CLEAN UP #################################################

# Clear environment
rm(list = ls()) 

# Clear packages
detach("package:datasets", unload = TRUE)  # For base

# Clear plots
graphics.off()  # Clears plots, closes all graphics devices

# Clear console
cat("\014")  # ctrl+L

# Clear mind :)
