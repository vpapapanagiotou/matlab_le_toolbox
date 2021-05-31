function tz_str = format_timezone_offset(t_days)
   
    if numel(t_days) ~= size(t_days, 1)
        error('Input should be a number or a column vector')
    end
    
    s = repmat('+', length(t_days), 1);
    s(t_days < 0) = '-';
    
    tz_str = [s datestr(abs(t_days), 'HH:MM')];
end