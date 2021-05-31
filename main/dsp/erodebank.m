function y = erodebank(x, m, k)
    %ERODEBANK Create a bank of consecutive erosions
    %
    %   y = ERODEBANK(x, m, k) erodes signal x with a structure element of
    %   ones with lengh m. The result is eroded again with the same
    %   structure element. A total of k erosions are performed, and are
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
        yd = erode1d(yd, m, shifts(i));
        y(:, i) = yd;
    end
end
