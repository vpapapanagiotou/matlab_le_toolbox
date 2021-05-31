function out=basemetricsDuration(a,ahat)
% BASEMETRICSDURATION Confusion matrix for duration-based evaluation
%
%   out=BASEMETRICSDURATION(a,ahat) returns the true positives (tp),
%   false positives (fp), true negatives (tn) and false negatives (fn)
%   as fields in the struct out. The input is two boolean arrays of
%   equal length, where a is the ground truth label (true is for
%   eating) and ahat is the prediction. The evaluation is based on
%   duration.

la=length(a);
lahat=length(ahat);

if la>lahat
    ahat(lahat+1:la)=false;
end

if la<lahat
    ahat(la+1:lahat)=[];
end

out.tp=sum( ( a)&( ahat) );
out.fp=sum( (~a)&( ahat) );
out.tn=sum( (~a)&(~ahat) );
out.fn=sum( ( a)&(~ahat) );
    
