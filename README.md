getting-data
============

Getting and Cleaning Data project

## PURPOSE:  
This is a class project that requires merging two data sets and extracting various metrics from the merged sets.

## SOURCE:  
The two data sets represent training and test sets of wearable computer observations.  The files were obtained from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## ACCOMPANYING DOCUMENTS:
* README.md (this doucument) - A brief explanation of the project, related documents, procedures and selection criteria for variables to study
* run_analysis.R - Code required to duplicate the study.  It includes greater detail for each step taken.
* code_book.md - Details the meaning of each data set and their variables

## SCOPE:
### Merging Data Sets
The first task in the assignment was to obtain and combine the two data sets.  As stated above, the data sets consist of measurements obtained from wearable computers during various activities.  The data files were divided into two sets representing training and test data for machine learning activities.  The master load included files detailing the measurements or features tracked, and providing keys to the activities that generated the measurements.  Each of the subsidiary test and training sets included a key to the test subjects wearing the computers, a list of the 561 features tracked, and the main data file containing the actual measurements.  Joining each of these 3 files gave a data frame in which each row contained a subject id, an activity id, and 561 measurements generated during the time that individual carried out that particular activity.

Carrying out this task created a data frame called "combineddata."  The actions required are detailed in steps 1-4 in run_analysis.R

### Extracting Relevant Measurements
The next task was to extract the mean and standard deviation observations for each measurement.



