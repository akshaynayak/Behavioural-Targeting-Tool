#aFile = readLines(classification)

library(tm)
#colnames(finalcsv)<-c("no","url","title","class_label")
#colnames(unskewed_data)

chrome_history<-chrome_history[chrome_history$title != "",]
Corpus = Corpus(VectorSource(chrome_history$title))
class(myCorpus)

Corpus=tm_map(Corpus,stripWhitespace)
Corpus = tm_map(Corpus, content_transformer(tolower))
Corpus = tm_map(Corpus, removePunctuation)
Corpus = tm_map(Corpus, removeNumbers)
Corpus = tm_map(Corpus, removeWords, stopwords("english"))

Corpus1=tm_map(Corpus1,stripWhitespace)

myCorpus=tm_map(myCorpus,stemDocument)


#writeCorpus(myCorpus)

#stemmedcol=wordStem(training$Title)

Corpus1 <- tm_map(Corpus1, PlainTextDocument)
#myDTM = DocumentTermMatrix(corpus_clean, control = list(minWordLength = 1))

mydtm_hist <- create_myhist_matrix(Corpus1, originalMatrix=feature_matrix,removeNumbers=TRUE,language="english")
#mydtm_hist=DocumentTermMatrix(Corpus1)

predicted_interests=predict(model,mydtm_hist)
summary(predicted_interests)

#plotting a wordcloud of the most prominent words in titles of users history
library("wordcloud")
wordcloud(Corpus1,min.freq = 2, scale=c(8,0.3),colors=brewer.pal(8, "Dark2"),  random.color= TRUE, random.order = FALSE, max.words = 150)






