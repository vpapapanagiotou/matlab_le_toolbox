function [n, x] = hist_str(strs)
    %HIST_STR Histogram of cell-array of strings
    %
    %   [n, x] = HIST_STR(strs) computes a histogram for the strings
    %   contained in the cell-array str. Vector n contains the histogram
    %   values, while cell-array x contains the unique strings.

    x = unique(strs);
    n = zeros(size(x));
    
    for i = 1:length(n)
        n(i) = sum(strcmp(strs, x{i}));
    end
end
