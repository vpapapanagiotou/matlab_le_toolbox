function yd = dilate1d(x, m, shift)
    %DILATE1d Dilation using a flat structure element
    %
    %   yd = DILATE1d(x, m) dilates signal x with a structure elementn of
    %   ones with length m.
    %
    %   yd = DILATE1D(x, m, shift) can change the default behaviour for
    %   structure elements of even length (default shift = false).

    if nargin == 2
        shift = false;
    end
    
    a = ceil((m - 1) / 2);
    b = m - 1 - a;
    if shift
        a = a - 1;
        b = b + 1;
    end
    
    xe = [zeros(a, 1); x(:); zeros(b,1)];
    N = length(xe);
    
    y = buffer(xe, N - m + 1, N - m, 'nodelay');
    yd = max(y, [], 2);
    
end
