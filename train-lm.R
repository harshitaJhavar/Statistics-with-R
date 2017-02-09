
# read in  the data kidiq.txt and take a look at the data summary.
# it contains information about the mum's iq and their child's iq.
# mom_hs indicates whether the mother has a high school degree
# 1= hs education, 0= no high school degree.


### plot kid_score against mom_iq in a scatter plot, and add a regression line (kid_score should be the response variable and mom_iq the predictor variable) to the plot. Name the plot and the axis in sensible ways.


### calculate a simple regression model for kid_score with mom_hs as a predictor and interpret the results.


### next, fit a regression model with two predictors: mom_hs and mom_iq. Interpret the model and compare to the previous model.



### now plot a model where both predictors are shown. Do this by plotting data points for mothers with high school degree==1 in black and those without one in gray. 
# then also fit two separate regression lines such that these lines reflect the model results.



## next, we will proceed to a model including an interaction between mom_hs and mom_iq. Interpret your results


# next, let's plot the results of this model


### Next, let's explore the "predict.lm" function. Please first generate  a new dataframe with one datapoint ( a mother with high school degree and iq of 100). Then, use the predict function to predict the child's iq. Please specify the predict function to also give you the 0.95 confidence interval.


# plotting confidence intervals:
# finally, we would like to use the predict function to plot confidence intervals for the regression line. We will do this here only for the simplest regression model (mom_iq as the only predictor).
# first, create a vector of mother iq's from 70 to 140 from which we want to predict the child iqs based on the regression model.
# then, use the predict function to calculate 95% CIs.
# then, plot the regression line in black, and the CI borders in blue.


# finally, do model checking on your model with the interaction, i.e. inspect the standard model plots provided by R, and interpret what you see.
