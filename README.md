# README 

## General

This is an R script to preprocess and tidy the UCI HAR dataset, available from
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Prerequisites

It is assumed that the UCI HAR dataset has been downloaded and extracted, while keeping the original folder structure unchanged.

## Usage

### Parameters
The script accepts a single parameter which indicates the root folder of the UCI HAR dataset. The root folder is the folder containing the folders train and test and files such as activity_labels.txt.

### Call
`cleandataset <- run_analysis(root_folder_of_UCIHAR_dataset)`
where eg. `root_folder_of_UCIHAR_dataset<-"data/UCI HAR Dataset"`

### Output
The script returns a cleaned dataset as a data.frame which only contains the mean of each original mean() and std() variable of the original dataset, computed per subject and activity type. Cf. CodeBook.md for a description of the variables of the returned dataset.


