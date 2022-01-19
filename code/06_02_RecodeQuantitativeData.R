# Title:    Recoding quantitative data
# File:     06_02_RecodeQuantitativeData.R
# Project:  R_EssT_1; R Essential Training, Part 1:
#           Wrangling and Visualizing Data

# INSTALL AND LOAD PACKAGES ################################

# Load base packages manually
# library(datasets)  # For example datasets

# Install pacman ("package manager") if needed
if (!require("pacman")) install.packages("pacman")

# pacman must already be installed; then load contributed
# packages (including pacman) with pacman
pacman::p_load(pacman, tidyverse)
# pacman: for loading/unloading packages
# tidyverse: for so many reasons
  
# REVERSE CODING ###########################################

# For 1-n scale, use (n+1) - x
(x1 <- 1:7)  # Parentheses print results
8 - x1

# For 0-n scale, use n - x
(x2 <- 0:6)
6 - x2

# For -x to +x scale, use 0 - x or multiple by -1
(x3 <- -3:3)
0 - x3
x3 * -1

# STANDARDIZING VALUES WITH Z-SCORES #######################

# Info on scale(), which transforms data to z-scores, or 
# distributions with a mean of 0 (if centered) and a
# standard deviation of 1 (if scaled)
?scale

# Centering variables on their respective means
(x4 <- matrix(1:10, ncol = 2))
scale(x4, scale = FALSE)  # Default "center = TRUE")

# Calculating z-scores
scale(x4)  #   # Default "center = TRUE, scale = TRUE")

# STANDARDIZING TO OTHER VALUES ############################

# To change scores to another distribution, first use
# scale() to convert to a z-score, then multiply to change
# the standard deviation and, finally, add to change the
# mean.

# Many personality tests, including the MMPI, use T-scores,
# which have a mean of 50 and SD of 10

# T-scores
x5 <- x4 %>%
  scale() %>%  # Converts each column to z-scores
  `*`(10) %>%  # Multiplies all values by 10 (so SD = 10)
  `+`(50) %>%  # Adds 50 to all values (so M = 50)
  print()

# IQ tests are often standardized to M = 100 and SD = 15

# IQ scores
x6 <- x4 %>%
  scale() %>%   # Converts each column to z-scores
  `*`(15) %>%   # Multiplies all values by 15 (so SD = 15)
  `+`(100) %>%  # Adds 100 to all values (so M = 100)
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
