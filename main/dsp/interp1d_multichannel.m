function vq = interp1dmc(x, v, xq, method)
    %INTERP1DMC Multi-channel 1D interpolation
    %
    %   vq = INTERP1DMC(x, v, xq) interpolates to find vq, the values of the
    %   underlying function v=f(x) at the query points xq.
    %
    %   Input x must be a column vector. Input y must be a matrix with equal
    %   number for rows as the length of x. Each column of y is treated as an
    %   independent channel.
    %
    %   Input xq specifies the query points at which to evalute. If xq is a
    %   number, it is treated as a target sampling frequency (where x is the
    %   time). If xq is negative, input points (x) are also included in xq.
    %
    %   vq = INTERP1DMV(..., method) also specifies the interpolcation method
    %   (see INTERP1D). Default is 'linear'.
    
    % Input argument handling
    if isequal(size(xq), [1 1])
        xq0 = xq;
        fs = abs(xq);
        xq1 = min(xq0):1 / fs:max(xq0);
        if fs > 0
            xq = xq1;
        elseif fs < 0
            xq = unique([xq0; xq1]);
        else
            error('When xq is used to provide fs, it cannot be 0')
        end
    end
    if nargin < 4
        method = 'linear';
    end

    % Useful variables
    n = size(x, 1);
    m = size(y, 2);
    
    % Pre-allocation
    vq = nan([n, m]);
    
    % Main interpolation
    for i = 1:m
        vq(:, i) = interp1(x, v(:, i), xq, method);
    end
end
