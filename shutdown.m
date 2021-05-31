le_paths = genpath('main');
cwd = [pwd() filesep()];

le_paths_list = strsplit(le_paths, ';');
if length(le_paths_list) == 1
    le_paths_list = strsplit(le_paths, ':');
end

disp(['Removing from path (under ' cwd '):'])
for i = 1:length(le_paths_list) - 1  % last is always empty
    disp(['    ' le_paths_list{i}])
    rmpath([cwd le_paths_list{i}])
end

clear cwd
clear i
clear le_paths
clear le_paths_list
