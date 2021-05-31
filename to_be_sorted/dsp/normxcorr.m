function r=normxcorr(x,h)
%NORMXCORR Normalised cross-correlation
%
%   r=NORMXCORR(x,h) computes the normalised cross-correlation arrays
%   x and h. The array x must be longer than the array h for the
%   normalisation to be meaningful. The resulting array r contains
%   correlation coefficients and its values may range from -1.0 to
%   1.0.

n=length(x);
m=length(h)-1;

x=x(:)-mean(x);
h=reshape(h,1,[]);
sumh2=sum(h.^2);

x=[zeros(m,1);x;zeros(m,1)];
r=zeros(n+m,1);

for i=1:length(r)
    
    w=x(i:i+m);
    w=w-mean(w);
    
    r(i)=(h*w)/sqrt(sum(w.^2)*sumh2);
    
end

end
