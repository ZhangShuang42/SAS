#随机季节模型exp7.1

data a; 
input x@@;
dif1_4=dif4(dif(x));
time=intnx('quarter','1jan1962'd,_n_-1);
format time year4.;
cards;
1.1	 0.5  0.4  0.7  1.6 
0.6  0.5  0.7  1.3  0.6 
0.5  0.7  1.2  0.5  0.4 
0.6  0.9  0.5  0.5  1.1 
2.9  2.1  1.7  2.0  2.7 
1.3  0.9  1.0  1.6  0.6 
0.5  0.7  1.1  0.5  0.5 
0.6  1.2  0.7  0.7  1.0 
1.5	 1.0  0.9  1.1  1.5 
1.0  1.0  1.6  2.6  2.1 
2.3  3.6  5.0  4.5  4.5 
4.9  5.7  4.3  4.0	4.4 
5.2  4.3  4.2  4.5  5.2	
4.1	 3.9  4.1  4.8  3.5 
3.4	 3.5  4.2  3.4	3.6	
4.3	 5.5  4.8  5.4  6.5 
8.0  7.0  7.4  8.5	10.1
8.9	 8.8  9.0  10.0 8.7 
8.8	 8.9  10.4 8.9	8.9	
9.0  10.2 8.6 8.4  8.4 
9.9  8.5  8.6 8.7  9.8	
8.6  8.4  8.2 8.8  7.6 
7.5	 7.6  8.1 7.1	6.9	
6.6	 6.8  6.1 6.2  6.2
;

proc gplot;
plot x*time dif1_4*time;
symbol c=black i=join v=star;

proc arima;
identify var=x(1,4);
estimate p=(1,4) noint;
forecast lead=0 id=time out=out;

proc gplot data=out;
plot x*time=1 forecast*time=2 /overlay;
symbol1 c=black i=none v=star;
symbol2 c=red i=join v=none;
run;


#exp7.2

data a;
input x@@;
dif1_12=dif12(dif(x));
time=intnx('month','1jan1948'd,_n_-1);
format time year4.;
cards;
446 650 592 561 491 592 604 635	580 
510 553 554 628 708 629 724 820	865 
1007 1025 955 889 965 878 1103 1092 978 
823 827 928 838 720 756 658 838 684
;
proc gplot;
plot x*time dif1_12*time;
symbol c=black i=join v=none; 
proc arima;
identify var=x(1,12);
estimate p=1 q=(1)(12) noint;
forecast lead=0 id=time out=out;
proc gplot data=out;
plot x*time=1 forecast*time=2 /overlay;
symbol1 c=black i=none v=dot;
symbol2 c=red i=join v=none;
run;


#exp7.4/5

proc arima 
data=shx1.xiaoshou;
identify var=x nlag=18;
run;


#exp7.6

data a;
set shx1.qdwg;
x1=lag(x)+lag2(x)+lag3(x)+lag4(x);
x2=-(lag(x)-lag2(x)+lag3(x)-lag4(x));
x3=lag(x)-lag3(x);x4=-(lag2(x)-lag4(x));
x5=dif4(x);
proc autoreg data=a;
model x5= x1 x2 x3 x4/nlag=1 method=ml noint;
run;

#

data a;
input x time$;
x1t=lag(x)+lag2(x)+lag3(x)+lag4(x);
x2t=-(lag(x)-lag2(x)+lag3(x)-lag4(x));
x3t=lag(x)-lag3(x);
x4t=-(lag2(x)-lag4(x));
dif4x=dif4(x);
cards;
/数据/
;
proc autoreg;
model dif4x=x1t x2t x3t x4t/nlag=1 method=ml noint;
run;
proc autoreg;
model dif4x=x1t x2t/nlag=1 method=ml noint;
run;


#exp7.7

data a;
set shx1.sars;
where time<='12dec2002'd;
proc arima;
identify var=x;
estimate p=(1,7,12,13) maxit=100 noint method=ml;
run;
proc arima;
identify var=x;
estimate p=(1) (12) maxit=100 noint method=ml;
run;

#X-11

data xiaoshoue;
input x;
time=intnx('month','01jan1993'd, _n_-1);
format time date.;
cards;
/数据/
;
proc x11 data=xiaoshoue;
monthly date=time;
var x;
tables b1 d10 d12 d11 d13 c15 f2 f1 e6 d8;
output out=h b1=x d12=T d13=I d10=S;
Run;

#绘制原始数据的时序图、季节调整后数据时序图、不规则成分时序图、季节成分时序图：
proc gplot;
plot x*time; symbol1 v=star i=spline;
run;
proc gplot;
plot I*time; symbol1 v=star i=spline;
run;
proc gplot;
plot S*time; symbol1 v=star i=spline;
run;

#建立线性回归方程进行预测：
data xiaooshou1;
input T_t@@;t=_n_;
cards;
/表7.15/
;
proc reg; model x=t/p;
Run;


