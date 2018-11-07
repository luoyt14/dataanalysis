# setwd("~/Downloads/课程/博士/大数据分析B/作业/hw1/code")
library(readxl)
data <-  read_excel('data.xlsx')
age <- data[[7]]
is.numeric(age)
png(file="../report/images/3a.png", bg="transparent")
hist(age,freq=FALSE,col='cyan',breaks=50,xlim=c(10,50),xlab='age',ylab='PDF')
curve(dnorm(x,mean(age),sd(age)),xlim=c(10,50),col="red",lwd=3,add=TRUE)
legend("topright",c("EPDF","Normal Distribution"),fill=c("cyan","red"))
dev.off()

library(nortest)
age_norm = scale(age)
ad.test(age_norm)
