function loc = read_location_bin(file_name)
    
    %% Setup
    % accuracy: float
    % altitude: double
    % bearing: float
    % elapsed: long
    % latitude: double
    % longitude: double
    % speed: float
    % time zone: long
    
    long_bytes = 8;
    float_bytes = 4;
    double_bytes = 8;
    
    record_size = 2 * long_bytes + 3 * float_bytes + 3 * double_bytes;
    
    %% Get file info for preallocation
    info = dir(file_name);
    if rem(info.bytes, record_size) ~= 0 && ~silent
        warning('ignoring some bytes')
    end
    
    n = round(info.bytes / record_size);
    loc.accuracy = nan([n, 1]);
    loc.altitude = nan([n, 1]);
    loc.bearing = nan([n, 1]);
    loc.elapsed_realtime_nanos = nan([n, 1]);
    loc.latitude = nan([n, 1]);
    loc.longitude = nan([n, 1]);
    loc.speed = nan([n, 1]);
    loc.time_zone_offset = nan([n, 1]);  % TODO - add unit to name
    
    %% Parsing loop
    h = fopen(file_name, 'rb', 'ieee-be');
    try
        for i = 1:n
            loc.accuracy(i) = fread(h, [1, 1], 'single');
            loc.altitude(i) = fread(h, [1, 1], 'double');
            loc.bearing(i) = fread(h, [1, 1], 'float');
            loc.elapsed_realtime_nanos(i) = fread(h, [1, 1], 'int64');
            loc.latitude(i) = fread(h, [1, 1], 'double');
            loc.longitude(i) = fread(h, [1, 1], 'double');
            loc.speed(i) = fread(h, [1, 1], 'single');
            loc.time_zone_offset(i) = fread(h, [1, 1], 'int64');
        end
    catch ME
        if ~silent
            disp(ME)
        end
    end
    fclose(h);
    
    loc = struct2table(loc);
    
    if nargout > 2
        nb = info.bytes;
    end       
end
