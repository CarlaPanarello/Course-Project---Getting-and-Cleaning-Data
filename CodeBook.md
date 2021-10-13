---
title: "Human Activity Recognition Using Smartphones Dataset"
output:
  pdf_document: default
  html_document: default
---


<!-- ================================================================== -->
<!-- Human Activity Recognition Using Smartphones Dataset -->
<!-- Version 1.0 -->
<!-- ================================================================== -->
<!-- Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto. -->
<!-- Smartlab - Non Linear Complex Systems Laboratory -->
<!-- DITEN - Università degli Studi di Genova. -->
<!-- Via Opera Pia 11A, I-16145, Genoa, Italy. -->
<!-- activityrecognition@smartlab.ws -->
<!-- www.smartlab.ws -->
<!-- ================================================================== -->
# Experiment description

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

Each record is identified by a pair subjectId-windowId, i.e an identifier of the subject who carried out the experiment and the sequence number of the fixed-width sliding window which the measurements are referred to.


For each record (i.e. for each pair subjectId - windowId) it is provided:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration   
- Triaxial Angular velocity from the gyroscope  
- 561-features with time and frequency domain variables, and the  associated activity label  


# Dataset description

The dataset includes the following files:

- 'CodeBook.md': this file! 

- 'features_info.txt': Shows information about the values in the last 561 columns of 'Dataset/processed_data.csv'

- 'Tidy UCI HAR Dataset/group_map.csv': a table of 30 rows and 2 column, (named 'subjectId' and 'group'), indicating whether each subject was selected for the test or training group.  
    Variables:  
    - subjectId: integer number in the range 1:30  
    - group: possible values are ('test','train')  

- 'Tidy UCI HAR Dataset/processed_data.csv': the first 2 columns identifies the subject who performed the activity for each window sample (subjectID-windowID). The 3rd column indicates the activity performed in each window. The remaining 561 columns are associated to the features calculated as explained in 'features_info.txt'.
    Variables:  
    - subjectId: integer number in the range 1:30  
    - windowId: sequence number for the fixed-width sliding windows for each subject  
    - activity: possible values are ('WALKING', 'WALKING_UPSTAIRS', 'WALKING_DOWNSTAIRS', 'SITTING', 'STANDING', 'LAYING')  
    - 561 more columns whose names and description, for readability reason, are listen in the file 'features_info.txt'

- 'Tidy UCI HAR Dataset/means_and_stds.csv': extracts from processed_data.csv the columns subjectID, windowId, activity  and only the measurements on the mean and standard deviation for each feature.
    Variables:  
    - subjectId: integer number in the range 1:30  
    - windowId: sequence number for the fixed-width sliding windows for each subject  
    - activity: possible values are ('WALKING', 'WALKING_UPSTAIRS', 'WALKING_DOWNSTAIRS', 'SITTING', 'STANDING', 'LAYING')  
    - 66 more columns extracted from 'Dataset/processed_data.csv', namely the measurements on the mean and standard deviation for each feature
  
- 'Tidy UCI HAR Dataset/average_means_and_stds.csv': the first two columns indicate the subject for each performed activity (180 rows: 30 subjects, 6 activities). The following 66 columns show the average for the variables in 'Dataset/means_and_stds.csv' for each activity and each subject.
    Variables:  
    - subjectId: integer number in the range 1:30  
    - activity: possible values are ('WALKING', 'WALKING_UPSTAIRS', 'WALKING_DOWNSTAIRS', 'SITTING', 'STANDING', 'LAYING')  
    - 66 more columns: average value of the variables for each activity and each subject.

- 'Tidy UCI HAR Dataset/Inertial Signals/total_acc_<axis>.csv', where <axis> = {x,y,z}: The acceleration signal from the smartphone accelerometer, corresponding to the axis indicate in the file name, in standard gravity units 'g'. Every row shows the pair subjectId-windowID in the first 2 columns, followed by a 128 element vector which represent the samples in each window.

- 'Tidy UCI HAR Dataset/Inertial Signals/body_acc_<axis>.csv', where <axis> = {x,y,z}: The body acceleration signal obtained by subtracting the gravity from the total acceleration. Every row shows the pair subjectId-windowID in the first 2 columns, followed by a 128 element vector which represent the samples in each window. 

- 'Tidy UCI HAR Dataset/Inertial Signals/body_gyro_<axis>.csv', where <axis> = {x,y,z}: The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. Every row shows the pair subjectId-windowID in the first 2 columns, followed by a 128 element vector which represent the samples in each window. 

# Notes: 

- Features are normalized and bounded within [-1,1].

For more information about this dataset contact: activityrecognition@smartlab.ws

# License:

Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

