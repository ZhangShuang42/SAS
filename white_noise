#1

data a;
do time=-50 to 1000;
x=rannor(32585);
if time>0 then output;
end;
proc gplot;
plot x*time;
symbol v=point i=join c=blue;
Run;

#2

data RV;
retain _seed_ 0;
mu=0;
sigma=1;
do time=1 to 100;
p=mu+sigma*rannor(_seed_);
output;
end;
drop _seed_ mu sigma;
run;
proc gplot;
plot p*time;
symbol1 v=star i=join c=blue;
run;
