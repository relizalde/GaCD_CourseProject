## Getting and Cleaning Data - Course Project

The purpose of this project is to demonstrate my ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

This repository include the following files:
* README.md - Describes the purpose and goal of the project 
* CodeBook.md - Describes the variables, the data, and all transformations performed to clean up the data 
* run_analysis.R - Script for performing the analysis

The R script does the following tasks: 

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive feature names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### DATA
The script works with the "Human Activity Recognition Using Smartphones" data set available at UCI repository. A full description is available at the site where the data was obtained:

> http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The script will verify if the file is already downloaded and unzipped. If not it will download the file to a temporary file and unzipped in the working directory.

There are several files in the dateset but the following are the ones that the script needs:
* 'features.txt': List of all features.
* 'activity_labels.txt': Links the class labels with their activity name.
* 'train/X_train.txt': Training set.
* 'train/y_train.txt': Training labels.
* 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample.
* 'test/X_test.txt': Test set.
* 'test/y_test.txt': Test labels.
* 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample.

### VARIABLES
#### Raw Data
The following variables save the data from the corresponding file:
* features: A 561-feature vector with time and frequency domain variables. All are estimations on the following signals:
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
* activity_labels: Links the class labels with their activity name

|id  | Name
|--- | :---:
| 1  | WALKING
| 2  | WALKING_UPSTAIRS
| 3  | WALKING_DOWNSTAIRS
| 4  | SITTING
| 5  | STANDING
| 6  | LAYING

* subject_test: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
* X_test: data.frame with the test set
* y_test: data.frame with the test labels
* subject_train: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
* X_train: data.frame with the training set
* y_train: data.frame with the training labels

#### Merged Data
* subjects: data.frame that contains the test and train subjects
* lblActivity: data.frame that contains the name of the activity associated to each row 
* allData: data.frame that contains the test and train data
* cn: it contains the clean columns names from features data.frame
* FinalDataset: data.frame that contains the subjects, name of activities and the data for all the features

#### Data Analysis
* MeanStdDataset: data.frame that contains the subjects, name of activities and the data for the features related to mean and standard deviation calculations
* MeltDataset: the result data.frame of a melting process on the subjects and activities variables
* AverageDataset: data.frame that contains the average of each variable for each activity and each subject

### SUMMARY
#### Processing Steps 
- Download and unzip the dataset from UCI if is not in the working directory
- Read raw data from files and save it to data.frame variables
- Merges the training and the test sets to create one data set. This step include the subjects and activity names.
- Assign the column names from the features table after cleaning them. The cleaning process consists in the following:
 + Change '-' for '.'
 + Change ',' for '_'
 + Delete '(' and ')'
- Subset the dataset in order to get just means and standard deviation calculations using `grep` function.
- Using `melt` and `dcast` functions, a data.frame (`AverageDataset`) that contains the average of each variable for each activity and each subject is created.
- Write `AverageDataset` in a file.

#### Important Considerations
*Naming*

Column names were assigned from the features file. Due to the length of the names and number of columns, I have used a combination of '.', '_' and capitals in order to make the names more understandable. This cleanng process was made using `gsub` function.

*Selecting mean and standard deviation measurements*

In order to achieve this we use the `grep` function. We looked for every column that contains 'mean' or 'std in the name but with the exception of the *angle* related measures. 

These *angle* related measures are the only ones that have the mean function with capital letter (Mean) so it was easy to neglect them.

*Installed packages*

For using `melt` and `dcast` functions the `reshape2` package needs to be installed. The script installed it and load it if it's not present.
