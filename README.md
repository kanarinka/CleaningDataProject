# Creating a tidy data set from the UCI HAR Dataset
The run_analysis.R script takes the sensor data in the subfolder "UCI HAR Dataset" and creates a summary tidy data set "tidy_data_set.csv".

## Transformations on the original data set

The run_analysis.R script does the following transformations on the dataset in the subfolder:
1. Merges the training and the test data sets 
2. Extracts the measurements that have to do with mean and standard deviation - These are all the measurements that included "mean()" or "std()" in their feature label.  
3. Uses activity labels ("WALKING", "STANDING") to name the activities in the data set
4. Renames the variables to more descriptive names e.g. tBodyAcc.mean.X while still preserving their relation to the original variable name so they can be traced back to the prior data set
5. Writes a CSV file with a tidy data set with the mean of each variable for each activity and each subject.