library(dplyr)
library(shiny)
library(caret)
library(plotly)

shinyServer(function(input, output) {

   starwars$height <- as.numeric(starwars$height)  
   starwarsOmit <- starwars[,c(2,3,9)]
   starwarsOmit <- starwarsOmit[rowSums(is.na(starwarsOmit)) == 0,]
   
   modelFit <- lm(mass ~ height + gender, data = starwars)
   
   output$predmass <- reactive({
       
      genderInput <- input$gender
      heightInput <- input$height
      m <- predict(modelFit, newdata = data.frame(gender = genderInput, height = heightInput))
      m <- round(m,2)
      m <- as.character(m)
   })
   
   modelFit2 <- lm(height ~ mass + gender, data = starwars)
   
   output$predheight <- reactive({
       
       if(input$nas == TRUE) {
           genderInput <- input$gender
           massInput <- input$mass
           n <- predict(modelFit2, newdata = data.frame(gender = genderInput, mass = massInput))
           n <- round(n,2)
           n <- as.character(n)
       }
       else{
           n <- "You didn't select this option"
       }

   })
   
   starwars2 <- starwars
   starwars2 <- starwars[-16,]
   output$plot1 <- renderPlot ({
      
      plot(starwars2$mass, starwars2$height, xlab = "Mass in kg", ylab = "Height in cm",
           col = alpha(ifelse(starwars$gender == "masculine", "blue", "magenta"),0.5), pch = 16)
      legend("bottomright", legend = c("feminine", "masculine"), col = alpha(c("magenta", "blue"),0.5), pch = 16)
      
      x <- input$mass
      y <- input$height
      
      points(x = x, y = y, col = "red", pch = 23, cex = 1.5)
      
      
      if(input$display == TRUE){
         abline(modelFit2, col = "red")
      }
   
      
   })
   
   output$plot2 <- renderPlot({
      par(mfcol = c(1,2))
      boxplot(starwars2$mass ~ starwars2$gender, xlab = "Gender", ylab = "Mass")
      boxplot(starwars2$height ~ starwars2$gender, xlab = "Gender", ylab = "Height")
   })
   
   

})
