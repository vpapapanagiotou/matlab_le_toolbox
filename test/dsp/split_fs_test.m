rng(1);
k = 3;
fs = randi(10000, [1, k]) / 100 + 20;
l = randi(1000, [1, k]) + 100;

dt = [];
for i = 1:k
    t_new = 1 / fs(i) + 0.002 * randn([l(i), 1]) ;
    dt = [dt; t_new];
end

dt(dt == 0) = 0.001;
dt(dt < 0) = -dt(dt < 0);
t = cumsum(dt);

[aisf, s] = split_fs(t, 0:5:100);

close all
figure
hold on

plot(100 * dt)
plot(aisf)

ax = axis();
for i = 1:k
    plot(sum(l(1:i)) * [1, 1], ax([3, 4]), 'k--')
    text(sum(l(1:i)), ax(4), [num2str(fs(i)) ' Hz'])
end

hold off
grid on
legend('dt (x100)', 'fs')
