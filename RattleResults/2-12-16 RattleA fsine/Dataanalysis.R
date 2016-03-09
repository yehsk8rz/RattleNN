library(lme4)
library(lmerTest)
library(ggplot2)

setwd('/Users/Bubba/Desktop/COGS195/Github/RattleNN/RattleResults')
rattledata = read.csv('300data.csv')
colnames(rattledata) = c("run","yoked","sec","RMS","f")
rattledata$yoked[rattledata$yoked==0] = "RMS-reinforced"
rattledata$yoked[rattledata$yoked==1] = "yoked control"

rattlelm = lmer(scale(RMS) ~ (1|run) + yoked + scale(sec) + yoked*scale(sec), data = rattledata)
summary(rattlelm)

qplot(sec,RMS,data=rattledata,main= "300s, 5 runs, Rattle A fsine 2-12-16", geom=c("smooth"),method ="lm",formula=y~x,color=yoked)
quartz.save("2-12_300s_RAS1_rattleresults.pdf",type="pdf")

plot(rattledata$f,rattledata$RMS, main= "300s, 5 runs, Rattle A fsine 2-12-16", xlab="f",ylab="RMS")
quartz.save("2-12_300s_RAS1_RMSvsf.pdf",type="pdf")




setwd('/Users/Bubba/Desktop/COGS195/Github/RattleNN/RattleResults')
rattledata = read.csv('600data.csv')
colnames(rattledata) = c("run","yoked","sec","RMS","f")
rattledata$yoked[rattledata$yoked==0] = "RMS-reinforced"
rattledata$yoked[rattledata$yoked==1] = "yoked control"

rattlelm = lmer(scale(RMS) ~ (1|run) + yoked + scale(sec) + yoked*scale(sec), data = rattledata)
summary(rattlelm)

qplot(sec,RMS,data=rattledata,main= "600s, 5 runs, Rattle A fsine 2-12-16", geom=c("smooth"),method ="lm",formula=y~x,color=yoked)
quartz.save("2-12_600s_RAS1_rattleresults.pdf",type="pdf")

plot(rattledata$f,rattledata$RMS, main= "600s, 5 runs, Rattle A fsine 2-12-16", xlab="f",ylab="RMS")
quartz.save("2-12_600s_RAS1_RMSvsf.pdf",type="pdf")



setwd('/Users/Bubba/Desktop/COGS195/Github/RattleNN/RattleResults')
rattledata = read.csv('900data.csv')
colnames(rattledata) = c("run","yoked","sec","RMS","f")
rattledata$yoked[rattledata$yoked==0] = "RMS-reinforced"
rattledata$yoked[rattledata$yoked==1] = "yoked control"

rattlelm = lmer(scale(RMS) ~ (1|run) + yoked + scale(sec) + yoked*scale(sec), data = rattledata)
summary(rattlelm)

qplot(sec,RMS,data=rattledata,main= "900s, 5 runs, Rattle A fsine 2-12-16", geom=c("smooth"),method ="lm",formula=y~x,color=yoked)
quartz.save("2-12_900s_RAS1_rattleresults.pdf",type="pdf")

plot(rattledata$f,rattledata$RMS, main= "900s, 5 runs, Rattle A fsine 2-12-16", xlab="f",ylab="RMS")
quartz.save("2-12_900s_RAS1_RMSvsf.pdf",type="pdf")



setwd('/Users/Bubba/Desktop/COGS195/Github/RattleNN/RattleResults')
rattledata = read.csv('1200data.csv')
colnames(rattledata) = c("run","yoked","sec","RMS","f")
rattledata$yoked[rattledata$yoked==0] = "RMS-reinforced"
rattledata$yoked[rattledata$yoked==1] = "yoked control"

rattlelm = lmer(scale(RMS) ~ (1|run) + yoked + scale(sec) + yoked*scale(sec), data = rattledata)
summary(rattlelm)

qplot(sec,RMS,data=rattledata,main= "1200s, 5 runs, Rattle A fsine 2-12-16", geom=c("smooth"),method ="lm",formula=y~x,color=yoked)
quartz.save("2-12_1200s_RAS1_rattleresults.pdf",type="pdf")

plot(rattledata$f,rattledata$RMS, main= "1200s, 5 runs, Rattle A fsine 2-12-16", xlab="f",ylab="RMS")
quartz.save("2-12_1200s_RAS1_RMSvsf.pdf",type="pdf")




setwd('/Users/Bubba/Desktop/COGS195/Github/RattleNN/RattleResults')
rattledata = read.csv('1500data.csv')
colnames(rattledata) = c("run","yoked","sec","RMS","f")
rattledata$yoked[rattledata$yoked==0] = "RMS-reinforced"
rattledata$yoked[rattledata$yoked==1] = "yoked control"

rattlelm = lmer(scale(RMS) ~ (1|run) + yoked + scale(sec) + yoked*scale(sec), data = rattledata)
summary(rattlelm)

qplot(sec,RMS,data=rattledata,main= "1500s, 5 runs, Rattle A fsine 2-12-16", geom=c("smooth"),method ="lm",formula=y~x,color=yoked)
quartz.save("2-12_1500s_RAS1_rattleresults.pdf",type="pdf")

plot(rattledata$f,rattledata$RMS, main= "1500s, 5 runs, Rattle A fsine 2-12-16", xlab="f",ylab="RMS")
quartz.save("2-12_1500s_RAS1_RMSvsf.pdf",type="pdf")