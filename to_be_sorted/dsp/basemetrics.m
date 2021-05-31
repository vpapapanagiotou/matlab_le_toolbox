function [tp,fp,tn,fn]=basemetrics(gt,s,pLbl,pUse)

if nargin~=2 && nargin~=4
    error('wrong number of input arguments')
end

if nargin==2
    pLbl=false(size(s));
    pUse=false(size(s));
end

steps=100;

a=min(s);
b=max(s);
thr=a:(b-a)/steps:b;

tp=nan(length(thr),1);
fp=nan(length(thr),1);
tn=nan(length(thr),1);
fn=nan(length(thr),1);

for i=1:length(thr)
    lbl=s>thr(i);
    if sum(pUse)>0
        lbl(pUse)=pLbl(pUse);
    end
    
    tp(i)=sum( ( gt)&( lbl) );
    fp(i)=sum( (~gt)&( lbl) );
    tn(i)=sum( (~gt)&(~lbl) );
    fn(i)=sum( ( gt)&(~lbl) );
end
