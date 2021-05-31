function I=logbandsmat(fI,f)

I=false(length(f),length(fI));

b=f<=fI(1);
I(b,1)=true;

for i=1:length(fI)-1
    b=fI(i)<f&f<=fI(i+1);
    I(b,i+1)=true;
end

emptybands=sum(I)==0;
I(:,emptybands)=[];
