function [x, y] = rocpoints(x, y)
    %ROCPOINTS prepare data points for ROC plot
    %
    %   [x, y] = ROCPOINTS(x, y) processes a set of data points and returns
    %   the points needed to plot the ROC curve directly.
    
    % Remove duplicates
    xy = [x(:), y(:)];
    xy = unique(xy, 'rows');
    x = xy(:, 1);
    y = xy(:, 2);
    
    % Paretto front
    del = false(size(x));
    for i = 1:length(x)
        xt = x;
        xt(i) = [];
        yt = y;
        yt(i) = [];
        b = x(i) <= xt & y(i) <= yt;
        del(i) = sum(b) > 0;
    end
    
    % Remove samples that are not in Paretto front
    x(del) = [];
    y(del) = [];
    
    % Sort
    [x, I] = sort(x);
    y = y(I);
    
    % Remove invalid (nan) points
    I = isnan(x) | isnan(y);
    x(I) = [];
    y(I) = [];
    
    % Prepare for plot
    x = kron(x(:), [1; 1]);
    y = kron(y(:), [1; 1]);
    x(end) = [];
    y(1) = [];
    
    x = [0; x; x(end)];
    y = [y(1); y; 0];

end
