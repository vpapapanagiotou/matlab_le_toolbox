function snacks=getSnacks2(b,fs)

t=(0:length(b)-1)/fs;
snacks=bool2table(t,b);

if isempty(snacks)
    return
end

snacks=unite(snacks,60);

dur=snacks(:,2)-snacks(:,1);
snacks(dur<10,:)=[];

end
