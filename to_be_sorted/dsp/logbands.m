function fI=logbands(f1,f2,n)
%LOGBANDS Group frequencies into log bands
%
%   fI=LOGBANDS(f1,f2,n) splits frequencies from f1 to f2 into n log bands.

lf1=log(f1);
lf2=log(f2);
fI=[exp(lf1:(lf2-lf1)/n:lf2)];
fI([1 end])=[f1 f2];
