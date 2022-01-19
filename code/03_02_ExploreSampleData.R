# Title:    Exploring sample datasets with pacman
# File:     03_02_ExploreSampleData.R
# Project:  R_EssT_1; R Essential Training, Part 1:
#           Wrangling and Visualizing Data

# INSTALL AND LOAD PACKAGES ################################

# Install pacman ("package manager") if needed
if (!require("pacman")) install.packages("pacman")

# pacman must already be installed; then load contributed
# packages (including pacman) with pacman
pacman::p_load(datasets, pacman, rio, tidyverse)
# datasets: for demonstration purposes
# pacman: for loading/unloading packages
# rio: for importing data
# tidyverse: for so many reasons

# LIST DATASETS WITH P_DATA ################################

# Get info on p_data() function from pacman package
?p_data()

# Numbered list of datasets in package with p_data()
p_data(datasets)

# TIDYVERSE DATASETS #######################################

# Need to query individual tidyverse packages
p_data(tidyverse)  # "no data sets found"

# browseURL("https://www.tidyverse.org/packages/")
# Includes ggplot2, dplyr, tidyr, readr, purrr, tibble,
# stringer, forcats, etc. (not all have datasets)

p_data(ggplot2)       # Tidyverse: Grammar of graphics
p_data(dplyr)         # Tidyverse: Data manipulation
p_data(tidyr)         # Tidyverse: Functions for tidy data
p_data(stringr)       # Tidyverse: Functions for strings
p_data(forcats)       # Tidyverse: Factors & categories

# OTHER PACKAGES WITH DATASETS #############################

# These are some packages with datasets that are installed
# on my machine. You can install and load these by
# ucommenting and running the p_load() command that follows.

# p_load(carData, caret, cluster, DescTools, GGally, gnm,
#   janeaustenr, Lahman, lava, lmtest, maps, MASS, mlbench,
#   nlme, nycflights13, psych, qcc, quantreg, rpart,
#   SixSigma, survival, titanic, vcd)

p_data(carData)       # Companion to Applied Regression
p_data(caret)         # Classification & regression training
p_data(cluster)       # Cluster analysis extended
p_data(DescTools)     # Tools for descriptive statistics
p_data(GGally)        # Extension to ggplot2
p_data(gnm)           # Generalized nonlinear models
p_data(janeaustenr)   # Jane Austen's complete novels
p_data(Lahman)        # Sean Lahman baseball database
p_data(lava)          # Latent variable models
p_data(lmtest)        # Testing linear regression models
p_data(maps)          # Draw geographical maps
p_data(MASS)          # Modern Applied Statistics with S
p_data(mlbench)       # Machine learning benchmark problems
p_data(nlme)          # Linear & nonlinear mixed effects
p_data(nycflights13)  # Flights from NYC in 2013
p_data(psych)         # Psychometrics
p_data(qcc)           # Quality control charts
p_data(quantreg)      # Quantile regression
p_data(rpart)         # Recursive partitioning
p_data(SixSigma)      # Six sigma tools for quality control
p_data(survival)      # Survival analysis
p_data(titanic)       # Titanic survival data
p_data(vcd)           # Visualizing categorical data

# CLEAN UP #################################################

# Clear environment
rm(list = ls()) 

# Clear packages
detach("package:datasets", unload = TRUE)  # For base
p_unload(all)  # Remove all contributed packages

# Clear plots
graphics.off()  # Clears plots, closes all graphics devices

# Clear console
cat("\014")  # ctrl+L

# Clear mind :)
