function stream = create_stream(t, xyz, allow_split, method, fs)
    %CREATE_STREAM Create a stream or array of streams from raw data
    %
    %   stream = CREATE_STREAM(t, xyz) creates a stream from raw data. Raw data
    %   are given in a [n x 1] vector that contains timestamps and a [n x 3]
    %   matrix that contains the three channels.
    %
    %   stream = CREATE_STREAM(t, xyz, allow_split) specifies if raw data can be
    %   split to multiple streams based on sampling frequency (each stream
    %   contains samples at an approximately constant sampling rate). Default is
    %   false.
    %
    %   stream = CREATE_STREAM(t, xyz, allow_split, method, fs) specifies a
    %   method to resample data (using linear interpolation) at a target
    %   frequency (each stream is resampled independently if allow_split is
    %   true). Available methods are:
    %     'raw'     : data are not changed (stream.fs = [])
    %     'estimate': sampling frequency is estimated using ESTIMATE_FS
    %     'aisf'    : sampling frequency is set to approximated ISF (obtained by
    %                 SPLIT_FS); this is only available when allow_split == true
    %     'custom'  : sampling frequency is set to fs
    %  Note that fs is only used if method is 'custom'; in all other cases it
    %  will be ignored and a warning will be displayed.
    
    %% Input argument handling
    if nargin < 3
        allow_split = false;
    end
    if nargin < 4
        method = 'estimate';
    end
    if nargin < 5
        if strcmp(method, 'custom')
            error('You must set a target fs for ''custom'' method')
        else
            fs = nan;
        end
    else
        if ~strcmp(method, 'custom')
            warning('Setting fs for mode '' method '' is not supported, input value will be ignored')
        end
    end
    
    %% First part
    [t, idx] = unique(t);
    xyz = xyz(idx, :);
   
       
    %% Main part
    % Select approprite sub-method based on allow_split option
    if allow_split
        stream = create_array(t, xyz, method, fs);
    else
        stream = create_single(t, xyz, method, fs);
    end
end

function streams = create_array(t, xyz, method, fs)
    % Create an array of streams based on SPLIT_FS, with option to resample
    % (linear interpolation) at a specific frequency.
    %
    % Option 'method' can be:
    %   'raw'     : data are not changed, fs is empty.
    %   'estimate': sampling frequency is estimated using ESTIMATE_FS, data are
    %               linearly interpolated to achieve estimated fs.
    %   'aisf'    : sampling frequency is set to approximated ISF, data are
    %               linearly interpolated to achieve AISF.
    %   'custom'  : sampling frequency is provided in 4-th input argument, data
    %               are linearly interpolated to achieve custom fs.
    
    [aisf, segments] = split_fs(t);
    
    for i = size(segments, 1):-1:1
        idx = segments(i, 1):segments(i, 2);
        
        % Handle new methods first
        if strcmp(method, 'aisf')
            method0 = 'custom';
            fs0 = aisf(idx(1));
        else
            method0 = method;
            fs0 = fs;
        end
        
        % Create array element
        streams(i) = create_single(t(idx), xyz(idx, :), method0, fs0);
    end
end

function stream = create_single(t, xyz, method, fs)
    % Create a single stream with the entire data, with option to resample
    % (linear interpolation) at a specific frequency.
    %
    % Option 'method' can be:
    %   'raw'     : data are not changed, fs is empty.
    %   'estimate': sampling frequency is estimated using ESTIMATE_FS, data are
    %               linearly interpolated to achieve estimated fs.
    %   'custom'  : sampling frequency is provided in 4-th input argument, data
    %               are linearly interpolated to achieve custom fs.

    if strcmp(method, 'raw')
        stream = create_single_raw(t, xyz);
    elseif strcmp(method, 'estimate')
        stream = create_single_fs(t, xyz, estimate_fs(t));
    elseif strcmp(method, 'custom')
        stream = create_single_fs(t, xyz, fs);
    else
        error(['Unknown method: ' method])
    end
end

function stream = create_single_raw(t, xyz)
    % Create a single stream with the entire data, without changing anything.
    stream.t = t;
    stream.x = xyz(:, 1);
    stream.y = xyz(:, 2);
    stream.z = xyz(:, 3);
    stream.fs = [];
end

function stream = create_single_fs(t, xyz, fs)
    % Create a single stream with the entire data, interpolated at fs.
    fs = round(fs);

    try    
        stream.t = (t(1):1 / fs:t(end))';
    catch ME
        disp(ME)
        stream = [];
        return
    end

    if length(stream.t) < 2
        stream = [];
        return
    end
    
    stream.x = interp1(t, xyz(:, 1), stream.t, 'linear');
    stream.y = interp1(t, xyz(:, 2), stream.t, 'linear');
    stream.z = interp1(t, xyz(:, 3), stream.t, 'linear');
    stream.fs = fs;
end
