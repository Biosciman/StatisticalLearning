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

binom.test(c(682, 243), p = 3/4)
binom.test(682, 682 + 243, p = 3/4)   # The same.

binom.test(c(682, 682), p = 3/4)   # 即0.5的概率与0.75相比是否有差异


"""
dbinom
The function dbinom returns the value of the probability density function (pdf) of the binomial distribution.
the binomial distribution is given a certain random variable x, number of trials (size) and probability of success on each trial (prob).
dbinom(x, size, prob) 
Put simply, dbinom finds the probability of getting a certain number of successes (x) in a certain number of trials (size) where the probability of success on each trial is fixed (prob).
"""
# Example 1
# Bob makes 60% of his free-throw attempts. 
# If he shoots 12 free throws, what is the probability that he makes exactly 10?

#find the probability of 10 successes during 12 trials where the probability of
#success on each trial is 0.6
dbinom(x=10, size=12, prob=.6)

# Example 2
# Sasha flips a fair coin 20 times. 
# What is the probability that the coin lands on heads exactly 7 times?

#find the probability of 7 successes during 20 trials where the probability of
#success on each trial is 0.5
dbinom(x=7, size=20, prob=.5)


"""
pbinom
The function pbinom returns the value of the cumulative density function (cdf) of the binomial distribution 
the binomial distribution is given a certain random variable q, number of trials (size) and probability of success on each trial (prob).
pbinom(q, size, prob)
Put simply, pbinom returns the area to the left of a given value q in the binomial distribution. 
If you’re interested in the area to the right of a given value q, you can simply add the argument lower.tail = FALSE
pbinom(q, size, prob, lower.tail = FALSE) 
"""

# Example 1
# Ando flips a fair coin 5 times. What is the probability that the coin lands on heads more than 2 times?

#find the probability of more than 2 successes during 5 trials where the
#probability of success on each trial is 0.5
pbinom(2, size=5, prob=.5, lower.tail=FALSE)

# Example 2
# Suppose Tyler scores a strike on 30% of his attempts when he bowls. If he bowls 10 times, what is the probability that he scores 4 or fewer strikes?

#find the probability of 4 or fewer successes during 10 trials where the
#probability of success on each trial is 0.3
pbinom(4, size=10, prob=.3)

"""
qbinom
The function qbinom returns the value of the inverse cumulative density function (cdf) of the binomial distribution 
the binomial distribution is given a certain random variable q, number of trials (size) and probability of success on each trial (prob).
qbinom(q, size, prob) 
Put simply, you can use qbinom to find out the quantile of the binomial distribution.
"""

#find the 10th quantile of a binomial distribution with 10 trials and prob
#of success on each trial = 0.4
qbinom(.10, size=10, prob=.4)

#find the 40th quantile of a binomial distribution with 30 trials and prob
#of success on each trial = 0.25
qbinom(.40, size=30, prob=.25)


"""
rbinom
The function rbinom generates a vector of binomial distributed random variables
binomial distributed random variables are given a vector length n, number of trials (size) and probability of success on each trial (prob).
rbinom(n, size, prob)
"""

#generate a vector that shows the number of successes of 10 binomial experiments with
#100 trials where the probability of success on each trial is 0.3.
results <- rbinom(10, size=100, prob=.3)
results

#find mean number of successes in the 10 experiments (compared to expected
#mean of 30)
mean(results)

#generate a vector that shows the number of successes of 1000 binomial experiments
#with 100 trials where the probability of success on each trial is 0.3.
results <- rbinom(1000, size=100, prob=.3)

#find mean number of successes in the 100 experiments (compared to expected
#mean of 30)
mean(results)







