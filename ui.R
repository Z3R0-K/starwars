library(shiny)

shinyUI(fluidPage(

   titlePanel("Star Wars"),
       
    
       sidebarLayout(
             
             sidebarPanel(
                   selectInput("gender", "Select a Gender", choices = list("masculine", "feminine"), selected = "masculine", multiple = FALSE),
                   sliderInput("height", "Select a Height in cms", 66, 234, value = 180),
                   sliderInput("mass", "Select a Mass in kg", 15, 250, value = 100),
                   
                   checkboxInput("nas", "Show Predicted Height", value = TRUE),
                   h3("Predicted Mass:"),
                   textOutput("predmass"),
                   h3("Predicted Height:"),
                   textOutput("predheight"),
                   
                   h1("Plot Control"),
                   checkboxInput("display", "Show Prediction Model", value = TRUE),
                ),
              
           
           
           mainPanel(
              tabsetPanel(
                 tabPanel("Height vs Mass", plotOutput("plot1")),
                 tabPanel("Gender", plotOutput("plot2")),
              ),
              
           )
       )
   
   
))


## Somehow incorporate widgets 
