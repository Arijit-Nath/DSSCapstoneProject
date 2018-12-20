library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    
    # Application title
    titlePanel("Predict the next word in English for Capstone Project"),
    
    sidebarPanel(
        helpText("This is demonstration of a simple application to predict the next words based
                 on nGrams text model. User can input a word, phrase or a senence, then it will
                 try to predict the possible next words"),
        hr()
    ),
    
    mainPanel(
        h3("Next Word Prediction"),
        textInput("textInput", "Enter a word, phrase, or sentence"),
        HTML("<h4><I>Possible next word:</I>"),
        # Next 3 predicted words
        textOutput("NextWord"),
        br(),
        br(),
        br()
        
    ),
    # Show the next 3 predicted words in plots
    tabsetPanel(
        tabPanel("main / plot",
                 mainPanel(plotOutput("plot"))))
)
)