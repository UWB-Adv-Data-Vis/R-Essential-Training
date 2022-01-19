# Title:    Saving data in native R formats
# File:     03_06_SaveRData.R
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

# SAVE AS RDATA ############################################

# RData files open natively, are easy to work with
# Note: .rda is a shorter name for .rdata; use either

# Use save()
save(df, file = "data/StateData.rdata")

# Clear data
rm(list = ls())  # Removes all objects from environment

# Now load saved datafile
# You have two choices for reading RData files:
# 1. Base Rs's load()
# 2. rio's import()

# load() immediate puts data in Environment but can't be
# renamed or displayed with same command.
load("data/StateData.rdata")
df  # Check data

# Clear data
rm(list = ls())  # Removes all objects from environment

# import() displays data but doesn't show in Environment
import("data/StateData.rdata") %>%
  print()

# import() can rename file as new object and print
new_df <- import("data/StateData.rdata") %>%
  print()

# Clear data
rm(list = ls())  # Removes all objects from environment

# SAVE AS RDS ##############################################

# Save a serialized version

# Use saveRDS()
df %>% saveRDS("data/StateData.rds")

# Or use write_rds() from tidyverse. Not compressed by 
# default, as "space is generally cheaper than time."
df %>% write_rds("data/StateData2.rds")

# Clear data
rm(list = ls())  # Removes all objects from environment

# You have three choices for reading RDS files:
# 1. Base Rs's readRDS()
# 2. readr's read_rds()
# 3. rio's import()

# Used on its own, import() shows data in Console
import("data/StateData.rds")

# With a destintation object, import saves data
new_df <- import("data/StateData.rds") %>%
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
