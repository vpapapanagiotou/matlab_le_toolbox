function t = unixt2matlab(unix_millis)
    %UNIXT2MATLAB Convert unix timestamps to MATLAB timestamps
    %
    %   t = UNIXT2MATLAB(unix_millis)
    
    a = 24 * 60 * 60 * 1000;
    b = datenum(1970, 1, 1);
    
    t = unix_millis / a + b;
end
