% x = icdf(name,p,A) 
% 基于 p 中的概率值计算并返回由 name 和分布参数 A 指定的单参数分布族的逆累积分布函数 (icdf) 值。
% icdf('T',1-α/2,k-1)
% k-1为自由度
% 当样本量无限大时，t分布接近正态分布

% Find the 95th percentile of the Student's t distribution with 50 degrees of freedom.
x = icdf('T',0.95,50)
x

p = .95;   
nu = 50;   
x = tinv(p,nu)
x