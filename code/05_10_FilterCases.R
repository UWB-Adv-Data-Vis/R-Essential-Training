# Title:    Filtering cases and subgroups
# File:     05_10_FilterCases.R
# Project:  R_EssT_1; R Essential Training, Part 1:
#           Wrangling and Visualizing Data

# INSTALL AND LOAD PACKAGES ################################

# pacman must already be installed; then load contributed
# packages (including pacman) with pacman
pacman::p_load(pacman, rio, tidyverse)
# pacman: for loading/unloading packages
# rio: for importing data
# tidyverse: for so many reasons

# LOAD AND PREPARE DATA ####################################

df <- import("data/StateData.xlsx") %>%
  as_tibble() %>%
  select(state_code, 
    region,
    psychRegions,
    instagram:modernDance) %>% 
  mutate(psychRegions = as.factor(psychRegions)) %>%
  # rename(y = psychRegions) %>%
  print()

# FLITER BY ONE VARIABLE ###################################

# "entrepreneur" is a quantitative variable
qplot(entrepreneur, geom = "histogram", data = df)
df %>%
  filter(entrepreneur > 1) %>%
  print()

# "region" is a character variable
qplot(region, data = df)
df %>%
  filter(region == "South") %>%
  print()

# "psychRegions" is a factor
qplot(psychRegions, data = df)
df %>%
  filter(psychRegions == "Relaxed and Creative") %>%
  print()

# FILTER BY MULTIPLE VARIABLES #############################

# "or" is the vertical pipe |
df %>%
  filter(region == "South" | 
    psychRegions == "Relaxed and Creative") %>%
  print()

# "and" is the ampersand &
df %>%
  filter(region == "South" & 
    psychRegions == "Relaxed and Creative") %>%
  print()

# "not" is the exclamation point !
df %>%
  filter(region == "South" & 
    !psychRegions == "Relaxed and Creative") %>%
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
