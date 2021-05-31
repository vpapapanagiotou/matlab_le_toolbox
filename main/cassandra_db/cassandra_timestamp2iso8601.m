function t = cassandra_timestamp2iso8601(ct)
    
    t = ct;
    
    if isempty(t)
        return
    end
    
    if iscell(t)
        if numel(t) ~= 1
            error('Can''t handle arrays')
        end
        t = t{1};
    end
    
    t(11) = 'T';
    t = [t(1:end - 2) ':' t(end - 1:end)]';
    t = reshape(t, 1, []);
end
