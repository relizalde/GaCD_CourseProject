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
4. Appropriately labels the data set with descriptive activity names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

The script works with the "Human Activity Recognition Using Smartphones" data set available at UCI repository. A full description is available at the site where the data was obtained:

> http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones