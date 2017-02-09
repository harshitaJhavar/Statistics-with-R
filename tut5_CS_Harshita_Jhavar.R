#Solutions submitted by Harshita Jhavar, Matriculation Number 2566267
library(lsr)
library(tidyr)
library(effsize)


# set your wd and load the data frame digsym_clean.csv
#setwd("C:/Users/HARSHITA/Desktop/Assignment 5")
mydata <- read.csv("digsym_clean.csv")
# get rid of the column "X"
mydata$X <- NULL

# Say you're interested in whether people respond with different accuracy to right vs wrong picture-symbol combinations.
# In other words, you want to compare the average accuracy for the digsym-right and digsym-wrong condition.
# Like the conscientious researcher you are, you want to take a look at the data before you get into the stats.
# Therefore, create a barplot of the mean accuracy data (split out by condition) using ggplot and the summarySE function (given below).
# run the function to summarize data and try to understand what the function is doing.

#Solution


summarySE <- function(data=NULL, measurevar, groupvars=NULL, na.rm=FALSE, conf.interval=.95) {
  library(doBy)
  length2 <- function (x, na.rm=FALSE) {
    if (na.rm) sum(!is.na(x))
    else       length(x)
  }

  # Collapse the data
  formula <- as.formula(paste(measurevar, paste(groupvars, collapse=" + "), sep=" ~ "))
  datac <- summaryBy(formula, data=data, FUN=c(length2,mean,sd), na.rm=na.rm)
  
  # Rename columns
  names(datac)[ names(datac) == paste(measurevar, ".mean",    sep="") ] <- measurevar
  names(datac)[ names(datac) == paste(measurevar, ".sd",      sep="") ] <- "sd"
  names(datac)[ names(datac) == paste(measurevar, ".length2", sep="") ] <- "N"
  
  # Calculate standard error of the mean
  datac$se <- datac$sd / sqrt(datac$N)  
  
  # Confidence interval multiplier for standard error
  # Calculate t-statistic for confidence interval: 
  # e.g., if conf.interval is .95, use .975 (above/below), and use df=N-1
  ciMult <- qt(conf.interval/2 + .5, datac$N-1)
  datac$ci <- datac$se * ciMult
  
  return(datac)
}



# apply the function on the accuracy data
summarySE(mydata,measurevar=accuracy, groupvars=NULL, na.rm=FALSE, conf.interval=.95)

# take a look at the sum object - what did the function do?

#The function provided a summary of the SE values.

# Create the barplot with error bars (which the function summarySE readily provided)
# Gauging from the plot, does it look like there's a huge difference in accuracy for responses to the right and wrong condition?

barplot(summarySE(mydata,measurevar=accuracy, groupvars=NULL, na.rm=FALSE, conf.interval=.95))

# Let's go back to our data frame "data", which is still loaded in your console
# Now that you've taken a look at the data, you want to get into the stats.
# You want to compute a t-test for the average accuracy data in the right and wrong condition.
# Why can't you compute a t-test on the data as they are now? 
# Hint: which assumption is violated?
#Solution:
#The assumption that the variance is homogeneous in the data is violated.

# we need to reshape( - cast) the data to only one observation (average accuracy) per subject and right/wrong condition 
# Collapse the data, using cast(data, var1 + var2 + var3 ... ~, function, value = var4, na.rm = T)

library(reshape)

data <- cast(mydata, accuracy~condition, mean,na.rm = T)

# Create a histogram of the accuracy data depending on the right and wrong condition and display them side by side

hist(data$accuracy, data$condition)

# Display the same data in a density plot 
plot(data)

# Based on the histograms and the density plots - are these data normally distibuted?

#Yes, the histogram and the density plot have a normal distribution.

# Create a boxplot of the accuracy data
boxplot(data$accuracy)

# compute the t-test to compare the mean accuracy between wrong and right picture combinations
# do you need a paired t-test or independent sample t-test? why?

#Solution
#We need an independent t-test here as the two samples are different.

# What does the output tell you? What conclusions do you draw?
#The output tells us that the difference between the output and the p-value is very high.
#Hence, the null hypothesis does not hold.

# Compute the effect size using CohensD 
cohensD(x=data$accuracy, y= data$condition, method="pooled")

# How big of an effect is the difference in accuracy?
#The difference in accuracy proves that the null hypothesis does not hold.

# In addition to the long-format data we've just been working on, you may also encounter data sets in a wide format (this is the format we have been using in class examples.)
# Let's do a transformation of our data set to see how it would like in a wide format.
# Use "spread" in tidyr
spreaddata <- spread(mydata, accuracy, condition, fill = NA, convert = FALSE)

# compute the t test again on the wide format data - note that for wide-format data you need to use a different annotation for the t-test

t.test(spreaddata,c(accuracy,condition))
# Compare the t-test results from the wide-format and the long-format data
#Solution:
#The t-test value for the wide format is larger than the previous format.

# Compute CohensD on the wide format data
cohensD(x=spreaddata$accuracy, y= spreaddata$condition, method="pooled")


# Let's try the t-test again, but for a different question:
# Suppose you are an interested in whether reaction times in the digit symbol task differ depending on gender.
# In other words, you want to test whether or not men perform significantly faster on average than women, or vice versa.
# Collapse the data again, using cast(data, var1 + var2 + var3 ... ~, function, value = var4, na.rm = T)

newdata <- cast(mydata, StimulDS1.RT~Gender, mean,na.rm = T)

# Take a look at cdat using head()

head(cdat)

# Compute the t-test to compare the accuracy means of female and male participants
# Which t-test do you need and why? How do you interpret the result?

#Solution:
# We need indepedent t-test as the two group of participants are different

t.test(newdata,c(StimulDS1.RT,Gender))



