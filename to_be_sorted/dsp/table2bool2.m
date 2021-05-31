function b=table2bool2(events,start,fs,n)
%TABLE2BOOL2 Returns a boolean indicator based on an events matrix
%
%   b=TABLE2BOOL(events,start,fs,n) returns a boolean indicator
%   signal of n samples, based on the Nx2 matrix events. Sampling
%   rate is defined by fs, and start time by start (usually 0).

t=start+(0:n-1)/fs;
b=false(size(t));

for i=1:size(events,1)
    I=events(i,1)<=t&t<=events(i,2);
    b(I)=true;
end
