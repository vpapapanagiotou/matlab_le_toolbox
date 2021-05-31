function yhat = gksmoothing(x, y, xhat, beta, distance_function)
    %GKSMOOTHING Gaussian kernel smoothing
    %
    %   yhat = GKSMOOTHING(x, y, xhat) Gaussian kernel smoothing for
    %   observations (x, y). Computes values at xhat. Matrixes x and xhat
    %   contain the points as rows; y must be a column vector.
    %
    %   yhat = GKSMOOTHING(x, y, xhat, beta) specifies parameter beta of
    %   Gaussian kernel (default 1).
    %
    %   yhat = GKSMOOTHING(x, y, xhat, beta, distance_function) also
    %   specifies the distance function (default is euclidian distance).
    %   Note that the function should be able to compute distances of one
    %   point from multiple ones (see specifications of DISTFUN for pdist).
    
    % Input arguments handling
    if nargin < 5
        distance_function = @euclidean_distance;
    end
    if nargin < 4
        beta = 1;
    end
    
    % Main part
    n = size(xhat, 1);
    m = size(y, 2);
    yhat = nan([n, m]);
    denom = 2 * beta^2;
    
    for i = 1:n
        % Compute kernel
        d = distance_function(xhat(i, :), x);
        k = exp(-d.^2 / denom);
        % Compute result
        yhat(i, :) = k' * y / sum(k);
    end
end
