library(lme4)
library(lmerTest)
library(ggplot2)

setwd('/Users/Bubba/Desktop/COGS195/Github/RattleNN/RattleResults')
rattledata = read.csv('25data.csv')
colnames(rattledata) = c("run","yoked","sec","RMS","f")
rattledata$yoked[rattledata$yoked==0] = "RMS-reinforced"
rattledata$yoked[rattledata$yoked==1] = "yoked control"

rattlelm = lmer(scale(RMS) ~ (1|run) + yoked + scale(sec) + yoked*scale(sec), data = rattledata)
summary(rattlelm)

qplot(sec,RMS,data=rattledata,main= "25s, 5 runs, Rattle C fsine 3-7-16", geom=c("smooth"),method ="lm",formula=y~x,color=yoked)
quartz.save("3-7_25s_RCS4_rattleresults.pdf",type="pdf")

plot(rattledata$f,rattledata$RMS, main= "25s, 5 runs, Rattle C fsine 3-7-16", xlab="f",ylab="RMS")
quartz.save("3-7_25s_RcS4_RMSvsf.pdf",type="pdf")




setwd('/Users/Bubba/Desktop/COGS195/Github/RattleNN/RattleResults')
rattledata = read.csv('50data.csv')
colnames(rattledata) = c("run","yoked","sec","RMS","f")
rattledata$yoked[rattledata$yoked==0] = "RMS-reinforced"
rattledata$yoked[rattledata$yoked==1] = "yoked control"

rattlelm = lmer(scale(RMS) ~ (1|run) + yoked + scale(sec) + yoked*scale(sec), data = rattledata)
summary(rattlelm)

qplot(sec,RMS,data=rattledata,main= "50s, 5 runs, Rattle C fsine 3-7-16", geom=c("smooth"),method ="lm",formula=y~x,color=yoked)
quartz.save("3-7_50s_RBS4_rattleresults.pdf",type="pdf")

plot(rattledata$f,rattledata$RMS, main= "50s, 5 runs, Rattle C fsine 3-7-16", xlab="f",ylab="RMS")
quartz.save("3-7_50s_RBS4_RMSvsf.pdf",type="pdf")



setwd('/Users/Bubba/Desktop/COGS195/Github/RattleNN/RattleResults')
rattledata = read.csv('100data.csv')
colnames(rattledata) = c("run","yoked","sec","RMS","f")
rattledata$yoked[rattledata$yoked==0] = "RMS-reinforced"
rattledata$yoked[rattledata$yoked==1] = "yoked control"

rattlelm = lmer(scale(RMS) ~ (1|run) + yoked + scale(sec) + yoked*scale(sec), data = rattledata)
summary(rattlelm)

qplot(sec,RMS,data=rattledata,main= "100s, 5 runs, Rattle C fsine 3-7-16", geom=c("smooth"),method ="lm",formula=y~x,color=yoked)
quartz.save("3-7_100s_RBS4_rattleresults.pdf",type="pdf")

plot(rattledata$f,rattledata$RMS, main= "100s, 5 runs, Rattle C fsine 3-7-16", xlab="f",ylab="RMS")
quartz.save("3-7_100s_RBS4_RMSvsf.pdf",type="pdf")



setwd('/Users/Bubba/Desktop/COGS195/Github/RattleNN/RattleResults')
rattledata = read.csv('200data.csv')
colnames(rattledata) = c("run","yoked","sec","RMS","f")
rattledata$yoked[rattledata$yoked==0] = "RMS-reinforced"
rattledata$yoked[rattledata$yoked==1] = "yoked control"

rattlelm = lmer(scale(RMS) ~ (1|run) + yoked + scale(sec) + yoked*scale(sec), data = rattledata)
summary(rattlelm)

qplot(sec,RMS,data=rattledata,main= "200s, 5 runs, Rattle C fsine 3-7-16", geom=c("smooth"),method ="lm",formula=y~x,color=yoked)
quartz.save("3-7_200s_RBS4_rattleresults.pdf",type="pdf")

plot(rattledata$f,rattledata$RMS, main= "200s, 5 runs, Rattle C fsine 3-7-16", xlab="f",ylab="RMS")
quartz.save("3-7_200s_RBS4_RMSvsf.pdf",type="pdf")


setwd('/Users/Bubba/Desktop/COGS195/Github/RattleNN/RattleResults')
rattledata = read.csv('300data.csv')
colnames(rattledata) = c("run","yoked","sec","RMS","f")
rattledata$yoked[rattledata$yoked==0] = "RMS-reinforced"
rattledata$yoked[rattledata$yoked==1] = "yoked control"

rattlelm = lmer(scale(RMS) ~ (1|run) + yoked + scale(sec) + yoked*scale(sec), data = rattledata)
summary(rattlelm)

qplot(sec,RMS,data=rattledata,main= "300s, 5 runs, Rattle C fsine 3-7-16", geom=c("smooth"),method ="lm",formula=y~x,color=yoked)
quartz.save("3-7_300s_RBS4_rattleresults.pdf",type="pdf")

plot(rattledata$f,rattledata$RMS, main= "300s, 5 runs, Rattle C fsine 3-7-16", xlab="f",ylab="RMS")
quartz.save("3-7_300s_RBS4_RMSvsf.pdf",type="pdf")


setwd('/Users/Bubba/Desktop/COGS195/Github/RattleNN/RattleResults')
rattledata = read.csv('400data.csv')
colnames(rattledata) = c("run","yoked","sec","RMS","f")
rattledata$yoked[rattledata$yoked==0] = "RMS-reinforced"
rattledata$yoked[rattledata$yoked==1] = "yoked control"

rattlelm = lmer(scale(RMS) ~ (1|run) + yoked + scale(sec) + yoked*scale(sec), data = rattledata)
summary(rattlelm)

qplot(sec,RMS,data=rattledata,main= "400s, 5 runs, Rattle C fsine 3-7-16", geom=c("smooth"),method ="lm",formula=y~x,color=yoked)
quartz.save("3-7_400s_RBS4_rattleresults.pdf",type="pdf")

plot(rattledata$f,rattledata$RMS, main= "400s, 5 runs, Rattle C fsine 3-7-16", xlab="f",ylab="RMS")
quartz.save("3-7_400s_RBS4_RMSvsf.pdf",type="pdf")


setwd('/Users/Bubba/Desktop/COGS195/Github/RattleNN/RattleResults')
rattledata = read.csv('600data.csv')
colnames(rattledata) = c("run","yoked","sec","RMS","f")
rattledata$yoked[rattledata$yoked==0] = "RMS-reinforced"
rattledata$yoked[rattledata$yoked==1] = "yoked control"

rattlelm = lmer(scale(RMS) ~ (1|run) + yoked + scale(sec) + yoked*scale(sec), data = rattledata)
summary(rattlelm)

qplot(sec,RMS,data=rattledata,main= "600s, 5 runs, Rattle C fsine 3-7-16", geom=c("smooth"),method ="lm",formula=y~x,color=yoked)
quartz.save("3-7_600s_RBS4_rattleresults.pdf",type="pdf")

plot(rattledata$f,rattledata$RMS, main= "600s, 5 runs, Rattle C fsine 3-7-16", xlab="f",ylab="RMS")
quartz.save("3-7_600s_RBS4_RMSvsf.pdf",type="pdf")