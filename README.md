# README: Samsung Galaxy Accelerometer Application Data Analysis
For the course Getting and Cleaning Data

The purpose of this project is to produce a tidy data set from accelerometer information as below.

The data is accelerometer information from a test among 30 subjects using the Samsung Galaxy smartphone app which measures physical activity.

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

In summary, the run_analysis.R script...

1. Downloads and unzips the appropriate data file into a working directory
2. Converts the raw data into R data frame objects
3. Merges the train and test data into a single files for analysis
4. Appends the subject ID to the appropriate row of data
5. Changes the data column names to descriptive names
6. Changes the activity data to descriptive names
7. Produces an aggregated tidy data file of activities by subject
