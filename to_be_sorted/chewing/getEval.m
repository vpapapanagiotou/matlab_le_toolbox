function X=getEval(actual,t,b,type)
% actual: Nx2 interval matrix for ground truth snacks
% t & b : timestamps and boolean decisions of detector
% type  : integer (1, 2, or 3)
% X1    : [tp fp fn tn] evaluation on duration
% X2    : [tp fp fn tn] evaluation on snacks/events
% X3    : [tp fp fn tn] evaluation on duration of snacks

t=t(:);
b=b(:);

detected=getSnacks(bool2table(t,b));
x=table2bool(detected,t);
y=table2bool(actual,t);
    
if type==1
    X(1,1)=sum(( b)&( y));
    X(1,2)=sum(( b)&(~y));
    X(1,3)=sum((~b)&( y));
    X(1,4)=sum((~b)&(~y));

elseif type==2
    [X(1,1),X(1,2),X(1,4),X(1,3)]=evalSnacks2(actual,detected);

elseif type==3
    X(1,1)=sum(( x)&( y));
    X(1,2)=sum(( x)&(~y));
    X(1,3)=sum((~x)&( y));
    X(1,4)=sum((~x)&(~y));

end
