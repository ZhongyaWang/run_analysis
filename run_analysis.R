##Getting and Cleaning the data
# read test data
subject_test <- read.table("~/Downloads/UCI HAR Dataset-2/test/subject_test.txt")
X_test <- read.table("~/Downloads/UCI HAR Dataset-2/test/X_test.txt",sep="")
Y_test<-read.table("~/Downloads/UCI HAR Dataset-2/test/y_test.txt")

# read train data
subject_train<-read.table("~/Downloads/UCI HAR Dataset-2/train/subject_train.txt")
X_train<-read.table("~/Downloads/UCI HAR Dataset-2/train/X_train.txt",sep="")
Y_train<-read.table("~/Downloads/UCI HAR Dataset-2/train/y_train.txt")

# variable name
var_name<-read.table("~/Downloads/UCI HAR Dataset-2/features.txt")

# activity labels
act_label<-read.table("~/Downloads/UCI HAR Dataset-2/activity_labels.txt")

# merge the test and train together
X<-rbind(X_test,X_train)
Y<-rbind(Y_test,Y_train)
sub<-rbind(subject_test,subject_train)

# abstract mean and sd
sub_w<-var_name[grep("mean\\(\\)|sd\\(\\)",var_name[,2]),]
X<-X[,sub_w[,1]]
colnames(X)<-sub_w[,2]

# Y
colnames(Y)<-"activity"
Y$identical<-factor(Y$activity,labels = as.character(act_label[,2])) # as.character important

# subject
colnames(sub)<-"subject"

# final data
data<-cbind(sub,Y,X)

# create a table with average of each variable 
##for each activity and each subject
install.packages("dplyr")
library(dplyr)

sub_data<-data%>% group_by(activity,subject)%>%summarize_each(funs(mean))


