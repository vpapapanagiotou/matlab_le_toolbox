function fs = estimate_fs(t)
    %ESTIMATE_FS Estimate sampling frequency based on timestamps
    %
    %   fs = ESTIMATE_FS(t) estimates the sampling frequnecy (in Hz) from
    %   an array of timetamps 't' (in sec).
    
    dt = sort(diff(t));
    n = length(dt);
    i1 = max([1, round(.1 * n)]);
    i2 = min([n, round(.9 * n)]);
    fs = 1 / mean(dt(i1:i2));
end
