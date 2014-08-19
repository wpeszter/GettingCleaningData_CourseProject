--------------------------------------------------------------------------------------------------------------------------
Tidy dataset for Getting and Cleaning Data course in Data Science Specialization at https://www.coursera.org/
made by Eszter Windhager-Pokol
--------------------------------------------------------------------------------------------------------------------------
The folder contains the following objects:
README.txt			-	this document
UCI HAR Dataset		-	folder with the raw data
run_analysis.R		-	the R script to create the tidy dataset from the raw data
tidy_dataset.txt		-	the tidy dataset (following the instructions of the course project) 
CodeBook.txt		-	the code book for the tidy dataset, describing the variables
--------------------------------------------------------------------------------------------------------------------------
For running the R script it is assumed that
1. The working directory is set in R
2. The raw data is downloaded and unzipped into the working directory from the following link:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
3. The run_analysis.R is in your working directory

If all of the above is done, then you can run the analysis with the following:
source("run_analysis.R");
tidy_data <- run_analysis()

As the result, the tidy dataset will be created into your working directory with the name of tidy_dataset.txt and the function gives you back the same tidy data.

For reading the tidy_data.txt you can use:
read.table("tidy_dataset.txt", header=TRUE)
--------------------------------------------------------------------------------------------------------------------------
Description of run_analysis.R

The first step is reading the data which is needed for both train and test partitions: variable names for x tables (UCI HAR Dataset/features.txt), activity labels (UCI HAR Dataset/activity_labels.txt).

Then a function called prep_data is defined, which prepares the train/test dataset separately, and we can ensure that both  train and test data is transformed exactly the same way:
-read the x file and matches the coloumn names
-extracts only the measurements on the mean and standard deviation for each measurement
-read the subject and the y files
-join the x, y and the subject files, and fill the coulmn names where needed
-merge the activity labels
-reorder the columns of the dataset, and delete the numeric activity codes

Function prep_data is called for the train and the test data separately and the result datasets are appended.
A tidy data set with the average of each variable for each activity and each subject is created and the column names are set, where needed.
Finally the tidy data is written into a text file called tidy_dataset.txt and the function also gives back the tidy_dataset.




