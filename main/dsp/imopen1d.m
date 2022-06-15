function y = imopen1d(x, m, shift)
    %IMOPEN1D performs morphological opening on 1D signals using a flat structure element
    %
    % y = IMOPEN1D(x, m) performs the morphological opening on the signal x
    % using a flat structure element of length m.
    %
    % y = IMOPEN1D(x, m, shift) can change the default behaviour for
    % structure elements of even length (default shift = false).
    
    if nargin < 3
        shift = false;
    end
    
    y = x;
    y = erode1d(y, m, shift);
    y = dilate1d(y, m, shift);
end
