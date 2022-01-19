# Title:    Creating cluster charts
# File:     04_09_ClusterCharts.R
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

# Save data to "df" (for "data frame")
# Rename outcome as "y" (if it helps)
# Specify outcome with df$y

?mtcars
mtcars
glimpse(mtcars)

df <- mtcars %>%
  rownames_to_column() %>%  # Tibbles don't have row names
  as_tibble() %>%
  select(car = rowname, mpg:hp, wt, qsec, gear, carb) %>%
  mutate_at(vars(-car), scale) %>%  # Standardize values
  print()

# ANALYZE DATA #############################################

# By using standardized object and variable names, the same
# code can be reused for different analyses.

# hclust (from stats) and agnes (from cluster) are
# agglomerative; diana (from cluster) is divisive

# Calculate clusters
hc <- df %>%  # Get data
  dist %>%    # Compute distance/dissimilarity matrix
  hclust      # Compute hierarchical clusters

# Plot dendrogram
hc %>% plot(labels = df$car, cex = 0.8, hang = -1)

# Draw boxes around clusters
hc %>% rect.hclust(k = 5, border = 2:6)

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
