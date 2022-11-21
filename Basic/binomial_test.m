% 100次中，在0.15概率正例的情况下，0.05的概率出现多少次
% 9次
% icdf拟积累分布函数
% x = icdf(name,p,A) 基于 p 中的概率值计算并返回由 name 和分布参数 A 指定的单参数分布族的逆累积分布函数 (icdf) 值。
% x = icdf(name,p,A,B) 基于 p 中的概率值计算并返回由 name 以及分布参数 A 和 B 指定的双参数分布族的 icdf 值。
% x = icdf(name,p,A,B,C) 基于 p 中的概率值计算并返回由 name 以及分布参数 A、B 和 C 指定的三参数分布族的 icdf 值。
% x = icdf(name,p,A,B,C,D) 在 p 中的概率值计算并返回由 name 以及分布参数 A、B、C 和 D 指定的四参数分布族的 icdf 值。
% x = icdf(pd,p) 在 p 中的概率值计算并返回概率分布对象 pd 的 icdf 函数。

icdf('Binomial',0.05,100,0.15)