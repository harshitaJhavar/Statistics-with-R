#Solutions by Harshita Jhavar with Matriculation Number 2566267
# Please do the "Cleaning Data with R" exercise that was assigned in dataCamp.
# We recommend that you take notes during the DataCamp tutorial, so you're able to use the commands you learned there in the exercise below.
# This week, the exercise will be about getting data into a good enough shape to start analysing. Next week, there will be a tutorial on running t tests for this data.

# download the data file "digsym.csv" from the moodle and save it in your working directory. The read in the data into a variable called "data".
data <- read.csv("digsym.csv")

# Load the libraries languageR, stringr, dplyr and tidyr.
library(languageR)
library(stringr)
library(dplyr)
library(tidyr)

# how many rows, how many columns does that data have?
nrow(data)
ncol(data)
# take a look at the structure of the data frame using "glimpse"
glimpse(data)
# view the first 20 rows, view the last 20 rows
head(data,n=20)
tail(data, n=20)

# Is there any missing data in any of the columns?
sum(is.na(data))
## Yes, there is missing data at 370 indexes in data

# get rid of the row number column
data <- data[, !(names(data) %in% "X")]
#data$X <- NULL

# put the Sub_Age column second
data <- data[,c("ExperimentName", "Sub_Age", "Group", "Gender","List","SubTrial","StimulDS1.CRESP", "StimulDS1.RESP",  "StimulDS1.RT","File")]
# data <- data[,c(1,10,2:9)]

# replace the values of the "ExperimentName" column with something shorter, more legible
data$ExperimentName <- as.factor(str_replace(data$ExperimentName,"Digit Symbol - Kopie","DSK"))

# keep only experimental trials (encoded as "Trial:2" in List), get rid of practice trials (encoded as "Trial:1"). When you do this, assign the subset of the data to a variable "data2", then assign data2 to data and finally remove data2.
data2 <- data[ which(data$List=="Trial:2"), ]
data<-data2
remove(data2)
# data2 <- subset(data, List == "Trial:2")
# data <- data2
# rm(data2)

# separate Sub_Age column to two columns, "Subject" and "Age", using the function "separate"
data <- separate(data,col=Sub_Age,into = c("Subject","Age"),sep=" _ ")

# make subject a factor
data$Subject <- as.factor(data$Subject)


# extract experimental condition from the "File" column:
# the stimulus that people saw - did it correspond to a wrong or right digit-symbol combination?

##Solution: Yes, if StimulDS1.CRESP is equal to 'm', then the value in "File" column is always "right".
##Whereas, if the StimulDS1.CRESP is equal to 'z', then the value in "File" column is always "false".

# 1) using str_pad to make values in the File column 8 chars long, by putting 0 on the end  (i.e., same number of characters, such that "1_right" should be replaced by "1_right0" etc)
data$File <- str_pad(data$File,width=8,side="right",pad="0")

# create a new column ("condition" (levels:right, wrong)) by extracting "right"/"wrong" using substr
data <- as.factor(separate(data, col = File, into = c("file","condition" ), sep = "_"))

l = nrow(data)
for (i in 1:l){
  data$condition[i] <- substr(data$condition[i], 1, 5)
}
# data$condition <- as.factor(substr(data$File,3,7))
# get rid of obsolete File column
data <- data[, !(names(data) %in% "file")]

# missing values, outliers:

# do we have any NAs in the data, and if so, how many and where are they?
sum(is.na(data))
# There are no missing values in the data now.

# create an "accuracy" column using if-statement
# if actual response (StimulDS1.RESP) is the same as the correct response (StimulDS1.CRESP), put in value 1, otherwise put 0
a=NULL
l = nrow(data)
for (i in 1:l)
  if(data$StimulDS1.RESP[i]==data$StimulDS1.CRESP[i]) a[i] <- 1 else a[i] <- 0
data["accuracy"] <- a 
#data$accuracy <- ifelse(data$StimulDS1.RESP == data$StimulDS1.CRESP, 1, 0)
# how many wrong answers do we have in total?
c=0
for(j in 1:l)
  if(data$accuracy[j]==0) c <- c+1
# sum(with(data,accuracy == 0))
#sum(data$accuracy == 0) 
# There are total 185 wrong answers.

# whats the percentage of wrong responses?
(185/3330)*100
# The percentage of wrong response is 5.55%

# create correct_RT column
correctRT_column=NULL
for(k in 1:l)
  if(data$accuracy[k]==1) correctRT_column[k] <- data$StimulDS1.RT[k]

# data$correct_RT <- ifelse(data$accuracy ==1, data$StimulDS1.RT,NA)

# create boxplot of correct_RT - any outliers?
boxplot(correctRT_column)
# Yes, there are outliers as can be seen from the boxplot

# create histogram of correct_RT with bins set to 50
hist(correctRT_column, breaks =50)

# describe the two plots - any tails? any suspiciously large values?
# The histogram has a suspeciously large vale of around 14000. It is left side positively skewed.
# There is a lower tail.
# The boxplot has many outliers.

# view summary of correct_RT
summary(correctRT_column)
#summary(correctRT_column, digit =5)
# we got one apparent outlier: 13850
# It should be 13852

# There is a single very far outlier. Remove it.
index <- which(data$StimulDS1.RT == 13852)
correctRT_column <- correctRT_column[-c(index)]
data <- data[-c(index),]
#data$correct_RT(data$correct_RT == "13852") <- NA

# dealing with the tail of the distribution: 
# outlier removal
# Now, remove all correct_RT which are more than 2.5. SD away from the grand mean

UpperLimit <- mean(correctRT_column,na.rm = TRUE) + (2.5*sd(correctRT_column,na.rm = TRUE))
LowerLimit <- mean(correctRT_column,na.rm = TRUE) - (2.5*sd(correctRT_column,na.rm = TRUE))

r <- correctRT_column
l <- length(r)

for(i in 1:l)
  if(!is.na(r[i]))
   if((LowerLimit > r[i]) || (r[i] > UpperLimit)) r[i] <- NA

#m <- mean(data$correct_RT, na.rm = TRUE)
#sd <- sd(data$correct_RT, na.rm = TRUE)   
    
# create new "correct_RT_2.5sd" column in data which prints NA if an RT value is below/above the cutoff
data["correct_RT_2.5sd"] <- r

# data$correct_RT_2.5sd <- ifelse(data$correct_RT)(m+(2.5*sd) | data$correct_Rt < (m - (2.5*sd)), NA, data$correct_RT)

# take a look at the outlier observations
# any subjects who performed especially poorly?
boxplot(data$correct_RT_2.5sd)

# how many RT outliers in total?
#(nrow(outlier)/nrow(data)) *100
# 2.372372
# plot a histogram and boxplot of the correct_RT_2.5sd columns again - nice and clean eh?
hist(data$correct_RT_2.5sd, breaks = 50)
boxplot(data$correct_RT_2.5sd)

# Next, we'd like to take a look at the avrg accuracy per subject
# Using the "cast" function from the library "reshape", create a new data.frame which shows the average accuracy per subject. Rename column which lists the average accuracy as "avrg_accuracy".
library(reshape)
avrg_accuracy <- cast(data,Subject~accuracy,mean)
#acc <- cast(data, Subject ~, mean, value = "accuracy", na.rm = !)
#acc <- rename(acc, c("(all)" = "avg_accuracy"))

# sort in ascending order or plot the average accuracies per subject.
#Incorrect #sort(avrg_accuracy)
#Incorrect #plot(avrg_accuracy,data$Subject)
acc <- acc[order(acc$avg_accuracy),]
# would you exclude any subjects, based on their avrg_accuracy performance?
# No, exclusing the subjects would lead to loss in information from the data.

## congrats! your data are now ready for analysis. Please save the data frame you created into a new file "digsym_clean.csv". We will continue working with this dataframe next week.
digsym_clean.csv <- write.csv(data)
# write.csv(data, "digsym_clean.csv" )
