function D = dir2(directory_name, absolute_names)
    %DIR2 Wrapper for MATLAB's dir function
    %
    %   D = DIR2(directory_name) should function exactly the same as
    %   MATLAB's DIR function, however it should not return current and
    %   parent folder entries.
    %
    %   D = DIR2(directory_name, absolute_path) specifies if the 'name'
    %   fields should contain the absolute filepath (default false).
    
    if nargin < 1
        directory_name = '.';
    end
    
    if nargin < 2
        absolute_names = false;
    end
    
    D = dir(directory_name);
    
    del = false(size(D));
    for i = 1:length(D)
        del(i) = strcmp(D(i).name, '.') ||  strcmp(D(i).name, '..');
    end
    D(del) = [];
    
    if absolute_names
        idx = strfind(directory_name, filesep());
        abs_path = directory_name(1:idx(end));
        for i = 1:length(D)
            D(i).name = [append_filesep(abs_path) D(i).name];
        end
    end
end
