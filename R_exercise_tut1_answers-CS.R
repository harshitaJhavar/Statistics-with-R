### Stats with R Exercise sheet 1 

## This exercise sheet contains the exercises that you will need to complete and submit by midnight on Sunday,
## November 6. Write the code below the questions. If you need to provide a written answer, comment this out using
## a hashtag (#). 
## Submit your homework via XXXXX.

## You are allowed to work together, but everybody needs to submit his or her own version of the exercise sheet.
## Many of the things on this exercise sheet have not been discussed in class. The answers will therefore not be on 
## the slides. You are expected to find the answers using the help function in R, in the textbooks and online. If you 
## get stuck on these exercises, remember: Google is your friend.
## If you have any questions, you can ask these during the tutorial.


###############
### Exercise 1: Getting started
###############
## a) Look at your current working directory.
getwd()

## b) Get help with this function.
?getwd()

## c) Change your working directory to another directory.
setwd(xxx)



###############
### Exercise 2: Participants' age & boxplots
###############
## In this exercise, we will deal with data from a package.

## a) Install the package "languageR" and load it.
install.packages("languageR")
library(languageR)

## b) Specifically, we will deal with the dataset 'dutchSpeakersDistMeta'. This dataset should be available to you once you've loaded languageR.
##    The dataset contains information on the speakers included in the Spoken Dutch Corpus.
##    Inspect 'dutchSpeakersDistMeta'. Look at the head, tail, and summary. What do head and tail show you?
head(dutchSpeakersDistMeta) #shows you the first 6 observations in the dataset
tail(dutchSpeakersDistMeta) #shows you the last 6 observations in the dataset
summary(dutchSpeakersDistMeta)

## c) Each line in this file provides information on a single speaker. How many speakers are included in this dataset?
##    In other words, use a function to retrieve the number of rows for this dataset.
nrow(dutchSpeakersDistMeta)

## d) Let's say we're interested in the age of the speakers included in the corpus, to see whether males and females are distributed 
##    equally. Create a boxplot for Sex and AgeYear.
boxplot(AgeYear~Sex, data=dutchSpeakersDistMeta)
boxplot(dutchSpeakersDistMeta$AgeYear~dutchSpeakersDistMeta$Sex,xlab="Sex Axis",ylab="Age Year Axis",boxwex=0.25,col="yellow",main="Boxplot for Sex and AgeYear")

## e) Does it seem as if either of the two groups has more variability in age?
# The group with female speakers.

## f) Do you see any outliers in either of the two groups?
#Yes, in the group 'male', there's two outliers.

## g) Now calculate the mean and standard deviation of the AgeYear per group. Do this by creating a subset for each group.
##    Do the groups seem to differ much in age?
mean(subset(dutchSpeakersDistMeta, Sex == "male")$AgeYear)
sd(subset(dutchSpeakersDistMeta, Sex == "male")$AgeYear)
mean(subset(dutchSpeakersDistMeta, Sex == "female")$AgeYear)
sd(subset(dutchSpeakersDistMeta, Sex == "female")$AgeYear)
# The groups don't seem to differ much.

## h) What do the whiskers of a boxplot mean?


###############
### Exercise 3: Children's stories & dataframes
###############
# A researcher is interested in the way children tell stories. More specifically, she wants to know how often children 
# use 'and then'. She asks 25 children to tell her a story, and counts the number of times they use 'and then'. The data follow:

# 18 15 22 19 18 17 18 20 17 12 16 16 17 21 25 18 20 21 20 20 15 18 17 19 20 


## a) Is this categorical or continuous data? Explain in one sentence why? (remember, comment out written answers)
# Discrete, ratio scale

## b) In the next question, you will create a dataframe of this data. Later, we will also include participant ID's.
##    Why is a dataframe better suited to store this data than a matrix?
# A dataframe is better because the data will consist of two different types (factor for the participant ID's, numbers for the data)

## c) First create a vector with participant ID's. Your vector should be named 'pps', and your participants should be labeled from 1 to 25
pps <- 1:25

## d) Next, create a vector containing all the observations. Name this vector 'obs'.
obs <- c(18, 15, 22, 19, 18, 17, 18, 20, 17, 12, 16, 16, 17, 21, 25, 18, 20, 21, 20, 20, 15, 18, 17, 19, 20)

## e) Create a dataframe for this data. Assign this to 'stories'. 
stories <- data.frame(pps, obs)

## f) Take a look at the summary of your dataframe, and at the classes of your columns. What class is the variable 'pps'?
summary(stories)
class(stories$pps)
# pps is an integer.

## g) Change the class of 'pps' to factor. Why is factor a better class for this variable?
stories$pps <- factor(stories$pps)
# Because the numbers do not represent a continuous scale, but rather unique ID's.

## h) Plot a histogram (using hist()) for these data. Set the number of breaks to 8.
hist(stories$obs, breaks=8)
#also informative:
h<-hist(stories$obs, breaks=8)
h
# show probabilities instead of frequencies:
hist(stories$obs, breaks=8, prob=TRUE)


## i) Create a kernel density plot using density().
d <- density(stories$obs)
plot(d)


## j) What is the difference between a histogram and a kernel density plot?
# kernel density plot has an area under the curve equal to 1, so the interpretation is related to probability density, not about the exact hight of a curve at a certain point. For a histogram (in standard setting), the y axis shows the frequency of observations that fall in a certain interval.

## k) Overlay the histogram with the kernel density plot 
  # (hint: the area under the curve should be equal for overlaying the graphs correctly.)
  
hist(stories$obs, breaks=8)
widthOfHistBar<-2
areaUnderCurvehist<-(length(stories$obs)* widthOfHistBar)
lines(d$x, d$y*areaUnderCurvehist)

# alternative solution:
hist(stories$obs, breaks=8, prob=TRUE)
lines(d)


###############
### Exercise 4: Normal distributions
###############
## In this exercise, we will plot more normal distributions.

## a) First, use seq() (?seq) to select the x-values to plot the range for (will become the x-axis in the plot).
##    Get R to generate the range from -5 to 5, by 0.1. Assign this to the variable x.
x = seq(from = -5, to = 5, by = 0.1)

## b) Now we need to obtain the y-values of the plot (the density). We do this using the density function for the normal distribution.
##    Use dnorm() without specifying the mean and standard deviation explicitly. Assign this to the variable y.
##    (If you do not specify mean and standard deviation explicitly, dnorm() assumes that the mean is zero and the standard deviation is 1.)
y = dnorm(x)

## c) Now use plot() to plot the normal distribution for x and y. 
plot(x, y)

## d) The plot now has a relatively short y-range, and it contains circles instead of a line. 
##    Using plot(), specify the ylimit ('ylim = c(0,0.8)'). Also specify that the type is a line ('type = "l" ').
plot(x, y, ylim = c(0, 0.8), type = "l")

## e) We want to have a vertical line to represent the mean of our distribution. 'abline()' can do this for us. Look up help for abline().
##    Can you describe in your own words how abline works? What do a en b mean? 
# Use abline() to create the vertical line. Specify the median of x using the argument 'v'.
##    In order to get a dashed line, set the argument 'lty' to 2.
abline(v = 0, lty = 2) # the vertical dashed line

## f) Take a look at the beaver1 dataset. (You can see it by typing "beaver1".) Then select only the temperature part and store it in a variable "b1temp".
beaver1
help(beaver1)

## g) Calculate the mean and standard deviation of this dataset and plot a normal distribution with these parameters.
mb <- mean(beaver1$temp)
sdb<- sd(beaver1$temp)
help(dnorm)
xaxis<-seq(35,39,0.01)
plot(xaxis,dnorm(xaxis, mb,sdb), type="l")


## h) We observe three tempareatures (36.91 and 38.13). What's the likelihood that these temperatures respectively come from the normal distribution from g)?
help(pnorm)
abline(v=36.91)
pnorm(36.91,mb,sdb,lower.tail=FALSE)*2
# probability >80% of getting a temperature more extreme than this one.

abline(v=38.13, col="red")
pnorm(38.13,mb,sdb, lower.tail=FALSE)*2
# probability < 0.00001 of getting a temperature more extreme than this one.

## i) Use the random sampling function in R to generate 20 random samples from the normal distribution from g), and draw a histrogram based on this sample. Repeat 5 times. What do you observe? 

hist(rnorm(20,mb, sdb))


##############
### In class exercise: More about these plots
##############

summary(dutchSpeakersDistMeta)
# Use aggregate or tapply to create subset

aggregate(dutchSpeakersDistMeta$AgeYear, list(dutchSpeakersDistMeta$Sex), mean)
aggregate(dutchSpeakersDistMeta$AgeYear, list(dutchSpeakersDistMeta$Sex), sd)

tapply(dutchSpeakersDistMeta$AgeYear, list(dutchSpeakersDistMeta$Sex), mean)
tapply(dutchSpeakersDistMeta$AgeYear, list(dutchSpeakersDistMeta$Sex), sd)

# Show that mean and SD don't work when there's NA values. Show how to get rid of NA values.




