function fI = logbands2(fmax, n, fmin, base)
%LOGBANDS2 
%
%   fI = LOGBANDS2(fmax, n)


    % Input argument handling
    if nargin < 3
        fmin = 0;
    end
    if nargin < 4
        base = 2;
    end

    % Error handling
    if fmax <= 0
        error('fmax should be greater than zero')
    end
    if fmin < 0
        error('fmin should be greater than or equal to zero')
    end
    if fmin >= fmax
        error('fmin should be less than fmax')
    end

    % Main part
    fI = [fmin, nan([1, n - 1]), fmax];
    r = fmax - fmin;
    for i = n:-1:2
        r = r / base;
        fI(i) = fmin + r;
    end
end
