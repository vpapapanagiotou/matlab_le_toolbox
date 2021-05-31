function s = sessions_from_folders(file_list, device_id)

    s = nan([length(file_list), 1]);
    k = length(num2str(device_id)) + 2;
    
    for i = length(file_list):-1:1
        s(i) = str2double(file_list(i).name(k:end));
    end
    
    s = sort(s);
end
