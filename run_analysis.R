#Read in all the data

X_test <- read.table("~/X_test.txt", quote="\"", comment.char="")
y_test <- read.table("~/y_test.txt", quote="\"", comment.char="")
features <- read.table("~/features.txt", quote="\"", comment.char="")
activity_labels <- read.table("~/activity_labels.txt", quote="\"", comment.char="")
subject_test <- read.table("~/subject_test.txt", quote="\"", comment.char="")
X_train <- read.table("~/X_train.txt", quote="\"", comment.char="")
y_train <- read.table("~/y_train.txt", quote="\"", comment.char="")
subject_train <- read.table("~/subject_train.txt", quote="\"", comment.char="")

# First with the test data :
  #Put ids into frames
datFeatTest <- X_test
names(datFeatTest) <- features$V2
colnames(activity_labels) = c("act_id","act_desc")
colnames(y_test) = c("act_id")
colnames(subject_test) <- c("subject_id")
  # Merge and combine activity and then the data 
datActTest <- merge(activity_labels,y_test,by="act_id",all.x = TRUE)
datTest <- cbind(subject_test,y_test,datFeatTest)
datTestFinal <- merge(activity_labels,datTest,by="act_id",all.x = TRUE)
# Then with train data
datFeatTrain <- X_train
names(datFeatTrain) <- features$V2
colnames(y_train) = c("act_id")
colnames(subject_train) <- c("subject_id")
# Merge and combine activity and then the data 
datActTrain <- merge(activity_labels,y_train,by="act_id",all.x = TRUE)
datTrain <- cbind(subject_train,y_train,datFeatTrain)
datTrainFinal <- merge(activity_labels,datTrain,by="act_id",all.x = TRUE)

# Select the columns we are interested in
selColMean <- grep(c("mean"),colnames(datFinal),value=TRUE)
selColstd <- grep(c("std"),colnames(datFinal),value=TRUE)
selRestCols <- colnames(datFinal)[1:3] # plus the activity and subject columns
selColsFinal <- c(selRestCols,selColMean,selColstd) # final vector of columns we need
datFinalSel <- datFinal[,selColsFinal] # this is the data tidy data set!
# Write the tidy set to a txt file
write.table(datFinalSel, "TidyData.txt", row.name=FALSE)
# Data set with the average of each variable for each activity and each subject
fs <- aggregate(.~act_id+act_desc+subject_id,data=datFinalSel,FUN='mean')

#Write the final tidy data set with aggregated data
write.table(fs, "TidyData2.txt", row.name=FALSE)
