rng(0);

n = 10;

clear x
x.a = randn(n, 2);
x.b = (1:n)';
x.c = randstr([n 1], 10);

for i = 1:n
    k = randi(7);
    x.d{i, 1} = randstr([k 1], [2 2]);
    x.d{i, 1} = randi(99, [k, 12]);
end

y = struct2table(x);
y = y(:, [1 4 3 2]);
z = table_explode(y, 2);

disp('Original table')
disp(y)
disp('Boom table')
disp(z)
