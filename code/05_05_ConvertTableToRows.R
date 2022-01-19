# Title:    Converting data from tables to rows
# File:     05_05_ConvertTableToRows.R
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

# LOAD AND EXPLORE DATA ####################################

?UCBAdmissions      # Info on dataset
str(UCBAdmissions)  # 3D Table; N = 4526
UCBAdmissions       # Prints six tables

# THE WRONG WAY ############################################

# 1. Coerce table to data frame
admit1 <- as.data.frame.table(UCBAdmissions)
admit1  # Show results

# 2. Repeat each row to match value in Freq (makes a list)
admit2 <- lapply(admit1, function(x)rep(x, admit1$Freq))
admit2  # Show results

# 3. Convers from list back to data frame
admit3 <- as.data.frame(admit2)
admit3  # Show results

# 4. Remove the last column, which has the frequencies
admit4 <- admit3[, -4]  
admit4  # Show results

# Or combine all of the steps into a single line
admit.rows <- as.data.frame(lapply(as.data.frame.table(UCBAdmissions), function(x)rep(x, as.data.frame.table(UCBAdmissions)$Freq)))[, -4]
admit.rows  # Show results

# THE RIGHT WAY ############################################

ucb <- UCBAdmissions %>%  # Start with tabular data
  as_tibble() %>%         # Convert to tibble with rows
  uncount(n) %>%          # Convert from summary values
  print()                 # Show results

# Can also go in a single line
ucb <- UCBAdmissions %>% as_tibble() %>% uncount(n)

# ANOTHER EXAMPLE ##########################################

# Use tabular dataset HairEyeColor
?HairEyeColor  # Get info
HairEyeColor   # See data tables

# Convert table to rows, save as "df" for "dataframe" 
df <- HairEyeColor %>%        # Start with tabular data
  as_tibble() %>%             # Convert to tibble with rows
  uncount(n) %>%              # Convert from summary values
  mutate_all(as_factor) %>%   # Convert all vars to factors
  mutate_all(fct_infreq) %>%  # Order by descending freq
  print()                     # Show results

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
