#loading the required packages
library(data.table)
library(dplyr)

#changing directory to read files
olddir <- getwd()
setwd("UCI HAR Dataset")

#reading datasets
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

#Merging the train and test sets
DfMerged <- rbind(DfTrain,DfTest)

#Labelling the variables
colnames(DfMerged) <- c("Subject","Activity",featureNames)

#Selecting the mean and std readings from variables
colIdx <- grep("mean|std",colnames(DfMerged))
DfMnSd <- select(DfMerged,1,2,colIdx)

#Renaming the variables to remove hyphens, paranthesis
colnames(DfMnSd) <- gsub("-|\\()","",colnames(DfMnSd))

#Naming the activities
DfMnSd <- mutate(DfMnSd,Activity = recode(Activity,'1' = "WALKING",
                                           '2' = "WALKING_UPSTAIRS",
                                           '3' = "WALKING_DOWNSTAIRS",
                                           '4' = "SITTING",
                                           '5' = "STANDING",
                                           '6' = "LAYING"))


#Taking the mean and std of the selected variables for each subject and activity
DfMnSd <- group_by(DfMnSd,Subject,Activity)
TidyData <- summarise(DfMnSd,across(everything(),
                                    list(mean = mean,sd = sd)))

#going back to the original directory
setwd(olddir)

#writing the tidy data onto a file
write.table(TidyData,file = "TidyData.txt",row.names = F)