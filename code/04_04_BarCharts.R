# Title:    Creating bar charts
# File:     04_04_BarCharts.R
# Project:  R_EssT_1; R Essential Training, Part 1:
#           Wrangling and Visualizing Data

# INSTALL AND LOAD PACKAGES ################################

# Load base packages manually
# library(datasets)  # For example datasets

# Install pacman ("package manager") if needed
if (!require("pacman")) install.packages("pacman")

# pacman must already be installed; then load contributed
# packages (including pacman) with pacman
pacman::p_load(datasets, pacman, psych, rio, tidyverse)
# datasets: for demonstration purposes
# pacman: for loading/unloading packages
# psych: for statistical functions
# rio: for importing data
# tidyverse: for so many reasons

# LOAD AND PREPARE DATA ####################################

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

# Plot with generic plot() command
df %>%
  select(Hair) %>%
  plot()

df %>%
  select(Eye) %>%
  plot()

df %>%
  select(Sex) %>%
  plot()

# USE QPLOT ################################################

# qplot() generally adapts well to variables
qplot(Hair, data = df)
qplot(Eye, data = df)
qplot(Sex, data = df)

# USE GGPLOT2 ##############################################

# One step approach
df %>%
  ggplot() + 
  geom_bar(aes(Eye))  # Succinct
  # geom_bar(mapping = aes(x = Eye))  # Verbose

# Two step approach
g <- df %>% ggplot(aes(Hair))  # Specify what to graph
g + geom_bar()                 # Specify how to graph it

# Add options
g + 
  geom_bar(fill = "#1D76B5") +  # Color bars (blue)
  theme_minimal() +             # Use plot theme
  coord_flip() +                # Flip coordinates
  labs(                         # Add titles & labels
    title    = "Hair Color", 
    subtitle = "592 Statistics Students",
    caption  = "(From HairEyeColor sample dataset)",
    y        = "Number of Students",
    x        = NULL)

# SAVE CHART ###############################################

# Save as PNG
ggsave("output/barchart.png",
  width = 12, height = 6, dpi = 300)

ggsave("output/barchart.pdf",
  width = 12, height = 6, dpi = 300)

# GROUPED #################################################

# Side-by-side bar chart
df %>%
  ggplot(aes(Hair, fill = Sex)) + 
  geom_bar(position = position_dodge()) +
  theme(legend.position = "bottom")

# Stacked bar chart
df %>%
  ggplot(aes(Hair, fill = Sex)) + 
  geom_bar()

# 100% stacked bar chart
df %>%
  ggplot(aes(Hair, fill = Sex)) + 
  geom_bar(position = "fill")

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
