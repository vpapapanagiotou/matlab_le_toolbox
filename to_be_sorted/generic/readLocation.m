function [t, ll, br] = readLocation(filename)
    %READLOCATION Parse binary location data
    %
    %   [t, ll, br] = READLOCATION(filename) parses the binary file
    %   specified by filename, and returns the location data in 'll'
    %   (longtitude and latittude as columns); 't' contains the timestamps
    %   in nanoseconds since the device boot, and 'br' contains the
    %   bearing.
    %
    %   https://developer.android.com/reference/android/location/Location.html
    
    % Constants
    long_bytes = 8;
    float_bytes = 4;
    double_bytes = 8;
    
    % Initalization
    fileinfo = dir(filename);
    rec_len = long_bytes + 2 * double_bytes + float_bytes;
    n = fileinfo.bytes / rec_len;
    
    % Preallocate
    t = nan([n, 1]);
    ll = nan([n, 2]);
    br = nan([n, 1]);
    
    % Parse
    fid = fopen(filename, 'rb', 'ieee-be');
    for i = 1:n
        t(i) = fread(fid, 1, 'int64');
        ll(i, :) = fread(fid, 2,'double');
        br(i) = fread(fid, 1, 'single');
    end
    fclose(fid);
    
end
