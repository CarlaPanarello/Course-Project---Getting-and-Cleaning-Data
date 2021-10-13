---
title: "Getting and Cleaning Data Course Project"
output:
  pdf_document: default
  html_document: default
---


For this project, I created one R script called 'run_analysis.R' that does the following:

- downloads the dataset from  
  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  

- extract all files and directories and recursively read them  

- merges the training and test sets to create a unique datasets   

  More specifically:  

  - creates a new table, 'group_map.csv', indicating whether each subject was selected for the test or training group  

  - creates a table, 'processed_data.csv', whose variables are the 561 features described in 'features_info.txt' and are descriptively named, accordingly.  
    
    The values for these variables were provided in the original files 'X_test.txt'and 'X_train.txt'.
    
    Since each record in the original datasets refers to a pair (subject, sample window), two columns are added to the table:  
    
    the first column, named 'subjectId', represents the subject identifier as provided in the original files 'subject_test.txt' and 'subject_train.txt';   
    
    the second column, named 'windowId, associates a sequence number to the sample windows for each subject.  

    Additional a third column, named 'activity', is added to indicate the activity performed by the subjects in each sample window. Values for this column were provided in the original files 'y_test.txt' and 'y_train.txt' as activity identifier, and the corresponding description were provided in the original file 'activity_labels.txt'. By combining the orginal files, only the activity labels are used as values for the 'activity' column in the final table.  

  - creates the tables 'total_acc_<axis>.csv', 'body_acc_<axis>.csv', 'body_gyro_<axis>.csv', where <axis> = {x,y,z}.  

    The values and formats of these tables are the same as in the homonym original files (more detailes are provided in the file 'CodeBook.md'), with the one exception that the columns 'subjectId' and 'windowId' are added to these tables to connect them coherently.

- extracts only the measurements on the mean and standard deviation for each measurement, from the table 'processed_data.csv' and save the new table as 'means_and_stds.csv'  

- creates a second, independent tidy data set ('average_means_and_stds.csv', with the average of each variable for each activity and each subject.  


More details about the transformations performed to clean up the data are provided as comments inside the R script.


The project include the following files:

My Project/README.md  
My Project/run_analysis.R  
My Project/Tidy Dataset/CodeBook.md  
My Project/Tidy Dataset/features_info.md  
My Project/Tidy Dataset/Tidy UCI HAR Dataset/group_map.csv  
My Project/Tidy Dataset/Tidy UCI HAR Dataset/processed_data.csv  
My Project/Tidy Dataset/Tidy UCI HAR Dataset/means_and_stds.csv  
My Project/Tidy Dataset/Tidy UCI HAR Dataset/average_means_and_stds.csv  
My Project/Tidy Dataset/Tidy UCI HAR Dataset/Inertial Signals/body_acc_x.csv  
My Project/Tidy Dataset/Tidy UCI HAR Dataset/Inertial Signals/body_acc_y.csv  
My Project/Tidy Dataset/Tidy UCI HAR Dataset/Inertial Signals/body_acc_z.csv  
My Project/Tidy Dataset/Tidy UCI HAR Dataset/Inertial Signals/body_gyro_x.csv  
My Project/Tidy Dataset/Tidy UCI HAR Dataset/Inertial Signals/body_gyro_y.csv  
My Project/Tidy Dataset/Tidy UCI HAR Dataset/Inertial Signals/body_gyro_z.csv  
My Project/Tidy Dataset/Tidy UCI HAR Dataset/Inertial Signals/total_acc_x.csv  
My Project/Tidy Dataset/Tidy UCI HAR Dataset/Inertial Signals/total_acc_y.csv  
My Project/Tidy Dataset/Tidy UCI HAR Dataset/Inertial Signals/total_acc_z.csv  


