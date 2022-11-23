'''
主成分分析（Principal Component Analysis，PCA）
通过将原始变量转换为原始变量的线性组合（主成分），在保留主要信息的基础上，达到简化和降维的目的。
目的：把不同变量聚类

主成分与原始变量之间的关系：
1.主成分是原始变量的线性组合
2.主成分的数量相对于原始数量更少
3.主成分保留了原始变量的大部分信息
4.主成分之间相互独立

主成分分析是把p个随机变量的方差分解为p个不相关的随机变量的方差和，
使得第一个主成分的方差达到最大，
其贡献率等于其方差在全部主成分方差中的占比。

主成分分析的一个关键问题是：主成分的个数选多少个比较合适？
有3个主要的衡量标准：
1.保留的主成分使得方差贡献率达到80%以上
2.保留的主成分的方差（特征值）大于1
3.Cattell碎石检验绘制了关于各主成分及其特征值的图形，我们只需要保留图形中变化最大之处以上的主成分即可

主成分分析优点：
1.不要求数据呈正态分布，主成分就是按数据离散程度最大的方向对基组进行旋转，这特性扩展了其应用范围，比如，用于人脸识别
2.通过对原始变量进行综合与简化，可以客观地确定各个指标的权重，避免主观判断的随意性
主成分分析缺点：
1.主成分分析适用于变量间有较强相关性的数据，若原始数据相关性弱，则起不到很好的降维作用
2.降维后，存在少量信息丢失，不可能包含100%原始数据
3.原始数据经过标准化处理之后，含义会发生变化，且主成分的解释含义较原始数据比较模糊
4.假设标准化后的原始变量间存在多重共线性，即原始变量之间存在不可忽视的信息重叠，主成分分析不能有效剔除信息重叠

主成分分析步骤：
1.分析前，先进行相关性检验，变量之间存在较强相关性，才能使用主成分分析方法。
2.选取初始变量
3.根据初始变量特性选择使用协方差矩阵还是相关矩阵来求主成分
4.计算协方差矩阵或相关矩阵的特征值和特征向量
5.确定主成分个数

参考
https://zhuanlan.zhihu.com/p/37755749
https://zhuanlan.zhihu.com/p/354086571
'''

### 手动PCA分析
# 1.数据标准化
# 为了统一数据的量纲并对数据进行中心化，在主成分分析之前往往需要对原始数据进行标准化。
# 将R自带的范例数据集iris储存为变量data;
data<-iris
head(data)
# 对原数据进行z-score归一化
# Z-score归一化（变量的均值为0，标准差为1）
dt<-as.matrix(scale(data[,1:4]))
head(dt)

# 2.计算相关系数（协方差）矩阵
# 既然主成分分析主要是选取解释变量方差最大的主成分，故先需要计算变量两两之间协方差
# 根据协方差与方差的关系，位于协方差矩阵对角线上的数值即为相应变量的方差。
# 由于对数据进行了Z-score归一化（变量的均值为0，标准差为1）
# 因此，根据相关系数的计算公式可知，此时相关系数其实等于协方差。
# 计算相关系数矩阵；
# cor () 用于测量两个向量之间的相关系数值
rm1<-cor(dt)
rm1

# 3.求解特征值和相应的特征向量
# eigen () 用于计算矩阵的特征值和特征向量
# 满足Ax=λx。A为矩阵，x为特征向量，λ为特征值
rs1<-eigen(rm1)
rs1

# 提取结果中的特征值，即各主成分的方差；
val <- rs1$values
# 换算成标准差(Standard deviation);
Standard_deviation <- sqrt(val)
# 计算方差贡献率和累积贡献率；
Proportion_of_Variance <- val/sum(val)
Proportion_of_Variance
# cumsum () 用于计算作为参数传递的向量的累积和
Cumulative_Proportion <- cumsum(Proportion_of_Variance)
Cumulative_Proportion


# 碎石图绘制;
# 方法1
par(mar=c(6,6,2,2))
plot(rs1$values,type="b",
     cex=2,
     cex.lab=2,
     cex.axis=2,
     lty=2,
     lwd=2,
     xlab = "Number of principal component",
     ylab="Eigenvalue (principal component variance)")
dev.off()
# 方法2
library(psych)
fa.parallel(dt,fa='pc')
abline(h=1) # 与y=1相交的即为主成分个数
dev.off()

# 4.计算主成分得分
# 方法1
# 提取结果中的特征向量(也称为Loadings,载荷矩阵)；
U<-as.matrix(rs1$vectors)
U
#进行矩阵乘法，获得PC score；
PC <-dt %*% U
colnames(PC) <- c("PC1","PC2","PC3","PC4")
head(PC)
# 方法2
library(psych)
fit <- principal(df[,1:4],
                 nfactors=2,
                 rotate='varimax', # 方差最大旋转
                 scores=T)
fit
# 绘制主成分分析的载荷矩阵，查看各个主成分的综合构成变量
fa.diagram(fit,digits=2)
dev.off()

# 5.绘制主成分散点图
#将iris数据集的第5列数据合并进来；
df<-data.frame(PC,iris$Species)
head(df)

#载入ggplot2包；
library(ggplot2)
#提取主成分的方差贡献率，生成坐标轴标题；
xlab<-paste0("PC1(",round(Proportion_of_Variance[1]*100,2),"%)")
ylab<-paste0("PC2(",round(Proportion_of_Variance[2]*100,2),"%)")
#绘制散点图并添加置信椭圆；
p1<-ggplot(data = df,aes(x=PC1,y=PC2,color=iris.Species))+
  stat_ellipse(aes(fill=iris.Species),
               type ="norm", geom ="polygon",alpha=0.2,color=NA)+
  geom_point()+labs(x=xlab,y=ylab,color="")+
  guides(fill=F)
p1
dev.off()

#载入scatterplot3d包；
library(scatterplot3d)
color = c(rep('purple',50),rep('orange',50),rep('blue',50))
scatterplot3d(df[,1:3],color=color,
              pch = 16,angle=30,
              box=T,type="p",
              lty.hide=2,lty.grid = 2)
legend(x=-3,y=4.4,cex=.5,c('Setosa','Versicolor','Virginica'),
       fill=c('purple','orange','blue'),box.col=NA)
dev.off()


### 使用prcomp()和princomp()进行PCA分析，一步到位
# 1.prcomp()函数
# scale. = TRUE表示分析前对数据进行归一化；
com1 <- prcomp(data[,1:4], center = TRUE,scale. = TRUE)
summary(com1)

# 2.princomp()函数
# 如果使用princomp()函数，需要先做归一化，princomp()函数并无数据标准化相关的参数。
# 且默认使用covariance matrix，得到的结果与使用相关性矩阵有细微差异
# princomp()函数只适用于行数大于列数的矩阵，否则会报错
com2 <- princomp(dt,cor = T)
summary(com2)
com3 <- princomp(dt)
summary(com3)

# 3.PCA结果可视化
#提取PC score；
df1<-com1$x
head(df1)
#将iris数据集的第5列数据合并进来；
df1<-data.frame(df1,iris$Species)
head(df1)

#提取主成分的方差贡献率，生成坐标轴标题；
summ<-summary(com1)
xlab<-paste0("PC1(",round(summ$importance[2,1]*100,2),"%)")
ylab<-paste0("PC2(",round(summ$importance[2,2]*100,2),"%)")
p2<-ggplot(data = df1,aes(x=PC1,y=PC2,color=iris.Species))+
  stat_ellipse(aes(fill=iris.Species),
               type = "norm", geom ="polygon",alpha=0.2,color=NA)+
  geom_point()+labs(x=xlab,y=ylab,color="")+
  guides(fill=F)
p2+scale_fill_manual(values = c("purple","orange","blue"))+
  scale_colour_manual(values = c("purple","orange","blue"))
dev.off()



