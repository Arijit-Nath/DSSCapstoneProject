library(shiny)
library(ggplot2)

source('predict.R')

shinyServer(function(input, output) {
  
        # output$NextWord <- renderText({
        #     if (!is.null(input$textInput)) {
        #         predictWord(input$textInput)
        #     } 
        # })
        # 

        prediction <- reactive({
            words = input$textInput
            prediction = predict(words)})
        
        output$NextWord <- renderText({
            if (!is.null(input$textInput) & !(input$textInput == "")) {
                as.character(paste(prediction()[1:3, ]$last_word[1], 
                             {function(x) if (!is.na(x) & !(x == "NULL")) x else ""} (prediction()[1:3, ]$last_word[2]), 
                             {function(x) if (!is.na(x) & !(x == "NULL")) x else ""} (prediction()[1:3, ]$last_word[3]), 
                             sep = " , ", collapse = NULL))
            } 
        })
        
        output$plot <- renderPlot({
            if (!is.null(input$textInput) & !(input$textInput == "")) {
            pred <- prediction() 
            pred$last_word <- as.character(pred$last_word)
            ggplot(pred, aes(reorder(x=last_word, desc(percent)), y=percent, fill=last_word)) +
                geom_bar(stat="identity") +
                ggtitle("Next 3 predicted words with probabilities") +
                geom_text(aes(label=percent),color = 'blue',vjust=-1) +
                xlab("words") +
                theme_minimal()
            }
        })

})
