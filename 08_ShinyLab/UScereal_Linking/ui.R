# UScereal: Linking exercise
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
  titlePanel("Linking exercise with UScereal dataset"),

  # Use a grid layout instead of the sidebarLayout
  # so that we can show two plots side by side
  # and selected cereals below
  # http://shiny.rstudio.com/articles/layout-guide.html
  
  # In first row, show sidebar and the two plots
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

    # Show the 1st plot,
    # and allow brushing
    # http://shiny.rstudio.com/articles/selecting-rows-of-data.html
    column(4,
      plotOutput("fibreVsCalories", brush = "fibreVsCalories_brush")
    ),
    
    # Show the 2nd plot, and allow brushing
    column(4,
      plotOutput("fatVsSugars", brush = "fatVsSugars_brush")
    )
  ),
  
  # In a 2nd row below the sidebar and plots,
  # show the cereal names of the brushed points
  # http://shiny.rstudio.com/articles/selecting-rows-of-data.html
  fluidRow(
    column(4, offset = 7,
      strong("Selected cereals:"),
      # Display as htmlOutput, not textOutput,
      # so that the line break tags <br> are interpreted
      htmlOutput("info")
    )    
  )
))
