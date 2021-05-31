function a = trimmed_mean(x, dim, trim_low, trim_high)
    %TRIMMED_MEAN Average or mean value with outlier trimming
    %
    %   a = TRIMMED_MEAN(x) is the mean value of the elements of x. The smallest
    %   and largest values (10% each) are excluded from the computation.
    %
    %   a = TRIMMED_MEAN(x, dim) takes the mean along the dimension dim of x.
    %
    %   a = TRIMMED_MEAN(x, dim, trim_low) specifies the percentage to trim for
    %   the lowest values (default is 0.1, corresponding to 10%).
    %
    %   a = TRIMMED_MEAN(x, dim, trim_low, trim_high) also specifies the
    %   percentage to trim for the largest values (default is equal to
    %   trim_low).
    
    % Input argument handling
    if nargin < 2 || isempty(dim)
        if isrow(x)
            dim = 2;
        else
            dim = 1;
        end
    end
    if nargin < 3
        trim_low = 0.1;
    end
    if nargin < 4
        trim_high = trim_low;
    end
    
    % Useful variables
    n = size(x, dim);
    i1 = round(n * trim_low);
    i2 = round(n * (1 - trim_high));
    
    % Main
    if n < 10
        a = mean(x, dim);
    else
        x = sort(x, dim);
        a = mean(x(i1:i2), dim);
    end
end
