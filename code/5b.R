# setwd("~/Downloads/课程/博士/大数据分析B/作业/hw1/code")
library(readxl)
data <-  read_excel('data.xlsx')
data$群类别 = as.factor(data$群类别)

category = data[[2]]
sexratio = data[[6]]
yeliaoratio = data[[13]]
photoratio = data[[14]]

png(file="../report/images/5b1.png", bg="transparent")
boxplot(性别比~群类别, data, notch=TRUE, varwidth=TRUE, 
           border=c('blue','cyan','red','green','magenta'),
           xlab='category',ylabel='sexratio')
dev.off()
# oneway.test(性别比~群类别, data, var.equal = T)
fit1 = aov(性别比~群类别, data)
summary(fit1)

png(file="../report/images/5b2.png", bg="transparent")
boxplot(夜聊比例~群类别, data, notch=TRUE, varwidth=TRUE, 
           border=c('blue','cyan','red','green','magenta'),
           xlab='category',ylabel='yeliaoratio')
dev.off()
# oneway.test(夜聊比例~群类别, data, var.equal = T)
fit2 = aov(夜聊比例~群类别, data)
summary(fit2)

png(file="../report/images/5b3.png", bg="transparent")
boxplot(图片比例~群类别, data, notch=TRUE, varwidth=TRUE, 
           border=c('blue','cyan','red','green','magenta'),
           xlab='category',ylabel='photoratio')
dev.off()
# oneway.test(图片比例~群类别, data, var.equal = T)
fit3 = aov(图片比例~群类别, data)
summary(fit3)
