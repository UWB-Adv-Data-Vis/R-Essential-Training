# Title:    Creating scale scores by counting
# File:     06_05_CountScores.R
# Project:  R_EssT_1; R Essential Training, Part 1:
#           Wrangling and Visualizing Data

# INSTALL AND LOAD PACKAGES ################################

# Load base packages manually
# library(datasets)  # For example datasets

# Install pacman ("package manager") if needed
if (!require("pacman")) install.packages("pacman")

# pacman must already be installed; then load contributed
# packages (including pacman) with pacman
pacman::p_load(pacman, rio, tidyverse)
# pacman: for loading/unloading packages
# rio: for importing data
# tidyverse: for so many reasons

# LOAD AND PREPARE DATA ####################################

df <- import("data/StateData.xlsx") %>%
  as_tibble() %>%
  select(state_code, museum:modernDance) %>% 
  print()

# COUNT VARIABLES ##########################################

# Create new variable to count variables that meet criterion
df <- df %>% 
  mutate(
    artsCount =                       # Create new variable
      ifelse(museum > 1, 1, 0) +      # Add 1 if true
      ifelse(scrapbook > 1, 1, 0) +   # Add 1 if true
      ifelse(modernDance > 1, 1, 0)   # Add 1 if true
  )

# Sort data by new variable
df %>%
  select(state_code, artsCount, museum:modernDance) %>%
  arrange(desc(artsCount)) %>%
  print(n = Inf)

# Histogram of values
df %>%
  pull(artsCount) %>%
  hist(main = "Values of artsCount")

# CREATE CATEGORIES WITH CASE_WHEN ########################

# Indicate whether a state is high on ANY of the variables

df %<>%
  mutate(
    likeArts = case_when(
      museum > 1 | scrapbook > 1 | modernDance > 1 ~ "yes",
      TRUE ~ "no"  # All other values
    )
  ) %>%
  select(
    state_code, 
    likeArts, 
    artsCount, 
    museum:modernDance) %>%
  arrange(desc(artsCount)) %>%
  print(n = Inf)

# PACKAGES #################################################

# Packages "psych" and "scale" expand on this process and 
# provide many more options

browseURL("https://CRAN.R-project.org/package=psych")
browseURL("https://CRAN.R-project.org/package=Scale")

# CLEAN UP #################################################

# Clear data
rm(list = ls())  # Removes all objects from environment

# Clear packages
p_unload(all)  # Remove all contributed packages

# Clear plots
graphics.off()  # Clears plots, closes all graphics devices

# Clear console
cat("\014")  # Mimics ctrl+L

# Clear mind :)
