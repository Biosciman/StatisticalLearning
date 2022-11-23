'''
若n个相互独立的随机变量ξ₁，ξ₂，...,ξn ，均服从标准正态分布（也称独立同分布于标准正态分布）
则这n个服从标准正态分布的随机变量的平方和构成一新的随机变量，其分布规律称为卡方分布（chi-square distribution）。

dchisq(x, df, ncp = 0, log = FALSE)
pchisq(q, df, ncp = 0, lower.tail = TRUE, log.p = FALSE)
qchisq(p, df, ncp = 0, lower.tail = TRUE, log.p = FALSE)
rchisq(n, df, ncp = 0)


'''

####卡方(chisq)分布
# 1.卡方分布中抽样函数rchisq
n = 100 # 观察次数
df <- 10 # 自由度
rchisq(n, df, ncp = 0)

# 2.卡方分布概率密度函数
x <- seq(0,30,0.1) # x为非负整数，表达次数。
x
y <- dchisq(x,df)
y
plot(x,y)

# 3.卡方分布累积概率
x <- seq(1,20,0.1)
x
plot(x,dchisq(x,df=10))
# P[X ≤ x]
pchisq(5, df=10)
# P[X > x]
pchisq(5, df=10,lower.tail = FALSE)

# probabilities p are given as log(p).
pchisq(5, df=10,log.p = TRUE)

# 4.qchisq函数(pchisq的反函数)
# 累积概率为0.95时的x值
qchisq(0.95, df=1)
qchisq(0.95, df=10)
qchisq(0.95, df=100)


## Effect of simulating p-values
x <- matrix(c(12, 5, 7, 7), ncol = 2)
chisq.test(x)$p.value           # 0.4233
chisq.test(x, simulate.p.value = TRUE, B = 10000)$p.value # Monte Carlo test
# around 0.29!



"""
dchisq: returns the value of the Chi-Square probability density function.
pchisq: returns the value of the Chi-Square cumulative density function.
qchisq: returns the value of the Chi-Square quantile function.
rchisq: generates a vector of Chi-Square distributed random variables.
"""

"""
dchisq
We often use the dchisq() function with the curve() function to plot a Chi-Square distribution with a certain number of degrees of freedom.
"""

#plot Chi_Square distribution with 5 degrees of freedom
curve(dchisq(x, df=5), from=0, to=20)

"""
pchisq
We often use the pchisq() function to find the p-value that corresponds to a given Chi-Square test statistic.
"""

# For example, suppose we perform a Chi-Square Test of Independence and end up with a test statistic of X2 = 0.86404 with 2 degrees of freedom.
# calculate p-value for given test statistic with 2 degrees of freedom
1-pchisq(0.86404, df=2)

"""
qchisq
We often use the qchisq() function to find the Chi-Square critical value that corresponds to a given significance level and degrees of freedom.
"""
qchisq(p=.95, df=13)

"""
rchisq
We often use the rchisq() function to generate a list of n random values that follow a Chi-Square distribution with a given degrees of freedom.
"""
#make this example reproducible
set.seed(0) 

#generate 1000 random values that follow Chi-Square dist with df=5
values <- rchisq(n=1000, df=5)

#view first five values 
head(values)
hist(values)
