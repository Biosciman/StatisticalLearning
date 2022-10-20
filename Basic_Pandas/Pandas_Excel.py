import pandas as pd

filename1 = 'MS221163-1D.xlsx'
filename2 = 'MS221163-4D.xlsx'

# 读取Excel文件，sheet_name不指定时默认返回全表数据，如果需要返回多个表，可以将sheet_name指定为一个列表，例如['sheet1', 'sheet2']
df1 = pd.read_excel(filename1, sheet_name='Proteins')
df2 = pd.read_excel(filename2, sheet_name='Proteins')

# 查看头部数据
print(df1.head())
# 查看标题
print(df1.columns)
# 查看行
print(df1.index)
# 查看指定列
print(df1['Accession'])
# 描述数据
print(df1.describe())
# 取指定列值，并转化为列表
list1 = df1['Accession'].values.tolist()
# 删除Accession中重复的行
df1.drop_duplicates(subset='Accession', keep=False)

'''
数据分析
目的：
① 提取'sum pep score'>30的'Accession'
② 找到1D和4D中均有的'Accession'，并且4D的'Score Sequest HT: Sequest HT'大于1D
③ 找到1D中无,4D中有的'Accession'
'''

# 解决目的①
# 方法1
Aim1_1 = df1[df1['Sum PEP Score'] > 30]
# 方法2，并提取'Accession'
Aim1_2 = df1.loc[df1['Sum PEP Score'] > 30, 'Accession']
# 方法3，并提取'Accession'，返回数组
Aim1_3 = df1.loc[df1['Sum PEP Score'] > 30, 'Accession'].values

# 解决目的②
# pd.merge中默认how=inner(为交集),_x来自df1,_y来自df2;当how=outer为并集，
Aim2 = pd.merge(df1, df2, on='Accession', how='inner')
Aim2_1 = Aim2[Aim2['Score Sequest HT: Sequest HT_y'] > Aim2['Score Sequest HT: Sequest HT_x']]
Aim2_list = Aim2_1['Accession'].values.tolist()

# 解决目的③
# 即取df2与df1的差集
list1 = list(df1['Accession'].values.tolist())
list2 = list(df2['Accession'].values.tolist())
list3 = list(set(list2).difference(set(list1)))
Aim3 = df2[df2['Accession'].isin(list3)]
