# Title:    Working with list data
# File:     05_07_ListData.R
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

# LOAD AND PREPARE DATA ####################################

# Create list data
dat <- list(
    c(1:5),
    c("R", "Python", "Julia", "Scala", "SQL"),
    c(TRUE, TRUE, FALSE, FALSE, TRUE)
    ) %>%
  print()

# Save as tibble
df <- as_tibble(dat, 
    .name_repair = "unique") %>%  # Unique column names
  print()

# Rename columns
df <- df %>% 
  rename(ID       = "...1") %>% 
  rename(Language = "...2") %>% 
  rename(Fluent   = "...3") %>%
  print()

# ANALYZE DATA #############################################

# How many languages does the person know?

# Create table of TRUE and FALSE frequencies
df %>% select(Fluent) %>% table()

# Or simply sum the values, as FALSE = 0 and TRUE = 1
sum(df$Fluent)

# What languages does the person know?
df %>% 
  filter(Fluent == TRUE) %>%
  select(Language)

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
