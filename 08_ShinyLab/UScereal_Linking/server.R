# UScereal: Linking exercise
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
  
  # Compute an indicator variable for the brushed rows
  brushedObs = reactive({
    # Use the logical OR operator | to decide whether each point
    # was selected by at least one brush
    brushedPoints(UScereal, input$fibreVsCalories_brush,
                               xvar = "calories", yvar = "fibre",
                               allRows = TRUE)$selected_ |
      brushedPoints(UScereal, input$fatVsSugars_brush,
                    xvar = "sugars", yvar = "fat",
                    allRows = TRUE)$selected_
    
  })
  
  # Use our indicator to decide which points
  # are linked and should be highlighted in red
  brushedColors = reactive({
    # Start with all points black
    colorVector = rep('black', nrow(UScereal))
    # Mark the brushed points red instead of black
    colorVector[which(brushedObs())] = 'red'
    return(colorVector)
  })

  # Create the fiber-vs-calories plot
  output$fibreVsCalories <- renderPlot({
    plot(UScereal[, "calories"], UScereal[, "fibre"],
         cex = 5 * UScereal[, input$sizeVar] / sizeVarMax(),
         col = brushedColors(),
         xlab = "Calories", ylab = "Fiber (g)",
         main = paste("US cereal portion contents\n(fiber vs calories)\nwith size proportional to",
                      input$sizeVar))
  })
  
  # Create the fat-vs-sugars plot
  output$fatVsSugars <- renderPlot({
    plot(UScereal[, "sugars"], UScereal[, "fat"],
         cex = 5 * UScereal[, input$sizeVar] / sizeVarMax(),
         col = brushedColors(),
         xlab = "Sugar (g)", ylab = "Fat (g)",
         main = paste("US cereal portion contents\n(fat vs carbs)\nwith size proportional to",
                      input$sizeVar))
  })
  
  # Create a table of all brushed cereals (from either plot);
  # separate names with <br> HTML tag
  # for line breaks between names
  output$info <- renderText({
    paste(rownames(UScereal)[which(brushedObs())],
          collapse = "<br>")
  })
  
})
