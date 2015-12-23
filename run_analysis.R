library(data.table)
library(reshape2)

if (!grepl("UCI HAR Dataset",getwd())){
  setwd("./UCI HAR Dataset")}

# Load: activity names. Omits first column because it contains only row numbers and is not necessary.
activityTypes <- read.table("./activity_labels.txt")[,2]

# Load: Names of features measured
features <- read.table("./features.txt")[,2]

# Extract only the measurements on the mean and standard deviation for each measurement.
featuresNeeded <- grepl("mean|std", features)



####### Part 1: Reshaping of test data

## Reshaping of X_test data
# Step 1:properly name al the columns(variables). 561 unnamed variables from X_test are named properly.
# Step 2:Leave only columns which contain info on mean and standard deviation.
xTest <- read.table("./test/X_test.txt")
names(xTest) = features
xTest = xTest[,featuresNeeded]

## Reshaping of Y_test data. At the beggining, it contains one column with index of activities for 2947 observations.
# step 1: We add another column with names of corresponding activities
# step 2: properly name columns
yTest <- read.table("./test/y_test.txt")
yTest <- cbind(yTest, activityTypes[yTest[,1]])
names(yTest) = c("activityID", "activityType")

## combining x_test and Y_test
#step 1: Loading subject_test.txt table which links each of 2947 observations (activities) to person who performed activity
#step 1: Naming the variable properly
#step 2: forming the new table with full info on all of 2947 observation: person, activity name, mean and std data.
testSubjects <- read.table("./test/subject_test.txt")
names(testSubjects) = "subject"
testData <- cbind(as.data.table(testSubjects), yTest, xTest)




####### Part 2: Reshaping of training data (7352 observations). Same principles apply as above.

# Tidying of X_train: Load  data, properly name columns and leave only required
xTrain <- read.table("./train/X_train.txt")
names(xTrain) = features
xTrain = xTrain[,featuresNeeded]

# Tidying of Y_train (adding name of activity for each obsevration):
yTrain <- read.table("./train/y_train.txt")
yTrain <- cbind(yTrain, activityTypes[yTrain[,1]])
names(yTrain) = c("activityID", "activityType")

# Combining training files into one table:
# step1: Loading subject_train.txt which contains info on persons(subjects) performing activity
# step2: Naming column properly
# step3: Creating new table with all the info on person, activity name, mean and std data.
trainSubjects <- read.table("./train/subject_train.txt")
names(trainSubjects) = "subject"
trainData <- cbind(as.data.table(trainSubjects), yTrain, xTrain)


##### Part 3: Generating final data

# step1: Merge test and train data, so they now show observations on both training and test data
data = rbind(testData, trainData)

# step2: Creating 'long' data, so different features measured (from features.txt) are now seen as one variable
longData = melt(data, c("subject", "activityID", "activityType"))

# step3: Calculating mean of all measurments for each person using dcast function.
finalData   = dcast(longData, subject + activityType ~ variable, mean)

write.table(finalData, file = "./final.txt")
