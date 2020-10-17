# Finding the file paths
Zoom_Report_path <- rstudioapi::selectFile(caption = "Select Zoom Report [CSV file]",
                              filter = "CSV Files (*.csv)",existing = TRUE)
AMS_student_list_path <- rstudioapi::selectFile(caption = "Select class list  from AMS [CSV file]",
                              filter = "CSV Files (*.csv)",existing = TRUE)
Attendance_list_path <- rstudioapi::selectFile(caption = "Save attendance in [write name or select file]",
                              filter = "CSV Files (*.csv)", existing = FALSE,label="Save")

ZoomR <- read.csv(Zoom_Report_path, header = TRUE,sep = ",");
classlist <- read.csv(AMS_student_list_path, header = TRUE,sep = ",");

Zdim=dim(ZoomR)
print(Zdim)
print(CLdim)
CLdim=dim(classlist)
classlist$W1=rep(NA, CLdim[1])

for (i in 1:Zdim[1])
{
  for (j in 1:CLdim[1])
  {

    for (k in 1:3) # to compare with the first 3 column
    {
      if (grepl(classlist$Student.ID[j],as.character(ZoomR[i,k]),ignore.case = TRUE))
      {
        classlist$W1[j]<-1
      }
      if (grepl(classlist$First.name[j],as.character(ZoomR[i,k]),ignore.case = TRUE))
      {
        classlist$W1[j]<-1
      }
      
      if (grepl(classlist$Last.name[j],as.character(ZoomR[i,k]),ignore.case = TRUE))
      {
        classlist$W1[j]<-1
      } 
    }
  }
}

Attendance<-data.frame(classlist$Student.ID,classlist$First.name,classlist$Last.name,classlist$W1)
names(Attendance)<-c('Student ID','First name','Last name','Attendance')

write.csv(Attendance,paste(Attendance_list_path,".csv",sep=""))
