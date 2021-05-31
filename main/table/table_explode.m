function y = table_explode(x, col)
    
    % Input argument handling
    if ischar(col)
        col_i = find(strcmp(x.Properties.VariableNames, col));
        if numel(col_i) ~= 1
           error(['Column ''' col ''' not found'])
        end
    else
        col_i = col;
    end
    
    % Size of x
    n = height(x);
    m = length(x.Properties.VariableNames);
    
    % Non-exploded columns
    cols_i = setdiff(1:m, col_i);
    
    % Squeeze and get length of each explosion
    lens = nan([n, 1]);
    for i = 1:n
        x{i, col_i}{1} = squeeze(x{i, col_i}{1});
        lens(i) = size(x{i, col_i}{1}, 1);
    end
    total_len = sum(lens);
    d = size(x{1, col_i}{1}, 2);
    
    % Initialize table
    y = x;
    y.exploded_col = cell([n, 1]);
    
    % Main part
    i1 = 1;  % current row of x
    e1 = 1;  % current item of i1-th row of x
    for i2 = total_len:-1:1  % current row of y
        for j = cols_i
            y{i2, j} = x{i1, j};
        end
        y.exploded_col{i2} = [x{i1, col_i}{1}(e1, :)];
        
        e1 = e1 + 1;
        if e1 > lens(i1)
            e1 = 1;
            i1 = i1 + 1;
        end
    end
    y = flipud(y);
    
    % Re-order columns
    new_cols = 1:m;
    new_cols(col_i) = m + 1;
    col_name = y.Properties.VariableNames{col_i};
    y = y(:, new_cols);
    y.Properties.VariableNames{col_i} = col_name;
end
