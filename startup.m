function startup()
    
    % cwd = [pwd() filesep()];
    cwd = mfilename('fullpath');
    cwd = cwd(1:end-7);
    le_paths = genpath([cwd 'main']);
    
    le_paths_list = strsplit(le_paths, ';');
    if length(le_paths_list) == 1
        le_paths_list = strsplit(le_paths, ':');
    end
    
    disp(['Adding to path (under ' cwd '):'])
    for i = 1:length(le_paths_list) - 1  % last is always empty
        disp(['    ' le_paths_list{i}(length(cwd) + 1:end)])
        addpath(le_paths_list{i})
    end
end
