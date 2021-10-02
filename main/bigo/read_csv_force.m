function x = read_csv_force(file_name)
    
    x = readtable(file_name, 'Delimiter', ',');
    
    variable_names = x.Properties.VariableNames;
    for i = 1:length(variable_names)
        if ~isempty(strfind(variable_names{i}, '_timestamp'))
            % unix timestamp column
            x{:, i} = unixt2matlab(x{:, i});
            
        elseif strcmp(variable_names{i}, 'timestamp')
            % ISO8601 timestamp column
            [x.utc_timestamp, x.local_timestamp] = arrayfun(@decode_iso8601_timestamp, x{:, i});
            
        end
    end

end
