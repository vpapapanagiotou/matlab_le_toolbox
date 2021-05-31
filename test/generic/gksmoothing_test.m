% Generate data
clear
t0 = (-10:.1:10)';
a = [1 3 -6 -8] / 4;
x0 = polyval(a, t0);
y0 = x0 + 10 * randn(size(x0));

idx = sort(randsample(length(t0), 20), 'ascend');
t = t0(idx);
y = y0(idx);

yhat = gksmoothing(t, y, t0, 1);

l = 10;
zhat = conv(y0, ones([l, 1]) / l, 'same');

% View
close all
figure

subplot(1, 2, 1)
hold on
plot(t0, x0)
plot(t, y, 'x')
plot(t0, y0)
hold off
grid on
legend({'x_0: initial data', 'y: random selection', 'y_0: noisy w_0'})

subplot(1, 2, 2)
hold on
plot(t0, x0)
plot(t, y, 'x')
plot(t0, yhat, '.-')
% plot(t0, zhat)
hold off
grid on
legend({'x_0: initial data', 'y: random selection', 'yhat: gksmoothed'})
