# Title:    Data science with R: A case study
# File:     0_10_2.CaseStudy.R
# Project:  R_EssT_1; R Essential Training, Part 1:
#           Wrangling and Visualizing Data

# INSTALL AND LOAD PACKAGES ################################

# Load base packages manually
# library(datasets)  # For example datasets

# Install pacman ("package manager") if needed
if (!require("pacman")) install.packages("pacman")

# pacman must already be installed; then load contributed
# packages (including pacman) with pacman
pacman::p_load(pacman, magrittr, productplots, psych, 
  RColorBrewer, tidyverse)
# pacman: for loading/unloading packages
# magrittr: for pipes
# productplots: for sample dataset "happy"
# psych: for statistical procedures
# RColorBrewer: for color palettes
# tidyverse: for so many reasons

# LOAD AND PREPARE DATA ####################################

# "happy" dataset from productplots package; dataset has
# 51,020 rows and 10 variables
?happy
names(happy)

# Info on productplots package
# browseURL("http://j.mp/2GMXZCZ")  # Page on CRAN
# browseURL("http://j.mp/36ImMTy")  # Ref manual on CRAN
# browseURL("http://j.mp/37Wxvv7")  # Preprint PDF

# Save dataset to tibble named "df" (for "dataframe")
df <- happy %>%
  as_tibble() %>%
  print()

# Delete id and wtssall, which is a weighting variable that
# doesn't change results appreciably
df %<>%
  select(happy:health) %>%
  print()

# Check levels of "happy"
levels(df$happy)

# Reverse levels of "happy" so "very happy" is at the top of
# stacked bar charts
df %<>%
  mutate(happy = fct_rev(happy))

levels(df$happy)

# OUTCOME VARIABLE: HAPPINESS ##############################

# Bar chart of happy
df %>%
  ggplot() + 
  geom_bar(aes(happy, fill = happy)) + 
  theme(
    axis.title.x = element_blank(), 
    legend.position = "none"
  )

# Frequencies for happy
df %>% count(happy)

# Filter out the NA responses on happy
df %<>%
  filter(!is.na(happy))

# Frequencies for happy
df %>% count(happy)

# HAPPINESS AND GENDER #####################################

# Bar chart of sex
df %>%
  ggplot() + 
  geom_bar(aes(sex, fill = sex)) + 
  theme(
    axis.title.x = element_blank(), 
    legend.position = "none"
  )

# Frequencies for sex
df %>% count(sex)

# 100% stacked bar chart
df %>%
  ggplot(aes(sex, fill = happy)) + 
  geom_bar(position = "fill")
# Looks pretty similar

# HAPPINESS AND MARITAL STATUS #############################

# Bar chart of marital
df %>%
  ggplot() + 
  geom_bar(aes(marital, fill = marital)) + 
  theme(
    axis.title.x = element_blank(), 
    legend.position = "none"
  )

# Frequencies for marital
df %>% count(marital)

# 100% stacked bar chart
df %>%
  filter(!is.na(marital)) %>%
  ggplot(aes(marital, fill = happy)) + 
  geom_bar(position = "fill")

# Create dichotmous married/not variable
df %<>%
  mutate(
    married = ifelse(
      marital == "married",
      "yes",
      "no")
  ) %>%
  mutate(married = as.factor(married)) %>%
 print()

# Frequencies for married
df %>% count(married)

# 100% stacked bar chart
df %>%
  filter(!is.na(married)) %>%
  ggplot(aes(married, fill = happy)) + 
  geom_bar(position = "fill")
# Married group has more in "very happy" and fewer in "not
# too happy"

# HAPPINESS AND LEVEL OF EDUCATION #########################

# Bar chart of degree
df %>%
  ggplot() + 
  geom_bar(aes(degree, fill = degree)) + 
  theme(
    axis.title.x = element_blank(), 
    legend.position = "none"
  )

# Frequencies of degree
df %>% count(degree)

# 100% stacked bar chart
df %>%
  filter(!is.na(degree)) %>%
  ggplot(aes(degree, fill = happy)) + 
  geom_bar(position = "fill")
# Things look bad for "lt high school" with only small
# differences between other groups?

# Create dichotomous college/not variable for exploration
df %<>%
  mutate(
    college = ifelse(
      degree %in%
      c("junior college",
        "bachelor",
        "graduate"),
      "yes", "no")
  ) %>%
  print()

# Frequencies of college
df %>% count(college)

# 100% stacked bar chart
df %>%
  ggplot(aes(college, fill = happy)) + 
  geom_bar(position = "fill")

# HAPPINESS AND FINANCIAL STATUS ###########################

# Bar chart of finrela
df %>%
  ggplot() + 
  geom_bar(aes(finrela, fill = finrela)) + 
  theme(
    axis.title.x = element_blank(), 
    legend.position = "none"
  )

# Frequencies for finrela
df %>% count(finrela)

# 100% stacked bar chart
df %>%
  filter(!is.na(finrela)) %>%
  ggplot(aes(finrela, fill = happy)) + 
  geom_bar(position = "fill")

# Create dichotomous varible for average finances or higher
df %<>%
  mutate(
    avg_fin = case_when(
      finrela %in%
        c("far below average",
          "below average") ~
          "no",
      finrela %in%
        c("average",
          "above average",
          "far above average") ~
          "yes",
      finrela == "NA" ~ "NA")
  ) %>%
  print()

# Get frequencies
df %>% count(avg_fin)

# 100% stacked bar chart
df %>%
  filter(!is.na(avg_fin)) %>%
  ggplot(aes(avg_fin, fill = happy)) + 
  geom_bar(position = "fill")
# Big differences in both "very happy" and "not too happy"

# HAPPINESS AND HEALTH #####################################

# Bar chart of health
df %>%
  ggplot() + 
  geom_bar(aes(health, fill = health)) + 
  theme(
    axis.title.x = element_blank(), 
    legend.position = "none"
  )

# Frequencies of health
df %>% count(health)

# 100% stacked bar chart
df %>%
  filter(!is.na(health)) %>%
  ggplot(aes(health, fill = happy)) + 
  geom_bar(position = "fill")
# Looks pretty linear; should be a good predictor as is

# HAPPINESS AND YEAR OF SURVEY #############################

# Histogram of year
df %>% qplot(year, binwidth = 5, data = .)

# Descriptive statistics for year
df %>% select(year) %>% summary()
# This the year of the survey, so it might reflect
# historical patterns or events (maybe)

# Density plots of year by group
df%>%
  ggplot(aes(x = year, 
    fill = happy)) + 
  geom_density(alpha = 0.5) +
  facet_grid(happy ~ .) +  # facet_grid
  theme(legend.position = "none")  # Turn off legend

# Boxplots of year by group
df %>%
  ggplot(aes(x = happy, 
    y = year, 
    fill = happy)) + 
  geom_boxplot() +
  coord_flip() +
  xlab("") +
  theme(legend.position = "none")
# No obvious differences

# HAPPINESS AND AGE ########################################

# Histogram of age
df %>% qplot(age, binwidth = 5, data = .)

# Descriptive statistics for age
df %>% select(age) %>% summary()
# Could create general age groups

# Density plots of age by group
df %>%
  ggplot(aes(x = age, 
    fill = happy)) + 
  geom_density(alpha = 0.5) +
  facet_grid(happy ~ .) +  # facet_grid
  theme(legend.position = "none")  # Turn off legend
# Maybe a bulge in "very happy" for people 55-70 years old?

# Boxplots of age by group
df %>%
  ggplot(aes(x = happy, 
    y = age, 
    fill = happy)) + 
  geom_boxplot() +
  coord_flip() +
  xlab("") +
  theme(legend.position = "none")
# No obvious differences

# HAPPINESS AND YEAR BORN ##################################

# Calculate year of birth
df %<>%
  mutate(born = year - age)

# Histogram of born
df %>% qplot(born, binwidth = 5, data = .)

# Descriptive statistics for bon
df %>% select(born) %>% summary()

# Density plots of born by group
df %>%
  ggplot(aes(x = born, 
    fill = happy)) + 
  geom_density(alpha = 0.5) +
  facet_grid(happy ~ .) +  # facet_grid
  theme(legend.position = "none")  # Turn off legend

# Boxplots of born by group
df %>%
  ggplot(aes(x = happy, 
    y = born, 
    fill = happy)) + 
  geom_boxplot() +
  coord_flip() +
  xlab("") +
  theme(legend.position = "none")
# No obvious differences

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
