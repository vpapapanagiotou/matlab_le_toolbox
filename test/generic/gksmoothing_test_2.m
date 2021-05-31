n = 100;

x = (1:n)';
y = rand([n, 1]);
xhat = x;
yhat = gksmoothing(x, y, xhat);

figure
hold on
plot(x, y, '.-')
plot(xhat, yhat, 'o-')
hold off
grid on
legend('original', 'smoothed')
