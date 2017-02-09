### Solutions of Stats with R Exercise sheet 1 - Submitted by Harshita Jhavar Matrikulation Number - 2566267.

## This exercise sheet contains the exercises that you will need to complete and submit by midnight on Sunday,
## November 6. Write the code below the questions. If you need to provide a written answer, comment this out using
## a hashtag (#). 
## Submit your homework via moodle.

## You are allowed to work together, but everybody needs to submit his or her own version of the exercise sheet.
## Many of the things on this exercise sheet have not been discussed in class. The answers will therefore not be on 
## the slides. You are expected to find the answers using the help function in R, in the textbooks and online. If you 
## get stuck on these exercises, remember: Google is your friend.
## If you have any questions, you can ask these during the tutorial, or use the moodle discussion board for the course.


###############
### Exercise 1: Getting started
###############
## a) Look at your current working directory.

##Solution- Here is the command to obtain the current directory.
getwd()
##Output[1] "C:/Users/HARSHITA/Desktop/WS 2016-17/Statistics with R/Tutorials"

## The current directory is obtained here.
##############################################################################################################################################

## b) Get help with this function.

## Solution- Here is the command for running the help command for the function 'getwd'

help(getwd)
?getwd()

##Both ways are correct 
###############################################################################################################################################
## c) Change your working directory to another directory.

## Solution- Changing my working directory to C:/
setwd("C:")

###############################################################################################################################################

### Exercise 2: Participants' age & boxplots
###############
## In this exercise, we will deal with data from a package.

## a) Install the package "languageR" and load it.

##Solution: Here is the code to install and load the package 'languageR' on our system. We used install.packages() command to install the package and require() command to load it. Now we can successfully use its functions.

install.packages("languageR")

##Installtion on Console reads as the following:
#Installing package into 'C:/Users/HARSHITA/Documents/R/win-library/3.3'
#(as 'lib' is unspecified)
#trying URL 'https://cran.rstudio.com/bin/windows/contrib/3.3/languageR_1.4.1.zip'
#Content type 'application/zip' length 2388348 bytes (2.3 MB)
#downloaded 2.3 MB
#package 'languageR' successfully unpacked and MD5 sums checked
#The downloaded binary packages are in
#C:\Users\HARSHITA\AppData\Local\Temp\RtmpUnKG6n\downloaded_packages

require(languageR)
##Loading required package: languageR
library(languageR)

################################################################################################################################################

## b) Specifically, we will deal with the dataset 'dutchSpeakersDistMeta'. This dataset should be available to you once you've loaded languageR.
##    The dataset contains information on the speakers included in the Spoken Dutch Corpus.
##    Inspect 'dutchSpeakersDistMeta'. Look at the head, tail, and summary. What do head and tail show you?

##  Solution: 
##  Firstly, using head() command. The head command resulted in showing the top 6 tuples in the Dataset.
##  Then, using tail() command. The tail command resulted in showing the last 6 entries in the Dataset.
##  Then I used summary() command. The summary command analyzed each column entries and gave a summary according to the different 
##  categories of measure according to each of the six variables in the dataset - Speaker, Sex, AgeYear, AgeGroup, Conversation Type, EduLevel.
##  These all are discreet categories. 
##  Here is the code for the same.   
  
 head(dutchSpeakersDistMeta)
## Output looks like the following
#      Speaker    Sex AgeYear  AgeGroup ConversationType EduLevel
# 410   N01001 female    1952 age45to55             <NA>     high
# 409   N01002   male    1952 age45to55       maleFemale     high
# 1157  N01003   male    1949 age45to55       maleFemale     high
# 252   N01004 female    1971 age25to34             <NA>     high
# 251   N01005 female    1944   age56up       femaleOnly      mid
# 254   N01006   male    1969 age25to34       maleFemale     high

 tail(dutchSpeakersDistMeta)
#      Speaker    Sex AgeYear  AgeGroup ConversationType EduLevel
# 163   N01216   male    1981 age18to24             <NA>      mid
# 162   N01217   male    1976 age25to34             <NA>      mid
# 164   N01218 female    1980 age18to24       maleFemale     high
# 1049  N01219   male    1980 age18to24             <NA>      mid
# 1051  N01220 female    1955 age35to44             <NA>      mid
# 1050  N01221 female    1983 age18to24       maleFemale     high

 summary(dutchSpeakersDistMeta)
# Speaker        Sex        AgeYear          AgeGroup    ConversationType EduLevel  
# N01001 :  1   female:90   Min.   :1923   age18to24:71   femaleOnly:26      high:117  
# N01002 :  1   male  :73   1st Qu.:1956   age25to34:38   maleFemale:55      low :  1  
# N01003 :  1   NA's  : 2   Median :1974   age35to44:12   maleOnly  :10      mid : 44  
# N01004 :  1               Mean   :1967   age45to55:20   NA's      :74      NA's:  3  
# N01005 :  1               3rd Qu.:1979   age56up  :22                                
# (Other):158               Max.   :1987   NA's     : 2                                
# NA's   :  2               NA's   :2 

################################################################################################################################## 

## c) Each line in this file provides information on a single speaker. How many speakers are included in this dataset?
##    In other words, use a function to retrieve the number of rows for this dataset.

## Solution- There are total 165 speakers included in the dataset as the results of nrow() command specify. This command is used to find the number of rows in the dataset.

nrow(dutchSpeakersDistMeta)
## Dimensions also give the length of the data 
dim(dutchSpeakersDistMeta)
#Output: [1] 165

## d) Let's say we're interested in the age of the speakers included in the corpus, to see whether males and females are distributed 
##    equally. Create a boxplot for Sex and AgeYear.

## Solution- The BoxPlot for Sex based on the group AgeYear is drawn by the following written code. The Red plot represents the females while the yellow represents the males.
     
      boxplot(dutchSpeakersDistMeta$AgeYear~dutchSpeakersDistMeta$Sex, main=toupper("BoxPlot for Sex and AgeYear"),col=c("red","Yellow"))
## na_action is used to ignore NA in boxplot 
## Box plot is used when the variable on the x axis is categorical and y axis ka variable is continuous 
## e) Does it seem as if either of the two groups has more variability in age?

## Solution- Yes, from the plot it seems that the females have more variability than the males as the vertical size of the box of the plot of number of females over age years is bigger than the plot of the number of males over the age years, thus, spread of age is more for the females than for the males.

## f) Do you see any outliers in either of the two groups?

## Solution- Yes, there appear to be two outliers in the group for males which might be around 1923, 1932 as appears from the plot.

## g) Now calculate the mean and standard deviation of the AgeYear per group. Do this by creating a subset for each group.
##    Do the groups seem to differ much in age?

## Solution - 
     
	 
      data <- dutchSpeakersDistMeta[,c("AgeYear", "Sex")] 
      ## Data now contains columns of AgeYear and Sex only.
      
      dataForFemaleOnAgeGroup <- subset(data, Sex =='female')
      ## DataForFemaleGroup contains values of Age Year for females only, i.e. a subset for female group.
      
      dataForMaleOnAgeGroup <- subset(data, Sex == 'male')
      ## DataForMaleGroup contains values of Age Year for males only, i.e. a subset for male group.
      
      fmean <- tapply(dataForFemaleOnAgeGroup$AgeYear,dataForFemaleOnAgeGroup$Sex, mean)
      ## fmean is mean of Age Year only for females.
      
      fmean
      ##Output:   female     male 
      ##         1966.889     NA 
      
      mmean <- tapply(dataForMaleOnAgeGroup$AgeYear,dataForMaleOnAgeGroup$Sex, mean)
      ## mmean is mean of Age Year only for males.
      
      mmean
      ##Output:   female     male 
      ##            NA     1967.301 
      
      fSD <- tapply(dataForFemaleOnAgeGroup$AgeYear,dataForFemaleOnAgeGroup$Sex, sd)
      ## fSD is value of Standard Deviation only for females over AgeYear Group    
      
      fSD
      ##Output: 
      ##  female     male 
      ##  15.87411    NA 
      
      mSD <- tapply(dataForMaleOnAgeGroup$AgeYear,dataForMaleOnAgeGroup$Sex, sd)
      ## mSD is value of Standard Deviation only for males over AgeYear Group    
      
      mSD
      ##Output:
      ##  female     male 
      ##    NA     14.66258 
      
      ## Also, the groups do not seem to differ much in age as for both males and females, the mean value is rounding to 1967. But yes, Standard Deviation for Females is larger than that of males.
      ## So, the data for females is distributed at larger distance compared to males and is more varied.

## h) What do the whiskers of a boxplot mean?

## Solution - The flattened arrows extending from the box plots are known as whiskers. They represent the reasonable extremes of the data. 
##            That is, these are the minimum and the maximum values that do not exceed a certain distance from the middle say~50% of the data.  
##            If no points exceed that certain distance(usually 1.5*Inter Quartile Range), then the whiskers are simply the minimum and the maximum value of the data. 
##            If there are points beyond that certain distance, the largest point that does not exceed that distance becomes the whisker. 
##            And the points beyond that certain distance are plotted as single points or outliers.

#########################################################################################################################################################################################################################################
 
### Exercise 3: Children's stories & dataframes
###############
# A researcher is interested in the way children tell stories. More specifically, she wants to know how often children 
# use 'and then'. She asks 25 children to tell her a story, and counts the number of times they use 'and then'. The data follow:

# 18 15 22 19 18 17 18 20 17 12 16 16 17 21 25 18 20 21 20 20 15 18 17 19 20 


## a) What measurement scale is this data? Is it discrete or continuous? Explain in one sentence why? (remember, comment out written answers)

      ## Solution: This data is using 'Ratio-Scale' for measurement.This data is discrete.
      ## This is Ratio-Scale because here, 0 has a value which means if a child doesn't speak 'and then' at all. 
      ## Also, one can always compare two children to relate the number of times a child has a tendency to speak 'and then', so operations like division or multiplication (may be to find rate of speaking 'and then' hold importance here.
      ## It is discrete because a real number like 2.5 times makes no sense here.

## b) In the next questions (c-e), you will create a dataframe of this data, which will also include participant IDs.
##    Why is a dataframe better suited to store this data than a matrix?

      ## Solution: Using dataframe rather than matrix for storing this data is a better idea because the data here is of fixed length and there is only one variable 
      ## with which we have to deal which is "No of times 'and then' has been spoken by a child", so there is no need of going into multidimensional matrix.
      ## If there would have been more than one observation recorded, then matrix could have been a better choice.
      
	  ## Here data is not only integer, it is used as an index.
	  
## c) First create a vector with participant IDs. Your vector should be named 'pps', and your participants should be labeled from 1 to 25

      ## Solution: 
      pps <- 1:25
      
## d) Next, create a vector containing all the observations. Name this vector 'obs'.

      ## Solution: Using concatenation function to create this vector,
      obs <- c(18, 15, 22, 19, 18, 17, 18, 20, 17, 12, 16, 16, 17, 21, 25, 18, 20, 21, 20, 20, 15, 18, 17, 19, 20)
      
## e) Create a dataframe for this data. Assign this to 'stories'. 

      ## Solution: 
      stories <- data.frame(pps, obs)
      
## f) Take a look at the summary of your dataframe, and at the classes of your columns. What class is the variable 'pps'?

      ## Solution: 
      summary(stories)
      ##Output for summary:
      #pps          obs       
    #Min.   : 1   Min.   :12.00  
    #1st Qu.: 7   1st Qu.:17.00  
    #Median :13   Median :18.00  
    #Mean   :13   Mean   :18.36  
    #3rd Qu.:19   3rd Qu.:20.00  
    #Max.   :25   Max.   :25.00 
      
      sapply(stories,class)
      #Output is:
 ##   pps       obs 
 ## "integer" "numeric"
 ##  Thus the variable 'pps' is of integer class.
  
## g) Change the class of 'pps' to factor. Why is factor a better class for this variable?

      ## Solution: 
      pps <- as.factor(pps)
      
      ## Factor rather than integer is a better class for pps because we are using this to store the participation IDs and we 
      ## want to make sure that no arithmentics or any other operation should modify any of the values of these ids.
      ## So, unlike integer class, factors assure that the functions will treat the data correctly and will not be able to modify the values in pps.
      
	  ## There is categorical difference between people and the increasing numbers are not a scale. p1 is not greater than or smaller than number 2 
## h) Plot a histogram (using hist()) for these data. Set the number of breaks to 8.

      ## Solution: 
      hist(obs, breaks = 8)
      
## i) Create a kernel density plot using density().

      ## Solution: 
      plot(density(obs))
      
## j) What is the difference between a histogram and a kernel density plot?

      ## Solution: 
      ## Histograms help with quickly visualizing & getting a feel for 1 or 2 dimensional slices of data.  One simply define a bin width (1-d) or area (2-d) and count how many samples fall into each bin - thus, it is fast & simple.  
      ## But for higher dimensional data, however, we are likely to run into the curse of dimensionality, thus, involving many features under analysis at the same time. Specifically, we will have an exponential number of hypercube bins & nearly all of them will probably be empty. Thus, we do not use histograms for data with more than 2 dimensions.
      ## Kernel density estimation (KDE) is a technique that uses distances (usually euclidean) to known samples in order to assign probabilities.  This means that every single point in our sample space has a non-zero probability.  
      ## KDE also has problems in high dimensions. The probabilities can get so close to zero as to look like zero to a computer. 
      ## Also, all samples in high-d are more-or-less equally far apart from each other. As a result, the more dimensions We have, the more uniform our space looks based on distances.  
      
      ## Area under curve is always equal to 1 for density plot while histogram shows only frequency.
	  ## Area under histogram is 50. So we can scale density plot by 50.
	  ## >h <- hist(stories$obs, breaks =8)
	  ## >h 
	  
	  ## par command is used to show two plots simultaneously.
	  ## overlaying 
	  ## hist
	  ## widthOfhistBar <- 2-dareaUnderCurvehist <- (length(stories$obs)* widthOfhistBar
## k) Overlay the histogram with the kernel density plot 
 ##(hint: the area under the curve should be equal for overlaying the graphs correctly.)

      ## Solution: 
      hist(obs, prob=TRUE, col = "yellow")
      lines(density(obs), col = "red")
      ## Here you have not plotted the frequency. But you can interpret saying that the probability is bla!
###########################################################################################################################################################
      
### Exercise 4: Normal distributions
###############
## In this exercise, we will plot normal distributions.

## a) First, use seq() (?seq) to select the x-values to plot the range for (will become the x-axis in the plot).
##    Get R to generate the range from -5 to 5, by 0.1. Assign this to the variable x.

      ## Solution: 
      x <- seq(from = -5, to = +5, by = 0.1)
      
## b) Now we need to obtain the y-values of the plot (the density). We do this using the density function for the normal distribution. Use "help(dnorm)" to find out about the standard functions for the normal distribution.

      ## Solution: Calculating mean and standard deviation of x to put it in dnorm function.

      y <- dnorm(x)
      
## c) Now use plot() to plot the normal distribution for z values of "x". 

      ## Solution: 
      plot(x,y)
      
## d) The plot now has a relatively short y-range, and it contains circles instead of a line. 
##    Using plot(), specify the y axis to range from 0 to 0.8, and plot a line instead of the circles.

      ## Solution:
      plot(x, y, ylim = c(0, 0.8), type = 'l')
      
## e) We want to have a vertical line to represent the mean of our distribution. 'abline()' can do this for us. Look up help for abline(). Use abline() to create the vertical line. Specify the median of x using the argument 'v'.
##    In order to get a dashed line, set the argument 'lty' to 2.

      ## Solution: The green solid line represents the mean here while the red dotted line represents the median here.
      ## Both mean and median coincide here as the curve is symmetric. There value is 0 approximately.
      abline(v = mean(x),col="green")
      abline(v = median(x),col="red",lty = 2)
      
## f) Take a look at the beaver1 dataset. (You can see it by typing "beaver1".) Then select only the temperature part and store it in a variable "b1temp".

      ## Solution: 
      b1temp <- beaver1[,c("temp")]
      
## g) Calculate the mean and standard deviation of this dataset and plot a normal distribution with these parameters.

      ## Solution: 
      mean(b1temp)
      #[1] 36.86219
      sd(b1temp)
      #[1] 0.1934217
      b1tempND <- pnorm(b1temp, mean = mean(b1temp), sd = sd(b1temp), log = FALSE)
      plot(b1temp,b1tempND)
      
## h) We observe two temperatures (36.91 and 38.13). What's the likelihood that these temperatures respectively come from the normal distribution from g)?

      ## Solution: From the plot of the normal distribution in question part g), it seems 36.91 has higher likelihood than of 38.13 to come from this normal distribution.
      ## The exact value of their chances of coming from this distribution is:
      
      pnorm(36.91, mean = mean(b1temp), sd = sd(b1temp), log = FALSE)
      #[1] 0.5976096
      pnorm(38.13, mean = mean(b1temp), sd = sd(b1temp), log = FALSE)
      #[1] 1
      
	  ## xaxis <- seq(35,39,0.01)
	  ## plot(dnorm(xaxis, mean,sd), type ='1')
      ## Thus, 36.91 has higher chances of occurence and 38.13 has almost no chances of occurences.
      
## i) Use the random sampling function in R to generate 20 random samples from the normal distribution from g), and draw a histrogram based on this sample. Repeat 5 times. What do you observe? 

      ## Solution: 
      RS1 <- sample(b1tempND, 20, replace = FALSE, prob = NULL)
      RS2 <- sample(b1tempND, 20, replace = FALSE, prob = NULL)
      RS3 <- sample(b1tempND, 20, replace = FALSE, prob = NULL)
      RS4 <- sample(b1tempND, 20, replace = FALSE, prob = NULL)
      RS5 <- sample(b1tempND, 20, replace = FALSE, prob = NULL)
      h <- c(RS1,RS2,RS3,RS4,RS5)
      hist(h, breaks =5)
      ##  This were the 100 samples generated.
      ##   [1] 0.963925734 0.335439536 0.298630700 0.047881223 0.474867991 0.413660080 0.280942694 0.231125641 0.433905611 0.711361881 0.474867991 0.637042896 0.557156456 0.373900285
      ##   [15] 0.557156456 0.974606860 0.354484416 0.536676076 0.160197290 0.004047717 0.931621482 0.557156456 0.777616937 0.136310126 0.316808413 0.053257925 0.536676076 0.393641545
      ##   [29] 0.656255930 0.335439536 0.454326067 0.959636143 0.280942694 0.053257925 0.280942694 0.160197290 0.728760379 0.858672164 0.373900285 0.656255930 0.474867991 0.761912858
      ##   [43] 0.637042896 0.557156456 0.890552968 0.413660080 0.656255930 0.745619667 0.858672164 0.280942694 0.557156456 0.711361881 0.474867991 0.003469435 0.215686201 0.536676076
      ##   [57] 0.454326067 0.495476957 0.280942694 0.011122453 0.280942694 0.298630700 0.002966473 0.354484416 0.536676076 0.637042896 0.011122453 0.105257630 0.656255930 0.949816624
      ##   [71] 0.656255930 0.792712809 0.373900285 0.454326067 0.215686201 0.557156456 0.761912858 0.959636143 0.745619667 0.413660080 0.335439536 0.536676076 0.597609610 0.298630700
      ##   [85] 0.373900285 0.597609610 0.949816624 0.454326067 0.354484416 0.728760379 0.495476957 0.745619667 0.280942694 0.373900285 0.298630700 0.280942694 0.335439536 0.557156456
      ##   [99] 0.011122453 0.160197290
      
      ## From the histogram, it seems, values of samples between 0.2 to 0.4 had the highest frequency. Again, between 0.4 to 0.6, it was second highest in frequency
      ## while 0.8-1.0 had the minimum frequency.
########################################################################################################################################################

