function v = trimmed_std(x, trim_perc, wsize, wstep)
    %TRIMMED_STD Standard deviation estimation from windows with outlier trimming. 
    %
    %   v = TRIMMED_STD(x) is the std value of the elements of x, estimated
    %   from windows over x.
    %
    %   v = TRIMMED_STD(x, trim_perc) specifies the percentage to trim
    %   (default is 0.1, corresponding to 10% from the top and 10% from the 
    %   bottom).
    %
    %   v = TRIMMED_STD(x, trim_perc, wsize) also specifies the window
    %   length that is used in estimation (default is selected so that 8
    %   windows can be obtained with 50% overlap).
    %
    %   v = TRIMMED_STD(x, trim_perc, wsize) also specifies the window step
    %   (default is half of wsize).
    
    % Useful variables
    n = length(x);
    
    % Input argument handling
    if nargin < 2
        trim_perc = 0.1;
    end
    if nargin < 3
        wsize = floor(n / 9) * 2;
    end
    if nargin < 4
        wstep = floor(wsize / 2);
    end
    
    % Bufferize input
    X = buffer(x, wsize, wsize - wstep, 'nodelay');
    if rem(n - wsize, wstep) ~= 0
        X(:, end) = [];
    end
    
    % Compute std
    v = std(X);
    
    % Trim
    v = trimmed_mean(v, [], trim_perc);
end
