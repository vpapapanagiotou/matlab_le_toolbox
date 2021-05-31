function b=table2bool(events,t)
%TABLE2BOOL Returns a boolean indicator based on an events matrix
%
%   b=TABLE2BOOL2(events,t) returns a boolean indicator signal of n
%   samples, based on the Nx2 matrix events, for eatch timestamp in t.

b=false(size(t));

for i=1:size(events,1)
    I=events(i,1)<=t&t<=events(i,2);
    b(I)=true;
end

