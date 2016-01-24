library(tm)
colnames(unskewed_data)<-c("title","no","label","url")
colnames(unskewed_data)

myCorpus = Corpus(VectorSource(unskewed_data$title))
#class(myCorpus)
#myCorpus = Corpus(VectorSource(sample))
myCorpus=tm_map(myCorpus,stripWhitespace)
myCorpus = tm_map(myCorpus, content_transformer(tolower))
myCorpus = tm_map(myCorpus, removePunctuation)
myCorpus = tm_map(myCorpus, removeNumbers)
myCorpus = tm_map(myCorpus, removeWords, stopwords("english"))
myCorpus=tm_map(myCorpus,stripWhitespace)

#myCorpus=tm_map(myCorpus,stemDocument)

#write.csv(file="chrome_history_wbt.csv",x=chrome_history)
#writeCorpus(myCorpus)

#stemmedcol=wordStem(training$Title)

myCorpus <- tm_map(myCorpus, PlainTextDocument)
#myDTM = DocumentTermMatrix(corpus_clean, control = list(minWordLength = 1))
myDTM=DocumentTermMatrix(myCorpus)

#mydtm_hist=DocumentTermMatrix(tweets.text.corpus)


library(tm)
library(slam)
colTotals <-  col_sums(myDTM)

#colTotals<-col_sums(dtMatrix)
#colTotals
dtm2 <- myDTM[,which(colTotals >0)]

#dim(dtm2)

