#CodeBook.md describing the variables.A code book that describes the variables, the data, and any transformations or work that you performed to clean up the data.

	
#Study design:Thorough description of how the data is collected.

Downloaded the zip file, unzip it and assign R variable to data set and label set
*activity_labels.txt label set with 6 activity assign to R variable activity_labels
*features.txt label set with 561 feature variables assign to R variable features
*subject_train.txt data set of 7352 obs. of  1 subject variable: 30 people assign to R variable subject_train
*subject_test.txt data set of 2947 obs. of  1 subject variable: 30 people assign to R variable subject_test
*X_train.txt data set of 7352 obs. of  561 feature variables assign to R variable x_train
*X_test.txt data set of 2947 obs. of  561 feature variables assign to R variable x_test
*y_train.txt data set of 7352 obs. of  1 activity variable: 6 activity assign to R variabley_train
*y_test.txt data set of 2947 obs. of  1 activity variable: 6 activity assign to R variable y_test

	
unify the 6 data set into a single R variable one_data_set and also include the label names.
*Change from factors to character for features data
*assign variable names of x_train to features data 	
*assign variable names of y_train to activity	
*assign variable names of subject_train to subjectid
*assign variable names of x_test to features data 
*assign variable names of y_test to activity
*assign variable names of subject_test to subjectid
*col bind subject train with y then x and assigned to R variable train_data
*col bind subject test with y then x and assigned to R variable test_data	
*row bind train and test data to create R variable one_data_set


Extract the required data variable	
*grep "mean()|std()" from the required data id from R variable one_data_set and assigned the extract data set to R variable extract_data_set


replace the activity from number id to description of activity using the R variable activity_labels
*Change from factors to character for R variable activity_labels
*assign the activity name of R variable activity_labels to the R variable extract_data_set 


make the variables readable
*uses sub() or gsub() to describe the labels in R variable extract_data_set
*all variable start with t(time), the unit is in second
*all variable start with f(frequency), the unit is in Hertz


calculate the average of each selected features variable by using melt() and dcast(), 
then melt() again to get the long form and order it using order()
*uses melt() to get the list of variables to calcualte mean and assigned to R variable new_data
*uses dcast() to find the mean for the variables from melt()and assigned to R variable final_data
*melt() again to get the data in the long form and assigned to R variable final_data_set
*Order the data for readability using order() and assigned to R variable order_final_data_set
*Rename to variable and value label column using sub()
	

# Code Book:Tidy data variables

The varibles of the final tidy data
[1]    "subjectid"            "activity"          "feature with mean/std"                 "average" 
	30 person              6 activity          measurement with mean/std               average of the same observation
units   person		 type of activity    	   time...				    second
						   frequency...			            Hertz
																			

			