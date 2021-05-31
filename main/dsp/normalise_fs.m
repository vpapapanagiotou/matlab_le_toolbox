function [x, fs, t_offset] = normalise_fs(t, x)
    %NORMALISE_FS Resample loosly sampled data to fixed sampling frequency
    %
    %   [y, fs] = NORMALISE_FS(t, x) normalises sampling frequency of data
    %   in 'x' with timestamps in 't'. Argument 'x' can be a vector (for
    %   1-channel signals) or a matrix (for multi-channel signals, each
    %   signal is stored as column).  It returns in 'y' the new sample
    %   values, and in 'fs' the fixed sampling rate.
    %
    %   Data are interpolated in a best-guess sampling frequency based on
    %   't'. Also, timestamps in 't' should start at 0; if not, 't' is
    %   offseted.
    %
    %   [x, fs, t_offset] = NORMALISE_FS(t, x) also returns the time offset.
    
    
    fs = round(estimate_fs(t));
    
    t_offset = t(1);
    t = t - t_offset;
    
    t_new = 0:1/fs:t(end);
    
    x = interp1(t, x, t_new, 'linear');
end
