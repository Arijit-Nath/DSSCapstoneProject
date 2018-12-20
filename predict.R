rm(list=ls(all=TRUE))
library(dplyr)
# setwd("~/Learning/Data Science Coursera/Data Science Capstone/Week 3/Final")
# example to test
# input <- "The guy in front of me just bought a pound of bacon, a bouquet, and a case of"
# input1 <- "This is it"
df <- readRDS("data/df.RData")
predict <- function(input){
    # convert to lower case
    hint <- tolower(input) 
    # remove punctuation 
    # hint to be used to search by original string
    hint <- gsub('[[:punct:] ]+',' ',hint)
    # Trim Leading & Trailing white spaces from the input string
    hint <- trimws(hint)
    input_length <- sapply(strsplit(hint, " "), length)
    if(input_length > 6) {
        # hint1 will be at most of 5 words, e.g. "banquet and a case of"
        hint1 <- paste0(tail(strsplit(hint, split=" ")[[1]], 5), 
                        collapse = ' ')    
        # hint12 will be at most of 4 words, e.g. "and a case of"
        hint2 <- paste0(tail(strsplit(hint, split=" ")[[1]], 4), 
                        collapse = ' ')
        # hint3 will be at most of 3 words, e.g. "a case of"
        hint3 <- paste0(tail(strsplit(hint, split=" ")[[1]], 3), 
                        collapse = ' ')
        # hint4 will be at most of 2 words, e.g. "case of"
        hint4 <- paste0(tail(strsplit(hint, split=" ")[[1]], 2), 
                        collapse = ' ')
        # hint5 will be at most of 1 words, e.g. "of"
        hint5 <- paste0(tail(strsplit(hint, split=" ")[[1]], 1), 
                        collapse = ' ') 
    } else {
        if (input_length > 1) {
            length_count <- input_length - 1
            counter = 0
            for (i in c(length_count:1)) {
                counter <- counter + 1
                # construct dynamic hint variable
                varname <- paste0("hint", counter)
                # assign hint value to the dynamic variable
                assign(varname, paste0(tail(strsplit(hint, split=" ")[[1]], i), 
                                       collapse = ' '))
            }       
        }
    }
  
    
    df1 <- subset(df, Hint == hint) #creating custom dataframe of just the userentry
    num_words1 <- sapply(strsplit(hint, " "), length)
    if (exists("hint1")) {
        df2 <- subset(df, Hint == hint1) 
        num_words2 <- sapply(strsplit(hint1, " "), length)
    } 
    if(exists("hint2")){
        df3 <- subset(df, Hint == hint2) 
        num_words3 <- sapply(strsplit(hint2, " "), length)
    } 
    if(exists("hint3")){
        df4 <- subset(df, Hint == hint3)   
        num_words4 <- sapply(strsplit(hint3, " "), length)
    }
    if(exists("hint4")){
        df5 <- subset(df, Hint == hint4)  
        num_words5 <- sapply(strsplit(hint4, " "), length)
    }
    if(exists("hint5")){
        df6 <- subset(df, Hint == hint5)  
        num_words6 <- sapply(strsplit(hint5, " "), length)
    }
    
    if(exists("df1") && nrow(df1) > 0 && num_words1 >= 1)  {
        custom_df <- df1 %>% 
            arrange(desc(Frequency))  %>%
            mutate(percent = round(Frequency / sum(Frequency) * 100,1)) %>%
            mutate(last_word = lapply(strsplit(as.character(Term), split=" "), tail, n=1))
        # Return top 3 results
        result <- head(custom_df, 3)  
    }
    else if (exists("df2") && nrow(df2) > 0 && num_words2 >= 1)  {
        custom_df <- df2 %>% 
            arrange(desc(Frequency))  %>%
            mutate(percent = round(Frequency / sum(Frequency) * 100,1)) %>%
            mutate(last_word = lapply(strsplit(as.character(Term), split=" "), tail, n=1))
        # Return top 3 results
        result <- head(custom_df, 3)  
    }
    else if (exists("df3") && nrow(df3) > 0 && num_words3 >= 1) {
        custom_df <- df3 %>% 
            arrange(desc(Frequency))  %>%
            mutate(percent = round(Frequency / sum(Frequency) * 100,1)) %>%
            mutate(last_word = lapply(strsplit(as.character(Term), split=" "), tail, n=1))
        # Return top 3 results
        result <- head(custom_df, 3)
    }
    else if (exists("df4") && nrow(df4) > 0 && num_words4 >= 1) {
        custom_df <- df4 %>% 
            arrange(desc(Frequency))  %>%
            mutate(percent = round(Frequency / sum(Frequency) * 100,1)) %>%
            mutate(last_word = lapply(strsplit(as.character(Term), split=" "), tail, n=1))
        # Return top 3 results
        result <- head(custom_df, 3)
    }
    
    else if (exists("df5") && nrow(df5) > 0 && num_words5 >= 1) {
        custom_df <- df5 %>% 
            arrange(desc(Frequency))  %>%
            mutate(percent = round(Frequency / sum(Frequency) * 100,1)) %>%
            mutate(last_word = lapply(strsplit(as.character(Term), split=" "), tail, n=1))
        # Return top 3 results
        result <- head(custom_df, 3)
    }
    
    else if (exists("df6") && nrow(df6) > 0 && num_words6 >= 1) {
        custom_df <- df6 %>% 
            arrange(desc(Frequency))  %>%
            mutate(percent = round(Frequency / sum(Frequency) * 100,1)) %>%
            mutate(last_word = lapply(strsplit(as.character(Term), split=" "), tail, n=1))
        # Return top 3 results
        result <- head(custom_df, 3)
    }
    # If nothing found, return "the" as it is most frequent
    else{result <- data.frame("Term" = input, "Frequency" = 0, "Hint" = 0, "words" = input_length,
                              "percent" = 0, "last_word" = "the")}
    return(result)
}


predictWord <- function(input){
    predDf <- predict(input)
    # return the next words
    result <- unlist(predDf[1,6])
    return(result)
}

# Test
# predict(input)
# predict(input2)