% Colored noise demo
n = 10000;

colors = {'blue', 'violet', 'brownian', 'pink'};

close all
figure
hold on
for color = colors
    x = colored_noise(n, color);
    [s, w] = pwelch(x, 100);
    plot(w / (2 * pi()), s)
end
hold off
grid on
legend(colors, 'Location', 'N')
set(gca(), 'YScale', 'log')
