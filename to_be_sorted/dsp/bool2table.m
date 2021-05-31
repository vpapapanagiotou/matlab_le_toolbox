function T=bool2table(t,b)

% First ensure only two levels
b=double(b);
if length(b(b==1|b==0))~=length(b)
    error('error')
end

% Find changes
db=diff(b);

Ipos=find(db==+1)+1;
Ineg=find(db==-1);
I=sort([Ipos(:);Ineg(:)]);

t2=t(I);
b2=b(I);

if b(1)
    t2=[t(1);t2];
end
if b(end)
    t2=[t2;t(end)];
end

T=reshape(t2,2,[])';

return




% Number of intervals
k=0;
% Intervals
T=zeros(0,2);
% State
inEvent=false;

for i=1:length(b)
    if inEvent && ~b(i)
        T(end,2)=t(i-1);
        inEvent=false;
    end
    if b(i) && ~inEvent
        T(end+1,1)=t(i);
        inEvent=true;
    end
end

if inEvent
    T(end,2)=t(end);
end

return

diffb=diff([0;b(:);0]);

up=find(diffb==1)+1-1;
down=find(diffb==-1)-1;

I=[up(:);down(:)];
tI=t(I);
bI=[true(length(up),1);false(length(down),1)];

[tI,IDX]=sort(tI,'ascend');
bI=bI(IDX);

tI=tI(:);
bI=bI(:);

if isempty(bI)
    T=[];
    return
end

if length(bI)==1
    if bI
        T=[tI;t(end)];
    else
        T=[t(1);tI];
    end
    return
end

if ~bI(1)
    tI=[t(1);tI];
    bI=[true;bI];
end

if bI(end)
    tI=[tI;t(end)];
    bI=[bI;false];
end

T=reshape(tI,2,[])';
end
