function I=localmaxima(x,n)

m=2*n+1;

x=[zeros(n,1);x(:);zeros(n,1)];
x=buffer(x,m,m-1,'nodelay');
x=bsxfun(@minus,x,x(n+1,:));
x(n+1,:)=[];
x=sum(x<0);
I=x==2*n;
