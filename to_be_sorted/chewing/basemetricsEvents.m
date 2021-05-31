function out=basemetricsEvents(a,ahat)
% BASEMETRICSEVENTS Confusion matrix for event-based evaluation
%
%   out=BASEMETRICSEVENTS(a,ahat) returns the true positives (tp),
%   false positives (fp), true negatives (tn) and false negatives (fn)
%   as fields in the struct out. The input is two boolean arrays of
%   equal length, where a is the ground truth label (true is for
%   eating) and ahat is the prediction. The evaluation is based on
%   creating events from the boolean arrays and performing a
%   one-to-one match.

if isempty(a) && isempty(ahat)
    out.tp=0;
    out.fp=0;
    out.tn=0;
    out.fn=0;
    return
end

if isempty(a)
    out.tp=0;
    out.fp=size(ahat,1);
    out.tn=0;
    out.fn=0;
    return
end

if isempty(ahat)
    out.tp=0;
    out.fp=0;
    out.tn=0;
    out.fn=size(a,1);
    return
end

% Number of real activations
n=size(a,1);
% Number of detected activations
m=size(ahat,1);

% Overlap matrix
p=zeros(n,m);
for i=1:n
    for j=1:m
        p(i,j)=overlapr(a(i,:),ahat(j,:));
    end
end

% Initialise mapping matrix
map=zeros(0,2);

% Perform the match
while true
    % Maximum overlap pair
    [i,j]=maxMat(p);
    
    % if sum(i==map(:,1))>0 || sum(j==map(:,2))>0 || p(i,j)<0
    % Escape if the maximum overlap is negative (no overlap)
    if p(i,j)<0
        break
    end
    
    % Append pair in mapping table
    map=[map;i j];
    
    % Destroy row and column to avoid rematching any of the events
    p(i,:)=-Inf;
    p(:,j)=-Inf;
end

out.tp=size(map,1);
out.fn=n-out.tp;
out.fp=m-out.tp;
out.tn=0;
end

function a=overlapr(x,y)
    t1=max([x(1) y(1)]);
    t2=min([x(2) y(2)]);
    a=t2-t1;
end

function [i,j]=maxMat(x)
    [n,m]=size(x);
    if n==1
        i=1;
        [~,j]=max(x);
        return
    end
    if m==1
        [~,i]=max(x);
        j=1;
        return
    end
    [t,IDX]=max(x);
    [~,j]=max(t);
    i=IDX(j);
end
