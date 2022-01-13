
setwd("C:/Users/Jerry Ann/Desktop/specdata")

getwd()

#step1/1a. Merging the training and test sets into one data set

# Read data training and testing data

x_training_data   <- read.table("./train/X_train.txt")
y_training_data   <- read.table("./train/Y_train.txt")
sub_training_data <- read.table("./train/subject_train.txt")

x_tests_data      <- read.table("./test/X_test.txt")
y_tests_data      <- read.table("./test/Y_test.txt") 
sub_tests_data    <- read.table("./test/subject_test.txt")

#Merging data

total_of_x        <- rbind(x_training_data , x_tests_data)
total_of_y        <- rbind(y_training_data , y_tests_data) 
total_of_sub      <- rbind(sub_training_data, sub_tests_data )



features_label    <-read.table("features.txt", header=FALSE)

#naming the columns

colnames(total_of_x)   <- features_label$V2
colnames(total_of_y )  <- "activity"
colnames(total_of_sub) <- "subject"


#final merge data

all_data <- cbind(total_of_sub, total_of_y , total_of_x   )
all_data <- all_data [, ! duplicated (colnames(all_data))]

#step2/1b. Extract only the measurements on the mean and standard deviation for each measurement.



mean_std  <-  grepl("(-std\\(\\)|-mean\\(\\))",features_label$V2)  # identify all the features that are either standard deviations or means of measurements

extractedData <- total_of_x [, which(mean_std == TRUE)]            #remove columns that are not means or standard deviation features

#Step 3/1c. Uses descriptive activity names to name the activities in the data set.

activity_labels <- read.table("./activity_labels.txt")             #read the text file

# convert the activity codes to a factor 
activity <- factor(all_data$activity, level =  activity_labels [ , 1], labels = c("WALKING", "WALKING_UPSTAIRS","wALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))


subject <- as.factor(all_data$subject)                             # transforming the subject codes to factors


extractedData <- cbind(subject, activity, extractedData)           #merge the subject, activity



#1d. Appropriately label the data set with descriptive variable names.

extractedData1<-gsub ("tBody", "time-Body", names(extractedData), ignore.case=FALSE)
extractedData1<-gsub ("tGravity", "time-Gravity", extractedData1, ignore.case=FALSE)
extractedData1<-gsub ("Mag", "Magnitude", extractedData1, ignore.case=FALSE)
extractedData1<-gsub ("Gyro", "Gyroscope", extractedData1, ignore.case=FALSE)
extractedData1<-gsub ("Acc", "Accelerometer", extractedData1, ignore.case=FALSE)
extractedData1<-gsub ("fBody", "fastFourierTransform-Body", extractedData1, ignore.case=FALSE)
extractedData1<-gsub ("Freq", "Frequency", extractedData1, ignore.case=FALSE)
extractedData1<-gsub ("BodyBody", "Body", extractedData1, ignore.case=FALSE)

colnames(extractedData)<-extractedData1

#Step 5/1e. Creates a second, independent tidy data set with the average of each variable for each label and each subject.
library(dplyr)

tidy <-extractedData %>%
  group_by(subject, activity) %>%
  summarise_each(funs(mean))

head(tidy)
