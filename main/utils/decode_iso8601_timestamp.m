function [utc, lcl] = decode_iso8601_timestamp(t)
    %DECODE_ISO8601_TIMESTAMP Decodes a timestamp to UTC and local-time MATLAB timestamps
    %
    %   [utc, lcl] = DECODE_ISO8601_TIMESTAMP(t) decodes an
    %   ISO8601-formatted string into UTC and local-time timestamps (using
    %   MATLAB representation). 
    
    if isempty(t)
        utc = [];
        lcl = [];
        return
    end
    
    if iscell(t)
        if numel(t) == 1
            t = t{1};
        else
            error('Cannot handle cell arrays')
        end
    end
    
    t0 = t;
    
    t = remove_locale(t);
    
    [dt, tz] = split_datetime_timezone(t);

    lcl = iso8601_to_datenum(dt);
    tz = timezone_in_days(tz);  % tz is not ISO8601, but the code is the same
    
    utc = lcl - tz;
end


function t = remove_locale(t)
    % Remove locale if it exists
    idx = strfind(t, '[');
    if length(idx) == 1
        t = t(1:idx - 1);
    elseif length(idx) > 1
        error(['Cannot handle ''', t, ''''])
    end
end


function [dt, tz] = split_datetime_timezone(t)
    
    % Handle 'Z' first, to avoid problems
    if strcmp(t(end), 'Z')
        dt = t(1:end - 1);
        tz = '+00:00';
        return
    end
    
    % Find timezone start using '+' or '-'   
    idx1 = strfind(t(end - 5:end), '+');
    idx2 = strfind(t(end - 5:end), '-');

    % There should only be only one '+' or '-'
    if length(idx1) + length(idx2) ~= 1
        error(['Cannot handle ''', t, ''''])
    end

    % Get index of split
    idx = length(t) - 6 + [idx1, idx2];
    
    dt = t(1:idx - 1);
    tz = t(idx:end);
end


function dt = iso8601_to_datenum(dt)
    dt(strfind(dt, 'T')) = ' ';
    dt = datenum(dt);
end


function a = timezone_in_days(tz)
    hours = str2double(tz(1:3));
    minutes = str2double(tz(end - 1:end));
    
    a = (hours + minutes / 60) / 24;
end
