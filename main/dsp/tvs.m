function [S, wsize, IDX] = tvs(x, ftwsize, ftwstep, ftn, wstep)
    %TVS Computes the Time Varying Spectrum
    %
    %   S = TVS(x, ftwsize, ftwstep, ftn, wstep) computes the time varying
    %   spectrum of signal x, using Welch spectrum estimator. For spectrum
    %   estimation, FFT is computed on windows of ftwsize samples, with a
    %   step of ftwstep samples. A total of ftn windows are used to
    %   estimate the spectrum. The spectrum is estimated every wstep
    %   samples.
    %
    %   [S, wsize] = TVS(...) also returns the window size (in samples)
    %   used for spectrum estimation.
    %
    %   [S, wsize, IDX] = TVS(...) also returns the indices corresponding
    %   to the center of the windows in which spectrum is estimated.
    
    % Welch spectrum estimator window size
    wsize = ftwsize + (ftn - 1) * ftwstep;
    
    if length(x) < wsize
        error('x is too short')
    end
    
    % TVS windows
    % n = fix((length(x) - wsize) / wstep) + 1;
    n = fix((length(x) - wsize + wstep) / wstep);
    
    notused = length(x) - (n - 1) * wstep - wsize;
    if notused > 0
        warning(['The last ' num2str(notused) ...
            ' samples of x will not be used for estimation'])
    end
    
    S = zeros(ftwsize, n);
    
    % Sliding window
    for i = 1:n
        idx = (i - 1) * wstep + (1:wsize);
        S(:, i) = welch(x(idx), ftwsize, ftwstep);
    end
    
    % Timestamps
    IDX = (0:n - 1) * wstep + fix(wsize / 2);
end
