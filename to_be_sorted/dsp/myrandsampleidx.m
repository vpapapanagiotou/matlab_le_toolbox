function y=myrandsampleidx(x,n)
% MYRANDSAMPLEIDX Proper random sampling of indices
%
%   y=MYRANDSAMPLEIDX Performs an improved version of randsample(x,n).
%   However, (a) it does not suffer from the case of x being a population
%   of one non-negative integer, and (b) if n is more than length(x), it
%   returns y=x.

if length(x)<=n
    y=x;
else
    y=x(randsample(length(x),n));
end
