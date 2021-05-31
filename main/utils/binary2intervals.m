function x = binary2intervals(t, b)
    %BINARY2INTERVALS Convert a binary signal to a list of start-stop timestamps
    %
    %   x = BINARY2INTERVALS(t, b) converts a binary singal to start-stop
    %   timestamps. Input arguments t and b must be column vectors of equal
    %   length; t contains the timestamps and b contains the binary value (0 or
    %   1).
    
    %% Some checks
    if isempty(t)
        x = [];
        return
    end
    
    %% Initialisation
    % Ensure columns
    t = t(:);
    b = b(:);
    
    %% Checks
    % Ensure only two values in b: 0 and 1
    b = double(b);
    if length(b(b == 1 | b == 0)) ~= length(b)
        error('binary input contains invalid values')
    end
    
    % Ensure equal length
    if length(t) ~= length(b)
        error('t and b must be of equal length')
    end
    
    %% Main part
    % Find changes
    db = diff(b);
    
    Ipos = find(db == +1) + 1;
    Ineg = find(db == -1);
    I = sort([Ipos(:); Ineg(:)]);
    
    t2 = t(I);
    b2 = b(I);
    
    if b(1)
        t2 = [t(1); t2];
    end
    if b(end)
        t2 = [t2; t(end)];
    end
    
    %% Form output and return
    x = reshape(t2, 2, [])';
end
