library(reshape)
library(languageR)

# Correlation, or:
# Looking at the relationship between variables.

# Get some data - access the ratings data set in languageR and name it "data".
# Subjective frequency ratings and their length averaged over subjects, for 81 concrete English nouns.
data <- ratings

# Take a look at the data frame.
head(data)

# Let's say you're interested in whether there is a linear relationship between the word frequency of the 81 nouns and their length.
# Take look at the relationship between the frequency and word length data by means a of a scatterplot. (use the plot function)

plot(data$Length,data$Frequency)
# Judging from the graphs, do you think that word frequency and word length are in any way correlated with one another?

#No it doesn't look from the scatter plot that the word frequency and word length are correlated to each other. 
#There is an uneven nature of increase and decrease in frequency values with respect to increasing length.
#Hence they are not correlated.

# Compute the Pearson correlation coefficient between the two variables by means of cor().
# Tell R to only include complete pairs of observations.
# As a reminder: Pearson coefficient denotes the covariance of the two variable divided by the product of their variance.
# Pearson is scaled between 1 (for a perfect positive correlation) to -1 (for a perfect negative correlation).

cor(data$Length,data$Frequency, use="complete.obs")

# Does the correlation coefficient suggest a small, medium or large effect?
# What about the direction of the effect?

#The correlation coefficient suggests a medium effect in the direction of the negative correlation with a value of -0.4281462.

#Note that we have a large number of tied ranks in word length data (since there are multiple words with the length of, e.g. 5).
#Thus, we might draw more accurate conclusions by setting the method to Kendall's tau instead of Pearson (which is the default).

cor(data$Length,data$Frequency,use="complete.obs",method="kendall")


# Note that the correlation coefficient has now changed, due to the fact that Kendall's is more conservative in estimating it.
# What about significance? Use the more user-friendly cor.test!

#Yes, the value has changed to -0.316297
cor.test(data$Length,data$Frequency, method = "kendall")
#z = -3.9186, p-value = 8.907e-05

# Take alook at the output  and describe what's in there.
# What do you conclude?
# As the p-value is much less than 0.05, the null hypothesis that they are correlated holds.

# Finally, we can also calculate Spearman's rank correlation for the same data.
cor(data$Frequency, data$Length, use="complete.obs",method="spearm")
# -0.4311981

###################################################################################################


# Regression, or:
# Taking correlation to the next level - predicting one variable from another!
# Fit a linear regression model to the data frame for the variables frequency (outcome variable) and Length (predictor variable).
# General form: "modelname <- lm(outcome ~ predictor, data = dataFrame, na.action = an action)"

dataModelName <- lm(data$Frequency ~ data$Length, data)

# How do you interpret the output? Is the relationship between the two variables positive or negative?
# Plot the data points and the regression line.

plot(dataModelName)
#Coefficients:
#(Intercept)  data$Length  
# 6.5015        -0.2943
# The relationship between the two variables is negative.

# Run the plotting command again and have R display the actual words that belong to each point. (Don't worry about readability of overlapping words.)

install.packages("calibrate")
library(calibrate)
textxy(data$Frequency,data$Length,data$Word)



###################################################################################################

# Try this again for another example:
# Let's go back to our digsym data set.
# Set your wd and load the data frame digsym_clean.csv

setwd("C:/Users/HARSHITA/Desktop/WS 2016-17/Statistics with R/Tutorials")
mydata <- read.csv("digsym_clean.csv")

# Suppose you want to predict reaction times in the digit symbol task by people's age.
# Fit a linear regression model to the data frame for the variables correct_RT_2.5sd (outcome variable) and Age (predictor variable).
# General form: "modelname <- lm(outcome ~ predictor, data = dataFrame, na.action = an action)"
myDataModelname <- lm(correct_RT_2.5sd ~ Age, data = mydata)

# Let's cast the data to compute an RT mean for each subject, so that we have only one Age observation by Subject.
# In case you're wondering why we still have to do this - like the t-test, linear regression assumes independence of observations.
# In other words, one row should correspond to one subject or item only.
mydataCasted <-  cast(mydata, Age ~ correct_RT_2.5sd, mean)

# Fit the regression model.
a <- lm(myDataModelname,mydata)

# Let's go over the output - what's in there?
# How do you interpret the output?
#Coefficients:
#(Intercept)          Age  
#639.47        20.82

# Again plot the data points and the regression line. 
plot(myDataModelname)



# Plot a normal probability plot of the residuals.

myDataSt = rstandard(myDataModelname)

qqnorm(myDataSt) 

# Plot Cooks distance which estimates the residuals (i.e. distance between actual values and the regression line) for individual data points in the model.

plot(cooks.distance(myDataModelname))

# It actually looks like we have one influential observation in there that has potential to distort (and pull up) our regression line.
# The last observation (row 37) in cast yielded a Cooks D is very high (greater than 0.6).
# In other words, the of the entire regression function would change by more than 0.6 when this particular case would be deleted.
mydata[37,]
# What is the problem with observation 37?
# Run the plotting command again and have R display the subjects that belong to each point.

textxy(mydata$correct_RT_2.5sd ,mydata$Age,data$Word)

# Make a subset of "cast" by excluding this subject and name it cast2.
cast2 <- mydata[-c(37)]


# Fit the model again, using cast2, and take a good look at the output.
myNewDataModelname <- lm(correct_RT_2.5sd ~ Age, data = cast2)
b <- lm(myNewDataModelname,cast2)

# What's different about the output?
# How does that change your interpretation of whether age is predictive of RTs?
#Coefficients:
#(Intercept)          Age  
#639.47        20.82 
# Plot the regression line again - notice the difference in slope in comparison to our earlier model fit?
plot(myNewDataModelname)


# Display the two plots side by side to better see what's going on.
# Compute the proportion of variance in RT that can be accounted for by Age.
# In other words: Compute R Squared.
# Refer to Navarro (Chapter on regression) if you have trouble doing this.
summary(myNewDataModelname)$r.squared 
# 0.06187916

# How do you interpret this number?
#Since, the proportion of variance is smaller than 1, it shows that the last tuple entry
#must not be considered.
