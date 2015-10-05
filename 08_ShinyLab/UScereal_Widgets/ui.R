# UScereal: Widgets exercise
# ui.R
#
# 08 Shiny Lab Session
# Jerzy Wieczorek
# 9/24/15
# 36-721 Statistical Graphics and Visualization


library(shiny)
library(MASS)

# Define UI for application
shinyUI(fluidPage(

  # Application title
  titlePanel("Widgets exercise with UScereal dataset"),

  # Sidebar with a selection input
  sidebarLayout(
    sidebarPanel(
      selectInput("sizeVar",
                  "Size variable:",
                  c("Protein (g)" = "protein",
                    "Fat (g)" = "fat",
                    "Sodium (mg)" = "sodium",
                    "Carbohydrates (g)" = "carbo",
                    "Sugars (g)" = "sugars",
                    "Potassium (g)" = "potassium"))
    ),

    # Show the selected plot of the data
    mainPanel(
      plotOutput("fibreVsCalories")
    )
  )
))
