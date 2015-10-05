# Restriction of Range exercise
# ui.R
#
# 08 Shiny Lab Session
# Jerzy Wieczorek
# 9/24/15
# 36-721 Statistical Graphics and Visualization


library(shiny)
library(ggplot2)

# Define UI for application
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Restriction of Range exercise with random dataset"),
  
  # Sidebar with a selection input
  sidebarLayout(
    sidebarPanel(
      sliderInput("limits",
                  "Restriction of range:",
                  min = -5, max = 5, value = c(-2, 5), step=.1)
    ),
    
    # Show the selected plot of the data
    mainPanel(
      plotOutput("plot")
    )
  )
))
