#Create a local file directory "specdata"
#use this directory as your workig directory throughout the activity. 
#download and unzip the file "UCI_HAR_Dataset.zip" inside the specdata. 
#after this, your are now ready to do the activity. 

#1. Create a R script called run_analysis.R

#1a. Merge the training and the test sets to create one data. 
  Using the function read.table, the user read all the necessary files such as the x,y, subject training and test files. Then by the function rbind, we can combined or merge the rows of x_training_data to the x_test_data and store it to the variable total_of_x, same with the   y_training_data to the y_test_data and store it to the variable total_of_y and with the sub_training_data and sub_tests_data where the results will be stored in the variable total_of_sub. 
  
  we also read a text file "features.txt" that can be used in naming the columns of the variable "total_of_x". we also named the columns of total_of_y by "label" and the columns of total_of_sub by the string "subject". 
  
  And to merge all the data`s we combine the columns of the total_of_sub, total_of_y , total_of_x using the function cbind and store it to the variable "all_data". We also added some code to manipulate the all_data variable wherein we remove the duplicated columns by the function "! duplicated". 
  
#1b. Extracts only the measurements on the mean and the standard deviation for each measurement. 

  Since the R already read the data in the feature.txt, we can now extract the columns that contains either the mean and standard deviation of the data`s in feature.txt by the use of the function "grepl" wherein the user can create a parameters stored in the variable "mean_std" that can extract the desired data. We then used the mean_std to filtered the data in the variable total_of_x in 1a. 

#1c. Uses descriptive activity names to name the activities in the data set. 

  In using the descriptive activity names to name the activities in the data we first read the text file "activity_labels.txt" and convert the activity and subject variables as a factor by the function "factor" and " as.factor". These factors allows us to transformed it into text strings. 
After factoring, we merge the subject, activity and the extractedData. In this way, we can now edit or named the activities in the data set. 

#1d. Appropriately label the data set with descriptive variable names. 

  In this part, the data set column names are being completely stated and not in a shortcut form. With the function "gsub", we are able to enumerate, edit, and correct the names of the columns (ex. from "mag" into "magnitude").
  
#1e. From the data in step 4/1d, create a second, independent tidy data set with the average of each variable for each activity and each subject.

  We are now creating an independent tidy data using the data set that we have formulated in the step 4/ 1d. we first call the library of dplyr for us to use some of its symbols and function to make the tidying of data easier. We then created a variable named "tidy" which includes the calling of extractedData, grouping the the subject and activities and summarized its means. With this function we created a more organized data set with descriptive labels, we can see the final output or the tidy data by calling the function "head" and hit run. 

  

  
