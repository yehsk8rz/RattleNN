library(lme4)
library(lmerTest)
library(ggplot2)

setwd('/Users/Bubba/Desktop/COGS195/Github/RattleNN')
rattledata = read.csv('data.csv')
colnames(rattledata) = c("run","yoked","sec","RMS","f")
rattledata$yoked[rattledata$yoked==0] = "RMS-reinforced"
rattledata$yoked[rattledata$yoked==1] = "yoked control"

rattlelm = lmer(RMS ~ (1|run) + yoked + sec + yoked*sec, data = rattledata)
summary(rattlelm)

qplot(sec,RMS,data=rattledata,geom=c("smooth"),method ="lm",formula=y~x,color=yoked)
quartz.save("rattleresults.pdf",type="pdf")