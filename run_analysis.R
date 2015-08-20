# set working directory
setwd("/Users/Air/spec-repo/GetCleanData/CourseProject")

# load libraries
library(plyr)
library(data.table)

# download data
if (!file.exists("UCI HAR Dataset")) {
        # download the data
        fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        zipfile="UCI_HAR_data.zip"
        message("Downloading data")
        download.file(fileURL, destfile=zipfile, method="curl")
        unzip(zipfile)
}

# read metadata from appropriate tables 
Names.x         <- read.table("UCI HAR Dataset/features.txt")
Labels.y        <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)

# read training and test data corresponding to subject and merge them
Train.Subject   <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
Test.Subject    <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
Subject         <- rbind(Train.Subject, Test.Subject)

# read training and test data corresponding to activity and merge them
Train.y         <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
Test.y          <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
Activity        <- rbind(Train.y, Test.y)

# read training and test data corresponding to features and merge them
Train.x         <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
Test.x          <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)
Features        <- rbind(Train.x, Test.x)

# column names can be obtained from the metadata in Names.x
colnames(Features) <- t(Names.x[2])

# naming Activity and Subject columns  
colnames(Activity) <- "Activity"
colnames(Subject) <- "Subject"

# Part 1
# merging all data
TotalData <- cbind(Features,Activity,Subject)

# column with either mean or standard deviation

ColMeanStd.Init <- grep(".*Mean.*|.*Std.*", names(TotalData), ignore.case=TRUE)

# add subject and activity columns
ColMeanStd.Fin <- c(ColMeanStd.Init, 562, 563)

# Part 2
# subset data with mead or standard deviation
SubsetData <- TotalData[,ColMeanStd.Fin]

# Part 3
# change from numeric to character
SubsetData$Activity <- as.character(SubsetData$Activity)
# updates akctivity with descriptive activity names
for (i in 1:6){
        SubsetData$Activity[SubsetData$Activity == i] <- as.character(Labels.y[i,2])
}
# after activity names are updated, factor the activity variable
SubsetData$Activity <- as.factor(SubsetData$Activity)


# Part 4
# Appropriately labels the data set with descriptive variable names. 
names(SubsetData)

names(SubsetData)<-gsub("Acc", "Accelerometer", names(SubsetData))
names(SubsetData)<-gsub("Gyro", "Gyroscope", names(SubsetData))
names(SubsetData)<-gsub("BodyBody", "Body", names(SubsetData))
names(SubsetData)<-gsub("Mag", "Magnitude", names(SubsetData))
names(SubsetData)<-gsub("tBody", "TimeBody", names(SubsetData))
names(SubsetData)<-gsub("angle", "Angle", names(SubsetData))
names(SubsetData)<-gsub("gravity", "Gravity", names(SubsetData))
names(SubsetData)<-gsub("-mean()", "Mean", names(SubsetData), ignore.case = TRUE)
names(SubsetData)<-gsub("-std()", "StandardDeviation", names(SubsetData), ignore.case = TRUE)
names(SubsetData)<-gsub("-freq()", "Frequency", names(SubsetData), ignore.case = TRUE)
names(SubsetData)<-gsub("^t", "Time", names(SubsetData))
names(SubsetData)<-gsub("^f", "Frequency", names(SubsetData))

names(SubsetData)

# Part 5. 
# From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject 
FinalData<-ddply(SubsetData, c("Subject","Activity"), numcolwise(mean))
#improve column names
FinalDataHeaders<-names(FinalData)
# Funcion addsuffix
addSuffix<- function(x, suffix) {
        if (!(x %in% c("Subject","Activity"))) {
                paste(x,suffix, sep="")
        }
        else{
                x
        }
}
# add suffix to column names
FinalDataHeaders<-sapply(FinalDataHeaders, addSuffix, ".mean")
names(FinalData)<-FinalDataHeaders
# write table tidy_data.txt
write.table(FinalData, file = "tidy_data.txt", row.name=FALSE)
