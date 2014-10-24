GettingCleaningData_Proiject
============================

Getting and Cleaning Data project

see file 'run_analysis.R'.

I create a new data set by merging the train & test data sets.
(features - x_train + x_test and labels - y_train + y_test)

create a new data set for only mean and standard deviation related features

I subset the new data set by the 6 activities and calculate the average of 
each variable for each activity, and then merge back all the result to one
tidy data set.

output file is df.txt

new code book file is selected_features.txt