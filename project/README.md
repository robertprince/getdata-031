## README.md

This explains how all of the scripts work and how they are connected.

## CodeBook.md

A code book that describes the variables, the data, and any transformations or work that you performed to clean up the data.

## run_analysis.R

The script that does the following:
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement.
* Uses descriptive activity names to name the activities in the data set.
* Appropriately labels the data set with descriptive variable names.
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Workflow to complete the project

1. Download the  data for the project from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip, using command like `download.file`
2. Unzip the downloaded file, this will create directories and files under **UCI HAR Dataset** directory.
3. Study text files in **UCI HAR Dataset** directory to prepare the CodeBook.md file.
4. Run run_analysis.R to generate the desire tidy data set file.
