#Coursera: Getting and Cleaning Data- Course Project#

The data for this project is from the following source:

__Human Activity Recognition Using Smartphones Dataset(Version 1.0)__,
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws

This data set is from the following publication[1]:

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

##Data Background##

The original data was obtained from experiments carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, they captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments were video-recorded to label the data manually. The obtained dataset was randomly partitioned into two sets, where 70% of the volunteers were selected for generating the training data and 30% the test data.

These datasets consist of a 561-feature vector per record. These features were calculated in the time and frequency domains from the measurements.

##Project Repo Files##
The purpose of this project was to generate two tidy datasets from the given data. Following are the files in this repo:

1. **tidy_data.txt:** This is a dataset consisting of 10299 records. Each record has a 66-feature vector associated with it. Each record consists of a.) An identifier of the subject who carried out the experiment. b.) Its activity label. c.) A 66-feature vector that consists of features filtered out from the original 561 features.
2. **avg\_tidy\_data.txt:** This dataset is obtained by calculating the mean of each feature for each activity and each subject in *tidy_data.txt*. It has 180 records.
3. **run_analysis.R:** This is the R script that generates the two tidy datasets from the given raw data.
4. **CodeBook.md:** This file explains the operations performed on the  raw data in the *run_analysis.R* script. It also explains what each of the variables in the tidy dataset means.
5. **README.md**