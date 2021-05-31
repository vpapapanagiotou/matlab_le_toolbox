function c=myconfusionmat(y,yhat)
%
%   -----------
%   | TP | FN |
%   |---------|
%   | FP | TN |
%   -----------

A=y==1;
B=yhat==1;

tp=sum(A&B);
fp=sum(B&~A);
fn=sum(A&~B);
tn=sum((~A)&(~B));

c=[tp fn;fp tn];
