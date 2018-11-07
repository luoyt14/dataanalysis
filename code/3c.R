setwd("~/Downloads/课程/博士/大数据分析B/作业/hw1/code")
library(readxl)
data <- read_excel('data.xlsx')
data$群类别 = as.factor(data$群类别)

png(file="../report/images/3c3.png", bg="transparent")
boxplot(平均年龄~群类别, data,notch=TRUE, varwidth=TRUE, border=c('blue','cyan','red','green','magenta'))
dev.off()

fit = aov(平均年龄~群类别, data)
summary(fit)