function [D, V] = fractaldim(x, wsize, wstep, m, k)
    %FRACTALDIM Fractal Dimension (and variance) of signal
    %
    %   [D, V] = FRACTALDIM(x, wsize, wstep, m, k) computes the Fractal
    %   Dimension (end variance) of signal x. The Fractal Dimension is
    %   computed for windows of wsize samples, with a step of wstep
    %   samples. A structure element of m samples is used for the first
    %   level of dilation-erosion, and a total of k levels are computed.
    %
    %   NOTE For the n-th level, the structure element length is
    %   n * (m - 1) + 1.
    
    % Number of windows
    n = ceil((length(x) - wsize + 1) / wstep);
    
    % Preallocate
    D = zeros(n, 1);
    V = zeros(n, 1);
    
    dilx = dilatebank(x, m, k);
    erox = erodebank(x, m, k);
    arex = dilx - erox;
    clear dilx
    clear erox
    
    lvl = gradient(log((1:k) *(m - 1) + 1));
    
    % Slidding window
    buffi = 1:wsize;
    for i = 1:n
        % Window indices
        idx = (i - 1) * wstep + buffi;
        
        % Variance of window
        V(i) = var(x(idx));
        if V(i) == 0
            warning(['V(' num2str(i) ') == 0, and so D(' num2str(i) ') will be 0 too'])
            D(i) = 0;
            continue
        end
        
        % Fractal Dimension
        a = arex(idx, :) / sqrt(V(i));
        lsa = log(sum(a));
        
        % Adelo's method
        D(i) = 2 - mean(gradient(lsa) ./ lvl);
        
        % Simple method
        % D(i, 2) = 2 - mean(diff(lsa) ./ diff(log(1:k))));
        
        % Linear fitting
        % p = polyfit(log(1:k), lsa, 1);
        % D(i, 3) = 2 - p(1);
    end

end
