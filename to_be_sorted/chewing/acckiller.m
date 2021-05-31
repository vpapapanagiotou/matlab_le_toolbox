function b=acckiller(t,acc)

thr=1e-3;

I=isnan(acc.E);
acc.E(I)=interp1(acc.t(~I),acc.E(~I),acc.E(I),'nearest');

b=interp1(acc.t,double(acc.E<thr),t,'nearest')';
b(isnan(b))=true;
