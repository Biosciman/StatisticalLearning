import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score
from sklearn.metrics import precision_score
from sklearn.metrics import recall_score
from sklearn.metrics import classification_report
from sklearn.metrics import confusion_matrix
from sklearn.metrics import roc_curve
from sklearn.metrics import roc_auc_score
from sklearn import metrics
from sklearn.metrics import mean_squared_error
from sklearn.linear_model import Lasso,LassoCV
import warnings
warnings.filterwarnings(action='ignore')

# 切分数据集
df = pd.read_csv("./diabetes.csv")
target = df.pop("Outcome")

data = df.values
X = data
Y = target
X_train, X_test, Y_train, Y_test = train_test_split(X, Y, test_size = 0.2)

# 10的-5到10的2次方
Lambdas = np.logspace(-5, 2, 200)
# 构造空列表，用于存储模型的偏回归系数
lasso_cofficients = []
for Lambda in Lambdas:
    lasso = Lasso(alpha=Lambda, normalize=True, max_iter=10000)
    lasso.fit(X_train, Y_train)
    lasso_cofficients.append(lasso.coef_)

# # 绘制Lambda与回归系数的关系
# plt.plot(Lambdas, lasso_cofficients)
# # 对x轴作对数变换
# plt.xscale('log')
# # 设置折线图x轴和y轴标签
# plt.xlabel('Lambda')
# plt.ylabel('Cofficients')
# # 显示图形
# plt.show()

# LASSO回归模型的交叉验证
lasso_cv = LassoCV(alphas=Lambdas, normalize=True, cv=10, max_iter=10000)
lasso_cv.fit(X_train, Y_train)
# 输出最佳的lambda值
lasso_best_alpha = lasso_cv.alpha_
print(lasso_best_alpha)


# 基于最佳的lambda值建模
lasso = Lasso(alpha=lasso_best_alpha, normalize=True, max_iter=10000)
lasso.fit(X_train, Y_train)

# 返回LASSO回归的系数
dic = {'特征': df.columns, '系数': lasso.coef_}
df = pd.DataFrame(dic)
df1 = df[df['系数'] != 0]
print(df1)
# coef = pd.Series(lasso.coef_, index=df.columns)
# imp_coef = pd.concat([coef.sort_values().head(10), coef.sort_values().tail(10)])
# sns.set(font_scale=1.2)
# # plt.rc('font', family='Times New Roman')
# plt.rc('font', family='simsun')
# imp_coef.plot(kind="barh")
# plt.title("Lasso回归模型")
# plt.show()

# 预测测试集
# lasso_predict = lasso.predict(test_dataset)
lasso_predict = np.round(lasso.predict(X_test))
print(sum(lasso_predict == Y_test))
print(metrics.classification_report(Y_test, lasso_predict))
print(metrics.confusion_matrix(Y_test, lasso_predict))
RMSE = np.sqrt(mean_squared_error(Y_test, lasso_predict))
print(RMSE)
print(lasso_predict)
print(Y_test)

