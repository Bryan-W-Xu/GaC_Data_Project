# GaC_Data Course Project

# CookBook

## Data Tranformation



0. Download data and unzip it

The data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones




```r
  library(lubridate)
```

```
## 
## Attaching package: 'lubridate'
```

```
## The following object is masked from 'package:base':
## 
##     date
```

```r
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, destfile = "./Dataset.zip", mode="wb")
  downloadTime <- paste("Download time:", now())
  downloadTime
```

```
## [1] "Download time: 2017-01-15 22:31:55"
```

```r
  unzip("Dataset.zip", exdir = ".")
  dir(recursive = TRUE)
```

```
##  [1] "CodeBook.html"                                               
##  [2] "CodeBook.md"                                                 
##  [3] "CodeBook.Rmd"                                                
##  [4] "Dataset.zip"                                                 
##  [5] "new_dataset.txt"                                             
##  [6] "UCI HAR Dataset/activity_labels.txt"                         
##  [7] "UCI HAR Dataset/features.txt"                                
##  [8] "UCI HAR Dataset/features_info.txt"                           
##  [9] "UCI HAR Dataset/README.txt"                                  
## [10] "UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt"   
## [11] "UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt"   
## [12] "UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt"   
## [13] "UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt"  
## [14] "UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt"  
## [15] "UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt"  
## [16] "UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt"  
## [17] "UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt"  
## [18] "UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt"  
## [19] "UCI HAR Dataset/test/subject_test.txt"                       
## [20] "UCI HAR Dataset/test/X_test.txt"                             
## [21] "UCI HAR Dataset/test/y_test.txt"                             
## [22] "UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt" 
## [23] "UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt" 
## [24] "UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt" 
## [25] "UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt"
## [26] "UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt"
## [27] "UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt"
## [28] "UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt"
## [29] "UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt"
## [30] "UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt"
## [31] "UCI HAR Dataset/train/subject_train.txt"                     
## [32] "UCI HAR Dataset/train/X_train.txt"                           
## [33] "UCI HAR Dataset/train/y_train.txt"
```

1. Read the test and train data sets and combine them into "df"
  
       "UCI HAR Dataset/test/X_test.txt"
  
       "UCI HAR Dataset/train/X_train.txt"

  

```r
   df_test <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)
   df_train <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
   
   df <- rbind(df_test, df_train)
```

2. Extracts only the measurements on the mean and standard deviation for each measurement.

2.1 Read features table

2.2 find rows with mean and std, which are columns corresponding to the mean and standard deviation of measurements in "df"

2.3 subset df with these columns to generate "df_mean_std""


```r
  library(dplyr)
```

```
## 
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:lubridate':
## 
##     intersect, setdiff, union
```

```
## The following objects are masked from 'package:stats':
## 
##     filter, lag
```

```
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```r
  features <- read.table("UCI HAR Dataset/features.txt")
  cols <- grep("mean\\(", features$V2)
  cols <- append(cols, grep("std\\(", features$V2))
  cols <- sort(cols)
  
  df_mean_std <- select(df, cols)
```

3. Appropriately labels the data set with descriptive variable names.

3.1  Get the activity names from features table

3.2  Remove the () in the activity names

3.3  Label the columns


```r
  colHeaders <- features[cols, 2]
  colHeaders <- sub("\\()", "", colHeaders)
  
  colnames(df_mean_std) <- colHeaders
```

4. Uses descriptive activity names to name the activities in the data set

4.1  Read activity list

      "UCI HAR Dataset/test/y_test.txt"
    
      "UCI HAR Dataset/train/y_train.txt"
    
4.2  Combine the two into one, "act"

4.3  Read activity labels

      "UCI HAR Dataset/activity_labels.txt"
    
4.4  Replace activity numbers with descriptive activity names

4.5  Insert "act"" as a new colume into df_mean_std


```r
    act_test <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
    act_train <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
    act <- rbind(act_test, act_train)
    
    act_label <- read.table("UCI HAR Dataset/activity_labels.txt")
    
    act$V1 <- act_label$V2[as.numeric(act$V1)]
    colnames(act) <- "Activity"
    
    df_mean_std <- cbind(act, df_mean_std)
```

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

5.1  Read subject lists and combine into one, "subject"

    "UCI HAR Dataset/test/subject_test.txt"
    
    "UCI HAR Dataset/train/subject_train.txt"  
    
5.2  Insert subject as a new column into df_mean_df


```r
    subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
    subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
    subject <- rbind(subject_test, subject_train)
    colnames(subject) <- "Subject"
    
    df_mean_std <- cbind(subject, df_mean_std)
```

5.3  Calculate the mean of variables for each subject and acrivity, write out the new data set as  "new_dataset.txt"


```r
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
```


## Decription of data set generated, "new_dataset.txt"    

         8 columns
      1980 rows
      
### Columns:

      [1] "Subject"            
      [2] "Variable"          
      [3] "LAYING"             
      [4] "SITTING"           
      [5] "STANDING"           
      [6] "WALKING"           
      [7] "WALKING_DOWNSTAIRS" 
      [8] "WALKING_UPSTAIRS" 

### Description of Columns

- Subject: values of 1 to 30

- Variable: corrsponding to 68 meansurements

       [1] "tBodyAcc-mean-X"          
       [2] "tBodyAcc-mean-Y"          
       [3] "tBodyAcc-mean-Z"          
       [4] "tBodyAcc-std-X"           
       [5] "tBodyAcc-std-Y"           
       [6] "tBodyAcc-std-Z"           
       [7] "tGravityAcc-mean-X"       
       [8] "tGravityAcc-mean-Y"       
       [9] "tGravityAcc-mean-Z"       
      [10] "tGravityAcc-std-X"        
      [11] "tGravityAcc-std-Y"        
      [12] "tGravityAcc-std-Z"        
      [13] "tBodyAccJerk-mean-X"      
      [14] "tBodyAccJerk-mean-Y"      
      [15] "tBodyAccJerk-mean-Z"      
      [16] "tBodyAccJerk-std-X"       
      [17] "tBodyAccJerk-std-Y"       
      [18] "tBodyAccJerk-std-Z"       
      [19] "tBodyGyro-mean-X"         
      [20] "tBodyGyro-mean-Y"         
      [21] "tBodyGyro-mean-Z"         
      [22] "tBodyGyro-std-X"          
      [23] "tBodyGyro-std-Y"          
      [24] "tBodyGyro-std-Z"          
      [25] "tBodyGyroJerk-mean-X"     
      [26] "tBodyGyroJerk-mean-Y"     
      [27] "tBodyGyroJerk-mean-Z"     
      [28] "tBodyGyroJerk-std-X"      
      [29] "tBodyGyroJerk-std-Y"      
      [30] "tBodyGyroJerk-std-Z"      
      [31] "tBodyAccMag-mean"         
      [32] "tBodyAccMag-std"          
      [33] "tGravityAccMag-mean"      
      [34] "tGravityAccMag-std"       
      [35] "tBodyAccJerkMag-mean"     
      [36] "tBodyAccJerkMag-std"      
      [37] "tBodyGyroMag-mean"        
      [38] "tBodyGyroMag-std"         
      [39] "tBodyGyroJerkMag-mean"    
      [40] "tBodyGyroJerkMag-std"     
      [41] "fBodyAcc-mean-X"          
      [42] "fBodyAcc-mean-Y"          
      [43] "fBodyAcc-mean-Z"          
      [44] "fBodyAcc-std-X"           
      [45] "fBodyAcc-std-Y"           
      [46] "fBodyAcc-std-Z"           
      [47] "fBodyAccJerk-mean-X"      
      [48] "fBodyAccJerk-mean-Y"      
      [49] "fBodyAccJerk-mean-Z"      
      [50] "fBodyAccJerk-std-X"       
      [51] "fBodyAccJerk-std-Y"       
      [52] "fBodyAccJerk-std-Z"       
      [53] "fBodyGyro-mean-X"         
      [54] "fBodyGyro-mean-Y"         
      [55] "fBodyGyro-mean-Z"         
      [56] "fBodyGyro-std-X"          
      [57] "fBodyGyro-std-Y"          
      [58] "fBodyGyro-std-Z"          
      [59] "fBodyAccMag-mean"         
      [60] "fBodyAccMag-std"          
      [61] "fBodyBodyAccJerkMag-mean" 
      [62] "fBodyBodyAccJerkMag-std"  
      [63] "fBodyBodyGyroMag-mean"    
      [64] "fBodyBodyGyroMag-std"     
      [65] "fBodyBodyGyroJerkMag-mean"        
      [66] "fBodyBodyGyroJerkMag-std" 

- LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS

      Mean values of variables of each subject and each activity


