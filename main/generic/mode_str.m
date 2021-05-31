function s = mode_str(strs)
    %MODE_STR Mode for cell-array of strings
    %
    %   s = MODE_STR(strs) returns the most frequent string in the
    %   cell-array of strings strs. It relies on HIST_STR.
    
    [n, x] = hist_str(strs);
    [~, idx] = max(n);
    s = x(idx);
end
