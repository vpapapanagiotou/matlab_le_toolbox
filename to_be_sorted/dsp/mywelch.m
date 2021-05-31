function X=mywelch(x,n,m)

% Bufferise
X=buffer(x,n,n-m,'nodelay');

% Check if last vector contains added zeros
l0=length(x);
[Xr,Xc]=size(X);
l1=Xr+(Xc-1)*m;
if l1>l0
    X(:,end)=[];
end

% Main part
X=bsxfun(@minus,X,mean(X));
X=bsxfun(@times,X,hamming(n));
X=fft(X);
X=X(1:fix(n/2)+1,:);
X=abs(X/n).^2;
X=mean(X,2);

