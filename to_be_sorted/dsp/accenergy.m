function E=accenergy(xyz,m,Wn,wsize,wstep,dillen)
%ACCENERGY Algorithm for accelerometer enery level
%
%   E=ACCENERGY(xyz,m,Wn,wsize,wstep,dilllen) computes the accelerometer
%   energy. The raw signals are included in the Nx3 matrix xyz. A 
%   pre-processing step removes the DC component at the cut of frequency Wn
%   (regularised) using a high-pass FIR filter of length m. A sliding
%   window of wsize samples length and wstep samples step is used for the
%   estimation. Finally, dilation is performed, with a structure element of
%   length dillen.
%
%   NOTE xyz samples should be measured in g (equal to 9.81 m/sec/sec)


% Total acceleration
a=sqrt(sum(xyz.^2,2));

% Filter
h=fir1(m,Wn,'high');
a=filter(h,1,a);

% Compensate for filter offset
a(1:fix(m/2))=[];

% Energy estimator
A=buffer(a,wsize,wsize-wstep,'nodelay');
E=var(A);

% Dilation
E=imdalate(E,ones(1,dillen));
