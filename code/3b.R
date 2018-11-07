# setwd("~/Downloads/课程/博士/大数据分析B/作业/hw1/code")
library(readxl)
library(nortest)
library(car)
data <-  read_excel('data.xlsx')
age <- data[[7]]
age1 <- subset(data, data[,2]==1)[[7]]
age1_norm = scale(age1)
ad.test(age1_norm)
age2 <- subset(data, data[,2]==2)[[7]]
shapiro.test(age2)
age2_norm = scale(age2)
ad.test(age2_norm)
age3 <- subset(data, data[,2]==3)[[7]]
age3_norm = scale(age3)
ad.test(age3_norm)
age4 <- subset(data, data[,2]==4)[[7]]
age4_norm = scale(age4)
ad.test(age4_norm)
age5 <- subset(data, data[,2]==5)[[7]]
age5_norm = scale(age5)
ad.test(age5_norm)

hist(age1,freq=FALSE,col='cyan',breaks=50,xlab='age',ylab='PDF',xlim=c(10,50))
curve(dnorm(x,mean(age1),sd(age1)),col="red",lwd=3,add=TRUE,xlim=c(10,50))

aggregate(data$平均年龄,by=list(data$群类别),FUN=mean)
aggregate(data$平均年龄,by=list(data$群类别),FUN=sd)
bartlett.test(平均年龄 ~ 群类别, data)
