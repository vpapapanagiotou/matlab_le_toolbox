function [t, X] = interp1gaps(t, X, target_fs, min_gap, method)
    %INTERP1GAPS 1-D Interpolation only in signal gaps
    %
    %   [t, X] = interp1gaps(t, X, target_fs, min_gap) interpolates when
    %   there are gaps larger than min_gap seconds in the timestamps t.
    %   [t, X] = interp1gaps(t, X, target_fs, min_gap, method) specifies
    %   the interpolation method. See INTERP1 for possible options.
    
    % Input argument handling
    if nargin < 5
        f = @(x, v, xq) interp1(x, v, xq);
    else
        f = @(x, v, xq) interp1(x, v, xq, method);
    end
    
    % Initialization
    dt = 1 / target_fs;  % sec

    % Main work
    idx = find(diff(t) >= min_gap);
    
    for i = 1:length(idx)
        % Interpolate
        t_q = t(idx(i)) + dt:dt:t(idx(i) + 1) - T;
        % X_q = repmat(X(idx(i), :), [length(t_q), 1]);
        X_q = f(t(idx(i):idx(i) + 1), X(idx(i):idx(i) + 1, :), t_q);
        
        % Append
        t = [t; t_q'];
        X = [X; X_q];
    end
    
    [t, idx] = sort(t);
    X = X(idx, :);
end
