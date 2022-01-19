# Title:    Title
# File:     0_0_.R
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

df <- import("data/StateData.xlsx") %>%
  as_tibble() %>%
  select(state_code, 
    psychRegions,
    instagram:modernDance) %>% 
  mutate(psychRegions = as.factor(psychRegions)) %>%
  rename(y = psychRegions) %>%
  print()

# ANALYZE DATA #############################################

# By using standardized object and variable names, the same
# code can be reused for different analyses

# Calculate clusters
hc <- df %>%  # Get data
  dist %>%    # Compute distance/dissimilarity matrix
  hclust      # Compute hierarchical clusters

# Plot dendrogram
hc %>% plot(labels = df$state_code)

# Draw boxes around clusters
hc %>% rect.hclust(k = 2, border = "gray80")  # 2 boxes
hc %>% rect.hclust(k = 3, border = "gray60")  # 3 boxes
hc %>% rect.hclust(k = 4, border = "gray40")  # 4 boxes

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
