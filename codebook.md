Original dataset
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


Data Set Information

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The following files from original data set are used:

'features.txt': List of 561 features measured (their IDs and names)

'activity_labels.txt': Contains names of 6 different activities conducted by each of participating subjects.

'train/X_train.txt': Contains measurments of all features from features.txt for each subject participating in the training set.
There are 7352 different observations.

'train/y_train.txt': In each rows there is ID of subject for which observation in train X are done.

'test/X_test.txt':  Contains measurments of all features from 'features.txt' for each subject participating in test set.
There are 2947 different observations.

'test/y_test.txt': In each rows there is ID of subject for which observation in 'X_test.txt' are done.



Script creates an independent tidy data set with the average of each variable for each activity and each subject and stores it in 'final.txt'.

Solution is divided in 3 parts:

1. Working on data from test folder and creating single table from it
2. Working on data from training folder and creating single table from it
3. Merging training and test data, and creating summary:
			by subjects (1st column), averages are given by activity (2nd column) for each of activities measuded (3rd +)

There is additional info in the comments.

