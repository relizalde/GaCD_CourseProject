## Getting and Cleaning Data - Course Project

## Downloading the data
if(!file.exists("UCI HAR Dataset")) # Verify if the data is unzipped
{   
    if(file.exists("getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")) # Verify if the zip is downloaded
    {
        unzip("getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip") # Unzip the file
    }else {
        # Download the file to a temp file
        temp <- tempfile()
        download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",temp)
        
        unzip(temp)
        
        unlink(temp)
    }
}

## Reading Features and Activity labels
features <- read.table("./UCI HAR Dataset/features.txt")
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

## Reading Test set
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")

## Reading Train set
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")

## Merging the training and the test sets to create one data set.
subjects <- rbind(subject_test, subject_train) # Join vertically the subjects
colnames(subjects) <- "idSubjects"

lblActivity <- merge(rbind(y_test, y_train), activity_labels, by=1) # Associate the type of activities
colnames(lblActivity) <- c("idActivity","lblActivity")
lblActivity <- lblActivity[,-1]

allData <- rbind(X_test, X_train) # Join vertically the data

# The set features contains the column names of the data
# Due to the length of the names and number of columns, I have used a combination of '.', '_' and capitals
# in order to make the names more understandable
cn <- features[,2]
cn <- gsub("-", cn, replacement=".", fixed = TRUE)
cn <- gsub(",", cn, replacement="_", fixed = TRUE)
cn[seq(555,561,by=1)] <- gsub("(", cn[seq(555,561,by=1)], replacement=".", fixed = TRUE) #This line handle the special cases for angle features
cn <- gsub("[()]", "", cn) # Delete all parenthesis in the names

colnames(allData) <- cn # Assign the features to columns names of the dataset

FinalDataset <- cbind(subjects, lblActivity, allData) # Join horizontally the previous sets

## Extracts only the measurements on the mean and standard deviation for each measurement.
MeanStdDataset <- FinalDataset[,sort.int(c(1,2,grep("mean|[Ss]td", colnames(FinalDataset))))] # View CodeBook.md for more explanation on this part

# write.table(MeanStdDataset, "MeanStdDataset.txt" , sep = ";") # If you need to print the dataset in a file uncomment the line

## Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
if (!require("reshape2")) 
{
    install.packages("reshape2")
    library("reshape2")
}

MeltDataset <- melt(MeanStdDataset, id = c("idSubjects", "lblActivity"))

AverageDataset <- dcast(MeltDataset, idSubjects + lblActivity ~ variable, mean)

write.table(AverageDataset, "AverageDataset.txt" , sep = ";") # Prints the dataset to a file