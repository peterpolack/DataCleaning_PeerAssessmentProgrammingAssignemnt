##It is assumed that all files for these functions are present
##in the working directory

##It is assumed that the reshape2 package is loaded

run_analysis <- function() {
  ##Load the training and test files
  train_data<-combined_activity_column_data("y_train.txt", "subject_train.txt", "x_train.txt")
  test_data<-combined_activity_column_data("y_test.txt", "subject_test.txt", "x_test.txt")
  
  ##Merge the training and test data sets to create one data set.  
  total_data<-rbind(train_data,test_data)
  
  ##Add column names to the data set
  names(total_data) <- add_column_names()
  
  ##Reduce the data set to only include the...
  ##  - Activity type
  ##  - Subject ID
  ##  - Columns containing mean() and std() variables
  total_data<-total_data[,c(1, 2,grep("mean()",names(total_data), fixed=TRUE), grep("std()",names(total_data), fixed=TRUE))]
    
  ##Change the Activity ID present in the total_data data set to the descriptive
  ##Activity text
  activity_labels<-read.table("activity_labels.txt",stringsAsFactors = FALSE)
  total_data$Activity<-factor(total_data$Activity,labels=c(activity_labels[,2]))
  
  ##Create a second, independent tidy data set with the average of each variable
  ##for each activity and each subject. 
  tidy_data_set_avg<-melt(total_data,id=c("Subject","Activity"))
  tidy_data_set_avg<-dcast(tidy_data_set_avg,formula=Subject+Activity~variable,mean)
    
  ##Write tidy_data_set_avg to csv file (with a txt file extension) for submission
  write.csv(tidy_data_set_avg,"tidy_data_set_avg_peter_polack.txt", row.names=FALSE)
  
  ##return tidy_data_set_avgs
  return(tidy_data_set_avg)
}
  

combined_activity_column_data <- function(activity_file, subject_file, data_file) {
  ## 'activity_file' is a character vector that represents the name of the file that
  ## contains the activities to be binded with the other files
  
  ## 'subject_file' is a character vector that represents the name of the file that
  ## contains the subjects (people) to be binded with the other files
  
  ## 'data_file' is a character vector that represents the name of the file that
  ## contains the data collected (by activity and subject) to be binded with the
  ## other files
  
  ## it is assumed that all three files have the exact same number of rows and that
  ## each row contains information relevant information across all thre files (i.e. 
  ## row 1 represents the same data set acros the activity, subject and data files)
  
  ## it is assumed that all three files are in the working directory.
  
  ## Returns the combined files in a single dataframe
  
  activity_table<-data.frame()
  subject_table<-data.frame()
  data_table<-data.frame()
  
  activity_table<-read.table(activity_file)
  subject_table<-read.table(subject_file)
  data_table<-read.table(data_file)
    
  return(cbind(activity_table,subject_table,data_table))
}

add_column_names<-function() {
  ##Reads from the features.txt file to get column names
  data<-read.table("features.txt",stringsAsFactors = FALSE)
  col_names<-(c("Activity","Subject",data[,2]))
  return(col_names)  
}
