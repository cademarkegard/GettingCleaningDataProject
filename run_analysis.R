library(dplyr)
library(tidyr)
#Assumes you are in the folder UCI\ HAR\ Dataset/
#read in the column names from the features file
colnames<-read.table("features.txt")
colnames<-colnames$V2

#now read in the test and training data 
testdata<-read.table("test/X_test.txt",col.names=colnames)
traindata<-read.table("train/X_train.txt",col.names=colnames)
combined<-rbind_all(list(traindata,testdata))

#remove the old data sets
rm(testdata,traindata)

#now we only want the mean() and std() columns
combined<-combined%>%select(-contains("angle."))%>%select(-contains("meanFreq"))%>%select(contains("mean"),contains("std"))

#read in the subjects
subjecttest<-read.table("test/subject_test.txt",col.names="Subject")
subjecttrain<-read.table("train/subject_train.txt",col.names="Subject")
subjectcombined<-rbind_all(list(subjecttrain,subjecttest))

#remove the old data
rm(subjecttest,subjecttrain)

#read in the activities
activitytest<-read.table("test/y_test.txt",col.names="Activity")
activitytrain<-read.table("train/y_train.txt",col.names="Activity")
activitycombined<-rbind_all(list(activitytrain,activitytest))

#remove the old data
rm(activitytest,activitytrain)

#make this automated in future
activitycombined$Activity[activitycombined$Activity == 1 ]<-"WALKING"
activitycombined$Activity[activitycombined$Activity == 2 ]<-"WALKING_UPSTAIRS"
activitycombined$Activity[activitycombined$Activity == 3 ]<-"WALKING_DOWNSTAIRS"
activitycombined$Activity[activitycombined$Activity == 4 ]<-"SITTING"
activitycombined$Activity[activitycombined$Activity == 5 ]<-"STANDING"
activitycombined$Activity[activitycombined$Activity == 6 ]<-"LAYING"
data<-tbl_df(cbind(combined,subjectcombined,activitycombined))

#part 5 create the tidy data
tidy<-data%>%
group_by(Subject,Activity) %>%
summarise_each(funs(mean))

write.table(tidy,file="UCI_HAR_TIDY.txt",row.name=FALSE)
