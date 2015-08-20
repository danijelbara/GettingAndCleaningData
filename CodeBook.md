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

## Tidy data set

The tidy data set contains :

* an identifier of the subject who carried out the experiment (__Subject__). Its range is from 1 to 30. 
* an activity label (__Activity__): WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
* mean of all other variables are measurement collected from the accelerometer and gyroscope 3-axial raw signal (numeric value)

The tidy data set is exported to tidy_data.txt where the first row is the header containing the names for each column.