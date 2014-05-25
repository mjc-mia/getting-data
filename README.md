getting-data
============

Getting and Cleaning Data project

## PURPOSE:  
This is a class project that requires merging two data sets and extracting various metrics from the merged sets.

## SOURCE:  
The two data sets represent training and test sets of wearable computer observations.  The files were obtained from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## ACCOMPANYING DOCUMENTS:
* README.md (this document) - A brief explanation of the project, related documents, procedures and selection criteria for variables to study
* run_analysis.R - Code required to duplicate the study.  It includes greater detail for each step taken.
* code_book.md - Details the meaning of each data set and their variables

## SCOPE:
### Merging Data Sets
The first task in the assignment was to obtain and combine the two data sets.  As stated above, the data sets consist of measurements obtained from wearable computers during various activities.  The data files were divided into two sets representing training and test data for machine learning activities.  The master load included files detailing the measurements or features tracked, and providing keys to the activities that generated the measurements.  Each of the subsidiary test and training sets included a key to the test subjects wearing the computers, a list of the 561 features tracked, and the main data file containing the actual measurements.  Joining each of these 3 files gave a data frame in which each row contained a subject id, an activity id, and 561 measurements generated during the time that individual carried out that particular activity.

Carrying out this task created a data frame called "combineddata."  The actions required are detailed in steps 1-4 in run_analysis.R

The only significant observation in this part is that the extraction of the compressed files was done manually.  A note in the run_analysis.R file indicates it could have been done with unz() function, but that would only be justified as part of the automated extract/transform/load process in a production environment.  For one-time use, it makes more sense to do it manually.

### Extracting Relevant Measurements
The next task was to extract the mean and standard deviation observations for each measurement.  The computers generated 17 different signals that were measured.  These measurements represented changed reported by the acceleromenter and gyroscope in the computer, and included such things as body acceleration in 3-D space.  From these signals, the researchers created 17 metrics for each measurment, including mean, median, standard deviation, and many others. For most of these metrics, there were three observations representing each of the Z, Y, and Z axes.  Further, there were raw observations (prefix "t"), and filtered, transformed measurements (prefix "f").  In all, 561 measurements were recorded for each subject and activity.

Only mean and standard deviation were included in the assignment. To do this, I selected all elements of the feature list (features.txt) that included "means" or "std" in the description.  I then used those lists with the subset() function to create a new data frame with only those columns.

This task was done in step 5 in run_analysis.R  

### Use descriptive activity names
The data frame created in the first task has a column for the activity  id.  To complete this task, we have to add another column with the activity description.  The activity description is in a separate file called activity_labels.txt.  We read the file into a data frame and complete the task by using the merge() function to combine the two data frames.

This task was done in step 6 in run_analysis.R  

The final data set is called "final" and will be uploaded with the name of "final-dataset.txt"

### Create separate data frame with only averages for each subject/activity combination

The desired output is one row per user-activity combination.  We use the aggregate() function
for this and output the data frame under the name "summarydata.csv."

This task is corresponds to step 7 in run_analysis.R


