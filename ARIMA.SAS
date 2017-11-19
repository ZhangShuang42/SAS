#拟合ARIMA模型

data li6_3;
input x@@;
difx=dif(x);
t=_n_;
cards;
1.05 -0.84 -1.42 0.20 2.81 6.72 5.40 4.385.52 4.46 2.89 -0.43 -4.86 -8.54 -11.54 -16.22-19.41 -21.61 -22.51 -23.51 -24.49 -25.54 -24.06 -23.44-23.41 -24.17 -21.58 -19.00 -14.14 -12.69 -9.48 -10.29-9.88 -8.33 -4.67 -2.97 -2.91 -1.86 -1.91 -0.80
;
Proc print;
Run;
proc gplot;
plot x*t;
symbol c=black v=star i=join;
run;    建立数据文件，并考察时间序列的平稳性

proc gplot;
plot difx*t;
symbol c=black v=star i=join;
proc arima;
identify var=x(1);
estimate p=1 noint;
forecast lead=5 id=t;
run;     对序列进行差分运算，并考察差分序列的平稳性


#拟合Auto-Regressive模型

data li6_4;
input x@@;
t=_n_;
cards;
3.03 8.46 10.22 9.80 11.96 2.83
8.43 13.77 16.18 16.84 19.57 13.26
14.78 24.48 28.16 28.27 32.62 18.44
25.25 38.36 43.70 44.46 50.66 33.01
39.97 60.17 68.12 68.84 78.15 49.84
62.23 91.49 103.20 104.53 118.18 77.88
94.75 138.36 155.68 157.46 177.69 117.15
;
proc gplot data=li6_4;
plot x*t=1;
symbol1 c=black i=join v=star;
run;     建立数据集，绘制时序图

proc autoreg data=li6_4;
model x=t/dwprob;
run;       因变量关于时间的回归模型
proc autoreg data=li6_4;
model x=t/nlag=5 backstep method=ml;
run;
proc autoreg data=li6_4;
model x=t/nlag=5 backstep method=ml noint;
output out=out p=xp pm=trend;    
run;
proc gplot data=out;
plot x*t=2 xp*t=3 trend*t=4/overlay;
symbol2 v=star i=none c=black;
symbol3 v=none i=join c=red w=2 l=3;
symbol4 v=none i=join c=green w=2;
run;       为了得到直观的拟合效果，还可以利用OUTPUT命令将拟合结果存入SAS数据集中，并对输出结果作图

proc autoreg data=li6_4;
model x=lagx/lagdep=lagx;
run;      延迟因变量回归模型

x=lagx/lagdep=lagx noint;
output out=out p=xp;
run;
proc gplot data=out;
plot x*t=2 xp*t=3/overlay;
symbol2 v=star i=none c=black;
symbol3 v=none i=join c=red w=2;
run;      在显著性水平默认为0.05的条件下，截距项不显著（P值大于0.1523），所以可以考虑在模型拟合命令中增加NOINT选项。最后输出拟合结果，并绘制拟合时序图.




