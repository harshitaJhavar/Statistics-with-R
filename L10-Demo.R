# homework: play around with the simulation code.
# Things I suggest you change and observe:
# - change the number of simulated observations - are the effects still found ? 
#Remember to re-run the sampling a few times because you of course get a different sample each time...
# - change effect sizes 
# - change the amount of "noise" (= error / unexplained variance) in the data and observe that this means 
#in terms of detecting the effects, also in combination with different choices of effect size / sample size.
# - check whether normalization also has a large effect when there is no interaction present in the data
# - create correlated variables and check whether normalization helps
# - optional: play around also with repeated measures, i.e. create subjects and items with some individual properties and then try out whether the linear regression model can pick them back up.

library(lme4)
library(car)

n <- 2000 # number of observations to be simulated
subj<-as.factor(rep(1:4,n/4))
item<-as.factor(c(rep(1,n/4), rep(2,n/4), rep(3,n/4), rep(4,n/4) ))

 predA <- rnorm(n, 100, 20)
 predB <- rnorm (n, 60, 30)
 error <- rnorm (n, 40, 3)
 error2 <- rnorm (n, 0, 0.8)

 resp <- predA + 1.2*predB - (0.0002*(predA*predB+error2)) + error
# resp_noerrorinteract <- predA + predB - (predA*0.01*predB) + error
# resp_noerrorinteract_noerror <- predA + predB - (predA*0.01*predB) 
 
# WRITE DOWN WHAT VALUES YOU WOULD HOPE FOR THE MODEL TO ESTIMATE
# IN THE IDEAL CASE
# intercept= ?
# predA= ?
# predB= ?
# predA:predB = ?

 normpredA <- (predA - mean(predA)) / sd(predA)
 normpredB <- (predB - mean(predB)) / sd(predB)
 
m1<- lmer(resp~normpredA+normpredB+(1|subj))
m2<- lmer(resp~normpredA+normpredB+(1|subj) + (1|item))
anova(m1,m2)
anova(m1)
anova(m2)
minteract<- lm (resp ~ predA *predB)
 summary(minteract)
 vif(minteract)
mstandinteract<-lm (resp ~normpredA * normpredB)
  summary(mstandinteract)
 vif(mstandinteract)
 
#HERE ARE THE ACTUAL ESTIMATES FOR THE VARIANCE AND MEAN FOR OUR SAMPLE:  
 mean(predA)
 sd(predA)
 mean(predB)
 sd(predB)

# HOW CAN WE CALCULATE INTERPRETABLE ESTIMATES?

names(mstandinteract)
coefficients(mstandinteract)

 denormPredA <- coefficients(mstandinteract)[2] / sd(predA)
 denormPredA
# expected: 1

denormPredB <- coefficients(mstandinteract)[3] / sd(predB)
 denormPredB
# expected: 1.2


 denormIntercept<-coefficients(mstandinteract)[1] - denormPredA * mean(predA) - denormPredB*mean(predB)
 denormIntercept
# expected: 40

 denormInteract <- coefficients(mstandinteract)[4] / (sd(predA)*sd(predB))
denormInteract

