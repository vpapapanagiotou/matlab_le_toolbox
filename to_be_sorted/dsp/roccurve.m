function [x,y,raw]=roccurve(x,y,z)

if nargin==2
    z=zeros(size(x));
end

% Remove duplicates
xy=[x(:) y(:) z(:)];
xy=unique(xy,'rows');
x=xy(:,1);
y=xy(:,2);
z=xy(:,3);

% Paretto front
del=false(size(x));
for i=1:length(x)
    xt=x;
    xt(i)=[];
    yt=y;
    yt(i)=[];
    b=x(i)<=xt & y(i)<=yt;
    del(i)=sum(b)>0;
end

% Remove samples that are not in Paretto front
x(del)=[];
y(del)=[];
z(del)=[];

% Sort
[x,I]=sort(x);
y=y(I);
z=z(I);

raw.x=x;
raw.y=y;
raw.z=z;

% Prepare for plot
x=kron(x(:),[1;1]);
y=kron(y(:),[1;1]);
x(end)=[];
y(1)=[];
