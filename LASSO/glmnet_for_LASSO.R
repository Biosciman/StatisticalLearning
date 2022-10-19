library(glmnet)
# https://www.cnblogs.com/xiaojikuaipao/p/7126076.html
filename= 'diabetes.csv'
ProbSet <- read.csv(file=filename, header=T)

x = as.matrix(ProbSet[,c(1:8)])
y = as.double(ProbSet$Outcome)


# Gaussian family : for continuous decimal data with normal distribution, like weight, length, et al.
# Poisson or quasipoisson family: for positive integer or small natural number like count, individual number, frequency.
# Binomial or quasibinomial family: binary data like 0 and 1, or proportion like survival number vs death number, positive frequency vs negative frequency, winning times vs the number of failtures, et al
# Gamma family : usually describe time data like the time or duration of the occurrence of the event.

fit = glmnet(x, y,family = 'gaussian',nlambda = 1000,alpha = 1)
print(fit)
plot(fit,xvar = 'lambda')

# Binomial family时，type.measure='auc'
# Gaussian family时，type.measure='mse' 'deviance' 'mae'
# Mean Square Error (MSE) 是回归任务中最通用的损失函数，MSE是目标值与预测值之间差值平方和的均值
# Mean Absolute Error (MAE) 是目标值与预测值绝对差之和的均值，MAE不考虑误差方向
# MSE损失在错分样本的损失随目标函数值以平方级变化，而MAE损失以线性级变化，对异常值敏感度低。
# 另一个角度是，MSE最优解位于均值处，MAE最优解位于中位数处，显然中位数解比均值解对异常值的鲁棒性更强。
# https://blog.csdn.net/sinat_34072381/article/details/105937799
lasso_fit <- cv.glmnet(x,y,family='gaussian',alpha=1,type.measure='mae',nlambda=1000)
print(lasso_fit)
plot(lasso_fit)

# lambda.min拟合最好
# lambda.1se模型最简单
lasso_best <- glmnet(x=x,y=y,alpha=1,lambda=lasso_fit$lambda.1se)
coef(lasso_best)
a <- as.matrix(coef(lasso_best))
write.csv(a, file='lambda.1se_export.csv')
