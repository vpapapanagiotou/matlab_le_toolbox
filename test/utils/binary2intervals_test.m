%% Test 1
t = 1:10;
b = zeros([10, 1]);
x = binary2intervals(t, b);
y = zeros([0, 2]);
disp_test_result('Test 1', isequal(x, y))

%% Test 2
t = 1:20;
b = zeros([20, 1]);
b([2:4, 7:8, 12]) = 1; 
x = binary2intervals(t, b);
y = [2 4; 7 8; 12 12];
disp_test_result('Test 2', isequal(x, y));

%% Test 3
t = 1:20;
b = zeros([20, 1]);
b([1:4, 7:8, 12]) = 1; 
x = binary2intervals(t, b);
y = [1 4; 7 8; 12 12];
disp_test_result('Test 3', isequal(x, y));

%% Test 4
t = 1:20;
b = zeros([20, 1]);
b([1:4, 7:8, 12:20]) = 1; 
x = binary2intervals(t, b);
y = [1 4; 7 8; 12 20];
disp_test_result('Test 4', isequal(x, y));

%% Test 5
t = 1:5;
b = zeros([5, 1]);
b([1 3 5]) = 1; 
x = binary2intervals(t, b);
y = [1 1; 3 3; 5 5];
disp_test_result('Test 5', isequal(x, y));
