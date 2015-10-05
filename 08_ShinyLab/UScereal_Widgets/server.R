# UScereal: Widgets exercise
# server.R
#
# 08 Shiny Lab Session
# Jerzy Wieczorek
# 9/24/15
# 36-721 Statistical Graphics and Visualization


library(shiny)
library(MASS)

# Define server logic
shinyServer(function(input, output) {
  
  output$fibreVsCalories <- renderPlot({
    # Compute max of sizeVar, for rescaling
    sizeVarMax = max(UScereal[, input$sizeVar])

    # Draw the scatterplot,
    # with symbol size proportional to the user-chosen variable
    # (selected in ui.R and passed here as input$sizeVar)
    plot(UScereal[, "calories"], UScereal[, "fibre"],
         cex = 5 * UScereal[, input$sizeVar] / sizeVarMax,
         xlab = "Calories", ylab = "Fiber (g)",
         main = paste("US cereal portion contents\nwith size proportional to",
                      input$sizeVar))
  })
})
