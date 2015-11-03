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

qplot(sec,RMS,data=rattledata,main= "400s, 5 runs, recur/WTA 10-29", geom=c("smooth"),method ="lm",formula=y~x,color=yoked)
quartz.save("10-29_rattleresults.pdf",type="pdf")

plot(rattledata$f,rattledata$RMS, main= "400s, 5 runs, recur/WTA 10-29", xlab="f",ylab="RMS")
quartz.save("10-29_RMSvsf.pdf",type="pdf")
