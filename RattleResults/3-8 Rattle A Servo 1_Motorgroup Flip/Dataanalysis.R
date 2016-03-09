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

qplot(sec,RMS,data=rattledata,main= "100s, 5 runs, Rattle A fsine 3-8-16", geom=c("smooth"),method ="lm",formula=y~x,color=yoked)
quartz.save("3-8_100s_RAS1_MotFlip_rattleresults.pdf",type="pdf")

plot(rattledata$f,rattledata$RMS, main= "100s, 5 runs, Rattle A fsine 3-8-16", xlab="f",ylab="RMS")
quartz.save("3-8_100s_RAS1_MotFlip_RMSvsf.pdf",type="pdf")




setwd('/Users/Bubba/Desktop/COGS195/Github/RattleNN/RattleResults')
rattledata = read.csv('600data.csv')
colnames(rattledata) = c("run","yoked","sec","RMS","f")
rattledata$yoked[rattledata$yoked==0] = "RMS-reinforced"
rattledata$yoked[rattledata$yoked==1] = "yoked control"

rattlelm = lmer(scale(RMS) ~ (1|run) + yoked + scale(sec) + yoked*scale(sec), data = rattledata)
summary(rattlelm)

qplot(sec,RMS,data=rattledata,main= "600s, 5 runs, Rattle A fsine 3-8-16", geom=c("smooth"),method ="lm",formula=y~x,color=yoked)
quartz.save("3-8_600s_RAS1_MotFlip_rattleresults.pdf",type="pdf")

plot(rattledata$f,rattledata$RMS, main= "600s, 5 runs, Rattle A fsine 3-8-16", xlab="f",ylab="RMS")
quartz.save("3-8_600s_RAS1_MotFlip_RMSvsf.pdf",type="pdf")



setwd('/Users/Bubba/Desktop/COGS195/Github/RattleNN/RattleResults')
rattledata = read.csv('300data.csv')
colnames(rattledata) = c("run","yoked","sec","RMS","f")
rattledata$yoked[rattledata$yoked==0] = "RMS-reinforced"
rattledata$yoked[rattledata$yoked==1] = "yoked control"

rattlelm = lmer(scale(RMS) ~ (1|run) + yoked + scale(sec) + yoked*scale(sec), data = rattledata)
summary(rattlelm)

qplot(sec,RMS,data=rattledata,main= "300s, 5 runs, Rattle A fsine 3-8-16", geom=c("smooth"),method ="lm",formula=y~x,color=yoked)
quartz.save("3-8_300s_RAS1_MotFlip_rattleresults.pdf",type="pdf")

plot(rattledata$f,rattledata$RMS, main= "900s, 5 runs, Rattle A fsine 3-8-16", xlab="f",ylab="RMS")
quartz.save("3-8_300s_RAS1_MotFlip_RMSvsf.pdf",type="pdf")



setwd('/Users/Bubba/Desktop/COGS195/Github/RattleNN/RattleResults')
rattledata = read.csv('500data.csv')
colnames(rattledata) = c("run","yoked","sec","RMS","f")
rattledata$yoked[rattledata$yoked==0] = "RMS-reinforced"
rattledata$yoked[rattledata$yoked==1] = "yoked control"

rattlelm = lmer(scale(RMS) ~ (1|run) + yoked + scale(sec) + yoked*scale(sec), data = rattledata)
summary(rattlelm)

qplot(sec,RMS,data=rattledata,main= "500s, 5 runs, Rattle A fsine 3-8-16", geom=c("smooth"),method ="lm",formula=y~x,color=yoked)
quartz.save("3-8_500s_RAS1_MotFlip_rattleresults.pdf",type="pdf")

plot(rattledata$f,rattledata$RMS, main= "500s, 5 runs, Rattle A fsine 3-8-16", xlab="f",ylab="RMS")
quartz.save("3-8_500s_RAS1_MotFlip_RMSvsf.pdf",type="pdf")




setwd('/Users/Bubba/Desktop/COGS195/Github/RattleNN/RattleResults')
rattledata = read.csv('700data.csv')
colnames(rattledata) = c("run","yoked","sec","RMS","f")
rattledata$yoked[rattledata$yoked==0] = "RMS-reinforced"
rattledata$yoked[rattledata$yoked==1] = "yoked control"

rattlelm = lmer(scale(RMS) ~ (1|run) + yoked + scale(sec) + yoked*scale(sec), data = rattledata)
summary(rattlelm)

qplot(sec,RMS,data=rattledata,main= "700s, 5 runs, Rattle A fsine 3-8-16", geom=c("smooth"),method ="lm",formula=y~x,color=yoked)
quartz.save("3-8_700s_RAS1_MotFlip_rattleresults.pdf",type="pdf")

plot(rattledata$f,rattledata$RMS, main= "700s, 5 runs, Rattle A fsine 3-8-16", xlab="f",ylab="RMS")
quartz.save("3-8_700s_RAS1_MotFlip_RMSvsf.pdf",type="pdf")



setwd('/Users/Bubba/Desktop/COGS195/Github/RattleNN/RattleResults')
rattledata = read.csv('300-400data.csv')
colnames(rattledata) = c("run","yoked","sec","RMS","f")
rattledata$yoked[rattledata$yoked==0] = "RMS-reinforced"
rattledata$yoked[rattledata$yoked==1] = "yoked control"

rattlelm = lmer(scale(RMS) ~ (1|run) + yoked + scale(sec) + yoked*scale(sec), data = rattledata)
summary(rattlelm)

qplot(sec,RMS,data=rattledata,main= "300-400s, 5 runs, Rattle A fsine 3-8-16", geom=c("smooth"),method ="lm",formula=y~x,color=yoked)
quartz.save("3-8_300-400s_RAS1_MotFlip_rattleresults.pdf",type="pdf")

plot(rattledata$f,rattledata$RMS, main= "300-400s, 5 runs, Rattle A fsine 3-8-16", xlab="f",ylab="RMS")
quartz.save("3-8_300-400s_RAS1_MotFlip_RMSvsf.pdf",type="pdf")



setwd('/Users/Bubba/Desktop/COGS195/Github/RattleNN/RattleResults')
rattledata = read.csv('300-600data.csv')
colnames(rattledata) = c("run","yoked","sec","RMS","f")
rattledata$yoked[rattledata$yoked==0] = "RMS-reinforced"
rattledata$yoked[rattledata$yoked==1] = "yoked control"

rattlelm = lmer(scale(RMS) ~ (1|run) + yoked + scale(sec) + yoked*scale(sec), data = rattledata)
summary(rattlelm)

qplot(sec,RMS,data=rattledata,main= "300-600s, 5 runs, Rattle A fsine 3-8-16", geom=c("smooth"),method ="lm",formula=y~x,color=yoked)
quartz.save("3-8_300-600s_RAS1_MotFlip_rattleresults.pdf",type="pdf")

plot(rattledata$f,rattledata$RMS, main= "300-600s, 5 runs, Rattle A fsine 3-8-16", xlab="f",ylab="RMS")
quartz.save("3-8_300-600s_RAS1_MotFlip_RMSvsf.pdf",type="pdf")



setwd('/Users/Bubba/Desktop/COGS195/Github/RattleNN/RattleResults')
rattledata = read.csv('300-700data.csv')
colnames(rattledata) = c("run","yoked","sec","RMS","f")
rattledata$yoked[rattledata$yoked==0] = "RMS-reinforced"
rattledata$yoked[rattledata$yoked==1] = "yoked control"

rattlelm = lmer(scale(RMS) ~ (1|run) + yoked + scale(sec) + yoked*scale(sec), data = rattledata)
summary(rattlelm)

qplot(sec,RMS,data=rattledata,main= "300-700s, 5 runs, Rattle A fsine 3-8-16", geom=c("smooth"),method ="lm",formula=y~x,color=yoked)
quartz.save("3-8_300-700s_RAS1_MotFlip_rattleresults.pdf",type="pdf")

plot(rattledata$f,rattledata$RMS, main= "300-700s, 5 runs, Rattle A fsine 3-8-16", xlab="f",ylab="RMS")
quartz.save("3-8_300-700s_RAS1_MotFlip_RMSvsf.pdf",type="pdf")