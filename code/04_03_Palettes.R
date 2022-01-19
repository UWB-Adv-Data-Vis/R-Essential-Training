# Title:    Using color palettes
# File:     04_03_Palettes.R
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

# BUILT-IN COLOR PALETTES ##################################

?palette  # Info on palettes
palette() # See current palette

barplot(x, col = 1:6)                # Use current palette
barplot(x, col = rainbow(6))         # Rainbow colors
barplot(x, col = heat.colors(6))     # Yellow through red
barplot(x, col = terrain.colors(6))  # Gray through green
barplot(x, col = topo.colors(6))     # Purple through tan
barplot(x, col = cm.colors(6))       # Pinks and blues

# RCOLORBREWER #############################################

browseURL("http://colorbrewer.org/")
p_load(RColorBrewer)
?RColorBrewer
display.brewer.all()  # Show all palettes

# SEQUENTIAL PALETTES: Blues, BuGn, BuPu, GnBu, Greens,
# Greys, Oranges, OrRd, PuBu, PuBuGn, PuRd, Purples, RdPu,
# Reds, YlGn, YlGnBu, YlOrBr, YlOrRd
display.brewer.pal(7,"BuPu")

# DIVERGING PALETTES: BrBG, PiYG, PRGn, PuOr, RdBu, RdGy,
# RdYlBu, RdYlGn, Spectral
display.brewer.pal(5,"BrBG")

# QUALITATIVE PALETTES: Accent (8), Dark2 (8), Paired (12),
# Pastel1 (9), Pastel2 (8), Set1 (9), Set2 (8), Set3 (12)
# (All sets require at least three groups)
display.brewer.pal(4,"Paired")

barplot(x, col = 1:6)                   # Default palette
barplot(x, col = brewer.pal(6,"BuPu"))  # Sequential
barplot(x, col = brewer.pal(6,"PuOr"))  # Diverging
barplot(x, col = brewer.pal(6,"Set3"))  # Qualitative

# WESANDERSON ##############################################

browseURL("https://github.com/karthik/wesanderson")
p_load(wesanderson)
?wesanderson
names(wes_palettes)

barplot(x, col = wes_palette("BottleRocket1"))
barplot(x, col = wes_palette("Zissou1"))
barplot(x, col = wes_palette("GrandBudapest2"))
barplot(x, col = wes_palette("IsleofDogs1"))

# OTHER PALETTE PACKAGES ###################################

# The viridis color palettes
browseURL("http://bit.ly/2tFEqKe")  

# Scientific Journal and Sci-Fi Themed Color Palettes
browseURL("http://bit.ly/2NXxIpT")

# CUSTOM PALETTES ##########################################

# Can specify colors with names
palette1 <- c("lightcyan", "orange2", "salmon", "tan")

# Can specify colors with hex codes (or other methods)
palette2 <- c("#D2B48C", "#FA8072", "#EE9A00", "#E0FFFF")

barplot(x, col = palette1)
barplot(x, col = palette2)

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
