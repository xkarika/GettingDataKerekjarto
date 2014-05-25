############# Preparing the training and test data sets ###############################################
#read in the training set related tables along with activity_lables
y_train_labels <- read.table("./data/UCI HAR DATASET/train/y_train.txt", header=FALSE, sep="")
X_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt", header=FALSE, sep="")
activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt", header=FALSE, sep="")

#adding column names to tables
colnames(y_train_labels) <- c("id")
colnames(activity_labels) <- c("id", "activity_name")

#join/mash the activity labels with the y_train_lables to be able to assign descriptive activity names to the train dataset
#use plyr library join function to keep the order of rows in y_train_labels (merge function does not retain order)
library(plyr)
y_train_labels_new <- join(y_train_labels,activity_labels, type="left", by="id")

#read in features txt file to serve as column names/labels for the X_train data set
features <- read.table("./data/UCI HAR Dataset/features.txt", sep="", header=FALSE)

#set the X_train dataset header (column names) to the features list
colnames(X_train) <- features$V2

#add the acivity names as row labels to the X_train set (from the y_train_labels_new)
y_train_final <-cbind(y_train_labels_new$activity_name, X_train)
#change name of first column to activity_name
names(y_train_final)[1] <- "activity_name"


#read in subjects from train-subjects
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)
#add subjects to training data set and name its column "subject"
y_train_final <- cbind(subject_train, y_train_final)
names(y_train_final)[1] <- "subject"

######################################################## Test ##############################
#read in the test set related tables 
y_train_labels <- read.table("./data/UCI HAR DATASET/train/y_train.txt", header=FALSE, sep="")
X_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt", header=FALSE, sep="")

#adding column names to tables
colnames(y_train_labels) <- c("id")

#join/mash the activity labels with the y_train_lables to be able to assign descriptive activity names to the train dataset
y_test_labels_new <- join(y_test_labels,activity_labels, type="left", by="id")

#set the X_test dataset header (column names) to the features list
colnames(X_test) <- features$V2

#add the acivity names as row labels to the X_test set (from the y_test_labels_new)
y_test_final <-cbind(y_test_labels_new$activity_name, X_test)
#change name of first column to activity_name
names(y_test_final)[1] <- "activity_name"

#read in subjects from test-subjects
subject_test<- read.table("./data/UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)
#add subjects to training data set and name its column "subject"
y_test_final <- cbind(subject_test, y_test_final)
names(y_test_final)[1] <- "subject"

############################ Merging the test and train data sets #########################################
selected <- c(colnames(combined_set)[1:2],grep("mean", colnames(combined_set), value=TRUE),grep("std", colnames(combined_set), value=TRUE) )
final_combined_set <- combined_set[,c(selected)]



