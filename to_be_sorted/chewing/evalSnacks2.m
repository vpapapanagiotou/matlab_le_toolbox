function [tp,fp,tn,fn]=evalSnacks2(actual,detected)

if isempty(actual) && isempty(detected)
    tp=0;fp=0;tn=0;fn=0;return
end
if isempty(actual)
    tp=0;fp=size(detected,1);tn=0;fn=0;return
end
if isempty(detected)
    tp=0;fp=0;tn=0;fn=size(actual,1);return
end

n=size(actual,1);
m=size(detected,1);

p=zeros(n,m);
for i=1:n
    for j=1:m
        p(i,j)=overlapr(actual(i,:),detected(j,:));
    end
end

map=zeros(0,2);

while true
    [i,j]=maxMat(p);
    
    if sum(i==map(:,1))>0 || sum(j==map(:,2))>0 || p(i,j)<=0
        break
    end
    map=[map;i j];
    p(i,:)=-Inf;
    p(:,j)=-Inf;
end

tp=size(map,1);
fn=n-tp;
fp=m-tp;
tn=0;
end

function a=overlapr(x,y)
    t1=max([x(1) y(1)]);
    t2=min([x(2) y(2)]);
    a=t2-t1;
end

function [i,j]=maxMat(x)
    [n,m]=size(x);
    if n==1
        i=1;
        [~,j]=max(x);
        return
    end
    if m==1
        [~,i]=max(x);
        j=1;
        return
    end
    [t,IDX]=max(x);
    [~,j]=max(t);
    i=IDX(j);
end
