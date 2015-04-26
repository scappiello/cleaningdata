# Course Project assignment for Getting and Cleaning Data

# This script assumes that the data is located in the same directory as run_analysis.R

# Load lookup data from files
# setwd("~/Downloads/UCI HAR Dataset")
df_activity_labels = read.table("activity_labels.txt", col.names = c("ActivityCode","ActivityName"))
df_features = read.table("features.txt", col.names = c("FeatureCode", "FeatureName"))

# Load test observation data from files
# setwd("~/Downloads/UCI HAR Dataset/test")
setwd("test")
df_subject_test = read.table("subject_test.txt", col.names = c("SubjectNumber"))
df_Y_test = read.table("Y_test.txt", col.names = c("ActivityCode"))
# Column names for the main observation file come from the Features lookup table
df_X_test = read.table("X_test.txt", col.names = df_features$FeatureName)

# Combine subject, activity and observations into one data frame for test data
df_X_test$SubjectNumber <- df_subject_test$SubjectNumber
df_X_test$ActivityCode <- df_Y_test$ActivityCode

# Load and prepare training data
# setwd("~/Downloads/UCI HAR Dataset/train")
setwd("../train")
df_subject_train = read.table("subject_train.txt", col.names = c("SubjectNumber"))
df_Y_train = read.table("Y_train.txt", col.names = c("ActivityCode"))
# Column names for the main observation file come from the Features lookup table
df_X_train = read.table("X_train.txt", col.names = df_features$FeatureName)

# Combine subject, activity and observations into one data frame for training data
df_X_train$SubjectNumber <- df_subject_train$SubjectNumber
df_X_train$ActivityCode <- df_Y_train$ActivityCode

# Append training data to test data
df_X_total <- rbind(df_X_test, df_X_train)

# Merge with Features lookup to get activity names
# Merge resorts the vector, so use after all cbinds and rbinds
library(dplyr)
df_X_total <- merge(df_X_total, df_activity_labels, all=TRUE)

# Select only the columns of interest
df_select <- select(df_X_total, SubjectNumber, ActivityName, contains("mean."), contains("std."))

# Summarize: calculate average by Subject and Activity
df_output <- df_select %>% group_by(SubjectNumber, ActivityName) %>% summarise_each(funs(mean))

# Write file to disk
# setwd("~/Google Drive/Coursera/Getting and Cleaning Data")
setwd("..")
write.table(df_output, "measurements.txt", row.names=FALSE)
