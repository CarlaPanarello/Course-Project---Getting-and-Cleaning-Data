library(dplyr)
library(tools)


wd <- getwd()

origDir <- file.path(wd,"Original Dataset")
destDir <- file.path(wd, "Tidy Dataset")

if(!file.exists(origDir)) { dir.create(origDir) }
if(!file.exists(destDir)) { dir.create(destDir) }

destDataset <- file.path(destDir, "Tidy UCI HAR Dataset")
destInertial = file.path(destDataset, "Inertial Signals")
if(!file.exists(destDataset)) { dir.create(destInertial, recursive = TRUE) }


# The following lines download the original files
dataUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipfilename <- file.path(origDir, "UCI HAR Dataset.zip")
download.file(dataUrl,destfile = zipfilename)
fileList <- unzip(zipfilename, exdir = origDir)
fileList <- data.frame(path = fileList, dir = dirname(fileList), filename = file_path_sans_ext(basename(fileList)), ext = file_ext(basename(fileList)))
fileList <- filter(fileList,filename != "README" & filename != "features_info")
                    


# The following lines read each file in 'fileList'
# e assign their content to an element of the list 'data'
# Since the names in 'data' are by default the whole path/filename
# they are renamed with the single file name
data <- sapply(as.character(fileList$path),read.table)
names(data) <- fileList$filename 

# The following lines build a dataframe 'D'
# which gives an overview of the dimension of the tables from each file 
D <- data.frame(c(0,0))
for(i in 1:26) { 
    D[i]<-dim(data[[i]])
}
colnames(D) = fileList$filename
rownames(D) <- c("nrows", "ncols")


# 'data$features' is a data.frame
# with 561 rows (one for each feature)
# and 2 columns which represent, in the order,
# the featureId and the corresponding featureLabel
# The following lines also modify the featureLabels 
# by replacing all the characters other than letters or numbers with '_'
# Additionally it make unique the features 
# whose name appears to be duplicated
# (since all duplicated names appears 3 times, 
#  they likely refer to the 3-axis X,Y,Z,
#  in order of appearance.
#  This assumption is consistent with the description in the file
#  feature_info.md.
#  However, it is yet an assumption... 
#  Therefore, by making the names unique, the strings 'X.', 'Y.', 'Z.'
#  will be appended to original names with the character '.' 
#  to indicate uncertainty)

colnames(data$features) <- c("featureId", "featureLabel")

dupl_X <- unique(data$features$featureLabel[duplicated(data$features$featureLabel)])
data$features$featureLabel <- make.unique(as.character(data$features$featureLabel), "@")
data$features$featureLabel <- sub("@1","_Y.", data$features$featureLabel)
data$features$featureLabel <- sub("@2","_Z.", data$features$featureLabel)
dupl_X_bool <- data$features$featureLabel %in% dupl_X
data$features$featureLabel[dupl_X_bool] <- paste0(dupl_X,"_X.")
data$features$featureLabel <- gsub("\\(|\\)","", data$features$featureLabel)
data$features$featureLabel <- gsub("-|,","_", data$features$featureLabel)



# 'data$activity_labels' is a data.frame
# with 6 rows (one for each activity_label)
# and 2 columns which represent, in the order,
# the activityId and the corresponding activityLabel
# 
colnames(data$activity_labels) <- c("activityId","activityLabel")



# The following lines:
# 1. merge the test and training data for the columns: subject, X and y 
# 2. rename the column subject as subjectId, 
#    rename the columns in the dataframe X 
#    with the featureLabels provided in 'data$features$featureLabel',
#    rename the column Y as activity
# 3. replace the activity Id in the column activity 
#    with the corresponding activityLabel
# 4. to guarantee the correspondence between the rows in each dataframe
#    also in the case of row reodering,
#    a unique identifier for each row must be provided. 
#    The subjectId alone is not sufficient, since every record in the old files 
#    is associated to the pair (subject, sample window).
#    Therefore a column with a window identifier, named windowId, is added
#    (to do that, 'vars' is grouped by subjectId and the rows for each group are numbered)
# 5. modify the order of the columns 
#    so that subjectId, windowId, activity are the first 3 columns
# 6. save in the variable 'group_map' 
#    whether the subject was in the test or training group
# 7. write 'vars' in the file processed_data.csv
#    'group_map' in the file group_map.csv

col4vars <- c("subject_test", "X_test","y_test","subject_train","X_train","y_train")
temp <- data[col4vars]
names(temp) <- rep(c("subject", "X", "y"), times = 2)
vars <- rbind(as.data.frame(temp[1:3]), as.data.frame(temp[4:6]))
colnames(vars) <- c("subjectId", as.character(data$features$featureLabel), "activity")
vars$activity <- data$activity_labels[vars$activity,2]
temp <- group_by(vars, subjectId)
vars <- mutate(temp, windowId=row_number())
vars <- relocate(vars, subjectId, windowId, activity, .before = as.character(data$feature$featureLabel[1]))
group_map <- data.frame(subjectId = vars$subjectId, group = c(rep("test", times = D["nrows", "subject_test"]), rep("train", times = D["nrows", "subject_train"])))
group_map <- unique(group_map)
write.csv(vars,file.path(destDataset, "processed_data.csv"))
write.csv(group_map,file.path(destDataset, "group_map.csv"))


# The following lines
# 1. merge the test and training data for the signal samples 
# 2. add two columns with the corresponding pair (subjectId, windowId)
# 3. write each element of the list samples in a file csv in the destInertial subdirectory
col4samples <- c("activity_labels", "features", col4vars)
temp <- data[names(data) %in% col4samples == FALSE]
names(temp) <- sub("_test","",names(temp))
names(temp) <- sub("_train","",names(temp))
samples <- list()
for(i in 1:9) { 
    samples[[i]] <- cbind(subjectId = vars$subjectId, windowId = vars$windowId, rbind(temp[[i]],temp[[i+9]]))
    write.csv(samples[[i]],file.path(destInertial, paste0(names(temp[i]),".csv")))
}
names(samples) <- names(temp[1:9])

# The following lines
# 1. select those column in 'vars' whose name contains the string "-mean()" or "-std()"
#    and also the first two columns with subjectId and activity
# 2. group the dataframe according to the subjectId and the activity
# 3. through the function summarise_all, apply the function mean to all the columnns
# 4. save the variable 'vars_avg' in the file average_means_and_stds

# meanstd <- vars[,c(1,2,grep("-mean\\(\\)|-std\\(\\)",names(vars)))]
meanstd <- select(vars, c(subjectId, activity, grep("mean|std",names(vars))))
meanstd <- group_by(meanstd, subjectId, activity)
vars_avg <- summarise_all(meanstd, mean)
write.csv(meanstd, file.path(destDataset, "means_and_stds.csv"))
write.csv(vars_avg,file.path(destDataset, "average_means_and_stds.csv"))

# The following line save 'vars_avg' in a txt file created with write.table()
# using row.name=FALSE, as requested for the project submission.

write.table(vars_avg,file.path(destDataset, "average_means_and_stds.txt"), row.name = FALSE)








