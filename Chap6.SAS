#exp6.1

data gpjg;
input gj date gjd;
cards;
10.5   1       0.03
10.44   2       -0.06
9.94    3       -0.50
10.25   4       0.31
11      5       0.75
9.88    6       -1.12
10.5    7       0.62
12      8       1.50
13.94   9       1.94
12.25   10      -1.69
12.61   11      0.36
13.5    12      0.89
13.44   13      -0.06
12.44   14      -1.00
13.5    15      1.06
15.39   16      1.89
15.75   17      0.36
13.88   18      -1.87
14.5    19      0.62
15.5    20      1.00
16.13   21      0.63
14.75   22      -1.38
11.75   23      -3.00
15.25   24      3.50
17.13   25      1.88
20.5    26      3.37
19      27      -1.50
21.5    28      2.50
20.25   29      -1.25
25.63   30      5.38
26.88   31      1.25
27.63   32      0.75
23.88   33      -3.75
26.38   34      2.50
24      35      -2.38
24.38   36      0.38
;
run;

proc gplot data=gpjg;
symbol1 i=spline;
plot gj*date;
run;

proc gplot data=gpjg;
symbol1 i=spline;
plot gjd*date;
run;

proc arima data=gpjg;
identify var=gjd nlag=24 outcov=def;
run;

proc arima data=gpjg;
identify var=gjd nlag=24 outcov=def;
estimate p=0 q=4 noconstant plot;
run;


#exp6.2

#1
data house;
input date price date1 price1;
cards;
200101  1889.57         1       -57.23
200102  1832.33         2       -57.23
200103  1825.18         3       -7.16
200104  1672.03         4       -153.14
200105  1630.83         5       -41.20
200106  1403.38         6       -227.45
200107  1706.54         7       303.16
200108  1546.25         8       -160.29
200109  1860.89         9       314.64
200110  1842.31         10      -18.58
200111  1372.88         11      -469.43
200112  1772.14         12      399.26
200201  1874.45         13      102.31
200202  1859.82         14      -14.63
200203  2040.55         15      180.73
200204  1742.26         16      -298.29
200205  1823.27         17      81.01
200206  2252.42         18      429.15
200207  1861.83         19      -390.59
200208  1951.21         20      89.38
200209  2136.11         21      184.90
200210  2124.55         22      -11.56
200211  2629.48         23      504.93
200212  2213.94         24      -415.54
200301  2374.11         25      160.17
200302  2226.5          26      -147.61
200303  2687.83         27      461.33
200304  2374.88         28      -312.95
200305  2483.15         29      108.27
200306  2341.8          30      -141.35
200307  2417.31         31      75.51
200308  2175.36         32      -241.95
200309  2377.02         33      201.66
200310  2447.25         34      70.23
200311  2471.37         35      24.12
200312  2595.96         36      124.59
200401  2560.83         37      -35.13
200402  2667.09         38      106.26
200403  2636.74         39      -30.35
200404  2808.5          40      171.76
200405  2533.52         41      -274.98
200406  2273.82         42      -259.70
200407  2337.59         43      63.77
200408  2544.08         44      206.49
200409  2770.01         45      225.93
200410  2772.98         46      2.97
200411  2636.42         47      -136.56
200412  2868.9          48      232.48
200501  2830.82         49      -38.08
200502  2973.76         50      142.94
200503  2875.72         51      -98.04
200504  3400.51         52      524.79
200505  2941.64         53      -458.87
;
run;

proc gplot data=house;
symbol1 i=spline;
plot price*date1;
run;

proc gplot data=house;
symbol1 i=spline;
plot price(1)*date1;
run;

proc gplot data=house;
symbol1 i=spline;
plot price1*date1;
run;

proc arima data=house;
identify var=price stationarity=(adf=(1));
run;

proc arima data=house;
identify var=price(1) stationarity=(adf=(1));
run;

proc arima data=house;
identify var=price(1) nlag=24 outcov=def;
estimate p=0 q=2 noconstant plot;
run;
forecast lead=8;
run;


#2-ppt
data houseprice;
input x;
y=dif(x);
t=intnx(‘month’,’01jan2000’d,_n_-1);
t1=_n_;
format t monyy.;
cards;/*数据*/
;
run;   #建立SAS数据文件

proc gplot data=houseprice;
plot x*t=1 y*t1=2;
symbol1 c=black v=star i=join;
symbol2 c=blue v=dot i=join;
run;  #绘制时间序列图

proc arima data=houseprice;
identify var=x  stationarity =(adf=1); 
identify var=y  stationarity =(adf=1);
run;   #计算自相关系数及单位根检验

Proc arima;
Identify var=x(1) stationarity=(adf=1);
Estimate q=1 method=cls noint;
Forecast lead=3 id=t1 out=results;
run;   #对住房均价序列建立ARIMA模型并进行3期预测

Proc gplot data=results;
Plot x*t1=1 forecast*t1=2 l95*t1=3 u95*t1=3/overlay;
Symbol1 c=blue v=star i=none;
Symbol2 c=red v=none i=join l=1 w=1;
Symbol3 c=green v=none i=join l=2 w=2;
run;   #对住房均价序列建立ARIMA模型的拟合效果图
