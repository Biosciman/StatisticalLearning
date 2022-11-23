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

t.test(1:10, y = c(7:20), conf.level = 0.95)      # P = .00001855
t.test(1:10, y = c(7:20, 200), conf.level = 0.95) # P = .1245    -- NOT significant anymore
