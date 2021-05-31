function y = padcellarray(x)
    % Taken from the internet. Could be wrong.
    
    first_cols = @(M, n) M(:, 1:n);
    pad2n = @(M, n) first_cols([M, zeros(size(M, 1), n)], n);
    width_needed = max(cellfun(@(M) size(M, 2), x));
    y = cellfun(@(M) pad2n(M, width_needed), x, 'uniform', 0);
end
