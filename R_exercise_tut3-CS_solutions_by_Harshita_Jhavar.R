### Solution- Stats with R Exercise sheet 3
## Submitted by - Harshita Jhavar, 2566267
## This exercise sheet contains the exercises that you will need to complete and submit 
## by midnight on Sunday, November 20. Write the code below the questions. 
## Submit your homework via Moodle.


###### Exercise 1. Binomial distribution
## Suppose there are 12 multiple choice questions in a quiz. 
## Each question has 5 possible answers, and only one of them is correct. 

## a) Please calculate the probability of getting exactly 4 answers right if you answer by chance. Calculate this using the dbinom() function.
##Solution: 
dbinom(x=4,size=12,prob=0.2,log=FALSE)
##Output: [1] 0.1328756

## b) Next please calculate the probability of answering 4 or less questions correctly by chance. 
##Solution:
## I added all the values of the different probabilities for success (4 correct, 3 correct, 2 correct, 1 correct, 0 correct) calculated by the dbinom function.
sum(dbinom(x=seq(0,4,by=1),size=12,prob=0.2,log=FALSE))
##Output: [1] 0.9274445

##########
###### Exercise 2. Chi-square test
## a) Consider the dataset dutchSpeakersDistMeta from our first tutorial again. Load the package (languageR)
##    and look at the summary of the variables, as well as their classes. Which variables are factors?
##Solution:
install.packages("languageR")
library(languageR)
summary(dutchSpeakersDistMeta)
## sapply(dutchSpeakerDiskMeta,class)
## b) We want to find out whether there is a difference between males and females with respect to the age groups they are in.
## Hint: remember you can use the function 'table()' to get the counts and create a contingency table of AgeGroup by Sex.
##Solution:
AgeGroupVsSexTable <- table(dutchSpeakersDistMeta$AgeGroup,dutchSpeakersDistMeta$Sex)
AgeGroupVsSexTable

## c) Inspect the table you created. Does it look like there could be a significant difference between the sexes?
##Solution:
##As we can see from the table, females are more in most cases except one. However, there does not seem to be significant
##difference between the males and the females. The max difference which can be observed here is 9 and the minimum is 2.

##Correct Answer- Females are bit more extreme than males - Argumentation vise okay answer. With extreme we mean they have less data in the middle age than in the lesser or larger ages.
## d) We are going to calculate whether there's a difference between males and females regarding their age group
##    using the function chisq.test. Look at the help of this function. Then use the function to calculate
##    whether there's a difference in our table 'age'. Is there a significant difference in age group?

##Solution:
help(chisq.test)
chisq.test(AgeGroupVsSexTable)
##Output
##      Pearson's Chi-squared test
##      data:  AgeGroupVsSexTable
##      X-squared = 3.2785, df = 4, p-value = 0.5124
## Since, p-value is very high here (>0.5), thus, there is no significant difference between the males and the females regarding their age groups.
## Correct- We have no reasons to reject the nulll hypothesis. The null hypothesis was that the females and the males are distributed equally.

## e) What are the degrees of freedom for our data? How are they derived?
##Solution:
##The degree of freedom is 4. It is derived as [(Number of rows -1)*(Number of columns -1)].

##Long-way solution for the chi-square test, manually calculating the chi square 
## First find the number of males and females and the age groups via summary.
## summary(dutchSpeak$AgeGroups)
## summary(dutchSpeaker$Sex)
## 90*71/163
## We can calculate this for all different table entries. You should try this manually.

##########
###### Exercise 3. Binomial versus chi-square

##    In this exercise, we'll do significance tests for a paper on therapeutic touch (google it if 
##	  you want to know what that is...) 
##    that was published in the Journal of the American Medical Association (Rosa et al., 1996).
##    The experimenters investigated whether therapeutic touch is real by using the following method:
##    21 practitioners of therapeutic touch were blindfolded. The experimenter placed her hand over one 
##    of their hands. If therapeutic touch is a real phenomenon, the principles behind it suggest that 
##    the participant should be able to identify which of their hands is below the experimenter's hand. 
##    There were a total of 280 trials, of which the therapeutic touch therapists correctly indicated
##    when a hand was placed over one of their hands 123 times.

## a) What is the null hypothesis, i.e. how often would we expect the participants to be correct by chance (in raw number and in percentage)?
##Solution:
##Null Hypothesis- The practitioner can sense the experimentor's "energy field" with their own hands and should be able to identify which of their hands is below the experimenter's hand.  
## Correct Null Hypothesis: The therapeutic touch doesn't work. 
## Remember: The manipulation is not working is the null hypothesis.
## The participants can be correct by chance by (0.5) and in percentage, the value is 50%.

## b) Using a chisquare test, what do you conclude about whether therapeutic touch works? 
##Solution:
##
chisq.test(as.data.frame(rbind(123,157)))
## Refer to Demberg's solution for manual soultion of chi square test.
## It calculates expectation intuitively. Otherwise, if you give the data separately, it treats these two values as two different samples.
##Output
##  Chi-squared test for given probabilities
##  data:  as.data.frame(rbind(123, 157))
##  X-squared = 4.1286, df = 1, p-value = 0.04216
## The null hypotheses can hold true.

## Correct conclusion: Since the value is less than 5%, we can say that the therapeutic value does not work. The null hypothesis is rejected.
## In this example, it will be more beneficial if we formulate it as one tail hypothesis.

## c) Now calculate significance using the binomial test as we used it in exercise 1.
##Solution:
binom.test(123,280,p=0.5)
## Correct Solution:
##pbinom(123,280,p=0.5)
#Output
  #Exact binomial test

  #data:  123 and 280
  #number of successes = 123, number of trials = 280, p-value = 0.0484
  #alternative hypothesis: true probability of success is not equal to 0.5
  #95 percent confidence interval:
  #  0.3802845 0.4995856
  #sample estimates:
  #  probability of success 
  #0.4392857
## Here we are getting a one tail test.
## We have to decide if we have to run it as a one tail test or as a two tail test.

## d) The results from these two tests are slightly different. Which test do you think is better for our data, and why?
##Solution: I believe the chisquare test is better than the binomial test as the two variables, correct choice vs the incorrect choice, here are unrelated.
## Correct Solution:- Binomial test is better as it does not make any estimation. It is an exact estimate.

###### Exercise 4. 

## Describe a situation where you would choose McNemar's test over the ChiSquare test. What would be the problem of using the normal ChiSquare test in a case where McNemar's test would be more appropriate?
##Solution
##Chi-Square tests can be used for larger tables, McNemar tests can only be used for a 2×2 table.
##The Chi-Square tests is testing for independence for two or more variables or  for equality of their proportions, but McNemar test is test for consistency in responses across two variables.
##Chi-square test for comparisons between 2 categorical variables (Fisher's exact test) while McNemar 's Chi-square (Binomial Test) test for paired categorical data
##So, McNemar's test should be used only when the variables are paired otherwise Chi-squared test should be used. 

##Correct Solution: McNemar's Test- It is used when we have for the same task, more than one observations - **CHAR data** - 
###### Exercise 5. 

## Please work on the "Intermediate R" course on DataCamp, in particular, please complete chapters 3 (Functions) and 4 (The apply family). You may skip chapters 1 and 2 of the "Intermediate R" course, if you think you are already sufficiently familiar with the contents of these chapters.

##Solution - I have completed the course "Intermediate R" on DataCamp.

