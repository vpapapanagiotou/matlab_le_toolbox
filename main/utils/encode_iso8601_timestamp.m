function timestamp = encode_iso8601_timestamp(t, tz_sec)
    %ENCODE_ISO8601_TIMESTAMP Encodes (formats) a timestamp to ISO8601
    %
    %   timestamp = DECODE_ISO8601_TIMESTAMP(t) formats a timestamp to
    %   ISO8601 specification. Since MATLAB timestamps are
    %   time-zone--agnostic, timezone is set to '+00:00'.
    %
    %   timestamp = DECODE_ISO8601_TIMESTAMP(t, tz_sec) allows to specify
    %   the timezone offest (in seconds).
    
    
    if nargin < 2
        tz = '+00:00';
    else
        tz_days = in_days(tz_sec, 'sec');
        t = t + tz_days;
        
        s = repmat('+', size(t));
        s(tz_sec < 0) = '-';
        tz = [s, datestr(abs(tz_days), 'HH:MM')];
    end
    
    timestamp = [datestr(t, 'yyyy-mm-ddTHH:MM:SS.FFF'), tz];
end
