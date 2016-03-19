##
## preparatory steps
##
library(data.table)
library(reshape2)
library(knitr)
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
input_path <- paste0(wd,"\\UCI HAR Dataset")
output_path <- paste0(wd,"\\output")
list.files(input_path, recursive = TRUE)
##
## Read training  data set.
##

# subject
data_Sub_Train <- fread(file.path(input_path, "train", "subject_train.txt"))
data_Sub_Test <- fread(file.path(input_path, "test", "subject_test.txt"))
# activity
data_act_Train <- fread(file.path(input_path, "train", "subject_train.txt"))
data_act_Test <- fread(file.path(input_path, "test", "subject_test.txt"))
#


data_Train_f <- read.table(file.path(input_path, "train", "X_train.txt"))
data_Train_tab <- data.table(data_Train_f)

data_Test_f <- read.table(file.path(input_path, "test", "X_test.txt"))
data_Test_tab <- data.table(data_Test_f)

##
## Merge the training and the test sets to create one data set.
##

##
##   Merge Training and Test Subjects
##

data_Sub_tab <- rbind(data_Sub_Train, data_Sub_Test)
setnames(data_Sub_tab, "V1", "subject")
##
##   Merge Training and Test Activities
##
data_Act_tab <- rbind(data_act_Train, data_act_Test)
setnames(data_Act_tab, "V1", "activityNum")
data_Merged_tab <- rbind(data_Train_tab, data_Test_tab)

##
##   Merge Columns
##
data_Sub_tab <- cbind(data_Sub_tab, data_Act_tab)
data_Merged_tab <- cbind(data_Sub_tab, data_Merged_tab)
#Set key

setkey(data_Merged_tab, subject, activityNum)
## Extracts only the measurements on the mean and standard deviation for each measurement.

data_Features <- fread(file.path(input_path, "features.txt"))
setnames(data_Features, names(data_Features), c("featureNum", "featureName"))
data_Features <- data_Features[grepl("mean\\(\\)|std\\(\\)", featureName)]


data_Features$featureCode <- data_Features[, paste0("V", featureNum)]
head(data_Features)
#
#Subset these variables using variable names.
#

select <- c(key(data_Merged_tab), data_Features$featureCode)
data_Merged_tab <- data_Merged_tab[, select, with = FALSE]
#
# ## Uses descriptive activity names to name the activities in the data set ( based on activity_lables.txt)
#
data_ActNames <- fread(file.path(input_path, "activity_labels.txt"))
setnames(data_ActNames, names(data_ActNames), c("activityNum", "activityName"))
# Merge activity lables
data_Merged_tab <- merge(data_Merged_tab, data_ActNames, by = "activityNum", all.x = TRUE)
#
## Appropriately labels the data set with descriptive variable names.
#
#Add activityName as a key.

setkey(data_Merged_tab, subject, activityNum, activityName)

# Melt the data table to reshape it from a short and wide format to a tall and narrow format.

data_Merged_tab <- data.table(melt(data_Merged_tab, key(data_Merged_tab), variable.name = "featureCode"))

# Merge activity name.

data_Merged_tab <- merge(data_Merged_tab, data_Features[, list(featureNum, featureCode, featureName)], by = "featureCode", 
            all.x = TRUE)

#Appropriately labels the data set with descriptive variable names.
# Create a new variable, activity that is equivalent to activityName as a factor class. Create a new variable, feature that is equivalent to featureName as a factor class.

data_Merged_tab$activity <- factor(data_Merged_tab$activityName)
data_Merged_tab$feature <- factor(data_Merged_tab$featureName)


match_feat <- function(expr) {
  grepl(expr, data_Merged_tab$feature)
}
## Features with 2 categories
n <- 2
y <- matrix(seq(1, n), nrow = n)
x <- matrix(c(match_feat("^t"), match_feat("^f")), ncol = nrow(y))
data_Merged_tab$featDomain <- factor(x %*% y, labels = c("Time", "Freq"))
x <- matrix(c(match_feat("Acc"), match_feat("Gyro")), ncol = nrow(y))
data_Merged_tab$featInstrument <- factor(x %*% y, labels = c("Accelerometer", "Gyroscope"))
x <- matrix(c(match_feat("BodyAcc"), match_feat("GravityAcc")), ncol = nrow(y))
data_Merged_tab$featAcceleration <- factor(x %*% y, labels = c(NA, "Body", "Gravity"))
x <- matrix(c(match_feat("mean()"), match_feat("std()")), ncol = nrow(y))
data_Merged_tab$featVariable <- factor(x %*% y, labels = c("Mean", "SD"))
## Features with 1 category
data_Merged_tab$featJerk <- factor(match_feat("Jerk"), labels = c(NA, "Jerk"))
data_Merged_tab$featMagnitude <- factor(match_feat("Mag"), labels = c(NA, "Magnitude"))
## Features with 3 categories
n <- 3
y <- matrix(seq(1, n), nrow = n)
x <- matrix(c(match_feat("-X"), match_feat("-Y"), match_feat("-Z")), ncol = nrow(y))
data_Merged_tab$featAxis <- factor(x %*% y, labels = c(NA, "X", "Y", "Z"))

# Check to make sure all possible combinations of feature are accounted for by all possible combinations of the factor class variables.
#
r1 <- nrow(data_Merged_tab[, .N, by = c("feature")])
r2 <- nrow(data_Merged_tab[, .N, by = c("featDomain", "featAcceleration", "featInstrument", 
                           "featJerk", "featMagnitude", "featVariable", "featAxis")])
r1 == r2

## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

setkey(data_Merged_tab, subject, activity, featDomain, featAcceleration, featInstrument, 
       featJerk, featMagnitude, featVariable, featAxis)
Tidy_data_Set <- data_Merged_tab[, list(count = .N, average = mean(value)), by = key(data_Merged_tab)]
#
# Write Output to file
#
f <- file.path(output_path, "ActivityMeasurementUsingSmartPhone.txt")
write.table(Tidy_data_Set, f, quote = FALSE, sep = "\t", row.names = FALSE)