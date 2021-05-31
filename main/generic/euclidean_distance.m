function d = euclidean_distance(x0, x)
    %EUCLEDIAN_DISTANCE Euclidean distance
    d = sqrt(sum(bsxfun(@minus, x, x0).^2, 2));
end
