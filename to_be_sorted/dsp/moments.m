function y=moments(x,lags,wsize,wstep,normalise)

% Useful renames
n=length(x);
k=length(lags);
q=max(lags);
m=n-2*q;

% Initialise loop
X=x;
% Start calculating products for each lag
for i=1:k
    X(1:n-lags(i))=X(1:n-lags(i)).*x(lags(i)+1:n);
end
% Simulate the last zeros that were not included in the previous iterations
X(n-q+1:n)=0;

% Bufferise
Y=buffer(X,wsize,wsize-wstep,'nodelay');
y=mean(Y);

if normalise
    
end
if ~normalise
    return
end

error('Bad value for normalise')
