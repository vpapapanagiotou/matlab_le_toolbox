function I=zerocross(x)

x1=x(1:end-1);
x2=x(2:end);
y=x1.*x2;
I=y<0;
