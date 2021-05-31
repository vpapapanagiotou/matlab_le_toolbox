function disp_test_result(test_name, b)
    if b
        disp([test_name, ': pass'])
    else
        disp([test_name, ': fail'])
    end
end
