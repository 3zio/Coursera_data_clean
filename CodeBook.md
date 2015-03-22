#Coursera: Getting and Cleaning Data- Codebook#

The data used in this project is from the following publication[1]:

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

Refer *README.md* for more information on the data.

##Files in the raw dataset##
The downloaded dataset contains the following files:

- *README.txt*

- *features_info.txt*: Shows information about the variables used on the feature vector.

- *features.txt*: List of all features.

- *activity_labels.txt*: Links the class labels with their activity name.

- *train/X_train.txt*: Training set.

- *train/y_train.txt*: Training labels.

- *test/X_test.txt*: Test set.

- *test/y_test.txt*: Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- *train/subject_train.txt*: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- *train/Inertial Signals/total\_acc\_x\_train.txt*: The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total\_acc\_x\_train.txt' and 'total\_acc\_z\_train.txt' files for the Y and Z axis. 

- *train/Inertial Signals/body\_acc\_x\_train.txt*: The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- *train/Inertial Signals/body\_gyro\_x\_train.txt*: The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 


##Feature Explanation##
The features in this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

- tBodyAcc-XYZ
- tGravityAcc-XYZ
- tBodyAccJerk-XYZ
- tBodyGyro-XYZ
- tBodyGyroJerk-XYZ
- tBodyAccMag
- tGravityAccMag
- tBodyAccJerkMag
- tBodyGyroMag
- tBodyGyroJerkMag
- fBodyAcc-XYZ
- fBodyAccJerk-XYZ
- fBodyGyro-XYZ
- fBodyAccMag
- fBodyAccJerkMag
- fBodyGyroMag
- fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

- mean(): Mean value
- std(): Standard deviation
- mad(): Median absolute deviation 
- max(): Largest value in array
- min(): Smallest value in array
- sma(): Signal magnitude area
- energy(): Energy measure. Sum of the squares divided by the number of values. 
- iqr(): Interquartile range 
- entropy(): Signal entropy
- arCoeff(): Autorregresion coefficients with Burg order equal to 4
- correlation(): correlation coefficient between two signals
- maxInds(): index of the frequency component with largest magnitude
- meanFreq(): Weighted average of the frequency components to obtain a mean frequency
- skewness(): skewness of the frequency domain signal 
- kurtosis(): kurtosis of the frequency domain signal 
- bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
- angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

- gravityMean
- tBodyAccMean
- tBodyAccJerkMean
- tBodyGyroMean
- tBodyGyroJerkMean

##Data Cleaning Process##
The entire code required for the data cleaning process is in the *run_analysis.R* script. The step by step cleaning process is as follows:

1. The data was downloaded from the source URL and unzipped.
2. The entire list of 561 feature labels was read from *features.txt* and stored in the variable *features*.
3. The mapping of activity labels to the activity numbers was read from *activity\_labels.txt* and stored in *activity\_labels*.
4. The set of measurements for training data were read from *X\_train.txt*. This data contained 7352 records. The lists of activity numbers and subject ids for each record were read from *y\_train.txt* and *subject\_train.txt* respectively.
5. All the three data frames were merged to form the training dataset.
6. Steps 4 and 5 were repeated for the testing data.
7. Finally, the features in training and testing data were named as per the features read in step 2. So, feature 1 in both training and testing data was named as the first label in *features*, feature 2 as the second label, and so on.
8. Both the training and testing data frames were merged as the data frame *dataset*.
9. The project required that the final data should contain only features measuring the mean and standard deviation of the measurements. Hence, those feature labels containing *mean()* and *std()* in their names were found using the regular expression matching function *grepl()*. The *fixed* parameter of the function was set to TRUE, otherwise the feature labels containing *meanFreq()* were also matched. Features that were *meanFreq()* were removed since this was a weighted mean and not a regular mean. Finally, only those features related to *mean()* and *std()* were retained in *dataset* using the output of the regex match. This formed a data frame containing 68 columns viz. subject, activity and 66 features.
10. The activity numbers in *dataset* were changed to labels as per the mapping in *activity\_labels*.
11. *dataset* was written to the file *tidy\_data.txt*.
12. Using the functionality of the dplyr package, the mean of each feature in *dataset* was calculated for each combination of subject and activity. This formed a data frame of 180 records, since there were 30 subjects and 6 activities for each. This data frame was written to *avg_tidy_data.txt*.