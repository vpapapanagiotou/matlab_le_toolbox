function snacks=dec2snacks(t,b)

boutMinDuration=5; % 5 seconds
boutMaxPause=120; % 120 seconds, maximum in-snack bout gap
snackMinDuration=90; % 90 seconds
minPercentageCoverage=.5;

if sum(b)==0
    snacks=[];
    return
end

% Make interval table
A=bool2table(t,b);

% Drop short duration intervals
del=A(:,2)-A(:,1)<boutMinDuration;
A(del,:)=[];

if isempty(A)
    snacks=[];
    return
end

% Unite nearby bouts
bouts=A;
del=false(size(bouts,1),1);
for i=1:size(bouts,1)-1
    if bouts(i+1,1)-bouts(i,2)<boutMaxPause
        bouts(i+1,1)=bouts(i,1);
        del(i)=true;
    end
end
bouts(del,:)=[];

if isempty(bouts)
    return
end

snacks=bouts;

% Drop short duration intervals
del=snacks(:,2)-snacks(:,1)<snackMinDuration;
snacks(del,:)=[];

% Percentage coverage
del=false(size(snacks,1),1);
for i=1:size(snacks,1)
    b=snacks(i,1)<=bouts(:,1)&bouts(:,2)<=snacks(i,2);
    durb=sum(bouts(b,2)-bouts(b,1));
    durs=snacks(i,2)-snacks(i,1);

    if durb/durs<minPercentageCoverage
        del(i)=true;
    end
end

snacks(del,:)=[];
