# README

## Getting and Cleaning Data Course Project

### * Files in the repo   
            - README.md   
            - run_analysis.R   
            - CodeBook.md   
            - new_dataset.txt   

### * run_analysis.R

Use the data

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

to perform the tasks:   
      1. Merges the training and the test sets to create one data set.   
      2. Extracts only the measurements on the mean and standard deviation for each measurement.   
      3. Uses descriptive activity names to name the activities in the data set.   
      4. Appropriately labels the data set with descriptive variable names.   
      5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.  

### * CodeBook.md 
The file includes the r code for each step of the data transformation and a deceription of the final output.

### * new_dataset.txt
This is the final data set. It contains    
               8 columns   
            1980 rows   
      
#### Columns:

      [1] "Subject"            
      [2] "Variable"          
      [3] "LAYING"             
      [4] "SITTING"           
      [5] "STANDING"           
      [6] "WALKING"           
      [7] "WALKING_DOWNSTAIRS" 
      [8] "WALKING_UPSTAIRS" 

#### Values of Columns

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

The meaning of the variables is explained in feature_info.txt including in the 
original zip file.

- LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS

      Mean values of variables of each subject and each activity

