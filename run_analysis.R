run_analysis <- function(ucihardata_rootfolder) {
  
  ##assuming libraries are present (required for quizzes)
  library(dplyr)
  library(magrittr)
  
  ##assuming original folder structure 
  trainsfile = "train/subject_train.txt";
  trainxfile = "train/X_train.txt";
  trainyfile = "train/Y_train.txt";
  
  testsfile = "test/subject_test.txt";
  testxfile = "test/X_test.txt";
  testyfile = "test/Y_test.txt";
  
  featurefile = "features.txt";
  activityfile = "activity_labels.txt";
  
  fullfile=paste(ucihardata_rootfolder,trainsfile,sep = "/");
  trains = read.delim(fullfile,sep = c(""," "),header=FALSE);
  fullfile=paste(ucihardata_rootfolder,trainxfile,sep = "/");
  trainx = read.delim(fullfile,sep = c(""," "),header=FALSE);
  fullfile=paste(ucihardata_rootfolder,trainyfile,sep = "/");
  trainy = read.delim(fullfile,sep = c(""," "),header=FALSE);
  
  fullfile=paste(ucihardata_rootfolder,testsfile,sep = "/");
  tests = read.delim(fullfile,sep = c(""," "),header=FALSE);
  fullfile=paste(ucihardata_rootfolder,testxfile,sep = "/");
  testx = read.delim(fullfile,sep = c(""," "),header=FALSE);
  fullfile=paste(ucihardata_rootfolder,testyfile,sep = "/");
  testy = read.delim(fullfile,sep = c(""," "),header=FALSE);
  
  fullfile=paste(ucihardata_rootfolder,featurefile,sep = "/");
  features = read.delim(fullfile,sep = c(""," "),header=FALSE);
  
  fullfile=paste(ucihardata_rootfolder,activityfile,sep = "/");
  activities = read.delim(fullfile,sep = c(""," "),header=FALSE);
  colnames(activities) = c("id","ActivityName");
  activities = as.data.frame(activities);
  
  ##join train and test data
  allx = rbind(trainx,testx);
  ally = rbind(trainy,testy);
  alls = rbind(trains,tests);
  #sourcelabels = c(rep("Train",nrow(trainx)),rep("Test",nrow(testx)));
  
  ##extract mean and std; note that we also have meanFreq variables, assumption skip?
  meanvars = grep("\\-mean\\(\\)",features[,2]);
  stdvars = grep("\\-std\\(\\)",features[,2]);
  relevantvars = c(meanvars,stdvars);
  relevantvars = sort(relevantvars);
  
  relevantdata = allx[,relevantvars];
  
  ##descriptive variable names
  colnames(relevantdata)=features[relevantvars,2];
  relevantdata=as.data.frame(relevantdata);
  
  relevantdata = cbind(relevantdata,ally,alls);#,sourcelabels); ##source TRAIN/TEST not required?
  colnames(relevantdata)[ncol(relevantdata)-1]<-"label";
  colnames(relevantdata)[ncol(relevantdata)]<-"SubjectID";
  #colnames(relevantdata)[ncol(relevantdata)]<-"source";
  
  ##descriptive activity names
  relevantdata2=merge(relevantdata,activities,by.x="label",by.y="id");
  relevantdata2=subset(relevantdata2,select=-label); ##redundant
  
  ##variable name cleanup (but no splitting, since crossdependencies)
  n=names(relevantdata2);
  n=gsub("^f","FrequencyDomain",n);
  n=gsub("^t","TimeDomain",n);
  n=gsub("Acc","Acceleration",n);
  n=gsub("Mag","Magnitude",n);
  n=gsub("\\-mean\\(\\)\\-","Mean",n);
  n=gsub("\\-mean\\(\\)","Mean",n);
  n=gsub("\\-std\\(\\)\\-","Std",n);
  n=gsub("\\-std\\(\\)","Std",n);
  colnames(relevantdata2)=n;
  
  ## create tidy dataset with mean per variable over subject and activity
  smalldata = relevantdata2 %>%
    group_by(SubjectID,ActivityName) %>%
    summarise_each(funs(mean));
  
  ##return only the summary dataset, not the cleanedup full dataset
  return(smalldata);
  
  ## output with: write.table(rdata,file = "tidydata.txt",row.names=FALSE)
  
}