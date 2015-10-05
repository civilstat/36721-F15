# UScereal: Brushing exercise
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
  
  # Compute max of sizeVar, for rescaling,
  # as a reactive function
  # http://shiny.rstudio.com/tutorial/lesson6/
  sizeVarMax = reactive({
    max(UScereal[, input$sizeVar])
  })

  # Create the fiber-vs-calories plot
  output$fibreVsCalories <- renderPlot({
    plot(UScereal[, "calories"], UScereal[, "fibre"],
         cex = 5 * UScereal[, input$sizeVar] / sizeVarMax(),
         xlab = "Calories", ylab = "Fiber (g)",
         main = paste("US cereal portion contents\n(fiber vs calories)\nwith size proportional to",
                      input$sizeVar))
  })
  
  # Create the fat-vs-sugars plot
  output$fatVsSugars <- renderPlot({
    plot(UScereal[, "sugars"], UScereal[, "fat"],
         cex = 5 * UScereal[, input$sizeVar] / sizeVarMax(),
         xlab = "Sugar (g)", ylab = "Fat (g)",
         main = paste("US cereal portion contents\n(fat vs carbs)\nwith size proportional to",
                      input$sizeVar))
  })
  
  # Create a table of fibre-vs-calories brushed cereals;
  # separate names with <br> HTML tag
  # for line breaks between names
  output$fibreVsCalories_info <- renderText({
    paste(rownames(brushedPoints(UScereal, input$fibreVsCalories_brush,
                                 xvar = "calories", yvar = "fibre")),
          collapse = "<br>")
  })
  
  # Create a table of fat-vs-sugars brushed cereals
  output$fatVsSugars_info <- renderText({
    paste(rownames(brushedPoints(UScereal, input$fatVsSugars_brush,
                                 xvar = "sugars", yvar = "fat")),
          collapse = "<br>")
  })

})
