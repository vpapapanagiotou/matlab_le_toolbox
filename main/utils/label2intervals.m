function [idx, t_ss, t_l] = label2intervals(t, l)
    %LABEL2INTERVALS Convert a time-series of labels to a list of start-stop
    %internvals with labels.
    %
    %   idx = LABEL2INTERVALS(t, l) converts a time-series of labels (timestamps
    %   in column vector t, labels in column vector l, vectors have equal
    %   length) to a a set of start-stop intervals, stored as rows in two-column
    %   matrix idx. Matrix idx contains the indices for each segment; each
    %   segment has the same label in all its samples, i.e. 
    %      l(idx(i, 1):idx(i, 2))
    %   contains the same values. Also, no consequtive intervals have the same
    %   label (maximality).
    %
    %   [idx, t_ss] = LABEL2INTERVALS(t, l) also returns a matrix with
    %   start-stop timestamps, i.e. t_ss = t(idx).
    %
    %   [idx, t_ss, t_l] = LABEL2INTERVALS(t, l) also returns a vector with
    %   the label of each segment, i.e. t_l = l(idx(:, 1)).
    

    % Ensure columns
    t = t(:);
    l = l(:);
    
    % Initialize states
    idx = [1, nan];
    n = 1;
    
    % Loop t
    for i = 2:length(t)
        if l(i) == l(i - 1)
            % Same label, continue in time
            continue
        end
        
        idx(n, 2) = i - 1;
        n = n + 1;
        idx(n, 1:2) = [i, nan];
    end
    
    idx(end, 2) = length(t);
    
    if nargout > 1
        t_ss = t(idx);
        
        % Special case handling
        if size(idx) == [1, 2]
            t_ss = reshape(t_ss, 1, 2);
        end
    end
    if nargout > 2
        t_l = l(idx(:, 1));
    end
end
