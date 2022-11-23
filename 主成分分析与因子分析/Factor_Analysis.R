'''
因子分析
目的：把不同的变量聚类

因子分析步骤：
1.选择分析变量
2.计算原始变量的相关系数矩阵
3.提取公因子
3.1取方差（特征值）大于0的因子
3.2因子的累积方差贡献率达到80%
4.因子旋转
4.1因子的实际意义更容易解释
5.计算因子得分

参考
https://zhuanlan.zhihu.com/p/37755749
'''


# 1.载入数据
data<-iris

# 2.数据标准化处理、计算相关系数（协方差）矩阵、求解特征值和相应的特征向量
dt<-as.matrix(scale(data[,1:4]))
rm1<-cor(dt)
rs1<-eigen(rm1)

# 3.确定因子数量
library(psych)
fa.parallel(dt,fa='fa')
abline(h=1) # 与y=1相交的即为主成分个数
dev.off()

# 4. 因子分析

fit <- principal(dt[,1:4],
                 nfactors=2,
                 rotate='varimax', # 方差最大旋转
                 scores=T)
fit
# 绘制主成分分析的载荷矩阵，查看各个主成分的综合构成变量
fa.diagram(fit,digits=2)
dev.off()


