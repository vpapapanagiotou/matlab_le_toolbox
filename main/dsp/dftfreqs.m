function f = dftfreqs(n, fs)
    %DFTFREQS Analog frequencies of DFT
    %
    %   f =  DFTFREQS(n, fs) computes the corresponding analog frequencies
    %   (in Hz) for a DFT of a signal with n samples and sampling frequency
    %   fs.
    %
    %   Note - it is now compatible with fftshift.
    
    if rem(n, 2) == 1
        m = floor(n / 2);
        f = [0:m, -m:-1] / m * fs / 2;
    else
        m = floor(n / 2);
        f = [0:m - 1, -m:-1] / m * fs / 2;
    end
end
