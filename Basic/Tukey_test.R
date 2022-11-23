"""
图基检验
Tukey检验的一个重要的优点是非常简单，而且所需实验样本相对较少。
Tukey test is a post hoc test

A one-way ANOVA is used to determine whether or not there is a statistically significant difference between the means of three or more independent groups.
In order to find out exactly which groups are different from each other, we must conduct a post hoc test.
参考资料：https://www.statology.org/tukey-test-r/

ptukey(q, nmeans, df, nranges = 1, lower.tail = TRUE, log.p = FALSE)
qtukey(p, nmeans, df, nranges = 1, lower.tail = TRUE, log.p = FALSE)

qtukey(1-α,k,Inf)/sqrt(2)

"""

# Step 1: Fit the ANOVA Model.
#make this example reproducible
set.seed(0)

# create data
# runif ()函数用于生成从0到1区间范围内的服从正态分布的随机数
data <- data.frame(group = rep(c("A", "B", "C"), each = 30),
                   values = c(runif(30, 0, 3),
                              runif(30, 0, 5),
                              runif(30, 1, 7)))

# view first six rows of data
head(data)

# fit one-way ANOVA model
model <- aov(values~group, data=data)

# view the model output
summary(model)


# Step 2: Perform Tukey’s Test.
# perform Tukey's Test
TukeyHSD(model, conf.level=.95) 

# Step 3: Visualize the results.
# plot confidence intervals
plot(TukeyHSD(model, conf.level=.95), las = 2)
'''
The mean values of group C are significantly higher than the mean values of both group A and B.
The mean values of group B are significantly higher than the mean values of group A.
'''

