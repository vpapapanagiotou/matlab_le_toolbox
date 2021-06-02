function f = dftfreqs(n, fs)
    %DFTFREQS Analog frequencies of DFT
    %
    %   f = DFTFREQS(n, fs) computes the corresponding analog frequencies
    %   (in Hz) for a DFT of a signal with n samples and sampling frequency
    %   fs.
    %
    %   Note - it is now compatible with fftshift.
    
    m = ceil(n / 2) - 1;
    f = [0:m, m - n + 1:-1] / n * fs;
end
