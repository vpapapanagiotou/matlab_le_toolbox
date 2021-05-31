function t = cassandra_timestamp2matlab(t)

    % Do nothing on empty input
    if isempty(t)
        return
    end
    
    % Determine if working on a single timestamp or a cell array
    is_cell = iscell(t);
    
    % Convert to cell array if required
    if ~is_cell
        t = {t};
    end
    
    % Main part
    t = main(t);
    
    % Convert back to single timestamp if required
    if ~is_cell
        t = t{1};
    end
end

function t = main(t)
    t = cellfun(@transform_t, t);
end

function t = transform_t(t)
    if length(t) >= 19
        t = datenum(t(1:19));
    elseif strcmp(t, '')
        t = nan;
    else
        error(['Unknown t: ' t])
    end
end
