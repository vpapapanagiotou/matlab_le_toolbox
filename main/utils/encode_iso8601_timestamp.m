function s = encode_iso8601_timestamp(t)
    %ENCODE_ISO8601_TIMESTAMP Encodes (formats) a timestamp to ISO8601
    %
    %   s = DECODE_ISO8601_TIMESTAMP(t) formats a timestamp to ISO8601
    %   specification. Since MATLAB timestamps are time-zone--agnostic,
    %   timezone is set to '+00:00'.
    
    s = datestr(t, 'yyyy-mm-ddTHH:MM:SS.FFF+00:00');
end
