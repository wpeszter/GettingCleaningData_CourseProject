run_analysis <- function() {
  
    #Read the data which is needed for both train and test partitions
    
    #1. variable names for x tables, 2. activity labels
    var_names<-read.table("UCI HAR Dataset/features.txt")
    activity_labels<-read.csv("UCI HAR Dataset/activity_labels.txt", sep=" ", header=FALSE)
    
    #prepare the dataset 
    #this fuction should be called for both train an test data
    #ensures that the train and test dataset is handled exactly the same way
    
    prep_data <- function(partition) {
    
    #read x file and fill the variable names    
    x_file <- paste(c("UCI HAR Dataset/", partition, "/X_", partition, ".txt"), collapse="") 
    xt<-read.table(x_file)
    colnames(xt)<-var_names$V2
    
    #select the variables needed (i.e. the means and stds)
    xt<-xt[, (grepl("mean()", var_names$V2, fixed=TRUE) | grepl("std()", var_names$V2, fixed=TRUE))]
    
    #read the subject and the y files
    subject_file <- paste(c("UCI HAR Dataset/", partition, "/subject_", partition, ".txt"), collapse="") 
    y_file <- paste(c("UCI HAR Dataset/", partition, "/y_", partition, ".txt"), collapse="") 
    st<- read.table(subject_file)
    yt<- read.csv(y_file, sep="", header=FALSE)
    
    #put the files together
    data<-cbind(st,yt)
    colnames(data)[1:2]<-c("subject", "act_code")
    data<-cbind(data, xt)
    
    # merge the activity labels and rename the appropriate col name
    data<-merge(data, activity_labels, by.x="act_code", by.y="V1")
    colnames(data)[ncol(data)]<-"activity"
    
    
    #reorder the columns of the dataset, and delete the numeric activity codes
    data <- data[c(2, ncol(data), 3:(ncol(data)-1))]
    
    data
    
    }
    
    #append the prepared train and test data
    data<-rbind(prep_data("train"), prep_data("test"))
    
    #we could write it into a file in case we want
    #write.table(data, file="tidy_dataset.txt")
    
    #calculate the average of each variable for each activity and each subject, and then rename the colnames
    tidy_data<-aggregate(data[,3:ncol(data)], by=list(data$subject,data$activity), FUN=mean, na.rm=TRUE)
    colnames(tidy_data)[1:2]<-c("subject", "activity")
    colnames(tidy_data) <- gsub("-", "_", colnames(tidy_data))
    colnames(tidy_data) <- gsub("\\(\\)", "", colnames(tidy_data))
    
    #write this new tidy dataset into a file
    write.table(tidy_data, file="tidy_dataset.txt", row.name=FALSE)
    
    #give back the tidy (averaged) data
    tidy_data
}