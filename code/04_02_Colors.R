# Title:    Using colors in R
# File:     04_02_Colors.R
# Project:  R_EssT_1; R Essential Training, Part 1:
#           Wrangling and Visualizing Data

# INSTALL AND LOAD PACKAGES ################################

# Load base packages manually
# library(datasets)  # For example datasets

# Install pacman ("package manager") if needed
if (!require("pacman")) install.packages("pacman")

# pacman must already be installed; then load contributed
# packages (including pacman) with pacman
pacman::p_load(datasets, pacman, rio, tidyverse)
# datasets: for demonstration purposes
# pacman: for loading/unloading packages
# rio: for importing data
# tidyverse: for so many reasons

# LOAD DATA ################################################

x <- c(24, 13, 7, 5, 3, 2)  # Sample data
barplot(x)                  # Default barplot

# COLORS IN R ##############################################

# Color names R has 657 color names for 502 unique colors,
# arranged alphabetically except for white, which is first
?colors
colors()  # Get list of color names

# Web page with R colors swatches, color names, hex codes,
# RBG codes (in 0-255 and 0.00-1.00), and R indez numbers;
# Browsable table on the page or in Google Sheets;
# downloadable as XLSX or PDF
browseURL("https://datalab.cc/rcolors")

# USE COLORS ###############################################

# Color names
barplot(x, col = "skyblue")  # skyblue
barplot(x, col = "linen")  # linen

# RGB triplets (0.00-1.00)
barplot(x, col = rgb(.52, .80, .92))  # skyblue
barplot(x, col = rgb(.98, .94, .90))  # linen

# RGB triplets (0-255)
barplot(x, col = rgb(135, 206, 235, max = 255))  # skyblue
barplot(x, col = rgb(250, 240, 230, max = 255))  # linen

# RGB hexcodes
barplot(x, col = "#87CEEB")  # skyblue
barplot(x, col = "#FAF0E6")  # linen

# Index numbers
barplot(x, col = colors() [589])  # skyblue
barplot(x, col = colors() [449])  # linen

# MULTIPLE COLORS ##########################################

# Can specify several colors in a vector, which will cycle
barplot(x, col = c("skyblue", "linen"))
barplot(x, col = c("#FAF0E6", "#87CEEB"))

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
