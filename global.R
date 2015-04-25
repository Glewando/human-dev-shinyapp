library(dplyr)
library(shiny)
library(googleVis)
#library(googleCharts)


# Read in data
data <- readRDS("data/HumDevCountryRegion.rds")

# set up world regions for color-by
data$Region <- as.factor(data$PrimaryRegion)



colnames(data) <-
       c("Country",
          "Human Development Rank",
          "Human Development Index",
          "Life Expectancy",
          "Education Index",
          "GNI Index",
          "Human Development Group",
          "PrimaryRegion",
          "Region")









