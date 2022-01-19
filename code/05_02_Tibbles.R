# Title:    Using tibbles
# File:     05_02_Tibbles.R
# Project:  R_EssT_1; R Essential Training, Part 1:
#           Wrangling and Visualizing Data

# INSTALL AND LOAD PACKAGES ################################

# Load base packages manually
# library(datasets)  # For example datasets

# Install pacman ("package manager") if needed
if (!require("pacman")) install.packages("pacman")

# pacman must already be installed; then load contributed
# packages (including pacman) with pacman
pacman::p_load(datasets, pacman, tidyverse)
# datasets: for demonstration purposes
# pacman: for loading/unloading packages
# tidyverse: for so many reasons

# LOAD AND PREPARE DATA ####################################

# Use "Orange" dataset
?Orange        # Get info on "Orange" dataset
head(Orange)   # Show dataframe
class(Orange)  # Show class of data

# Convert orange from dataframe to tibble
df <- Orange %>%
	as_tibble() %>%
  print()

# Get the class of df
class(df)

# Convert Tree to factor 
df <- df %>%                            
  mutate(Tree = factor(Tree,  # Convert to factor
  	levels = 1:5)) %>%        # Manually order levels
	print()                     # Show data

# Graph circumference as a function of age for each tree
df %>%
  ggplot(aes(age, circumference, fill = Tree)) +
  geom_point() +
  geom_smooth(method = "lm") +
  ggtitle("Predicting Circumference with Age by Tree")

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

