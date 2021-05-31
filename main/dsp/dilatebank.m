function y = dilatebank(x,m,k)
    %DILATEBANK Create a bank of consecutive dilations
    %
    %   y = DILATEBANK(x, m, k) dialtes signal x with a structure element
    %   of ones with lengh m. The result is eroded again with the same
    %   structure element. A total of k dilations are performed, and are
    %   returned as columns in y.
    
    N = length(x);
    y = zeros(N, k);
    
    shifts = false(k, 1);
    
    if rem(m, 2) == 0
        % Length of structure element is even, need for corrections
        shifts(2:2:end) = true;
    end
    
    yd = x(:);
    for i = 1:k
        yd = dilate1d(yd, m, shifts(i));
        y(:, i) = yd;
    end
end
