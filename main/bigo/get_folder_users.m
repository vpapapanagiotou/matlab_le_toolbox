function users = get_folder_users(folder)
    %GET_FOLDER_USERS Get a list of users from a folder

    file_list = dir2(folder);
    users = cell(size(file_list));
    for i = 1:length(file_list)
        users{i} = file_list(i).name;
    end
end
