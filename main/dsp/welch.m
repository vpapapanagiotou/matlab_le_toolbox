function S = welch(x, wsize, wstep)
    %WELCH Computes spectrum based on Welch
    %
    %   S = WELCH(x, wsize, fwtstep) computes the signal x spectrum. For
    %   the estimation, FFT is computed on windows of wsize with a step of
    %   wstep.
    
    n = length(x);
    notused = rem(n - wsize, wstep);
    
    if notused > 0
        warning(['The last ' num2str(notused) ...
            ' samples of x will not be used for estimation'])
        x(end - notused + 1:end) = [];
    end
    
    S = buffer(x, wsize, wsize - wstep, 'nodelay');
    S = bsxfun(@minus, S, mean(S));
    S = bsxfun(@times, S, hamming(wsize));
    S = fft(S);
    S = abs(S).^2;
    S = mean(S, 2);
