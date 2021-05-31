function l = dbscan(x, eps, min_pts, distance_function, border_points)
    %DBSCAN Density-based spatial clustering of applications with noise
    %
    %   l = DBSCAN(x, eps) applies the DBSCAN algorithm on a set
    %   of points x; x is a matrix that contains points as rows. Parameters
    %   eps and min_pts are used to define the required density for
    %   direct-density connectivity. Returns a column vector l which
    %   contains the label (cluster insted) for each point of x.
    %
    %   Label specifications
    %      nan: undefined (should never appear as output)
    %        0: noise
    %        1: cluster 1
    %       -1: border point of cluster 1
    %        2: cluster 2
    %       -2: border point of cluster 2
    %      ...: ...
    %
    %   l = DBSCAN(..., min_pts) specifies the minimum number of points required
    %   for core points (default = size(x, 2) + 1)).
    %
    %   l = DBSCAN(..., min_pts, distance_function) also specifies the distance
    %   function (default is euclidian distance). Note that the function should
    %   be able to compute distances of one point from multiple ones (see
    %   specifications of DISTFUN for pdist).
    %
    %   l = DBSCAN(..., min_pts, distance_function, border_points) also
    %   specifies whether border points should be marked separately (default =
    %   true). You can use l = abs(l) to revert this effect.
    %
    %   https://en.wikipedia.org/wiki/DBSCAN
    
    
    % Argument handling
    if nargin < 5
        border_points = true;
    end
    if nargin < 4
        distance_function = @euclidean_distance;
    end
    if nargin < 3
        min_pts = size(x, 2) + 1;
    end
    
    % Initialization
    n = size(x, 1);  % Number of points
    l = nan([n, 1]);  % Labels
    c = 0;  % Cluster counter
    
    for i = 1:n
        % Skip if already processed
        if ~isnan(l(i))
            continue
        end
        
        % Find neighbors
        idx = range_query(x, i, eps, distance_function);
        
        % Density check, label as noise if required
        if length(idx) < min_pts
            l(i) = 0;
            continue
        end
        
        % Create a new cluster label
        c = c + 1;
        
        % Label initial point
        l(i) = c;
        
        % Process idx
        jj = 0;
        while jj < length(idx)
            jj = jj + 1;
            j = idx(jj);
            
            % Change noise to border point
            if l(j) == 0
                l(j) = -c;
            end
            
            % Previously processed
            if ~isnan(l(j))
                continue
            end
            
            % Label neighbor
            l(j) = c;
            % Find neighbors
            idx2 = range_query(x, j, eps, distance_function);
            % Density check, add new neighbors to seed set if required
            if length(idx2) >= min_pts
                idx2 = setdiff(idx2, idx);
                idx = [idx; idx2];
            end
        end
    end
    
    % Border points
    if ~border_points
        l = abs(l);
    end
end

function idx = range_query(x, i, eps, distance_function)
    d = distance_function(x(i, :), x);
    idx = find(d <= eps);
    idx = setdiff(idx, i);
end
