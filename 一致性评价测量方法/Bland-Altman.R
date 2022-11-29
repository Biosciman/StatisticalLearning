'''
Bland-Altman图是一种一致性测量的可视化展示方法。
其将测量数据相关计算后，进行散点展示出来.
如果说散点在可信区间范围内（一般是差值的1.96个标准差范围内），那么就说明数据具有较好的一致性水平。

Bland-Altman图的横坐标为两种方法的平均值，纵坐标为两种方法的差值。
比如有100个研究对象，每个对象进行两次测量，那么就会有100个平均值数据（两次测量的平均值），
对应以及100个差值数据（两种方法的测量数据差值），将此100个数据散点展示，
如果说此100个点介于“差值的95%区间即差值的1.96的标准差范围内”，此时说明具有非常好的一致性，
但具体标准是全部点都在标准内，还有绝大多数点都在标准内即说明具有一致性，这将由参考文献决定。
'''
library(BlandAltmanLeh)
library(ggplot2)

# group1 <- rnorm(105,mean=123.88,sd=60)
# group1 <- sort(group1)
# group2 <- rnorm(105,mean=135.92,sd=70)
# group2 <- sort(group2)

library(readxl)
data <- read_xlsx('test.xlsx', sheet = 1,col_names = F)
group1 <- sort(data$...1)
group2 <- sort(data$...2)

MVI <- rep(c(1,2), 63, length.out = 125) # new knowledge; "each = 63"

ba.stats <- bland.altman.stats(group1, group2)

dev.off()
par(mar=c(4,4,4,4))
plot(ba.stats$means, ba.stats$diffs, col= MVI, 
     sub=paste("critical difference is", round(ba.stats$critical.diff,4)),
     main="Bland-Altman Plot", pch=18-MVI,ylim = c(-40,15))
abline(h = ba.stats$lines, lty=c(2,3,2), col=c("lightblue","blue","lightblue"), 
       lwd=c(3,2,3))
legend(x = "topright", legend = c("Roche","Snibe"), fill = 1:2,cex=0.5) 
# Notes: MVI里赋值时不要赋0和1，因为他们代表黑和白，图片上显示不出来
