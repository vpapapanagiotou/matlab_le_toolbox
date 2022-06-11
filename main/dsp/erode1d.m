function ye = erode1d(x, m, shift)
    %ERODE1D Erosion using a flat structure element
    %
    %   ye = ERODE1D(x, m) erodes signal x with a structure element of
    %   ones with length m.
    %
    %   ye = ERODE1D(x, m, shift) can change the default behaviour for
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
    
    xe = [zeros(a, 1); x(:); zeros(b, 1)];
    N = length(xe);
    
    y = buffer(xe, N - m + 1, N - m, 'nodelay');
    ye = min(y, [], 2);
    
end
