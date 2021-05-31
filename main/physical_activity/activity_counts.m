function [counts, t] = activity_counts(stream, method, fs_target, wsize_sec, wstep_sec)
    %ACTIVITY_COUNTS Actigraph's counts (loose interpretation by lebill)
    %
    %   counts = ACTIVITY_COUNTS(stream) extracts Actigraph's counts from
    %   accelerometer data. The algorithm is a loose interpretation by
    %   lebill, since no complete and clear description of the processing
    %   can be found online. Note that this version uses the 'sum-of-abs'
    %   approach.
    %
    %   Argument 'stream' contains a stream of accelerometer data and is a
    %   struct with the following fields: 
    %      x : n x 1 vector of x-axis samples
    %      y : n x 1 vector of y-axis samples
    %      z : n x 1 vector of z-axis samples
    %      fs: sampling frequency    
    %   
    %   Optional arguments:
    %      method   : normalisation method, can be 'none', 'length', or
    %                 'actigraph' (default)
    %      fs_target: resample stream to this frequency before computing
    %      wsize_sec: window size
    %      wstep_sec: window step
    %
    %   Based on the following sources
    %   - https://actigraph.desk.com/customer/en/portal/articles/2515580-what-are-counts-
    %   - https://www.ncbi.nlm.nih.gov/pubmed/28604558
    %   - http://jap.physiology.org/content/100/4/1324.short
    
    if nargin < 2
        method = 'actigraph';
    end
    if nargin < 3
        fs_target = 10;  % Hz
    end
    if nargin < 5
        wsize_sec = 60;  % sec
        wstep_sec = 60;  % sec
    end
    
    % Simple check
    if size(stream.x, 2) ~= 1
        error('''stream''''s fields must be column vectors, not row vectors')
    end
    
    % First, compute total acceleration in g
    a = sqrt(sum(stream.x.^2 + stream.y.^2 + stream.z.^2, 2)) / 9.81;
    a = filter_magnitude_stream(a);
    
    % Resampling
    if isnan(fs_target)
        fs = stream.fs;
    else
        fs = fs_target;
        a = resample(a, fs_target, stream.fs);
    end
   
    % Filtering
    Woff = 0.25;  % Hz
    Wp = [0.29, 1.66];  % Hz
    Ws = Wp + [-Woff, +Woff];  % Hz
    Rp = 1;  % dB
    Rs = 3;  % dB
    
    [butter_n, butter_Wn] = buttord(2 * Wp / fs, 2 * Ws / fs, Rp, Rs);
    [filter_B, filter_A] = butter(butter_n, butter_Wn);
    a = filter(filter_B, filter_A, a);
   
    % Windowing
    wsize = fix(wsize_sec * fs);
    wstep = fix(wstep_sec * fs);
    
    % Vectorized impementation
    A = buffer(a, wsize, wsize - wstep, 'nodelay');
    counts = sum(abs(A))';
    
    % Normalisation
    if strcmp(method, 'none')
        % Do nothing
    elseif strcmp(method, 'length')
        counts = counts / wsize;
    elseif strcmp(method, 'actigraph')
        counts = counts / fs / 0.001664;
    else
        error('Unknown normalisation type')
    end
    
    % Additional output (timestamps)
    if nargout >= 2
        t = wsize_sec / 2 + (0:length(counts) - 1)' * wstep_sec;
    end
end
