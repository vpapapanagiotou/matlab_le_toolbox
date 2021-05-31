function snacks=getSnacks(bouts)

% Maximum in-snack bout gap
dg=60;
% Minimum snack duration
sd=30;
% Magic parameter Q
Q=0.25;

if isempty(bouts)
    snacks=[];
    return
end

% Main
boutsx=bouts;
del=false(size(boutsx,1),1);
for i=1:size(boutsx,1)-1
    if boutsx(i+1,1)-boutsx(i,2)<dg
        boutsx(i+1,1)=boutsx(i,1);
        del(i)=true;
    end
end
boutsx(del,:)=[];
snacks=boutsx;

if isempty(snacks)
    return
end

dur=snacks(:,2)-snacks(:,1);
snacks(dur<sd,:)=[];

del=false(size(snacks,1),1);
for i=1:size(snacks,1)
    b=snacks(i,1)<=bouts(:,1)&bouts(:,2)<=snacks(i,2);
    durb=sum(bouts(b,2)-bouts(b,1));
    durs=snacks(i,2)-snacks(i,1);

    if durb/durs<Q
        del(i)=true;
    end
end

snacks(del,:)=[];

end
