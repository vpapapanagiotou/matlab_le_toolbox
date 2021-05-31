function b = is_unique(ix)
    %IS_UNIQUE Compute uniqueness booleans
    %
    %   b = IS_UNIQUE(ix) computes a boolean column vector indicating
    %   uniqueness. Input argument ix should be the third output argument of
    %   MATLAB's UNIQUE function.

    b = false(size(ix));
    
    [n, x] = hist(ix, unique(ix));
    
    for i = reshape(x(n == 1), 1, [])
        b(ix == i) = true;
    end
    
end
