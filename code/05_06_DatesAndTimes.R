# Title:    Working with dates and times
# File:     05_06_DatesAndTimes.R
# Project:  R_EssT_1; R Essential Training, Part 1:
#           Wrangling and Visualizing Data

# INSTALL AND LOAD PACKAGES ################################

# Load base packages manually
# library(datasets)  # For example datasets

# Install pacman ("package manager") if needed
if (!require("pacman")) install.packages("pacman")

# pacman must already be installed; then load contributed
# packages (including pacman) with pacman
pacman::p_load(datasets, lubridate, pacman, tidyverse, 
  tsibble)
# datasets: for demonstration purposes
# lubridate: for working with dates
# pacman: for loading/unloading packages
# tidyverse: for so many reasons
# tsibble: for working with time-series data

# LOAD AND PREPARE DATA ####################################

# EuStockMarkets from "datasets" package
?EuStockMarkets       # Get info
EuStockMarkets        # Show data

# Save data in timeseries tibble
df <- EuStockMarkets %>%
	as_tsibble() %>%            # Save a time-series tibble
  mutate(                     # Create new variables
  	year  = year(index),      # Separate var for year
  	month = month(index),     # Separate var for month
  	day   = day(index),       # Separate var for day
  ) %>%
	print()                     # Show data

# GRAPH DATA OVER TIME #####################################

# Graph each index over time
df %>%
  ggplot(aes(index, value, col = key)) +
  geom_line(alpha = .5) +                 # Semi-transparent
  geom_smooth(method = 'gam',             # Add GAM smoother
  	formula = y ~ s(x, bs = "cs")) +      # Calculate GAM
  labs(                                   # Add labels
  	title = "EU Stock Indices", 
  	x     = "Date Time", 
  	y     = "Closing Price") 

# GRAPH GROWTH BY INDEX ####################################

df %>%
  group_by_key() %>%                          # Group index
  index_by(~ max(df$index)) %>%               # Group date
  summarize(ROI = max(value)/min(value)) %>%  # Find ROI
	select(Index = key, ROI) %>%                # Select data
  mutate(Index = fct_reorder(                 # Reorder
  	Index,                                    # Var to order
  	ROI,                                      # Order by var
  	.desc = T)                                # Descending
  ) %>% 
  ggplot(aes(x = Index,                       # Group var
  	y = ROI,                                  # Outcome var
  	fill = Index)) +                          # Color bars
	geom_text(aes(label = round(ROI, 2)),       # Add labels
		vjust = -0.5) +                           # Above bars
  geom_col() +                                # Draw bars
	theme(legend.position = "none")             # No legend

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