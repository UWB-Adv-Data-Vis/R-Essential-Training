# Title:    Transforming outliers
# File:     06_03_TransformOutliers.R
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

# "islands" dataset has a strong positive skew
?islands
islands
islands %>% hist(main = NULL)
islands %>% boxplot(horizontal = T)

# REMOVE OUTLIERS ##########################################

# Sort observations in descending value
islands2 <- islands %>%
  enframe() %>%             # Convert vector to tibble
  arrange(desc(value)) %>%  # Sort by descending values
  print()

# Filter out the continents
islands2 %<>%
  filter(value < 1000) %>%
  print()

# pull() creates a vector (like islands$value), while
# select() creates a dataframe; different functions need
# different data formats
islands2 %>% pull(value) %>% hist(main = NULL)  
islands2 %>% select(value) %>% boxplot(horizontal = T)

# BRING IN OUTLIERS ########################################

# "Winsorizing" refers to giving extreme cases the same
# value as less extreme cases, which can make for more
# robust analyses, even if it's peculiar in this case

# Sort observations in descending value
islands3 <- islands %>%
  enframe() %>%             # Convert vector to tibble
  arrange(desc(value)) %>%  # Sort by descending values
  print()

# The largest non-continent is Greenland, with an area of
# about 840,000 square miles (coded as 840 in this dataset)
islands3 <- islands3 %>% 
  mutate(
    value = ifelse(
      value > 840,  # Test if value is greater than 840
      840,          # If true, replace value with 840
      value         # If false, keep existing value
    )
  ) %>% 
  print()

# Graph results
islands3 %>% pull(value) %>% hist(main = NULL)  
islands3 %>% select(value) %>% boxplot(horizontal = T)

# CREATE NEW GROUPS ########################################

islands4 <- islands %>%
  enframe() %>%             # Convert vector to tibble
  arrange(desc(value)) %>%  # Sort by descending values
  print()

islands4 %<>% 
  mutate(
    landmass = ifelse(
      value < 1000,  # Test if value is less than 1m sq mi
      "island",      # If true, it's an island
      "continent"    # If false, it's a continent
    )
  ) %>%
  print()

# Boxplot of area of continents
islands4 %>% 
  filter(landmass == "continent") %>% 
  select(value) %>% 
  boxplot(
    horizontal = T,
    main = "Area of Continents",
    xlab = "Thousands of Square Miles"
  )

# Boxplot of area of islands
islands4 %>% 
  filter(landmass == "island") %>% 
  select(value) %>% 
  boxplot(
    horizontal = T,
    main = "Area of Islands",
    xlab = "Thousands of Square Miles"
  )

# TRANSFORMING DATA ########################################

# Strong positive skew
islands %>% hist(main = NULL)
islands %>% boxplot(horizontal = T)

# log is natural logarithm with base e (base 10 is log10); 
# it brings in extreme positive values
islands %>% log() %>% hist(main = NULL)
islands %>% log() %>% boxplot(horizontal = T)

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
