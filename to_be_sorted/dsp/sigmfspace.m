function x=sigmfspace(a,b,n,f)
% X3SPACE Similar to linspace, but for sigmoid
%
%   x=SIGMFSPACE(a,b,n2) creates a vector of n points, so that: x(1)=a,
%   x(end)=b, x has a sigmoid shape.
%
%   x=SIGMFSPACE(a,b,n2,f) determines the sigmoid shape (default 4).

if nargin==3
    f=4;
end

params=[f (b+a)/2];

t=linspace(a,b,n);
x=sigmf(t,params);
x=x*(b-a)+a;
