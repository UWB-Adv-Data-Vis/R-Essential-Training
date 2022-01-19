# Title:    Creating box plots
# File:     04_06_Boxplots.R
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

# LOAD AND PREPARE DATA ####################################

# iris dataset from "datasets" package
?iris
iris

# BASE GRAPHICS ############################################

# All variables at once
iris %>% boxplot()

# One variable, all groups together
iris %>% 
  select(Petal.Length) %>%
  boxplot(horizontal = T)

# One variable, by groups
boxplot(Petal.Length ~ Species, 
  data = iris,
  horizontal = T)

# QPLOT ####################################################

# Basic dotplot by group.
qplot(Species, Petal.Length, data = iris)

# Dotplot, colored by group.
qplot(Species, 
  Petal.Length, 
  col  = Species, 
  data = iris)

# Dotplot, colored by group, jittered w/boxplots
qplot(Species, 
  Petal.Length, 
  col  = Species, 
  geom = c("boxplot", "jitter"), 
  data = iris)

# Boxplots only, colored by groups
qplot(Species, 
  Petal.Length, 
  col  = Species, 
  geom = c("boxplot"), 
  data = iris)

# GGPLOT2 ##################################################

iris %>%
  ggplot(aes(x = Species, 
    y = Petal.Length, 
    fill = Species)) + 
  geom_boxplot() +
  coord_flip() +
  xlab("") +
  theme(legend.position = "none")

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
