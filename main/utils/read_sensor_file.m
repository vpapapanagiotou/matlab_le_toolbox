function [t, x, nb] = read_sensor_file(file_name, noof_channels, value_type, silent)
    %READ_SENSOR_FILE Parse binary sensor data
    %
    %   [t, x] = READ_SENSOR_FILE(file_name) parses the binary file
    %   specified by filename and returns the timestamps in vector t (in
    %   nanoseconds from device boot time) and the sensor channels as
    %   columns in matrix x. The first timestamp of t corresponds to the
    %   timestamp implied by the filename. 
    %
    %   ... = READ_SENSOR_FILE(file_name, noof_channels) specifies the
    %   number of time-series of the sensor (e.g. 3 for triaxial
    %   accelerometer, see Android documentation, default 3).
    %
    %   ... = READ_SENSOR_FILE(file_name, noof_channels, value_type) also
    %   specifies the data type (default 'single'). 
    %
    %   ... = READ_SENSOR_FILE(file_name, noof_channels, value_type,
    %   silent) also specifies if warnings/errors should be displayed
    %   (default true).
    %
    %   https://developer.android.com/reference/android/hardware/SensorEvent.html#values
    
    %% Input argument handling
    if nargin < 4
        silent = true;
    end
    if nargin < 3
        value_type = 'single';
    end
    if nargin < 2
        noof_channels = 3;
    end
    
    %% Setup
    if strcmp(value_type, 'single')
        sensor_value_size = 4;
    elseif strcmp(value_type, 'double')
        sensor_value_size = 8;
    else
        error(['Unknown sensorValueType ''' value_type ''''])
    end
    
    record_size = 8 + noof_channels * sensor_value_size;
    
    %% Get file info for preallocation
    info = dir(file_name);
    if rem(info.bytes, record_size) ~= 0 && ~silent
        warning('ignoring some bytes')
    end
    
    n = round(info.bytes / record_size);
    t = nan([n, 1]);
    x = nan([n, 3]);

    %% Parsing loop
    h = fopen(file_name, 'rb', 'ieee-be');
    try
        for i = 1:n
            t(i, 1) = fread(h, [1, 1], 'int64');
            x(i, :) = fread(h, [1, noof_channels], value_type);
        end
    catch ME
        if ~silent
            disp(ME)
        end
    end
    fclose(h);
    
    if nargout > 2
        nb = info.bytes;
    end
end
