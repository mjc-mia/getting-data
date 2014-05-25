# PURPOSE:  This is a class project that requires merging two data sets and
# extracting various metrics from the merged sets.

# SOURCE:  The two data sets represent training and test sets of wearable
# computer observations.  The files were obtained from
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# SCOPE:  
#   A. Steps 1-4 merge the two data sets


#  1. Create directory for project
if (!file.exists("project")) {
        dir.create("project")
}
setwd("./project")

# 2. Download file
url=" https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "projectdata")

# 2. Unzip file either manually or using unz() function.  If this procedure were
# part of a regular business cycle, then it would make sense to automate this
# step, but as part of a one-time extract/transform/load, it makes more sense to
# extract the six files manually.  

# 3. Create one data frame for training data and one for test data in 
# anticipation of merging the two.  Each new data frame will combine the data
# frames that contain the subject id, the activity id, and the measurements.

# 3a. Read the test csv files, bind into data frame & add column labels

subjectid = read.table("./test/subject_test.txt") ; names(subjectid) = c("subjectid")
activityid = read.table("./test/Y_test.txt") ; names(activityid) = c("activitycode")
measurements = read.table("./test/X_test.txt")
featurenames=read.table("features.txt", stringsAsFactors=F)
names(measurements) = featurenames$V2
# if using R Studio, the Environment window will show all 3 files with same # records
testdata=cbind(subjectid, activityid, measurements)

# 3b. Read the training csv files & bind into data frame

subjectid = read.table("./train/subject_train.txt") ; names(subjectid) = c("subjectid")
activityid = read.table("./train/Y_train.txt") ; names(activityid) = c("activitycode")
measurements = read.table("./train/X_train.txt")
names(measurements) = featurenames$V2
# if using R Studio, the Environment window will show all 3 files with same # records
traindata=cbind(subjectid, activityid, measurements)

# 4 Merge the two data sets
combineddata =  rbind(testdata, traindata)


# 5 Create subset of the combined data frame containing only means and standard deviation observations

# 5a Create list with feature names that have "means" or "std" in name
meanscolumns=subset(featurenames$V2, grepl("(^.*[Mm]ean.*$)", featurenames$V2))
stdcolumns=subset(featurenames$V2, grepl("(^.*[Ss]td.*$)", featurenames$V2))


# 5b Create subset using desired columns

meansubset=subset(combineddata, select=meanscolumns)
stdsubset=subset(combineddata, select=stdcolumns)
meansandstd=cbind(combineddata$activitycode, combineddata$subjectid, meansubset, stdsubset)
names(meansandstd)[2]="subjectid" ; names(meansandstd)[1]="activitycode"

#6 Use descriptive activity names

# 6a Read the activity_labels.txt file into a data frame
activitynames = read.table("activity_labels.txt")
names(activitynames) = c("activity", "activityname")

# 6b Merge activitynames and  meansandstd data frames using activity id as key

# To prevent a name clash with previous data frame, rename activity code.  Would not be needed
# if intermediary data sets had been deleted--I kept them in case I needed to go back.
names(meansandstd)[1]="activityidx"
names(activitynames)[1]="activityidx"
final=merge(activitynames, meansandstd, by="activityidx")
names(final)[1]="activitycode"

# 6c Write out finished file
write.csv(final, "final-dataset.csv")





