function i = fnsd(x)
    %FNSD First non-singleton dimesion
    %
    %   i = FNSD(x) returns the index of the first non-singleton dimension
    %   of x.
    
    i = find(size(x) > 1, 1);
end
