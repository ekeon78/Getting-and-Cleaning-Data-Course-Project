## To download the zip file from web and save as getdata.zip in the working directory using download.file()
	fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
	download.file(fileUrl, destfile = "getdata.zip", method="curl")
	dateDownloaded <- date()


## Unzip getdata.zip using unzip()
	unzip("getdata.zip")


## Assign 6 data sets and 2 label sets from getdata folder files to R variables using read.table()
	
	## activity_labels.txt label set with 6 activity assign to R variable activity_labels
		activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE)

	## features.txt label set with 561 feature variables assign to R variable features
		features <- read.table("./UCI HAR Dataset/features.txt", header = FALSE)

	## subject_train.txt data set of 7352 obs. of  1 subject variable: 30 people assign to R variable subject_train
		subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)

	## subject_test.txt data set of 2947 obs. of  1 subject variable: 30 people assign to R variable subject_test
		subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)

	## X_train.txt data set of 7352 obs. of  561 feature variables assign to R variable x_train
		x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)

	## X_test.txt data set of 2947 obs. of  561 feature variables assign to R variable x_test
		x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)

	## y_train.txt data set of 7352 obs. of  1 activity variable: 6 activity assign to R variable y_train
		y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)

	## y_test.txt data set of 2947 obs. of  1 activity variable: 6 activity assign to R variable y_test
		y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE)


## 1) Merges the 3 training and the 3 test data sets to create R variable one_data_set using cbind() and rbind().
## (label the 6 data sets with the 561 features label set, subjectid and activity using names() and for() loop)

	## Change from factors to character for features data
		features[,2] <- as.character(features[,2])

	## assign variable names of x_train to features data 
		for(i in 1:length(x_train)){names(x_train)[i] = features[i,2]}
	
	## assign variable names of y_train to activity
		names(y_train) = "activity"
	
	## assign variable names of subject_train to subjectid
		names(subject_train) = "subjectid"

	## assign variable names of x_test to features data 
		for(i in 1:length(x_test)){names(x_test)[i] = features[i,2]}
	
	## assign variable names of y_test to activity
		names(y_test) = "activity"
	
	## assign variable names of subject_test to subjectid
		names(subject_test) = "subjectid"

	## col bind subject train with y then x and assigned to R variable train_data
		train_data <- cbind(subject_train,y_train)
		train_data <- cbind(train_data, x_train)

	## col bind subject test with y then x and assigned to R variable test_data
		test_data <- cbind(subject_test,y_test)
		test_data <- cbind(test_data, x_test)

	## row bind train and test data to create R variable one_data_set
		one_data_set <- rbind(train_data,test_data)


## 2) Extracts only the measurement variables that are mean and standard deviation for each observation of R variable one_data_set 
## using grep() and assign to R variable extract_data_set. 

	## grep "mean()|std()" from the required data id from one_data_set and assigned the extract data set to R variable extract_data_set
		extract <- grep("mean()|std()", names(one_data_set))	
		extract_data_set <- one_data_set[,c(1:2,extract)]
		extract_data_set <- extract_data_set[,!grepl("meanFreq",names(extract_data_set))] 
	

## 3) Uses descriptive activity names of activity_labels to name the activities in the R variable extract_data_set using for() loop

	## Change from factors to character for R variable activity_labels
		activity_labels[,2] <- as.character(activity_labels[,2])

	## assign the activity name of R variable  activity_labels to the R variable extract_data_set 
		for(j in 1:length(extract_data_set[,2]))
		{
			if(extract_data_set[j,2] == 1) {extract_data_set[j,2] <- activity_labels[1,2]}
			if(extract_data_set[j,2] == 2) {extract_data_set[j,2] <- activity_labels[2,2]}
			if(extract_data_set[j,2] == 3) {extract_data_set[j,2] <- activity_labels[3,2]}
			if(extract_data_set[j,2] == 4) {extract_data_set[j,2] <- activity_labels[4,2]}
			if(extract_data_set[j,2] == 5) {extract_data_set[j,2] <- activity_labels[5,2]}
			if(extract_data_set[j,2] == 6) {extract_data_set[j,2] <- activity_labels[6,2]}
		}


## 4) Appropriately labels the data set with descriptive variable names in R variable  extract_data_set using sub().
	
	## uses sub() to describe the labels in R variable extract_data_set
	names(extract_data_set) <- sub("BodyAccJerk","bodylinearacceleration",names(extract_data_set))
	names(extract_data_set) <- sub("BodyGyroJerk","bodyangularvelocity",names(extract_data_set))
	names(extract_data_set) <- sub("BodyGyro","bodygyro",names(extract_data_set))
	names(extract_data_set) <- sub("BodyAcc","bodyacceleration",names(extract_data_set))
	names(extract_data_set) <- sub("GravityAcc","gravityacceleration",names(extract_data_set))
	names(extract_data_set) <- sub("Mag","magnitude",names(extract_data_set))
	names(extract_data_set) <- sub("^t","time",names(extract_data_set))
	names(extract_data_set) <- sub("^f","frequency",names(extract_data_set))
	names(extract_data_set) <- sub("X","x",names(extract_data_set))
	names(extract_data_set) <- sub("Y","y",names(extract_data_set))
	names(extract_data_set) <- sub("Z","z",names(extract_data_set))
	names(extract_data_set) <- gsub("-","",names(extract_data_set))
	

		

## 5) creates a second, independent tidy data set from extract_data_set with the average of each variable for each activity and each subject. 
## using melt() to create the list of variables to calculate the mean, dcast() to find mean of the variables
## melt to get the final_data_set in the long form and use order() to get the order_final_data_set for easy readability	
	
	library(reshape2)
	## uses melt() to get the list of variables to calcualte mean and assigned to R variable new_data
	new_data <- melt(extract_data_set, id =c("subjectid", "activity"), measure.vars = names(extract_data_set[,3:68]))
	## uses dcast() to find the mean for the variables from melt()and assigned to R variable final_data
	final_data <- dcast(new_data, subjectid + activity ~ variable, mean)
	## melt() again to get the data in the long form and assigned to R variable final_data_set
	final_data_set <- melt(final_data, id =c("subjectid", "activity"), measure.vars = names(final_data[,3:68]))
	## Order the data for easy readability using order() and assigned to R variable order_final_data_set
	order_final_data_set <- final_data_set[order(final_data_set[,1],final_data_set[,2]),]
	## Rename to average for the value label column using sub()
	names(order_final_data_set) <- sub("^value","average",names(order_final_data_set))
	names(order_final_data_set) <- sub("^variable","feature with mean/std",names(order_final_data_set))

## upload orde_final_data_set as a txt file created with write.table() using row.name=FALSE into file datatable.txt
	
	write.table(order_final_data_set, "./datatable.txt", row.name=FALSE ) 