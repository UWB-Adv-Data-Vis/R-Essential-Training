# Title:    Creating histograms
# File:     04_05_Histograms.R
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

# BELL CURVES ##############################################

# Draw just the probability density function (just the line)
# for the standard normal distribution
p <- ggplot(data.frame(x = c(-4, 4)), aes(x = x))
p + stat_function(fun = dnorm, 
    size  = 2, 
    color = "#1D76B5") +
  xlab("z-scores") +
  ylab("Relative Frequency")

# Draw a histogram for a standard normal distribution
x <- rnorm(10000)
ggplot(NULL, aes(x = x)) + 
  geom_histogram(binwidth = 0.5, 
    fill  = "#1D76B5", 
    color = "white") +
  xlab("z-scores") +  # Title on Y axis
  ylab("Frequency") 

# QPLOT ####################################################

# Basic histogram
qplot(Petal.Length, geom = "histogram", data = iris)

# Histogram, colored by group.
qplot(Petal.Length, 
  geom = "histogram",
  fill = Species, 
  data = iris)

# Density plot, colored by group.
qplot(Petal.Length, 
  geom = "density",
  fill = Species, 
  data = iris)

# GGPLOT2 ##################################################

# Histogram
iris %>%
  ggplot(aes(x = Petal.Length, 
    fill = Species)) + 
  geom_histogram() +
  theme(legend.position = "bottom")

# Density plot
iris %>%
  ggplot(aes(x = Petal.Length, 
    fill = Species)) + 
  geom_density(alpha = 0.5) +
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
