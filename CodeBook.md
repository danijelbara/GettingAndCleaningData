# CodeBook of Course Project Getting And Cleaning Data

##Introduction

This is a codebook that describes the variables, data, and any transformations or work that was performed to clean up the data.
It also describes script run_analysis.R

## Raw data 

Raw data are obtained from UCI Machine Learning repository: [http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

## Information about data set
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

## Script description
The raw data sets are processed with the script run_analysis.R script to create a tidy data set.

__Merge training and test sets__
Merges the training and the test sets to create one data set.

__Extract mean and standard deviation variables__
Extracts only the measurements on the mean and standard deviation for each measurement. 

__Get descriptive activity names__
Uses descriptive activity names to name the activities in the data set

__Get abel variables appropriately__
Appropriately labels the data set with descriptive variable names. 

__Create a tidy data set__
From the data set in previous step, independent tidy data set is created with the average of each variable for each activity and each subject.

##Transformations

Following are the transformations that were performed on the input dataset:

* X_train.txt is read into Train.x.
* y_train.txt is read into Train.y.
* subject_train.txt is read into Train.Subject.
* X_test.txt is read into Test.x.
* y_test.txt is read into Test.y.
* subject_test.txt is read into Test.Subject.
* features.txt is read into Names.x.
* activity_labels.txt is read into Labels.y.

The subjects in training and test set data are merged to form __Subject__.
The activities in training and test set data are merged to form __Activity__.
The features of test and training are merged to form __Features__.
The name of the features are set in features from __Names.x__.

__Features__, __Activity__ and __Subject__ are merged into TotalData.

Indexes of columns that contain standard deviation or mean, activity and subject are taken into ColMeanStd.Init .
SubsetData is created with data from columns in ColMeanStd.Init.
Activity column in SubsetData is updated with descriptive names of activities taken from Labels.y. Activity column is expressed as a factor variable.

Acronyms in variable names in SubsetData, are replaced with descriptive labels:
* Acc was replaced with Accelerometer
* Gyro was replaced with Gyroscope
* BodyBody was replaced with Body
* Mag was replaced with Magnitude
* Character __f__ was replaced with Frequency
* Character __t__ was replaced with Time

FinalData is created as a set with average for each activity and subject of SubsetData. 
Entries in FinalData are ordered based on activity and subject.

## Tidy data set

The tidy data set from FinalData is exported to *tidy_data.txt* where the first row is the header containing the names for each column.
