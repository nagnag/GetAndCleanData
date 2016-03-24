##########################################################################################################

# run_analysis.R  

# 
#
# This script creates a tidy data set from the study, "Smartphone-Based Human Activity Recognition." 
#
# Here is the link to the study -  http://www.tdx.cat/bitstream/handle/10803/284725/TJLRO1de1.pdf?sequence=1
# 
#  
#
# Required packages: plyr dplyr knitr memisc
#
# To arrive at a tidy data set, the following steps are performed as per instructions
# 
#
# 0  Download the raw data
#
# 1. Merge the training and the test sets to create one data set.
# 2. Extract only the measurements on the mean and standard deviation for each measurement.
# 3. Use descriptive activity names to name the activities in the data set
# 4. Appropriately label the data set with descriptive variable names.
# 5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
##########################################################################################################

##
## preparatory steps
##
library(plyr)
library(dplyr)
library(knitr)
library(memisc)

#
#  Replace dir as apporporiate
#
setwd("C:\\R\\CleanData\\Project")
wd <- getwd()

##
## Download file
##
file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
file_name <- "Dataset.zip"
download.file(file_url, file.path(wd, file_name))
##
## Extract file from zip
##
unzip(file_name)
#
#
output_path <- paste0(wd,"\\output")
list.files(input_path, recursive = TRUE)


##########################################################################################################
# Step 1: Merge the training and the test sets to create one data set.
##########################################################################################################
# 
# Read the features file and assign to a data frame - 561 items
#
features_list <- read.table('UCI HAR Dataset/features.txt',header=FALSE, stringsAsFactors = FALSE); 
#
# Convert to lower case for consistency
#
features_list$V2 <- tolower(features_list$V2) 

# Read  Activity Labels from file:
activity_labels <-read.table('UCI HAR Dataset/activity_labels.txt',header=FALSE);
#
# Convert to lower case for consistency
#
activity_labels$V2 <- tolower(activity_labels$V2)

# Read activity ids for training
train_activity_Id <- read.table('UCI HAR Dataset/train/Y_train.txt',header=FALSE) 

# Read activity ids for test
test_activity_Id <- read.table('UCI HAR Dataset/test/y_test.txt',header=FALSE)

# Read file for observations per subject for training (21 subjects, 7352 total obs)
Train_obs <-read.table('UCI HAR Dataset/train/subject_train.txt',header=FALSE) 

# Read file for observations per subject for test (9 subjects, 2947 total obs) 
Test_obs <- read.table('UCI HAR Dataset/test/subject_test.txt',header=FALSE)

# Read in the training and  test data sets

# Read in training data (called the 'Training set'in README.txt) into a data frame:
Training_Set <- read.table('UCI HAR Dataset/train/X_train.txt',header=FALSE)

# Read in test data (called the 'Test set'in README.txt) into a data frame:
Test_Set <- read.table('UCI HAR Dataset/test/x_test.txt',header=FALSE)

# Assign sensible variable names to all data sets
colnames(Train_obs) <- "subject"
colnames(Test_obs) <- "subject"
colnames(Training_Set) <- features_list[,2]
colnames(Test_Set) <- features_list$V2 # features[,2]
colnames(train_activity_Id) <- "activityid";
colnames(test_activity_Id) <- "activityid";

# create full training and test data sets: append subject and activity_Id variables to x_train & x_test 
Training_Set_c <- cbind(Training_Set,Train_obs,train_activity_Id)
Test_Set_c <- cbind(Test_Set,Test_obs,test_activity_Id)

# Merge test and train data sets
merged_Data <- rbind(Training_Set_c,Test_Set_c)

##########################################################################################################
# Step 2: Extract only the measurements on the mean and standard deviation for each measurement
# (but also include the activityid and subject variables, as I will need those later)
##########################################################################################################

#
# Fetch column names
#
data_vars <- names(merged_Data)

# 53 mean variables
mean_vars <- grep("mean",tolower(data_vars),value=TRUE)
# 33 std variables
std_vars <- grep("std",tolower(data_vars),value=TRUE)

# Store lables
ActSub <- c("activityid","subject")

meanStd_fields <- c(mean_vars,std_vars,ActSub)
meanStd_filtered <- merged_Data[,meanStd_fields]

##########################################################################################################
# Step 3. Use descriptive activity names to name the activities in the data set
##########################################################################################################
meanStd_filtered <- merge(meanStd_filtered,activity_labels,by.x="activityid",by.y="V1",all=TRUE)

##########################################################################################################
# Step 4. Appropriately label the data set with descriptive activity names. 
##########################################################################################################

# get all the current column names
meanStd_filterednames <- colnames(meanStd_filtered)

# Rename the "V2" column name to the descriptive column name "activity"
meanStd_filterednames[89] <- "activity"

# Get rid of  "()" from column lable
meanStd_filterednames <- sub("\\()","",meanStd_filterednames)

# reassign more descriptive column names
colnames(meanStd_filtered) <- meanStd_filterednames

##########################################################################################################
# Step 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
#    for each activity and each subject.
##########################################################################################################

# remove 'activitiyid' column

meanStd_filtered <- subset(meanStd_filtered, select=-c(activityid))

Tidy_data_Set = ddply(meanStd_filtered, c("subject","activity"), numcolwise(mean))

#
# Write Output to file
#
f <- file.path(output_path, "ActivityMeasurementUsingSmartPhone.txt")
write.table(Tidy_data_Set, f, quote = FALSE, sep = "\t", row.names = FALSE)
#
# Write Codebook to file
#
cf <- file.path(output_path, "Codebook.md")
Write(codebook(Tidy_data_Set),
      file=cf)