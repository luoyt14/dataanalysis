# setwd("~/Downloads/课程/博士/大数据分析B/作业/hw1/code")
library(readxl)
data <-  read_excel('data.xlsx')

sexratio = data[[6]]
yeliaoratio = data[[13]]
photoratio = data[[14]]

# draw the epdf of the origin data
png(file="../report/images/41.png", bg="transparent")
layout(matrix(c(1,2,3), 1,3,byrow = TRUE))
hist(sexratio,freq=FALSE,col='blue',breaks=100,xlab='sexratio',ylab='PDF')
hist(yeliaoratio,freq=FALSE,col='blue',breaks=100,xlab='yeliaoratio',ylab='PDF')
hist(photoratio,freq=FALSE,col='blue',breaks=100,xlab='photoratio',ylab='PDF')
dev.off()

# draw the pdf of the log transformation of data
png(file="../report/images/42.png", bg="transparent")
layout(matrix(c(1,2,3), 3,1,byrow = TRUE))
hist(log(sexratio),freq=FALSE,col='blue',breaks=300,xlab='sexratio',ylab='PDF')
hist(log(yeliaoratio),freq=FALSE,col='blue',breaks=300,xlab='yeliaoratio',ylab='PDF')
hist(log(photoratio),freq=FALSE,col='blue',breaks=300,xlab='photoratio',ylab='PDF')
dev.off()

# Normality test
library(nortest)
ad.test(sexratio)
ad.test(yeliaoratio)
ad.test(photoratio)
ad.test(log(sexratio+1e-16))
ad.test(log(yeliaoratio+1e-16))
ad.test(log(photoratio+1e-16))

# homogeneity of variances test
bartlett.test(性别比 ~ 群类别, data)
bartlett.test(夜聊比例 ~ 群类别, data)
bartlett.test(图片比例 ~ 群类别, data)
bartlett.test(log(性别比+1e-16) ~ 群类别, data)
bartlett.test(log(夜聊比例+1e-16) ~ 群类别, data)
bartlett.test(log(图片比例+1e-16) ~ 群类别, data)
