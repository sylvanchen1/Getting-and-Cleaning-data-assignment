## Download the data into R
library(plry)
library(data.table)
fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(!file.exits("getdata_projectfiles_UCI HAR Dataset.zip")){
  dir.creat("getdata_projectfiles_UCI HAR Dataset.zip")
}
download.file(fileurl,destfile = "getdata_projectfiles_UCI HAR Dataset.zip", method = "curl")

## Unzip the data file
unzip(zipfile = "getdata_projectfiles_UCI HAR Dataset.zip", exdir = "getdata_projectfiles_UCI HAR Dataset.zip")

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

## read data from the file
path_rf <- file.path("getdata_projectfiles_UCI HAR Dataset.zip")
files <- list.files(path_rf,recursive = TRUE)
files

## Merges the training and the test sets to creat one data set.
## Called the data set "data.set".
data.set <- rbind(data.train, data.test)

## Extracts only the measurements on the mean and standard deviation for each measurement.
mean_std.select <- grep('mean|std', features)
data.sub <- data.set[,c(1,2,mean_std.select + 2)]

## Uses descriptive activity names to name the activities in the data set.
activityLabels <- read.table("getdata_projectfiles_UCI HAR Dataset.zip",header=FALSE)
head(Data$activity,30)

## Appropiately labels the data set with descriptive variable names.
## Change variable names to more appropiate names.
name.new <- names(data.sub)
name.new <- gsub("[(][)]","",name.new)
name.new <- gsub("Acc","Accelerometer",name.new)
name.new <- gsub("Gryo","Gyroscope",name.new)
name.new <- gsub("Mag","Magnitude",name.new)
name.new <- gsub("-mean-","Mean",name.new)
name.new <- gsub("-std-","StandardDeviation",name.new)
name.new <- gsub("^t",Time,name.new)
name.new <- gsub("^f",Frequency,name.new)
names(data.sub) <- name.new
names(data.sub)

## From the data set in step4, creats a second, independent tidy data set with the average of each variablen for each activity and each subject.
names(names)
library(data.table)
Data.table2 <- aggregate(data.sub[,3:81],by = list(activity = data.sub$activity, subject = data.sub$subject), FUN = mean)
write.table(Data.table2,file = "tidydatatable.txt", row.name = FALSE)





