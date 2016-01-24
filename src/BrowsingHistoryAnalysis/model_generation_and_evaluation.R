library(tm)
library(slam)
colTotals <-  col_sums(myDTM)

#edit below line according to required frequency
dtm2 <- myDTM[,which(colTotals >0)]
#dim(dtm2)

library(caret)
set.seed(325)
inTrain <- createDataPartition(y=unskewed_data$class_label,
                               p=0.7, list=FALSE)

library("e1071")

feature_matrix<-dtm2[inTrain,]
y_label<-unskewed_data$class_label[inTrain]

#generating model using linear kernel svm
model<-svm(feature_matrix,y_label,cost=1,kernel="linear")

#for saving model
save(model, file = "linear_cost1_svm_1.6lakhterms.rda")

#training prediction
total_pred<-predict(model,feature_matrix)
confusionMatrix(total_pred,y_label)

#testing pred
testing_data<-dtm2[-inTrain,]
correct_y_label<-unskewed_data$class_label[-inTrain]
test_pred<-predict(model,testing_data)
confusionMatrix(test_pred,correct_y_label)


