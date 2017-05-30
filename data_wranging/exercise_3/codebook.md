The UCI HAR Dataset includes 28 files.  

18 of these (in Inertial Signals folders) are subsets of the summary datasets we've been asked to work with (which have been prefixed X_) and will not be used in this project.

X_test and X_train contain just the measurements from the test.  

In order for the data to be well understood, I appended to this file: 
	categorical label (1-6) for the activity being measured: contained in y_test and y_train respectively 
	information regarding the individual (subject) on whom the test is being performed: contained in subject_test and subject_train respectively
	column headers describing what is being measured: these are the same for both test and train sets, and are contained in features.txt

I also chose to add a descriptor column in each set which contains either "test" or "train", in order that we might be able to distinguish these entries in some future project. 

Data sets were then merged together.  

The assignment asked that two columns be created with average and standard deviation for each row's data.  Although the interpretive value of such measures is questionable, I created these columns, being careful to exclude columns that contain non-integer information.    

In order to name the activities associated with each label, I executed a left join of the main data set with the data from activity_lables.txt file.  This comprehensive data set is labeled samsung4. 

Finally, in order to create a tidy data set that includes only summary statistics (by activity and also by subject) from the main data file, I ran the aggregate command twice (one for each grouping approach), saving them separately and then merging them back together.  This file was saved as samsung_tidy.csv. 


 
