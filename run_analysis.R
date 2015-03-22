# Coursera- Getting and Cleaning Data- Course Project

# Download the data if not present
if(!file.exists('data_clean_project.zip')){
    data_url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
    download.file(url = data_url, destfile = 'data_clean_project.zip', mode = 'wb')
    unzip('data_clean_project.zip')
    rm(data_url)
}

# Read the feature names and activity labels
features <- read.table(file = './UCI HAR Dataset/features.txt', sep = ' ',
                       colClasses = c('NULL', 'character'))
features <- features[1:nrow(features),]

activity_labels <- read.table(file = './UCI HAR Dataset/activity_labels.txt', sep = ' ',
                              colClasses = rep('factor', 2),
                              col.names = c('activity_num', 'activity'))

# Read the train data files and merge them
conn <- file('./UCI HAR Dataset/train/subject_train.txt', open = 'r')
subject_train <- as.factor(as.numeric(readLines(con = conn)))
close(conn)

conn <- file('./UCI HAR Dataset/train/y_train.txt', open = 'r')
activity_train <- as.factor(as.numeric(readLines(con = conn)))
close(conn)

x_train <- read.table(file = './UCI HAR Dataset/train/X_train.txt', header = F)

train <- cbind(subject_train, activity_train, x_train)
rm(subject_train, activity_train, x_train)

# Read the test data files and merge them
conn <- file('./UCI HAR Dataset/test/subject_test.txt', open = 'r')
subject_test <- as.factor(as.numeric(readLines(con = conn)))
close(conn)

conn <- file('./UCI HAR Dataset/test/y_test.txt', open = 'r')
activity_test <- as.factor(as.numeric(readLines(con = conn)))
close(conn)

x_test <- read.table(file = './UCI HAR Dataset/test/X_test.txt', header = F)

test <- cbind(subject_test, activity_test, x_test)
rm(subject_test, activity_test, x_test)

rm(conn)

# Name the columns in train and test, merge them and keep only columns corresponding to mean and std
# measurements
names(train) <- c('subject', 'activity', features)
names(test) <- c('subject', 'activity', features)
dataset <- rbind(train, test)
rm(train, test, features)

mean_col <- grepl(pattern = 'mean()', x = names(dataset), fixed = T)
std_col <- grepl(pattern = 'std()', x = names(dataset), fixed = T)
cols <- mean_col | std_col
cols[c(1,2)] <- c(T, T)
dataset <- dataset[, cols]
rm(cols, mean_col, std_col)

# Label the activity factors
dataset$activity <- factor(x = dataset$activity, levels = 1:6, labels = activity_labels$activity)
rm(activity_labels)

# Write the dataset to the directory
write.table(x = dataset, file = 'tidy_data.txt', row.names = F)

# Create the second tidy dataset
library(dplyr)

dataset <- tbl_df(dataset)

avg_data <- dataset %>% group_by(subject, activity) %>% summarise_each(funs(mean))

write.table(x = avg_data, file = 'avg_tidy_data.txt', row.names = F)