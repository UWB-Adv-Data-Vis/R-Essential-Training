# Title:    Recoding categorical data
# File:     06_01_RecodeCategoricalData.R
# Project:  R_EssT_1; R Essential Training, Part 1:
#           Wrangling and Visualizing Data

# INSTALL AND LOAD PACKAGES ################################

# Load base packages manually
# library(datasets)  # For example datasets

# Install pacman ("package manager") if needed
if (!require("pacman")) install.packages("pacman")

# pacman must already be installed; then load contributed
# packages (including pacman) with pacman
pacman::p_load(magrittr, pacman, rio, tidyverse)
# pacman: for loading/unloading packages
# magrittr: for pipes
# rio: for importing data
# tidyverse: for so many reasons

# This script makes use of functions from the forcats
# package, which is installed as part of the tidyverse

# LOAD AND PREPARE DATA ####################################

# Import data into tibble "df"
df <- import("data/MobileOS_US.xlsx") %>%
  as_tibble() %>%
  print()

# Define "MobileOS" as factor
df %<>% 
  mutate(MobileOS = as.factor(MobileOS)) %>%
  print()

# Select 2010 variable, convert to whole numbers
df %<>% 
  mutate(OS_2010 = `2010-01` * 100) %>%
  select(MobileOS, OS_2010) %>%
  print()

# Check for outliers
df %>% 
  select(OS_2010) %>% 
  boxplot(horizontal = T)

# Convert to rows
df %<>% 
  uncount(OS_2010) %>%
  print()

# Check frequencies again
df %>% 
  select(MobileOS) %>% 
  pull() %>% 
  fct_count()

# RELEVEL ##################################################

## Revel Manually ==========================================

# Relevel so Nintendo is first
df %<>% 
  mutate(
    MobileOS = fct_relevel(MobileOS, "Nintendo")
  )

# Check levels
df %>% 
  pull(MobileOS) %>% 
  levels()

# Bar chart
df %>%
  ggplot(aes(MobileOS)) +
  geom_bar()

## Relevel by Descending Frequencies =======================

# Relevel all categories by descending frequencies
df %<>%
  mutate(
    MobileOS = fct_infreq(MobileOS)
  )

# Check levels
df %>% 
  pull(MobileOS) %>% 
  levels()

# Bar chart
df %>%
  ggplot(aes(MobileOS))+
  geom_bar()

# COLLAPSE CATEGORIES ######################################

# Collapse Specific Categories =============================

# Collapse Unknown and Other
df %<>%
  mutate(
    MobileOS = fct_collapse(
      .$MobileOS,
       unknown_other = c("Unknown", "Other")
    )
  )

# Check levels
df %>% 
  pull(MobileOS) %>% 
  levels()

# Bar chart, again
df %>%
  ggplot(aes(MobileOS))+
  geom_bar()

## Collapse Categories by Rank =============================

# Lump everything but the top three in "lump_MobileOS"
df %<>%
  mutate(
    lump_MobileOS = fct_lump(MobileOS, n = 3)
  )

# Check levels
df %>% 
  pull(lump_MobileOS) %>% 
  levels()

# Bar chart
df %>%
  ggplot(aes(lump_MobileOS)) +
  geom_bar()

## Collapse by Frequencies =================================

# Lump levels with fewer than 100 counts into "min_MobileOS"
df %<>%
  mutate(
    min_MobileOS = fct_lump_min(MobileOS, min = 100)
  )

# Check levels
df %>% 
  pull(min_MobileOS) %>% 
  levels()

# Bar chart
df %>%
  ggplot(aes(min_MobileOS)) +
  geom_bar()

## Keep Only Specified Category ============================

# Compare iOS to all others with "MobileOS_iOS"
df %<>%
  mutate(
    MobileOS_iOS = fct_other(MobileOS, keep = "iOS")
  )

# Check levels
df %>% 
  pull(MobileOS_iOS) %>% 
  levels()

# Bar chart
df %>%
  ggplot(aes(MobileOS_iOS))+
  geom_bar()

## Remove Levels ===========================================

# Filter out Other and unknown_other 
df %<>%
  filter(!(MobileOS == "Other" |
    MobileOS=="unknown_other"))

# Drop NA values from MobileOS
df %<>%
  mutate(MobileOS = fct_drop(MobileOS))%>%
  print()

# Check levels
df %>% 
  pull(MobileOS) %>% 
  levels()

# Bar chart
df %>%
  ggplot(aes(MobileOS))+
  geom_bar()

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
