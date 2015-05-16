# Code Book 

## General
This document describes the variables and structure of the data.frame returned by the run_analysis.R script after cleaning and summarising the UCI HAR dataset, originally from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Structure
The returned dataframe is tidy in the sense that

* each variable is in one column; the variables are 
    + 66 mean values of the original mean() and std() variables
    + one subject ID
    + one activity name
* each observation is in one row 
    + an observation is a set of mean values of measurements resulting from a named activity done by one subject
* there is exactly one table since all variables are considered of the same type, ie. means of accelerometer measurements

## Data Dictionary

* SubjectID
    + Unique identifier of the subject which performed an activity for data collection
    + integer in range 1..30
* ActivityName
    + Name describing the activity performed during the measurement
    + string in the set WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
* 66 variables which provide mean values of different sensor measurements
    + float data type, normalized in range -1..1
    + variable names have the concatenated structure DOMAIN,MEASUREMENT TYPE, STATISTIC, 3D DIMENSION
        + DOMAIN can be frequency or time domain
        + MEASUREMENT TYPE can be BodyAcceleration[|Jerk|Magnitude|JerkMagnitude], GravityAcceleration[|Jerk|Magnitude|JerkMagnitude], BodyGyro[|Jerk|Magnitude|JerkMagnitude]
        + STATISTIC can be Mean or Std
        + 3D DIMENSION can be X,Y,Z  

## Summary Choices
The test and training sets were merged. From the original 561 variables, only the 66 mean and std variables were selected. For all  observations of each distinct set (SubjectID, ActivityName), the mean of these variables was computed. The activity labels were replaced with their descriptive names, and the variable names were expanded for better clarity based on the original feature descriptions in features_info.txt.

## Study Design
For detailed information on the study setup, cf http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Citation from the website:
*The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.*

