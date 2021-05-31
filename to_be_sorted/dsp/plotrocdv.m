function [rec,prec,raw]=plotrocdv(y,dv,k)
%PLOTROCDV Receiver Operator Characteristic for devision value thresholding
%
%   PLOTROCDV(y,dv) Plots the ROC curve for a movind threshold across the
%   decision values of a classifier. Array y contains the class label,
%   which should be '0' and '1'. Array dv holds the corresponding decision
%   values of the classifier.

if nargin==2
    k=true(size(dv));
end

A=min(dv);
B=max(dv);

thr=A:(B-A)/99:B;

for i=1:length(thr)
    x=double(dv>=thr(i) & k);
    c=myconfusionmat(y,x);
    
    prec(i)=c(1,1)/(c(1,1)+c(2,1));
    rec(i)=c(1,1)/(c(1,1)+c(1,2));
    acc(i)=(c(1,1)+c(2,2))/sum(c(:));
end

[prec,rec,raw]=roccurve(prec,rec,acc);

figure
hold on
plot([0 1],[1 0],'k--')
plot(rec,prec)
grid on
xlabel('rec')
ylabel('prec')
axis([0 1 0 1])
