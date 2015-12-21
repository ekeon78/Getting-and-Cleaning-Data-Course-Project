# Getting-and-Cleaning-Data-Course-Project

# README.md in the repo describing how the script works. This repo explains how all of the scripts work and how they are connected.

*Step 1: to download the zip file from web and save as getdata.zip in the working directory using download.file()

*Step 2: Unzip getdata.zip using unzip()

*Step 3: assign 6 data sets and 2 label sets from getdata folder files to R variables using read.table()

*Step 4: merges the 3 training and the 3 test data sets to create R variable one_data_set using cbind() and rbind().(label the 6 data sets with the 561 features label set, subjectid and activity using names() and for() loop)

*Step 5: extracts only the measurement variables that are mean and standard deviation for each observation of R variable one_data_setusing grep() and assign to R variable extract_data_set. 

*Step 6: uses descriptive activity names of activity_labels to name the activities in the R variable  extract_data_set using for() loop.

*Step 7: appropriately labels the data set with descriptive variable names in R variable  extract_data_set using sub().

*Step 8: creates a second, independent tidy data set from extract_data_set with the average of each variable for each activity and each subject. using melt() to create the list of variables to calculate the mean, dcast() to find mean of the variablesmelt to get the final_data_set in the long form and use order() to get the order_final_data_set for readability

*Step 9: upload orde_final_data_set as a txt file created with write.table() using row.name=FALSE into file datatable.txt