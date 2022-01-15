### Description

The R script in this repo "run_analysis.R" makes a tidy dataset from the "UCI HAR Dataset". The original data contains 7352 observations in the X_train set and 2947 observations in the X_test set each of 561 variables. It also has Y_train and Y_test data showing which activity (out of 6 different ones) was the data collected for. Finally the subject_train and subject_test shows which subject (out of 30 people) was the data collected for.  

The R script merges the train and test data and selects only the mean and standard deviation measurements (79 variables) from the 561 variables. It then groups the data by subject and the activity they performed, and finds the mean and standard deviation of the selected variables for each group.  

Thus the final data has 180 observations (30x6 for each person and each activity) of 160 variables (2*79 mean and standard deviation of the selected variables + subject and activity columns)

### Running the script

The "run_analysis.R" script must be in the **same directory** as "UCI HAR Dataset" folder (NOTE : script should NOT be in the "UCI HAR Dataset" folder, both should be in the same directory)  

The packages *dplyr* and *data.table* must be installed for the script to run.

### Reading the tidy dataset

The script writes the tidy data onto a text file "TidyData.txt". This file has also been included in the repo. To read the txt file use *fread()* from *data.table* package, only the filename argument has to be given.
