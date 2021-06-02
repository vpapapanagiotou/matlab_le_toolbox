%% TEST 1

fs = 12;
n = 3;
x = dftfreqs(n, fs);
e = sum(abs(x - [0, 4, -4]))


%% TEST 2

fs = 12;
n = 4;
x = dftfreqs(n, fs);
e = sum(abs(x - [0, 3, -6, -3]))
