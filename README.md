DataCleaning_PeerAssessmentProgrammingAssignemnt
================================================
It is assumed that all files for these functions are present in the working directory

It is assumed that the reshape2 package is loaded

run_analysis
============
run_analysis is the primary function that...
 - loads the data files (via the 'combined_activity_column_data' function)
 - merges the data files
 - adds the column names (via the 'add_column_names' function)
 - Eliminates columns without 'mean()' and 'std()' in them
 - Changes Activity ID to their corresponding Activity text
 - Creates a tidy data set with the average of each variable for each activity and each subject. 
 - Writes a file of the new tiday data set
 - Returns the tidy data set

combined_activity_column_data(activity_file, subject_file, data_file)
=====================================================================
The combined_activity_column_data(activity_file, subject_file, data_file) function combines the three provided files and...
  - 'activity_file' is a character vector that represents the name of the file that contains the activities to be binded with the other files
  - 'subject_file' is a character vector that represents the name of the file that contains the subjects (people) to be binded with the other files
  - 'data_file' is a character vector that represents the name of the file that contains the data collected (by activity and subject) to be binded with the other files
  
It is assumed that all three files have the exact same number of rows and that each row contains information relevant  information across all thre files (i.e. row 1 represents the same data set acros the activity, subject and data files)
  
It is assumed that all three files are in the working directory.  

The function returns the combined files in a single dataframe
  

add_column_names
================
This function reads from the features.txt file to get column names and returns those column names
