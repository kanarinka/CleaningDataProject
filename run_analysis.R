library("plyr")
library("reshape2")

# read in the two main data sets
trainData <- read.table("UCI HAR Dataset/train/X_train.txt")
testData <- read.table("UCI HAR Dataset/test/X_test.txt")

# add human readable, R-compliant names to headers
dataHeaders <- read.table("UCI HAR Dataset/features.txt",check.names=TRUE)
colnames <- make.names(dataHeaders$V2, unique=TRUE)
colnames <- gsub("\\.\\.\\.",".",colnames)
colnames <- gsub("\\.\\.",".",colnames)
names(trainData) <- colnames
names(testData) <- colnames

# add Y labeling data
trainDataY <-read.table("UCI HAR Dataset/train/y_train.txt")
trainData$activity <- trainDataY$V1
testDataY <-read.table("UCI HAR Dataset/test/y_test.txt")
testData$activity <- testDataY$V1

# merge data sets
allData <- join(trainData,testData)

# add activity label
activityList <- read.table("UCI HAR Dataset/activity_labels.txt")
allData$activityLabel<-activityList[allData$activity,2]

# subset on only mean or std measurements
allData <- allData[ , grep( "mean\\.|std\\.|activityLabel" , names( allData ) ) ]

# melt data by activityLabel
melted<-melt(allData, id.vars=c("activityLabel"))

# group data by subject & activity, calculate mean of each group
summarizedData <- ddply(melted, .(activityLabel, variable), summarize, mean=mean(value))

# write CSV file
write.csv(summarizedData, file="tidy_data_set.txt")