function y = fmt_perc(x, n)
    %FMT_PERC Format (with rounding) for percentage values
    %
    %   y = FMT_PERC(x) rounds all values in x and multiplies by 100.
    %
    %   y = FMT_PERC(x, n) rounds to n decimal digits (default is 2).
    
    % Input argument handling
    if nargin < 2
        n = 2;
    end
    
    % Rounding & percentage
    y = 100 * round(x, n);
end
    
