# Title:    Creating scatterplots
# File:     04_07_Scatterplots.R
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

# QPLOT ####################################################

# Basic scatterplot
qplot(Petal.Width, Petal.Length, data = iris) 

# Colored by species
qplot(Petal.Width,
  Petal.Length, 
  color = Species, 
  data = iris) 

## GGPLOT2 #################################################

# Basic scatterplot
ggplot(iris, 
  aes(Petal.Width, Petal.Length)) +
  geom_point()

# Scatterplot, jittered
ggplot(iris, 
  aes(Petal.Width, Petal.Length)) +
  geom_jitter()

# Scatterplot, jittered, variable size, colored by species
ggplot(iris, 
  aes(Petal.Width, Petal.Length,
    size  = Sepal.Length,
    color = Species)) +
  geom_jitter(alpha = .5)

# Scatterplot, colored by species, fit line
ggplot(iris, 
  aes(Petal.Width, Petal.Length,
    color = Species)) +
  geom_point(size = 3) +
  geom_smooth(method = lm)

# Scatterplot, colored by species, fit line, density
ggplot(iris, 
  aes(Petal.Width, Petal.Length,
    color = Species)) +
  geom_point(size = 3) +
  geom_smooth(method = lm) +
  geom_density2d(alpha = .5) +
  theme(legend.position = "bottom")

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
