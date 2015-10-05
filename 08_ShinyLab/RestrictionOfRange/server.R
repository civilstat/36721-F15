# Restriction of Range exercise
# server.R
#
# 08 Shiny Lab Session
# Jerzy Wieczorek
# 9/24/15
# 36-721 Statistical Graphics and Visualization


library(shiny)
library(ggplot2)

# Define server logic
shinyServer(function(input, output) {
  
  # Create a random dataset for plotting (once per Shiny session),
  # where Y = 0.5 * X + e,
  # and X and e are both N(0,1)
  n = 1000
  X = rnorm(n)
  Y = 0.5 * X + rnorm(n)
  
  # Use a reactive function to add an indicator to this dataset,
  # for whether or not each row's X value was selected by the slider
  df = reactive({
    included = input$limits[1] < X & X < input$limits[2]
    data.frame(X = X, Y = Y,
               group = factor(included, levels = c(TRUE, FALSE),
                              labels = c("Included", "Excluded")))
  })
  
  # Also use a reactive function to create a subset
  # with just the included rows
  dfIncluded = reactive({
    subset(df(), group == "Included")
  })
  
  # Create the plot, with two regression lines:
  # thin line on full dataset,
  # thick line on Included subset
  output$plot <- renderPlot({
    ggplot(df(), aes(X, Y)) + 
      geom_point(aes(col = group)) + 
      geom_smooth(method = "lm", se = FALSE) + 
      geom_smooth(data = dfIncluded(),
                  method = "lm", se = FALSE, lwd = 2)
  })
})
