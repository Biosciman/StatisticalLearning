# -*- codeing = utf-8 -*-

# 参考https://www.jianshu.com/p/4e797f766935

import numpy as np
import torch
from matplotlib import pyplot as plt
from torch.utils.data import Dataset  # 构建数据集
from torch.utils.data import DataLoader  # 加载数据 mini-batch 以供训练

# dataset是一个抽象类,不能实例化,必须先用子类继承该抽象类
class DiabetesDataSet(Dataset):
    def __init__(self, filepath):
        # float能容纳的小数范围比较小，double能容纳的小数范围比较大。
        # float类型和float64类型在十进制中可以有16位，而float32类型在十进制中有8位
        xy = np.loadtxt(filepath, delimiter=",", skiprows=1, dtype=np.float32)  # 读取csv文件,格式为float32
        self.len = xy.shape[0]  # 读取矩阵第一维的长度
        # self.shape = xy.shape()  # 读取矩阵的形状
        # 若不写 self. 开头的话, 那么x_data就是函数内部的成员变量
        # 若写了 self. 的话,那么这个成员变量就是类中的成员变量
        self.x_data = torch.from_numpy(xy[:, :-1])  # 切片[row, column]，除了最后一列为参数，python为左包括，右不包括
        self.y_data = torch.from_numpy(xy[:, [-1]])  # 最后一列为outcome，为结果。加上[]使每个结果变为matrix

    # 通过 index 获得数据索引
    def __getitem__(self, index):
        return self.x_data[index], self.y_data[index]

    # 获取数据的长度 length
    def __len__(self):
        return self.len


# 初始化数据集
dataset = DiabetesDataSet("diabetes.csv")

# 用Pytorch提供的DataLoader来加载数据集
# dataset:数据集 batch_size:mini-batch的大小，shuffle:是否打乱数据集顺序，num_workers:读取batch时采用的多线程的线程数
train_loader = DataLoader(dataset=dataset, batch_size=64, shuffle=True, num_workers=0)  # 攻击12个batch（768/64）


# 2.构建神经网络模型(Neural Network)
# 采用全连接的神经网络，最后用sigmoid来处理output
# 需要继承nn.Module类，并实现forward方法
# 一般把网络中具有可学习参数的层放在构造函数__init__()中，如全连接层、卷积层等
# 一般把不具有可学习参数的层(如ReLU、dropout、BatchNormanation层)可放在构造函数中，也可不放在构造函数中
# 不具有可学习参数的层如果不放在构造函数__init__里面，则在forward方法里面可以使用nn.functional来代替
# forward方法是必须要重写的，它是实现模型的功能，实现各个层之间的连接关系的核心

class Model(torch.nn.Module): # 继承torch.nn.Module
    def __init__(self):  # __init__定义了4个层
        super(Model, self).__init__()  # 调用父类torch.nn.Module的__init__()
        # 线性模型: y = w*x + b
        # 在线性模型 Linear 类中,第一次训练时的参数 w 和 b 都是给的随机数，所以多次运行代码，结果不大相同
        self.linear1 = torch.nn.Linear(8, 6)  # 输入8，输出6。特征数为8。
        self.linear2 = torch.nn.Linear(6, 4)  # 输入6，输出4。上个函数输出为6。
        self.linear3 = torch.nn.Linear(4, 1)
        self.sigmoid = torch.nn.Sigmoid()

    # 类里面定义的每个函数都需要有个参数self,来代表自己，用来调用类中的成员变量和方法
    def forward(self, x):  # forward实现所有层的连接关系进行前向传播，以下为顺序连接
        x = self.linear1(x)
        x = self.linear2(x)
        x = self.linear3(x)
        x = self.sigmoid(x)
        return x


model = Model()

# 3.构建损失函数和优化器
# 损失函数：损失函数采用BCELoss计，运用交叉熵计算两个分布之间的差异
# 优化器：优化器采用SGD随机梯度优化算法
criterion = torch.nn.BCELoss(reduction="mean")
opt = torch.optim.SGD(params=model.parameters(), lr=0.001)

epochs = []
costs = []

# 4.开始训练
for epoch in range(300):
    epochs.append(epoch)
    # enumerate: 在遍历支持迭代的对象时，给出数据和数据index
    # zip: 将两个 list 或 tuple , 取出一一对应
    for i, data in enumerate(train_loader, 0):  # i为index，data为元素
        inputs, labels = data  # 将x_data和y_data分别赋值inputs和labels
        # x_data输入模型，前向计算模型训练输出的值
        y_pred_data = model(inputs)
        # 损失函数计算训练输出的值和真实的值之前的分布差异
        loss = criterion(y_pred_data, labels)
        print(print("epoch=", epoch, "batch=", i, "loss=", loss.item()))
        # 重置梯度
        opt.zero_grad()
        # 计算梯度反向传播
        loss.backward()
        # 优化器根据梯度值进行优化
        opt.step()

    costs.append(loss.item())


# 6.训练过程可视化
plt.plot(epochs, costs)
plt.ylabel('Cost')
plt.xlabel('Epoch')
plt.show()
