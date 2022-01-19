# Title:    Using data.table
# File:     05_03_DataTable.R
# Project:  R_EssT_1; R Essential Training, Part 1:
#           Wrangling and Visualizing Data

# INSTALL AND LOAD PACKAGES ################################

# Load base packages manually
# library(datasets)  # For example datasets

# Install pacman ("package manager") if needed
if (!require("pacman")) install.packages("pacman")

# pacman must already be installed; then load contributed
# packages (including pacman) with pacman
pacman::p_load(pacman, data.table, httr, tidyverse)
# pacman: for loading/unloading packages
# data.table: for working with large datasets
# httr: for working with web sources
# tidyverse: for so many reasons

# LOAD AND PREPARE DATA ####################################

# Figshare is a site for sharing open scientific data
# browseURL("https://figshare.com/")
# Weather data in CSV format (43 MB)
# N = 655,362
# Set URL where data is
url <- "https://ndownloader.figshare.com/files/8448380"

# Read URL - (US daily weather data by station)
response <- httr::HEAD(url)

# Get the file size in bytes and confirm
httr::headers(response)[["Content-Length"]]

# Download with data.table
df <- fread(url)

# Take a look at the data
head(df)

# WORK WITH DATA.TABLE #####################################

# data.table notation: df[i, j, by]
# i:  Filter by row (empty if no filter is needed)
# j:  Select columns and summarizations to perform
#     (e.g., sum, count, mean, etc)
# by: Categorical variable to group by. 

# Filter rows
df[siteid == 'Rosemount', ]

# Select columns
df[, data, siteid]

# Filter rows and select columns
df[siteid == 'Rosemount', data, siteid]

# Filter rows, select columns, and summarize by parameter
df[siteid == 'Rosemount',
	mean(data, na.rm = TRUE), 
	by = param]

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
