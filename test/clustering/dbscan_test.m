clear

x1 = mvnrnd([2, 3], [1 1.5; 1.5 3], 500);
y1 = 1 * ones([size(x1, 1), 1]);

x2 = mvnrnd([3, 0], [1.5 1; 1 1], 300);
y2 = 2 * ones([size(x1, 1), 1]);

x = [x1; x2];
l = dbscan(x, 0.5, 20, @euclidean_distance, true);
length(unique(l))

close all
figure
hold on

plot(x1(:, 1), x1(:, 2), '.')
plot(x2(:, 1), x2(:, 2), '.')

ax = gca;
ax.ColorOrderIndex = 1;

for i = 1:max(abs(l))
    idx = l == i;
    plot(x(idx, 1), x(idx, 2), 'o')
end

ax = gca;
ax.ColorOrderIndex = 1;

for i = -1:-1:-max(abs(l))
    idx = l == i;
    plot(x(idx, 1), x(idx, 2), 'x')
end

idx = l == 0;
plot(x(idx, 1), x(idx, 2), 'ok')

hold off
grid on
