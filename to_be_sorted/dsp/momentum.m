function y=momentum(x,a,init)
%MOMENTUM Momentum estimation of x
%
%   y=MOMENTUM(x,a,init) estimates the momentum of x, using memory
%   parameter (1-a); init is the initialisation value of momentum.

% Pre-allocate
y=zeros(size(x));

% Memory
b=1-a;

% Main part
xold=init;
for i=1:length(x)
    y(i)=b*xold+a*x(i);
end

