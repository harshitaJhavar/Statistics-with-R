# read in the data file from gender.Rdata, sem.Rdata or relclause.Rdata.
# You can choose the one you'd like best based on the description of the items below, and explore the analysis for that dataset. Afterwards, you can adapt your analysis for the other datasets (that should be considerably less work.)
gD <- "gender.Rdata"
genderData<-read.table(gD, header=TRUE, sep=" ")
rcD <- "relclause.Rdata"
relclauseData <- read.table(rcD, header=TRUE, sep=" ")
sD <- "sem.Rdata"
semData <- read.table(sD, header=TRUE, sep=" ")
# the files contain data from an experiment where people were reading sentences, and pressed the space bar to see the next word. 
#The duration for which a word was viewed before pressing the space bar again is the reading time of the word, and is stored in the 
#file as "WORD_TIME". The experiment had 24 items (given as "ITEM_ID") and 24 subjects (given as "PARTICIPANT"). 
#The order in which the different sentences were presented in the experiment is given in the variable "itemOrder". 
# For each of the files, the sentences that were shown had a different property. Sentences in the sem.Rdata experiment had a 
#semantic violation, i.e. a word that didn't fit in with the previous words in terms of its meaning. 
#The experiment contained two versions of each item, which were identical to one another except for the one sentence 
#containing a semantic violation, while the other one was semantically correct. These conditions are named "SG" for 
#"semantically good" and "SB" for "semantically bad".
######
#Notes of tutorial
#Item id is different than the Word Order ID as different people get different order of words. So, it will be taken as a predictor.
#Here every participant has seen around 97 - 98 (Depends on max value of 98)
######

#Semantic materials (the experiment is in German, English translation given for those who don't speak German')

#Christina schießt / raucht eine Zigarette nach der Arbeit. 
#“Christina is shooting / smoking a cigarette after work.”

# The crticial word here is "Zigarette", as this would be very surprising in the context of the verb "schießt", but not in the context of the verb "smoke". Reading times are comparable because the critical word "Zigarette" is identical in both conditions.

# Syntactic items:
# Simone hatte eine(n) schreckliche(n) Traum und keine Lust zum Weiterschlafen. 
# “Simone had a[masc/fem] horrible[masc/fem] dreammasc and didn’t feel like sleeping any longer.”

# here, there are again two conditions, one using correct grammatical gender on "einen schrecklichen" vs. the other one using incorrect grammatical gender "eine schreckliche". The critical word is "Traum" (it's either consisten or inconsistent with the marking on the determiner and adjective)

# Relative clause items:
#Die Nachbarin, [die_sg nom/acc einige_pl nom/acc der Mieter auf Schadensersatz  verklagt hat_sg/ haben_pl]RC, traf sich gestern mit Angelika. 
#“The neighbor, [whom some of the tenants sued for damages / who sued some of  the tenants for damages]RC, met Angelika yesterday.”

#When reading such a sentence, people will usually interpret the relative pronoun die as the subject of the relative clause and the following noun phrase "einige der Mieter" as the object. This interpretation is compatible with the embedded singular-marked (sg) verb hat at the end of the relative clause. Encountering the verb haben, which has plural marking (pl), leads to processing difficulty: in order to make sense of the relative clause, readers need to reinterpret the relative pronoun die as the object of the relative clause and the following noun phrase "einige der Mieter" as its subject. (Note that the sentences are all grammatical, as the relative pronoun and following NPs are chosen such that they are ambiguous between nominative (nom) and accusative (acc) case marking.)

# The number of the word in a sentence is given in column "SEMWDINDEX". 0 designates the word where the semantic violation happens (in the SB condition; in the SG condition, it's the corresponding word). We call this word the "critical word" or "critical region". -1 is the word before that, -2 is two words before that word, and 2 is two words after that critical word. "EXPWORD" shows the words. We expect longer reading times for the violation at word 0 or the word after that (word 1) (if people press the button quickly before thinking properly).

# Take a look at the data. Plot it; decide whether you want to exclude any data points; try to make a plot where for each word, 
# the average reading (collapsing across items and subjects) is shown; in this plot all violations are at point 0. Of course, you 
# should not collapse the semantically good vs. bad condition.
# Experiment with calculating a linear mixed effects model for this study, and draw the appropriate conclusions.

#For genderData
#Plotting its boxplot
boxplot(genderData$WORD_TIME,xlab="Expression Words", ylab="Word Time")
#Clearly, as we can see in the Box Plot, there are two outliers which have to be removed.
#Viewing the summary of genderData to get the outlier value
summary(genderData)
#From summary, we get value of first outlier as 6269. Yes, we have to remove this data point.
#Removing this outlier 6269 and assigning 'NA' to it.
#May be some of the outliers come from end of the sentence and not from the critical region.
critical_region <- subset(genderData, RELWDINDEX==0)
summary(critical_region)
boxplot(critical_region$WORD_TIME)
#You can check with histogram as well
hist(critical_region$WORD_TIME, breaks = 100)
subset(critical_region, WORD_TIME>2000)
#Clearly, p1934mr subject has contributed three data points greater than 2000, we do not want to calculate this.
#So, we want our data to be normally distributed. So we will take values less than 2000
clean=subset(critical_region, WORD_TIME<2000)
hist(critical_region$WORD_TIME, breaks = 100, xlim=c(0,500))
#Still there are first two entries which are suspicious.
hist(clean$WORD_TIME,breaks=100)
#So, not the question is whether to do regression on this raw data or clean it further. 
# We will do log transform on it so as to make it look more modelled
hist(log(clean$WORD_TIME))
#Here the main predictor we are interested in is a binary predictor. So even if we change it, it wont make a difference.
# We are not interested in other items as we do not expect it to produce some interesting results.
clean$logRT <- log(clean$WORD_TIME)
summary(clean)
#Incorrecet = index <- which(genderData$WORD_TIME == 6269)
#Incorrect = genderData$WORD_TIME[index] = NA
#Viewing the summary of genderData again to get the second outlier value
summary(genderData)
#Incorrect = From summary, we get value of secondt outlier as 4373. Yes, we have to remove this data point.
#Incorrect = Removing this outlier 4373 and assigning 'NA' to it.
#Incorrect = index <- which(genderData$WORD_TIME == 4373)
#Incorrect = genderData$WORD_TIME[index] = NA
#Again, plotting the Boxplot 
boxplot(clean$WORD_TIME~clean$PARTICIPANT)
#We can conclude only about intercepts as we have not shown the effect of the predictor, so, no talk about the slope.
boxplot(clean$WORD_TIME~clean$ITEM_ID)
#The second boxplot with respect to the ITEM_ID is much better. There are less variations as compared to the previous boxplot.
boxplot(clean$WORD_TIME~clean$ITEM_ID+clean$ITEM_TYPE,las=2)
#Plotting for each word, average reading time collapsed across ITEM_ID and PARTICIPANT with red representing the critical point.
#In general case, if your model is converges (like you are not worried if there is no variation,then it will be nice to include both the random slope and the intercept)
boxplot(clean$WORD_TIME~clean$PARTICIPANT+clean$ITEM_TYPE,las=2)
#Linear Mixed Effect MODEL
library(lme4)
m1a <- lmer(WORD_TIME~ITEM_TYPE + (1+ITEM_TYPE|PARTICIPANT) + (1+ITEM_TYPE|ITEM_ID), data=clean)
#Here, in the above model, we have included the random slopes, item_type/particpant and item_type/item_id. We include these as we believe that this has impact on the data.
summary(m1a)
#Here, from the estimate at the fixed effects as seen in the summary, the model seems to converge properly.
#Here, there are many residuals, as there are lot of unexplainable variability.
lm1a <-lmer(logRT~ITEM_TYPE+ (1+ITEM_TYPE|PARTICIPANT) + (1+ITEM_TYPE|ITEM_ID), data= clean)
plot(lm1a)
#We have more variance on the right side than on the left side.
#For short reading times, we have less residuals.
resid <- residuals(m1a)
plot(resid)
qqnorm(resid)
#This is for out non-logged transform. It is the tail for the response variable that we saw.
qqnorm(residuals(lm1a))
#This looks quiet nicer as line is more straight. We have not violated our assumptions in terms of what is significant and not.
#How about we include item order as predictor in our model
plot(clean$itemOrder, clean$WORD_TIME)
#It looks like people are getting little bit faster as experiment proceeds. Let us check that.
ml2a <- lmer(logRT~ITEM_TYPE + itemOrder+ (1+ITEM_TYPE|PARTICIPANT)+(1+ITEM_TYPE|ITEM_ID) , data=clean)
summary(ml2a)
#Here, we have taken item_order as a fixed effect
m2 <- lmer(WORD_TIME~ITEM_TYPE + itemOrder+ (1+ITEM_TYPE|PARTICIPANT)+(1+ITEM_TYPE|ITEM_ID) , data=clean)
summary(m2)
#With item Order, we try to capture how people are getting faster with the experiment.
#So, it would not fit with the random slope.
#In the summary, from the estimates of the fixed effexts, if I have to find the right value, I will subtract ITEM_TYPEGG value and ITEMORDER value from it to estimate the value.
#Comparing the two models
anova(m1a,m2)
#m2 is better.
#We have to include itemOrder with random slope.
#As long as the model converges, it will be the best
m3 <- lmer(logRT~ITEM_TYPE + itemOrder+ (1+ITEM_TYPE|PARTICIPANT)+(1+ITEM_TYPE|ITEM_ID) , data=clean)
summary(m3)
#In the logarithmic model, there was no significant interaction. In the previous model, there were more interaction. In the first model, the assumptions were violated.
#So, we trust this model.
anova(m2,m3)
#There is a warning, m2 and m3, REML is for approximation of small dataset.
lm3 <- lmer(logRT~ITEM_TYPE + itemOrder+ (1+ITEM_TYPE+itemOrder|PARTICIPANT)+(1+ITEM_TYPE+itemOrder|ITEM_ID) , data=clean)
#Basically, some itmes differ in the effect of the reading times with later or in beginning reading of the experiment.
#Here there is a warning and thus, stops converging. If we have a large random effect structure, then, we will often run into this problem.

#library(doBy)
averagedgenderData <- summaryBy(WORD_TIME ~ ITEM_ID + PARTICIPANT + EXPWORD + ITEM_TYPE + RELWDINDEX, data = genderData, FUN = function(x) { c(m = mean(x), s = sd(x)) } )
plot(averagedgenderData$EXPWORD,averagedgenderData$WORD_TIME.m, col = ifelse(averagedgenderData$RELWDINDEX == 0,"red", "black"))
#The red are the critical points

#Linear Mixed Effect Model 
library(arm)
lmer(WORD_TIME~EXPWORD + (1|ITEM_ID) + (1|PARTICIPANT), data= clean)


#This model has EXPWORD as fixed effect and WORD_TIME as random effect.
#REML value is 79030.92 which is a logical scalar quantity which tells us the likelihood of the estimates which we have chosen for optimization of the REML criterion.
#With the result of this plot, we have obtained the result fixed effect value for each unique value in the dataset.
#The value for the intercept for Item_Id is 9.54 and value for participant is 144.059.
#The value for resudual is 264.177.

#For semData
#Plotting its boxplot
boxplot(semData$WORD_TIME,xlab="Expression Words", ylab="Word Time")
#Clearly, as we can see in the Box Plot, there is one outlier which has to be removed.
#Viewing the summary of semData to get the outlier value
summary(semData)
#From summary, we get value of outlier as 4975. Yes, we have to remove this data point.
#Removing this outlier 4975 and assigning 'NA' to it.
index <- which(semData$WORD_TIME == 4975)
semData$WORD_TIME[index] = NA
#Again, plotting the Boxplot 
boxplot(semData$WORD_TIME,xlab="Expression Words", ylab="Word Time")
#Now, we get the required box plot.
#Plotting for each word, average reading time collapsed across ITEM_ID and PARTICIPANT with red representing the critical point.
a <- semData
library(doBy)
averagedSemData <- summaryBy(WORD_TIME ~ ITEM_ID + PARTICIPANT + EXPWORD + ITEM_TYPE + SEMWDINDEX, data = semData, FUN = function(x) { c(m = mean(x), s = sd(x)) } )
plot(averagedSemData$EXPWORD,averagedSemData$WORD_TIME.m, col = ifelse(averagedSemData$SEMWDINDEX == 0,"red", "black"))
#The red colored are the critical ones.

#Linear Mixed Effect Model 
library(arm)
lmer(WORD_TIME~EXPWORD + (1|ITEM_ID) + (1|PARTICIPANT), data= semData)
#This model has EXPWORD as fixed effect and WORD_TIME as random effect.
#REML value is 61469.28 which is a logical scalar quantity which tells us the likelihood of the estimates which we have chosen for optimization of the REML criterion.
#With the result of this plot, we have obtained the result fixed effect value for each unique value in the dataset.
#The value for the intercept for Item_Id is 0 and value for participant is 154.9.
#The value for resudual is 255.9.

#For relclauseData
#Plotting its boxplot
boxplot(relclauseData$WORD_TIME,xlab="Expression Words", ylab="Word Time")
#Clearly, as we can see in the Box Plot, there are two outliers which have to be removed.
#Viewing the summary of relclauseData to get the outlier value
summary(relclauseData)
#From summary, we get value of first outlier as 9946. Yes, we have to remove this data point.
#Removing this outlier 9946 and assigning 'NA' to it.
index <- which(relclauseData$WORD_TIME == 9946)
relclauseData$WORD_TIME[index] = NA
#Viewing the summary of genderData again to get the second outlier value
summary(relclauseData)
#From summary, we get value of secondt outlier as 8860. Yes, we have to remove this data point.
#Removing this outlier 8860 and assigning 'NA' to it.
index <- which(relclauseData$WORD_TIME == 8860)
relclauseData$WORD_TIME[index] = NA
#Again, plotting the Boxplot 
boxplot(relclauseData$WORD_TIME,xlab="Expression Words", ylab="Word Time")
#Now, we get the required box plot without any outliers.
#Plotting for each word, average reading time collapsed across ITEM_ID and PARTICIPANT with red representing the critical point.
a <- relclauseData
library(doBy)
averagedrelclauseData <- summaryBy(WORD_TIME ~ ITEM_ID + PARTICIPANT + EXPWORD + ITEM_TYPE + RELWDINDEX, data = relclauseData, FUN = function(x) { c(m = mean(x), s = sd(x)) } )
plot(averagedrelclauseData$EXPWORD,averagedrelclauseData$WORD_TIME.m, col = ifelse(relclauseData$RELWDINDEX == 0,"red", "black"))
#The red are the critical points
#Linear Mixed Effect Model 
library(arm)
lmer(WORD_TIME~EXPWORD + (1|ITEM_ID) + (1|PARTICIPANT), data= relclauseData)
#This model has EXPWORD as fixed effect and WORD_TIME as random effect.
#REML value is 133348.3 which is a logical scalar quantity which tells us the likelihood of the estimates which we have chosen for optimization of the REML criterion.
#With the result of this plot, we have obtained the result fixed effect value for each unique value in the dataset.
#The value for the intercept for Item_Id is 23.28 and value for participant is 147.51.
#The value for residual is 305.06.

