function [x,y]=plotableIntervals(A)

x=reshape(A',1,[]);
x=kron(x,[1 1]);
y=zeros(size(x));
y(2:4:end)=1;
y(3:4:end)=1;
