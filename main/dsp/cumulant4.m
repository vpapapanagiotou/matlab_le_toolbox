function y = cumulant4(x, m1, m2, m3)
%CUMULANT4 Forth-order cumulant of x
%
%   y = CUMULANT4(x, m1, m2, m3) computes the forth-order cumulant for x,
%   with lags m1, m2 and m3. Also, 0 < m1 <= m2 <= m3 < length(x) must
%   hold.
%
%   NOTE It is required that mean(x) is zero.

A = lemoment(x, [m1 m2 m3], 1);
B = lemoment(x, m1) * lemoment(x, [m3 m2], 1);
C = lemoment(x, m2) * lemoment(x, [m3 m1], 1);
D = lemoment(x, m3) * lemoment(x, [m2 m1], 1);

y = A - B - C - D;
