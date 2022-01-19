# Title:    Creating multiple graphs
# File:     04_08_MultipleGraphs.R
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

# HISTOGRAMS ###############################################

# Groups marked by color in one plot
iris %>%
  ggplot(aes(x = Petal.Length, 
    fill = Species)) + 
  geom_histogram() +
  theme(legend.position = "bottom")

# Separate plots by group
iris %>%
  ggplot(aes(x = Petal.Length, 
    fill = Species)) + 
  geom_histogram() +
  facet_grid(Species ~ .) +  # facet_grid
  theme(legend.position = "none")  # Turn off legend

# DENSITY PLOTS ############################################

# Groups marked by color in one plot
iris %>%
  ggplot(aes(x = Petal.Length, 
    fill = Species)) + 
  geom_density(alpha = 0.5) +
  theme(legend.position = "bottom")

# Separate plots by group
iris %>%
  ggplot(aes(x = Petal.Length, 
    fill = Species)) + 
  geom_density(alpha = 0.5) +
  facet_grid(Species ~ .) +  # facet_grid
  theme(legend.position = "none")  # Turn off legend

# SCATTERPLOTS #############################################

# Scatterplots with groups
ggplot(iris, 
  aes(Petal.Width, Petal.Length,
    color = Species)) +
  geom_point(size = 3) +
  geom_smooth(method = lm) +
  geom_density2d(alpha = .5) +
  theme(legend.position = "bottom")

# Separate scatterplots for groups
ggplot(iris, 
  aes(Petal.Width, Petal.Length,
    color = Species)) +
  geom_point(size = 3) +
  geom_smooth(method = lm) +
  geom_density2d(alpha = .5) +  
  facet_grid(Species ~ .) +  # facet_grid
  theme(legend.position = "none")  # Turn off legend

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
