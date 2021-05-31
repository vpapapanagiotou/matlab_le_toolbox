function f = dftfreqs(n, fs)
    %DFTFREQS Analog frequencies of DFT
    %
    %   f =  DFTFREQS(n, fs) computes the corresponding analog frequencies
    %   (in Hz) for a DFT of a signal with n samples and sampling frequency
    %   fs.
    %
    %   Note - it is now compatible with fftshift.
    
    m = floor(n / 2);
    i = [0:m - 1, (m:n - 1) - n];
    f = fs / 2 * i / m;
end
