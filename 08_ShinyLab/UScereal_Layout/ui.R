# UScereal: Layout exercise
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
  titlePanel("Layout exercise with UScereal dataset"),

  # Use a grid layout instead of the sidebarLayout
  # so that we can show two plots side by side
  # http://shiny.rstudio.com/articles/layout-guide.html
  fluidRow(

    # Sidebar with a selection input
    column(4,
      wellPanel(
        selectInput("sizeVar",
                    "Size variable:",
                    c("Protein (g)" = "protein",
                      "Sodium (mg)" = "sodium",
                      "Carbohydrates (g)" = "carbo",
                      "Potassium (g)" = "potassium"))
        )
      ),

    # Show the 1st plot
    column(4,
      plotOutput("fibreVsCalories")
    ),
    
    # Show the 2nd plot
    column(4,
      plotOutput("fatVsSugars")
    )
  )
))
