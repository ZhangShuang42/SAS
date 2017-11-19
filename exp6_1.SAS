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
