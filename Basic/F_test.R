"""
F检验（F-test），最常用的别名叫做联合假设检验（joint hypotheses test），此外也称方差比率检验、方差齐性检验 。
它是一种在零假设（null hypothesis, H0）之下，统计值服从 F-分布 的检验。
F检验:检验两个正态随机变量的总体方差是否相等的一种假设检验方法。

An F-test is used to test whether two population variances are equal. 
The null and alternative hypotheses for the test are as follows:
H0: the population variances are equal
H1: the population variances are not equal

Method 1: var.test(x, y, alternative = “two.sided”)
Method 2: var.test(values ~ groups, data, alternative = “two.sided”)

应用：
方差齐性检验（F-test of equality of variances）
方差分析（Analysis of Variance, ANOVA）
线性回归方程整体的显著性检验

方差齐性是方差分析和一些均数比较检验的重要前提，利用F检验进行方差齐性检验是最原始的，但对数据要求比较高。

df(x, df1, df2, ncp, log = FALSE)
pf(q, df1, df2, ncp, lower.tail = TRUE, log.p = FALSE)
qf(p, df1, df2, ncp, lower.tail = TRUE, log.p = FALSE)
rf(n, df1, df2, ncp)

qf(1-α,k-1,(k-1)*(N-1))
两个自由度：
K： 有多少组数据
N： 所以有组数据加起来，有多少样本（总样本数）

F检验的前提：数据满足正态分布，使用Shapiro-Will进行正态分布检验

"""
qf(0.95,3,3*10)

x <- rnorm(50, mean = 0, sd = 5)
shapiro.test(x) # 正态分布检验:结果显示p-value大于显著性水平0.05，所以不能拒绝零假设：样本来自正态分布。
x
y <- rnorm(30, mean = 0, sd = 1)
shapiro.test(y) # 正态分布检验:结果显示p-value大于显著性水平0.05，所以不能拒绝零假设：样本来自正态分布。
y
var.test(x, y)

# Method 1: F-Test in R
#define the two groups
x <- c(18, 19, 22, 25, 27, 28, 41, 45, 51, 55)
y <- c(14, 15, 15, 17, 18, 22, 25, 25, 27, 34)

#perform an F-test to determine in the variances are equal
var.test(x, y)

# The F test statistic is 4.3871 
# the corresponding p-value is 0.03825. 
# Since this p-value is less than .05, we would reject the null hypothesis.
# This means we have sufficient evidence to say that the two population variances are not equal.

# Method 2: F-Test in R
#define the two groups
data <- data.frame(values=c(18, 19, 22, 25, 27, 28, 41, 45, 51, 55,
                            14, 15, 15, 17, 18, 22, 25, 25, 27, 34),
                   group=rep(c('A', 'B'), each=10))

#perform an F-test to determine in the variances are equal
var.test(values~group, data=data)


