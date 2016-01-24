# Text of the books downloaded from:
# A Mid Summer Night's Dream:
#  http://www.gutenberg.org/cache/epub/2242/pg2242.txt
# The Merchant of Venice:
#  http://www.gutenberg.org/cache/epub/2243/pg2243.txt
# Romeo and Juliet:
#  http://www.gutenberg.org/cache/epub/1112/pg1112.txt
#load("modelfinal_featurematrix.RData", envir=.GlobalEnv)
library(plotrix)
function(input, output, session) {
  # Define a reactive expression for the document term matrix
  terms <- reactive({
    # Change when the "update" button is pressed...
    input$update
    # ...but not for anything else
    isolate({
      withProgress({
        setProgress(message = "Processing corpus...")
        getTermMatrix()
      })
    })
  })

  # Make the wordcloud drawing predictable during a session
  wordcloud_rep <- repeatable(wordcloud)

  output$plot <- renderPlot({
    v <- terms()
    
    wordcloud_rep(names(v), v, scale=c(4,0.5),
                  min.freq = input$freq, max.words=input$max,
                  colors=brewer.pal(8, "Dark2"))
  })
  #output$plot2 <- renderPlot({
   # v <- terms()
    #hist_dtm<-create_myhist_matrix(v,language="english",originalMatrix=feature_matrix,removeNumbers=TRUE)
    #hist_pred<-predict(modelfinal,hist_dtm)
    #lbls <- c("Arts", "Business", "Computers","Education", "Health","Recreation","Shopping","Sports") 
    #pie3D(summary(hist_pred),labels=lbls,explode=0.1, main="User Interest Pie Chart")
    
  #})
}