function date = get_sensor_stream_date(file_name)
    %GET_SENSOR_STREAM_DATE Infer start timestamp (date + time) based on
    %file name. Used internally by 'read_sensor_stream'.
    
    i = strfind(file_name, filesep());
    if ~isempty(i)
        file_name = file_name(i(end) + 1:end);
    end
    
    i = strfind(file_name, '_');
    i = i(end);
    s = file_name(i + 1:end);
    
    year = str2double(s(1:4));
    month = str2double(s(5:6));
    day = str2double(s(7:8));
    hour = str2double(s(9:10));
    minute = str2double(s(11:12));
    second = str2double(s(13:14));
    
    date = datenum(year, month, day, hour, minute, second);

end
