features <- read.table("UCI HAR Dataset/features.txt", col.names = c("num","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("activityID","activity"))

x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")

y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

# merging train and test
X <- rbind(x_train,x_test)
Y <- rbind(y_train,y_test)
Subj <- rbind(subject_train,subject_test)

# merging X Y and subject info 
merged <- cbind(X,Y, Subj)

#only mean and SD
df <- select(merged, subject,code,contains("std"),contains("mean"))

df$code <- activities[df$code,2]

names(df)[2] = "activity"
names(df)<-gsub("Acc", "Accel", names(df))
names(df)<-gsub("Gyro", "Gyroscope", names(df))
names(df)<-gsub("BodyBody", "Body", names(df))
names(df)<-gsub("Mag", "Magnitude", names(df))
names(df)<-gsub("^t", "Time", names(df))
names(df)<-gsub("^f", "Frequency", names(df))
names(df)<-gsub("tBody", "TimeBody", names(df))
names(df)<-gsub("-mean()", "Mean", names(df), ignore.case = TRUE)
names(df)<-gsub("-std()", "SD", names(df), ignore.case = TRUE)
names(df)<-gsub("-freq()", "Frequency", names(df), ignore.case = TRUE)
names(df)<-gsub("angle", "Angle", names(df))
names(df)<-gsub("gravity", "Gravity", names(df))

df_2 <- group_by(df, subject,activity)
df_3 <- summarise_all(df_2, funs(mean))

# print(head(df_3))
write.table(df_3,"answer.txt",row.name=FALSE)
