library(shiny)
library(tm)
library(stylo)
library(data.table)
library(RWeka)
library(stringr)
library(dplyr)

source('myLib.R')

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Data Science Capstone Project - Word Prediction Application"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
        h3("User Input Panel"),
        br(),
        
        strong(""),
        textInput("txtInputPhrase", "Enter a phrase below:", value = "i would like to read"),
        br(),
        
        strong("Click the button below to predict next word:"),br(),
        actionButton("btnSubmit", "Submit")
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
        h3("Output:"),
        br(),
        br(),
        
        span ('Input Phrase:'),
        verbatimTextOutput("txtOutputPhrase"),
        br(),
        
        span('Next possible word:'),
        verbatimTextOutput("txtPredictedWord")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  # Display input phrase
  getInputPhrase <- eventReactive(input$btnSubmit, {
    paste(input$txtInputPhrase)
  })
  output$txtOutputPhrase <- renderText({ getInputPhrase() })
  
  # Diplay predicted word
  getNextWordPrdicted <- eventReactive(input$btnSubmit, {
    predictNextWord(input$txtInputPhrase)
  })
  output$txtPredictedWord <- renderText({ getNextWordPrdicted() })

}

# Run the application 
shinyApp(ui = ui, server = server)

