function yhat = gksmoothing(x, y, xhat, beta, distance_function, block_size)
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
    %
    %   yhat = GKSMOOTHING(x, y, xhat, beta_distance_function, block_size)
    %   breaks xhat into blocks of block_size length. Use if you run out of
    %   memory. Default value is 0 (no blocks). You can also pass 'auto' to
    %   let the function decide a reasonable block_size (targeted for 16GB
    %   RAM computers).

    % Input arguments handling
    if nargin < 4
        beta = 1;
    end
    if nargin < 5
        distance_function = @euclidean_distance;
    end
    if nargin < 6
        block_size = 0;
    end
    
    % Initialization
    n = size(xhat, 1);
    m = size(y, 2);
    denom = 2 * beta^2;
    
    if block_size == 0
        block_size = n;
    elseif strcmp(block_size, 'auto')
        block_size = round(3e8 / size(x, 1));
    else
        yhat = nan([n m]);
    end
    
    % Main part
    for i = 1:ceil(n / block_size)
        idx = (1 + (i - 1) * block_size):(min([i * block_size, n]));
        %d = pdist2(xhat(idx, :), x, distance_function);
        fh = @(x) exp(-distance_function(x).^2 / denom);
        k = pdist2(xhat(idx, :), x, fh);
        % k = exp(-d.^2 / denom);
        yhat(idx, :) = bsxfun(@rdivide, k * y, sum(k, 2));
    end
end
