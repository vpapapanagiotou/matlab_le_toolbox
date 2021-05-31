function [t, x, date, toff] = read_sensor_stream(fnmask, abspath, noof_channels, value_type, silent)
    %READ_SENSOR_STREAM Parse multile binary sensor data files
    %
    %   [t, x] = READ_SENSOR_STREAM(fnmask) parses all files with file-name
    %   matching "*fnmask*.bin", and returns the relative timestamps in
    %   vector t (in seconds) and the sensor channels as colums in matrix
    %   x. The first timestamp is always 0.
    %
    %   ... = READ_SENSOR_STREAM(fnmask, abspath) parses all files in
    %   absolute path abspath.
    %
    %   .. = READ_SENSOR_STREAM(fnmask, abspath, noof_channels) also
    %   specifies the number of sensor channels (e.g. 3 for triaxial
    %   accelerometer, see Android documentation, default 3).
    %
    %   ... = READ_SENSOR_STREAM(fnmask, abspath, noof_channels,
    %   value_type) also specifies  the data type (default 'single').
    %
    %   ... = READ_SENSOR_STREAM(fnmask, abspath, noof_channels,
    %   value_type, silent) also specifies if warnings/errors should be
    %   displayed (default true).
    %
    %   [t, x, date] = READ_SENSOR_STREAM(...) also detects the start
    %   timestamp (date & time) based on the file name of the first file of
    %   the stream.
    %
    %   [t, x, date, toff] = READ_SENSOR_STREAM(...) also returns the
    %   actual timestamp of the first sample. This is the number of
    %   nanoseconds ellapsed since device boot.
    %
    %
    %   https://developer.android.com/reference/android/hardware/SensorEvent.html#values
        
    %% Input argument handling
    if nargin < 5
        silent = 4;
    end
    if nargin < 4
        value_type = 'single';
    end
    if nargin < 3
        noof_channels = 3;
    end
    if nargin < 2
        abspath = '.';
    end

    %% Init
    t = [];
    x = [];
    toff = [];
    date = [];
    abspath = append_filesep(abspath);
    
    %% Find files
    file_list = dir([abspath '*' fnmask '*.bin']);
    n = length(file_list);
    if n == 0 && ~silent
        warning('No files found')
        return
    end
    
    %% Parsing loop
    nb_total = 0;
    for i = 1:n
        if ~silent
            disp(['Reading file ' num2str(i) ' from ' num2str(n)])
        end
        [file_t, file_x, nb] = read_sensor_file([abspath file_list(i).name], noof_channels, value_type);
        t = [t; file_t];
        x = [x; file_x];
        nb_total = nb_total + nb;
    end
    if ~silent
        disp(['  read a total of ' num2str(nb_total) ' bytes'])
    end
    
    if isempty(t)
        return
    end
    
    %% Sort and normalize time
    [t, idx] = sort(t);
    x = x(idx, :);
    t1 = t(1);
    t = (t - t1) * 1e-9;

    %% Date
    if nargout >= 3
        date = get_sensor_stream_date([abspath file_list(1).name]);
    end
    
    %% Time offset
    if nargout >= 4
        toff = t1 * 1e-9;
    end
end
