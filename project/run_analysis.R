# Here are the data for the project:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# You should create one R script called run_analysis.R that does the following.
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set.
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## You should create one R script called run_analysis.R that does the following. 
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Make sure UCI HAR Dataset directory is in same directory with run_analysis.R

require(plyr)

# 1. Merges the training and the test sets to create one data set.

# Load features
features <- read.table('./UCI HAR Dataset/features.txt', colClasses = c('character'))
# Load activity_labels
activity_labels <- read.table('./UCI HAR Dataset/activity_labels.txt', col.names = c("activityId", "activity"))
# Load train data
x_train <- read.table('./UCI HAR Dataset/train/X_train.txt')
y_train <- read.table('./UCI HAR Dataset/train/y_train.txt')
subject_train <- read.table('./UCI HAR Dataset/train/subject_train.txt')
# Load test data
x_test <- read.table('./UCI HAR Dataset/test/X_test.txt')
y_test <- read.table('./UCI HAR Dataset/test/y_test.txt')
subject_test <- read.table('./UCI HAR Dataset/test/subject_test.txt')

# Binding data
training_data <- cbind(cbind(x_train, subject_train), y_train)
test_data <- cbind(cbind(x_test, subject_test), y_test)
# Merge data
merged_data <- rbind(training_data, test_data)
# Assign variables names to data
variable_names <- c(features[, 2], 'subject', 'activityId')
names(merged_data) <- variable_names

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

merged_data_mean_sd <- merged_data[, grepl('mean|std|subject|activityId', names(merged_data))]

# 3. Uses descriptive activity names to name the activities in the data set.

merged_data_mean_sd <- join(merged_data_mean_sd, activity_labels, by = 'activityId', match = 'first')
# remove activityId
merged_data_mean_sd <- merged_data_mean_sd[, -1]

# 4. Appropriately labels the data set with descriptive names.

names(merged_data_mean_sd) <- gsub('\\(|\\)',"",names(merged_data_mean_sd), perl = TRUE)
names(merged_data_mean_sd) <- gsub('Freq',"Frequency",names(merged_data_mean_sd))
names(merged_data_mean_sd) <- gsub('mean',"Mean",names(merged_data_mean_sd))
names(merged_data_mean_sd) <- gsub('std',"StandardDeviation",names(merged_data_mean_sd))
names(merged_data_mean_sd) <- gsub('Acc',"Acceleration",names(merged_data_mean_sd))
names(merged_data_mean_sd) <- gsub('Mag',"Magnitude",names(merged_data_mean_sd))
names(merged_data_mean_sd) <- gsub('^t',"Time-",names(merged_data_mean_sd))
names(merged_data_mean_sd) <- gsub('^f',"Frequency-",names(merged_data_mean_sd))

# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

tidy_data_with_avg_of_variable_for_activity_and_subject = ddply(merged_data_mean_sd, c('subject', 'activity'), numcolwise(mean))
write.table(tidy_data_with_avg_of_variable_for_activity_and_subject, file = "tidy_data_with_avg_of_variable_for_activity_and_subject.txt", row.name=FALSE)
