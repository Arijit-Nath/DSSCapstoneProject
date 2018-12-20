rm(list=ls(all=TRUE))
library(stringr)

##Set up working directory 
gpath2 <- "~/Learning/Data Science Coursera/Data Science Capstone/Week 3/Final/"
setwd(gpath2)

# Load n-Grams data models
df2 <- readRDS("df2.RData")
df3 <- readRDS("df3.RData")
df4 <- readRDS("df4.RData")
df5 <- readRDS("df5.RData")
df6 <- readRDS("df6.RData")

#combining all ngrams
df <- rbind(df2,df3,df4,df5,df6)
rm(df2); rm(df3); rm(df4); rm(df5); rm(df6)
# View(df[1000000:10000100,])
df$words <- sapply(df$Term, function(x) sapply(strsplit(x, " "), length))
# Alternate
# df$words <- sapply(df$Term, function(x) str_count(x, '\\w+'))
# View(df[1:100,])
saveRDS(df, "df.RData")
# df <- readRDS("df.RData")
rm(df)
