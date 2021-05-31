function [tp,fp,tn,fn]=evalSnacks(actual,detected)

tp=0;
fp=0;
tn=0;
fn=0;

for i=1:size(actual,1)
    if overlap(actual(i,1),actual(i,2),detected)
        tp=tp+1;
    else
        fn=fn+1;
    end
end

for i=1:size(detected,1)
    if overlap(detected(i,1),detected(i,2),actual)
        
    else
        fp=fp+1;
    end    
end

end

function b=overlap(x1,x2,y)
if isempty(y)
    b=false;
    return
end
b1=x2<y(:,1);
b2=y(:,2)<x1;
b=b1|b2;
b=~b;
b=sum(b)>0;
end
