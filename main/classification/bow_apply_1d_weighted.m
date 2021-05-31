function y = bow_apply_1d_weighted(model, x, w, distance_function)
    %BOW_APPLY_1D_WEIGHTED Bag-of-words prediction (voting) for 1-D weighted feature vectors
    %
    %   model = BOW_APPLY_1D_WEIGHTED(model, x, w) applies the bag-of-words
    %   model and computes the normalized histograms of feature vectors of
    %   x. Input model is the model returned by BOW_TRAIN_1D, matrix x
    %   contains the feature vectors as rows, and vector w contains the
    %   weights of the feature vectors. If w is empty, all weights are set
    %   equal to 1.
    %
    %   model = BOW_APPLY_1D_WEIGHTED(model, x, w, distance_function) also
    %   specifies the distance function (default is Euclidian distance).
    %   Note that the function should be able to compute distances of one
    %   point from multiple ones (see specifications of DISTFUN for pdist).
    
    % Useful variables
    n = size(x, 1);  % number of feature vectors to apply
    
    % Pre-allocation
    y = zeros([1, model.k]);
    
    % Input argument handling
    if isempty(w)
        w = ones([size(x, 1), 1]);
    end

    % Main part
    if nargin < 4
        d = pdist2(model.c, x);
    else
        d = pdist2(model.c, x, distance_function);
    end
    [~, idx] = min(d);
    
    % Weighted histogram
    for i = 1:length(idx)
        ii = idx(i);
        y(ii) = y(ii) + w(i);
    end
    
    y = y / sum(y);
end
