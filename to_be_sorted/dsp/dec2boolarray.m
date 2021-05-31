function b=dec2boolarray(x,n)
% DEC2BOOLARRAY Convert decimal integer to boolean array

c=dec2bin(x,n);
b=false(size(c));
for i=1:length(c)
    b(i)=strcmp(c(i),'1');
end

