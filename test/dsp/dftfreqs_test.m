%% TEST 1

fs = 10;
n = 10;
x = dftfreqs(n, fs);
e = sum(abs(x - [0, 1, 2, 3, 4, -5, -4, -3, -2, -1]))


%% TEST 2

fs = 8;
n = 9;
x = dftfreqs(n, fs);
e = sum(abs(x - [0, 1, 2, 3, 4, -4, -3, -2, -1]))
