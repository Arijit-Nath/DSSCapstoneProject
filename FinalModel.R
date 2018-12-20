rm(list=ls(all=TRUE))

library(quanteda)
library(stringr)


setwd("~/Learning/Data Science Coursera/Data Science Capstone/Week 3/Final")
gpath1 <- "~/Learning/Data Science Coursera/Data Science Capstone/data/"

blogsPath <- paste0(gpath1, "en_US.blogs.txt")
twitPath <- paste0(gpath1, "en_US.twitter.txt")
newsPath <- paste0(gpath1, "en_US.news.txt")
bwPath <- paste0(gpath1, "badwords.txt")

blogs <- readLines(blogsPath, encoding = "UTF-8", skipNul = TRUE)
news <- readLines(newsPath, encoding = "UTF-8", skipNul = TRUE)
twitter <- readLines(twitPath, encoding = "UTF-8", skipNul = TRUE)
badWords <- readLines(bwPath, encoding = "UTF-8", skipNul = TRUE)


allData <- c(blogs,news,twitter)

rm(blogs)
rm(news)
rm(twitter)

set.seed(0)
sampleData = sample(allData, length(allData) * .5)
rm(allData)

if (!file.exists("token1.RData")) {
    token1 <- tokens(sampleData, remove_numbers = TRUE, remove_punct = TRUE, remove_symbols = TRUE,
                     remove_separators = TRUE, remove_twitter = TRUE, remove_hyphens = TRUE)
    token1 <- tokens_tolower(token1)
    token1 <-  tokens_select(token1, badWords, selection = "remove" )
    saveRDS(token1, "token1.RData")  
} else {
    token1 <- readRDS("token1.RData")
}
rm(sampleData)
rm(badWords)

##########2 - Gram########
mydf2<-dfm(token1,ngrams=2,concatenator = " " )
mydf2<-dfm_trim(mydf2, min_termfreq = 10, min_docfreq = 2)
# View(mydf2[1:100,1:20])
# dim(mydf2)

df2 <- data.frame(Term = featnames(mydf2), Frequency = colSums(mydf2),
                  Hint = sub("^\\s*((?:\\S+\\s+){0}\\S+).*", "\\1", featnames(mydf2)), 
                  stringsAsFactors = FALSE, row.names = NULL)
df2<-df2[order(df2$Frequency,decreasing=TRUE),]
# View(df2[1:100,])
# dim(df2)
saveRDS(mydf2,"mydf2.RData")
saveRDS(df2,"df2.RData")
rm(mydf2); rm(df2)

##########
# df2tm <- mydf2[1:100,]
# df2_tm <- data.frame(Term = featnames(df2tm), Frequency = colSums(df2tm),
#                   Hint = sapply(strsplit(featnames(df2tm),split=" "), function(x) tail(x[[1]],1)), 
#                   stringsAsFactors = FALSE, row.names = NULL)
# df2_tm<-df2_tm[order(df2_tm$Frequency,decreasing=TRUE),]
# rm(df2tm)
##########


##########3 - Gram########
mydf3<-dfm(token1,ngrams=3,concatenator = " " )
mydf3<-dfm_trim(mydf3, min_termfreq = 6, min_docfreq = 2)
# View(mydf3[1:100,1:20])
# dim(mydf3)
df3 <- data.frame(Term = featnames(mydf3), Frequency = colSums(mydf3),
                    Hint = sub("^\\s*((?:\\S+\\s+){1}\\S+).*", "\\1", featnames(mydf3)), 
                    stringsAsFactors = FALSE, row.names = NULL)
df3<-df3[order(df3$Frequency,decreasing=TRUE),]
# View(df3[1:100,])
# dim(df3)
saveRDS(mydf3,"mydf3.RData")
saveRDS(df3,"df3.RData")
rm(mydf3); rm(df3)


######
# df3tm <- mydf3[1:20,1:100]
# df3_tm <- data.frame(Term = featnames(df3tm), Frequency = colSums(df3tm),
#                   Hint = sapply(strsplit(featnames(df3tm),split=" "), function(x) tail(x[[1]], 3)),
#                   stringsAsFactors = FALSE, row.names = NULL)
# View(df3_tm[1:20,])

##########4 - Gram########
mydf4<-dfm(token1,ngrams=4,concatenator = " " )
mydf4<-dfm_trim(mydf4, min_termfreq = 3, min_docfreq = 2)
# View(mydf4[1:100,1:20])
# dim(mydf4)
df4 <- data.frame(Term = featnames(mydf4), Frequency = colSums(mydf4),
                  Hint = sub("^\\s*((?:\\S+\\s+){2}\\S+).*", "\\1", featnames(mydf4)), 
                  stringsAsFactors = FALSE, row.names = NULL)
df4<-df4[order(df4$Frequency,decreasing=TRUE),]
# View(df4[1:100,])
# dim(df4)
saveRDS(mydf4,"mydf4.RData")
saveRDS(df4,"df4.RData")
rm(mydf4); rm(df4)


##########5 - Gram########
mydf5<-dfm(token1,ngrams=5,concatenator = " " )
mydf5<-dfm_trim(mydf5, min_termfreq = 2, min_docfreq = 2)
# View(mydf5[1:100,1:20])
# dim(mydf5)
df5 <- data.frame(Term = featnames(mydf5), Frequency = colSums(mydf5),
                  Hint = sub("^\\s*((?:\\S+\\s+){3}\\S+).*", "\\1", featnames(mydf5)), 
                  stringsAsFactors = FALSE, row.names = NULL)
df5<-df5[order(df5$Frequency,decreasing=TRUE),]
# View(df5[1:100,])
# dim(df5)
saveRDS(mydf5,"mydf5.RData")
saveRDS(df5,"df5.RData")
rm(mydf5); rm(df5)


##########6 - Gram########
mydf6<-dfm(token1,ngrams=6,concatenator = " " )
mydf6<-dfm_trim(mydf6, min_termfreq = 2, min_docfreq = 2)
# View(mydf6[1:100,1:20])
# dim(mydf6)
df6 <- data.frame(Term = featnames(mydf6), Frequency = colSums(mydf6),
                  Hint = sub("^\\s*((?:\\S+\\s+){4}\\S+).*", "\\1", featnames(mydf6)), 
                  stringsAsFactors = FALSE, row.names = NULL)
df6<-df6[order(df6$Frequency,decreasing=TRUE),]
# View(df6[1:100,])
# dim(df6)
saveRDS(mydf6,"mydf6.RData")
saveRDS(df6,"df6.RData")
rm(mydf6); rm(df6)

rm(token1)
