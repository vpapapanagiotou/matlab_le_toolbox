function host_name = get_host_name()
    
    [status, result] = system('hostname');
    
    if status ~= 0
        error('Error getting hostname')
    end
    
    host_name = result(1:end - 1);
end
