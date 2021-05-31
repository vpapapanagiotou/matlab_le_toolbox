function mytvs(x,fs,tvsSize,tvsStep,welchSize,welchStep)

X=buffer(x,tvsSize,tvsSize-tvsStep,'nodelay');
n=size(X,2);

S=zeros(fix(welchSize/2)+1,n);
for i=1:n
    S(:,i)=mywelch(X(:,i),welchSize,welchStep);
end

f=fff(welchSize,fs);
f=f(1:fix(welchSize/2)+1);
t=((0:n-1)*tvsStep+tvsSize/2)/fs;
figure
mesh(t,f,S)
xlabel('Time (sec)')
ylabel('Freq (Hz)')
zlabel('S')

