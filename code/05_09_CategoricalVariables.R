# Title:    Working with categorical variables
# File:     05_09_CategoricalVariables.R
# Project:  R_EssT_1; R Essential Training, Part 1:
#           Wrangling and Visualizing Data

# INSTALL AND LOAD PACKAGES ################################

# Load base packages manually
# library(datasets)  # For example datasets

# Install pacman ("package manager") if needed
if (!require("pacman")) install.packages("pacman")

# pacman must already be installed; then load contributed
# packages (including pacman) with pacman
pacman::p_load(pacman, tidyverse, vcd)
# pacman: for loading/unloading packages
# tidyverse: for so many reasons
# vcd: for categorical data and sample dataset

# LOAD AND PREPARE DATA ####################################

# Use "Arthritis" dataset from vcd package
?Arthritis
df <- Arthritis %>%
	as_tibble() %>%
	print()

# Explore data
df %>% qplot(Age, data = .)       # Histogram
df %>% select(Age) %>% summary()  # Summary statistics

# Create two age groups
df %<>% 
	mutate(
	  Age_Groups = ifelse(
	    Age < 55,   # Test
	  	'Younger',  # Value if true
	  	'Older'     # Value if false
	  )
	) %>%
	print()         # Age_Groups is a character variable

# Transform Age_Groups into factor
df %<>% 
  mutate(Age_Groups = factor(Age_Groups)) %>%
  print()

# Check factor levels
df %>% 
  pull(Age_Groups) %>%
  levels()

# Change the order of the factors
df <- df %>%
  mutate(
    Age_Groups = factor(
      Age_Groups, 
      levels = c('Younger','Older')
    )
  )

# Check new ordering
df %>% 
  pull(Age_Groups) %>%
  levels()

# Factor frequencies
df %>% 
  group_by(Sex) %>%       # Select variable
  summarize(Count = n())  # Count rows

# Factors frequencies as proportions
df %>% 
  with(table(Sex)) %>%  # Select variables to compare
  prop.table() %>%      # Get the frequency
  as_tibble() %>%       # Convert to tibble
  print()

# Two factors variables relationships
df %>% 
  with(table(Sex, Age_Groups)) %>%
  as_tibble() %>%
  print()

# Two factors variables relationships as proportions
df %>% 
  with(table(Sex, Age_Groups)) %>% 
  prop.table() %>% 
  as_tibble() %>%
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

