function x=unite(x,d)

for i=size(x,1):-1:2
    if x(i,1)-x(i-1,2)<d
        x(i-1,2)=x(i,2);
        x(i,:)=[];
    end
end

end
