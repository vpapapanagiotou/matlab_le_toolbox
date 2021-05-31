function stream = assert_stream_fs(stream)
    %ASSERT_STREAM_FS Makes sure that the stream has a valid sampling frequency
    
    if ~isempty(stream.fs) 
        if ~isempty(stream.fs) && ~isnan(stream.fs) && ~isinf(stream.fs)
            % stream already has an 'fs', do nothing
            return
        end
    end
    
    warning('stream.fs is empty, estimating with ''estimate_fs()''')
    
    if isempty(stream.t)
        error('stream.t is also empty, can''t estimate fs')
    end
    
    stream.fs = estimate_fs(stream.t);
end
