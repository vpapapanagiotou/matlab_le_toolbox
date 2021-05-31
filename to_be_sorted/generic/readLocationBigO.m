function data = readLocationBigO(filename)
    %READLOCATIONBIGO Parse binary location data (BigO version)
    %
    %   data = READLOCATIONBIGO(filename) parses the binary file
    %   specified by filename, and returns a data structure.
    %
    %   https://developer.android.com/reference/android/location/Location.html
    %
    %   Binary structure
    %     float  : accuracy
    %     double : altitude
    %     float  : bearing
    %     long   : elapsedRealTimeNanos
    %     double : latitude
    %     double : longitude
    %     float  : speed
    %     long   : timezone
    
    % Constants
    long_bytes = 8;
    float_bytes = 4;
    double_bytes = 8;
    
    % Initalization
    fileinfo = dir(filename);
    rec_len = 1 * long_bytes + 3 * double_bytes + 3 * float_bytes;
    n = floor(fileinfo.bytes / rec_len);
    
    if n * rec_len < fileinfo.bytes
        warning(['File size is not what it should be (', ...
            num2str(fileinfo.bytes - n * rec_len), ' bytes were not used)'])
    end
    
    % Preallocate
    data.accuracy = nan([n, 1]);
    data.altitude = nan([n, 1]);
    data.bearing = nan([n, 1]);
    data.latitude = nan([n, 1]);
    data.longitude = nan([n, 1]);
    data.speed = nan([n, 1]);
    data.local_time = nan([n, 1]);
    % data.time_zone = nan([n, 1]);
    
    start_time = get_datenum(fileinfo.name);
    
    % Parse
    fid = fopen(filename, 'rb', 'ieee-be');
    for i = 1:n
        % long   : fread(fid, 1, 'int64');
        % double : fread(fid, 1, 'double');
        % float  : fread(fid, 1, 'single');
        data.accuracy(i) = fread(fid, 1, 'single');
        data.altitude(i) = fread(fid, 1, 'double');
        data.bearing(i) = fread(fid, 1, 'single');
        data.local_time(i) = fread(fid, 1, 'int64');
        data.latitude(i) = fread(fid, 1, 'double');
        data.longitude(i) = fread(fid, 1, 'double');
        data.speed(i) = fread(fid, 1, 'single');
        % data.time_zone(i) = fread(fid, 1, 'int64');
    end
    fclose(fid);

    % Work on timestamps
    % Remove initial offset
    data.local_time = data.local_time - data.local_time(1);
    % Convert to (from nanos)
    data.local_time = 1e-9 * data.local_time / 60 / 60 / 24;
    % Add start time
    data.local_time = data.local_time + start_time;
end

function t = get_datenum(filename)
    t = datenum(...
        str2double(filename(10:13)), ...
        str2double(filename(14:15)), ...
        str2double(filename(16:17)), ...
        str2double(filename(18:19)), ...
        str2double(filename(20:21)), ...
        str2double(filename(22:23)) ...
        );
end
