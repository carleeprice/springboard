#load the data
NH11 <- readRDS("NatHealth2011.rds")
## Assignment: 
##   1. Use glm to conduct a logistic regression to predict ever worked
##      (everwrk) using age (age_p) and marital status (r_maritl).
#first: check the integrity of the three variables we'd like to study.
levels(NH11$everwrk)
#for everwrk, we'll collapse missing values to NA's
NH11$everwrk <- factor(NH11$everwrk, levels=c("2 No", "1 Yes"))
summary(NH11$everwrk)
summary(NH11$age_p)
#this one looks good, no missing values
summary(NH11$r_maritl)
marlev <- c("1 Married - spouse in household", "2 Married - spouse not in household", "4 Widowed", "5 Divorced", "6 Separated", "7 Never married", "8 Living with partner")
NH11$r_maritl <- factor(NH11$r_maritl, levels=marlev)
summary(NH11$r_maritl)
#then run the regression model
predwork <- glm(everwrk~age_p+r_maritl, data=NH11, family="binomial")
coef(summary(predwork))
##   2. Predict the probability of working for each level of marital
##      status.
predDat <- with(NH11, expand.grid(r_maritl = marlev, age_p = mean(age_p, na.rm = TRUE)))
cbind(predDat, predict(predwork, type = "response",
                       se.fit = TRUE, interval="confidence",
                       newdata = predDat))
#there is a 93.1% chance that someone who is divorced works, 76.7% if widowed, 86.7% if married and cpouse in household
#these are just examples from the 7 different outcomes.
#and, for fun:
library(effects)
#this is really cool!!
plot(allEffects(predwork))
