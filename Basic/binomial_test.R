'''
在处理实际问题时，有些数据的取值只能划分为两类，比如医学中的生与死、患病的有与无。
从这种二分类总体中抽取的样本，要么是对立分类中的这一类，要么是另一类，其频数分布服从二项分布。
二项式检验（Binomial test），就是一种用来检验样本是否来自参数为（n，p）的二项分布总体的方法。
其中n为样本量，p为比例。

d = density：密度函数；
p = distribution function：分布函数；
q = quantile function：分位数函数；
r = random generation (random deviates)：使用对应概率分布生成随机值函数；

norm()为正态分布
包括：dnorm, pnorm, qnorm & rnorm
dnorm():输入的是x轴上的数值，输出的是该点的概率密度
pnorm():输入的是x的z-score,输出的是面积，不带参数输出的是该点左边的面积，如果后面带lower.tail=F的参数，输出的是该点右边的面积。因为Lowertial表示的是左边，uppertail表示的是右边
qnorm():输入的是分位数，区间为0—1，输出的是z-score
rnorm():输入的是数值的个数，并且进行将这几个数值进行正态分布。

z分数（z-score），也叫标准分数（standard score）是一个数与平均数的差再除以标准差的过程。 

dbinom(x, size, prob, log = FALSE)
pbinom(x, size, prob, lower.tail = TRUE, log.p = FALSE)
qbinom(p, size, prob, lower.tail = TRUE, log.p = FALSE) 该函数采用概率值，并给出累积值与概率值匹配的数字。
rbinom(n, size, prob)

x是数字的向量
p是概率的向量
n是观察次数
size是试验次数
prob是每次试验成功的概率

'''

# Probability of getting 26 or less heads from a 100 tosses of a coin.
x <- pbinom(42,100,0.5)
x

# 与pbinom互补
# How many heads will have a probability of 0.05 will come out when a coin is tossed 100 times.
# 即0.05的概率出现多少次硬币头朝上
x <- qbinom(0.05,100,0.15)
x

