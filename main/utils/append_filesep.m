function y = append_filesep(x)
    %APPEND_FILESEP Safely adds a filesep() to a string
    %
    %   y = APPEND_FILESEP(x) Appends a trailing slash '/' (or '\') at path
    %   x, and returns the result. If x already ends with a filesep(),
    %   no extra filesep() is appended.
    
    % Init
    fsep = filesep();
    
    % Main
    if length(x) < length(fsep)
        % x is too short to have fsep already appended
        % So simply append and return
        y = [x fsep];
    else
        % First, get the last part of x
        test = x(end - length(fsep) + 1:end);
        % Check if fsep exists
        if strcmp(test, fsep)
            % x already contains fsep, so no need to do anything
            y = x;
        else
            y = [x fsep];
        end
    end
    
end
