function user_list = txtfile2cellstr(file_name)

    u = readtable(file_name, 'ReadVariableNames', false);
    u = u.Var1;
    u = sort(u);
    
    if nargout == 0
        disp(u)
    else
        user_list = u;
    end
end
