function [utc, lcl] = decode_iso8601_timestamp(ts)
    %DECODE_ISO8601_TIMESTAMP Decodes a timestamp to UTC and local-time MATLAB timestamps
    %
    %   [utc, lcl] = DECODE_ISO8601_TIMESTAMP(ts) decodes an ISO8601-formatted
    %   string into UTC and local-time timestamps (using MATLAB representation).
    
    if isempty(ts)
        utc = [];
        lcl = [];
        return
    end
    
    if iscell(ts)
        ts = ts{1};
    end
    
    s1 = ts(1:19);  % main timestamp (no millis)
    s2 = ts(end - 5:end);  % timezone
    if length(ts) > 25
        s3 = ts(20 + (1:length(ts) - 26));  % millis
    else
        s3 = '0';
    end

    % Timezone handling
    s2a = str2double([s2(1) '1']);
    s2b = str2double(s2(2:3));
    s2c = str2double(s2(5:6));
    tz = s2a * datenum(0, 0, 0, s2b, s2c, 0);
    
    lcl = datenum(s1, 'yyyy-mm-ddTHH:MM:SS');
    lcl = lcl + in_days(str2double(s3), 'millis');

    utc = lcl - tz;
end
