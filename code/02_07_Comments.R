# Title:    Comments and headers
# File:     02_07_Comments.R
# Project:  R_EssT_1; R Essential Training, Part 1:
#           Wrangling and Visualizing Data

# INSTALL AND LOAD PACKAGES ################################

# Load base packages manually
library(datasets)  # For example datasets

# LOAD AND PREPARE DATA ####################################

df <- iris
head(df)

# COMMENT OUT LINES ########################################

# Comment/uncomment lines in RStudio with shift-cmd/ctrl-C

# Use comments to disable commands
hist(df$Sepal.Width,
  # col  = "#CD0000",  # red3
  # border = NA,  # No borders
  main = "Histogram of Sepal Width",
  xlab = "Sepal Width (in cm)")

# THIS IS A LEVEL 1 HEADER #################################

## This Is a Level 2 Header ================================

### This is a level 3 header. ------------------------------

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