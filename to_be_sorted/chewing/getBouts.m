function bouts=getBouts(chews)

l=2;
md=5;

if isempty(chews)
    bouts=[];
    return
end


bouts=unite(chews,l);

dur=bouts(:,2)-bouts(:,1);
bouts(dur<md,:)=[];

end
