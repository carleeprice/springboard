#load & examine the data
states.data <- readRDS("dataSets/states.rds") 
tail(states.data, 8)
sts.nrg.met <- subset(states.data, select = c("energy", "metro"))
summary(sts.nrg.met)
#look for correlations in our data --> too high and our subsequent analysis becomes difficult
cor(sts.nrg.met, use = "pairwise.complete.obs")
#examine the data in plot format
plot(sts.nrg.met)
#we need to choose the variables for our model.  
#a scatterplot matrix allows us to have a quick loook at candidates
library(car)
scatterplotMatrix(~pop+density+energy+metro+miles, data=states.data)
scatterplotMatrix(~energy+area+toxic+green+income, data=states.data)
#metro looks like it might have some explanatory power
model1 <- lm(energy ~ metro, data=states.data) 
summary(model1)
#low r^2 means low explanatory power
plot(nrg.met, which = c(1, 2))
#there are three strong outliers here,lets look at them.
states.data[c(2,19,51),]
#is there one characteristic for which all these outliers are offside?
#they all are quite large, relative to the average
summary(states.data$area)
#add area to the regression, see if it improves
model2 <- (lm(energy ~ metro + area, data = states.data))
summary(model1)
#it sure does: r^2 is now nearly 50%
class(model2)
names(model2)
methods(class = class(model2))[1:9]
confint(model2)
hist(residuals(model2))
#compare two models -- lets add density to our model see if it improves
model3 <-  lm(energy ~ metro + area + density, data = states.data)
anova(model2, model3)
coef(summary(model2))

## Interactions and factors
#Add the interaction to the model
model4 <- lm(energy ~ metro*toxic,data=states.data) 
#Show the results in a regression coefficients table
coef(summary(model4)) # show regression coefficients table
#only the intercept here seems to be meaningful

## Regression with categorical predictors
str(states.data$region)
states.data$region <- factor(states.data$region)
#Add region to the model
model5 <- lm(energy ~ region,data=states.data) 
#Show the results
coef(summary(model5)) 
anova(model5) # show ANOVA table

contrasts(states.data$region)
# change the reference group
coef(summary(lm(energy ~ C(region, base=4),data=states.data)))
# change the coding scheme
model6 <- lm(energy ~ C(region, contr.helmert),data=states.data)
summary(model6)
coef(summary(model6))

