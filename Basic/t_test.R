'''
dt(x, df, ncp, log = FALSE)
pt(q, df, ncp, lower.tail = TRUE, log.p = FALSE)
qt(p, df, ncp, lower.tail = TRUE, log.p = FALSE)
rt(n, df, ncp)

dt gives the density
pt gives the distribution function
qt gives the quantile function
rt generates random deviates

x, q为分位数的向量
df为自由度

qt(1-α/2,k-1)
'''

# Find the 95th percentile of the Student's t distribution with 50 degrees of freedom.
x <- qt(0.95, 50)
x
