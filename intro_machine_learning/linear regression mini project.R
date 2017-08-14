#load & examine the data
states.data <- readRDS("dataSets/states.rds") 
tail(states.data, 8)
sts.nrg.met <- subset(states.data, select = c("energy", "metro"))
summary(sts.nrg.met)
#look for correlations in our data --> too high and our subsequent analysis becomes difficult
cor(sts.nrg.met, use = "pairwise.complete.obs")
#examine the data in plot format
plot(sts.nrg.met)
nrg.met <- lm(energy ~ metro, data=states.data) 
summary(nrg.met)
#low r^2 means low explanatory power
plot(nrg.met, which = c(1, 2))
#there are three strong outliers here,lets look at them.
states.data[c(2,19,51),]
#is there one characteristic for which all these outliers are offside?
#they all are quite large, relative to the average
summary(states.data$area)
#add area to the regression, see if it improves
model1 <- (lm(energy ~ metro + area, data = states.data))
summary(model1)
#it sure does: r^2 is now nearly 50%
class(model1)
names(model1)
methods(class = class(model1))[1:9]
confint(model1)
hist(residuals(model1))
par(mar = c(4, 4, 2, 2), mfrow = c(1, 2)) #optional


sat.voting.mod <-  lm(csat ~ expense + house + senate, data = na.omit(states.data))
sat.mod <- update(sat.mod, data=na.omit(states.data))
anova(sat.mod, sat.voting.mod)
coef(summary(model1))

