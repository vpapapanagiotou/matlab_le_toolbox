x_dim = 2;
y_dim = 3;
n = 1000;
m = 100;

x = rand([n, x_dim]);
y = rand([n, y_dim]);

xhat = rand([m, x_dim]);

yhat1 = gksmoothing_original(x, y, xhat);
yhat2 = gksmoothing(x, y, xhat);

sum(sum(abs(yhat1 - yhat2)))
