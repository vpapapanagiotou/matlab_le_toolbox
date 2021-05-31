function c = setcartesian2(a, b)
    %SETCARTESIAN2 Cartesian product of 2 sets
    
    if ~iscell(a) || ~iscell(b)
        error('Input sets must be cell arrays')
    end
    
    na = numel(a);
    nb = numel(b);
    
    A = repmat(a(:), 1, nb);
    B = repmat(b(:)', na, 1);
    
    c = bsxfun(@(x, y) [x, y], A, B);
end
