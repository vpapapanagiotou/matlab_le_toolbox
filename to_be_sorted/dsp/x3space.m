function x=x3space(a,b,n)
% X3SPACE Similar to linspace, but for x^3
%
%   x=X3SPACE(a,b,n2) creates a vector of 2*fix(n/2)+1 points, so that:
%   x(1)=a, x(end)=b, and diff(x.^(-13)) is constant.

n2=fix(n/2);
x=linspace(-n2,n2,n).^3;
x=x*(b-a)/2/n2^3+(a+b)/2;
