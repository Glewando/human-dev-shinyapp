# Load all libraries needed for both ui.r and server.r

library(dplyr)
library(shiny)
library(googleVis)

# Read in data
data <- readRDS("data/HumDevCountryRegion.rds")
# change columns names to user-friendly names
colnames(data) <-
       c("Country",
          "Human Development Rank",
          "Human Development Index",
          "Life Expectancy",
          "Education Index",
          "GNI Index",
          "Human Development Group",
          "Region")









