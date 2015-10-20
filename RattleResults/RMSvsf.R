library(lme4)
library(lmerTest)
library(ggplot2)

setwd('/Users/Bubba/Desktop/COGS195/Github/RattleNN/RattleResults')
rattledata = read.csv('data.csv')
colnames(rattledata) = c("run","yoked","sec","RMS","f")
rattledata$yoked[rattledata$yoked==0] = "RMS-reinforced"
rattledata$yoked[rattledata$yoked==1] = "yoked control"

rattlelm = lmer(scale(RMS) ~ (1|run) + yoked + scale(sec) + yoked*scale(sec), data = rattledata)
summary(rattlelm)

qplot(sec,RMS,data=rattledata,main= "600ms, 5 runs, WTA 10-14", geom=c("smooth"),method ="lm",formula=y~x,color=yoked)
quartz.save("rattleresults.pdf",type="pdf")

plot(rattledata$f,rattledata$RMS, main= "600ms, 5 runs, WTA 10-14", xlab="f",ylab="RMS")
quartz.save("RMSvsf.pdf",type="pdf")
