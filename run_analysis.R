## GaC_Data Course Project

library(lubridate)

## Download data and unzip it
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, destfile = "./Dataset.zip", mode="wb")
downloadTime <- paste("Download time:", now())
downloadTime

unzip("Dataset.zip", exdir = ".")
dir(recursive = TRUE)


## Read the test and train data sets and combine them into "df"
##  "UCI HAR Dataset/test/X_test.txt"
##  "UCI HAR Dataset/train/X_train.txt"

df_test <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)
df_train <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)

df <- rbind(df_test, df_train)

## Extracts only the measurements on the mean and standard deviation for each measurement.
## 1 Read features table
## 2 find rows with mean and std, which are columns corresponding to
##   the mean and standard deviation of measurements in "df"
## 3 subset df with these columns to generate "df_mean_std""

library(dplyr)

features <- read.table("UCI HAR Dataset/features.txt")
cols <- grep("mean\\(|std\\(", features$V2)

df_mean_std <- select(df, cols)

## Appropriately labels the data set with descriptive variable names.
##  1  Get the activity names from features table
##  2  Remove the () in the activity names
##  3  Label the columns

colHeaders <- features[cols, 2]
colHeaders <- sub("\\()", "", colHeaders)
colnames(df_mean_std) <- colHeaders

## Uses descriptive activity names to name the activities in the data set
##  1 Read activity list
##     "UCI HAR Dataset/test/y_test.txt"
##     "UCI HAR Dataset/train/y_train.txt"
##  2 Combine the two into one, "act"
##  3 Read activity labels
##     "UCI HAR Dataset/activity_labels.txt"
##  4 Replace activity numbers with descriptive activity names
##  5 Insert "act"" as a new colume into df_mean_std

act_test <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
act_train <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
act <- rbind(act_test, act_train)

act_label <- read.table("UCI HAR Dataset/activity_labels.txt")

act$V1 <- act_label$V2[as.numeric(act$V1)]
colnames(act) <- "Activity"

df_mean_std <- cbind(act, df_mean_std)

## From the data set in step 4, creates a second, independent tidy data set
## with the average of each variable for each activity and each subject.
## 1  Read subject lists and combine into one, "subject"
##    "UCI HAR Dataset/test/subject_test.txt"
##    "UCI HAR Dataset/train/subject_train.txt"
## 2  Insert subject as a new column into df_mean_df

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
subject <- rbind(subject_test, subject_train)
colnames(subject) <- "Subject"

df_mean_std <- cbind(subject, df_mean_std)

## 3  Calculate the mean of variables for each subject and acrivity, write out
##    the new data set as  "new_dataset.txt"

if(exists("new_df")) rm("new_df")

for (i in 3:ncol(df_mean_std)) {
      tmp <- tapply(df_mean_std[, i], list(df_mean_std$Subject, df_mean_std$Activity), mean)
      tmp <- cbind(c(1:30), c(names(df_mean_std)[i]), tmp)

      if(!exists("new_df")) {
            new_df <- tmp
      }
      else {
            new_df <- rbind(new_df, tmp)
      }
}

colnames(new_df)[1:2] <- c("Subject", "Variable")

write.table(new_df, file = "new_dataset.txt", row.names = FALSE)
