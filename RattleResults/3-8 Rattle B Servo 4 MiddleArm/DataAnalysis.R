library(lme4)
library(lmerTest)
library(ggplot2)

setwd('/Users/Bubba/Desktop/COGS195/Github/RattleNN/RattleResults')
rattledata = read.csv('100data.csv')
colnames(rattledata) = c("run","yoked","sec","RMS","f")
rattledata$yoked[rattledata$yoked==0] = "RMS-reinforced"
rattledata$yoked[rattledata$yoked==1] = "yoked control"

rattlelm = lmer(scale(RMS) ~ (1|run) + yoked + scale(sec) + yoked*scale(sec), data = rattledata)
summary(rattlelm)

qplot(sec,RMS,data=rattledata,main= "100s, 2 runs, Rattle A fsine 3-8-16", geom=c("smooth"),method ="lm",formula=y~x,color=yoked)
quartz.save("3-8_100s_RBS4_rattleresults.pdf",type="pdf")

plot(rattledata$f,rattledata$RMS, main= "100s, 5 runs, Rattle A fsine 3-8-16", xlab="f",ylab="RMS")
quartz.save("3-8_100s_RBS4_RMSvsf.pdf",type="pdf")




setwd('/Users/Bubba/Desktop/COGS195/Github/RattleNN/RattleResults')
rattledata = read.csv('200data.csv')
colnames(rattledata) = c("run","yoked","sec","RMS","f")
rattledata$yoked[rattledata$yoked==0] = "RMS-reinforced"
rattledata$yoked[rattledata$yoked==1] = "yoked control"

rattlelm = lmer(scale(RMS) ~ (1|run) + yoked + scale(sec) + yoked*scale(sec), data = rattledata)
summary(rattlelm)

qplot(sec,RMS,data=rattledata,main= "200s, 2 runs, Rattle A fsine 3-8-16", geom=c("smooth"),method ="lm",formula=y~x,color=yoked)
quartz.save("3-8_200s_RBS4_rattleresults.pdf",type="pdf")

plot(rattledata$f,rattledata$RMS, main= "200s, 2 runs, Rattle B fsine 3-8-16", xlab="f",ylab="RMS")
quartz.save("3-8_200s_RBS4_RMSvsf.pdf",type="pdf")



setwd('/Users/Bubba/Desktop/COGS195/Github/RattleNN/RattleResults')
rattledata = read.csv('300data.csv')
colnames(rattledata) = c("run","yoked","sec","RMS","f")
rattledata$yoked[rattledata$yoked==0] = "RMS-reinforced"
rattledata$yoked[rattledata$yoked==1] = "yoked control"

rattlelm = lmer(scale(RMS) ~ (1|run) + yoked + scale(sec) + yoked*scale(sec), data = rattledata)
summary(rattlelm)

qplot(sec,RMS,data=rattledata,main= "300s, 2 runs, Rattle A fsine 3-8-16", geom=c("smooth"),method ="lm",formula=y~x,color=yoked)
quartz.save("3-8_300s_RBS4_rattleresults.pdf",type="pdf")

plot(rattledata$f,rattledata$RMS, main= "900s, 2 runs, Rattle A fsine 3-8-16", xlab="f",ylab="RMS")
quartz.save("3-8_300s_RBS4_RMSvsf.pdf",type="pdf")

