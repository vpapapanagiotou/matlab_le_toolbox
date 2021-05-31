function y = lemoment(x, lags, sqrtE)
    %LEMOMENT Moment of x
    %
    %   y = LEMOMENT(x, lags) Computes any order moment of x, for any lags.
    %   The order of the moment is equal to length(lags) + 1. Array lags
    %   contains the lags that are used in the computation of the cumulant,
    %   and should be non-negative.
    %
    %   y = LEMOMENT(x, lags, sqrtE) uses the pre-computed square root of
    %   the energy of x. Default is sqrt(sum(x .* x)).
    
    if nargin == 2
        sqrtE = sqrt(sum(x .* x));
    end
    
    n = length(lags);
    idx = 1:length(x) - max(lags);
    
    X = zeros(n + 1, length(idx));
    X(1, :) = x(idx);
    for i = 1:n
        X(i + 1, :) = x(lags(i) + idx);
    end
    
    y = mean(prod(X));
    y = y / sqrtE^(n + 1);
end
