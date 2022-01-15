library(data.table)
library(dplyr)

olddir <- getwd()
setwd("UCI HAR Dataset")

featureNames <- fread("features.txt")
featureNames <- featureNames$V2

XTrain <- fread("train/X_train.txt")
YTrain <- fread("train/y_train.txt")
SubTrain <- fread("train/subject_train.txt")

DfTrain <- cbind(SubTrain,YTrain,XTrain)

XTest <- fread("test/X_test.txt")
YTest <- fread("test/y_test.txt")
SubTest <- fread("test/subject_test.txt")

DfTest <- cbind(SubTest,YTest,XTest)

DfMerged <- rbind(DfTrain,DfTest)
colnames(DfMerged) <- c("Subject","Activity",featureNames)
colIdx <- grep("mean|std",colnames(DfMerged))
DfMnSd <- select(DfMerged,1,2,colIdx)

colnames(DfMnSd) <- gsub("-|\\()","",colnames(DfMnSd))
DfMnSd <- mutate(DfMnSd,Activity = recode(Activity,'1' = "WALKING",
                                           '2' = "WALKING_UPSTAIRS",
                                           '3' = "WALKING_DOWNSTAIRS",
                                           '4' = "SITTING",
                                           '5' = "STANDING",
                                           '6' = "LAYING"))


DfMnSd <- group_by(DfMnSd,Subject,Activity)
TidyData <- summarise(DfMnSd,across(everything(),
                                    list(mean = mean,sd = sd)))

setwd(olddir)

fwrite(TidyData,file = "TidyData.csv")