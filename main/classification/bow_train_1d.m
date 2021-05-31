function model = bow_train_1d(x, k, distance_function)
    %BOW_TRAIN_1D Bag-of-words training (centre extraction) for 1-D feature vectors
    %
    %   model = BOW_TRAIN_1D(x) applies the k-means algorithm to extract a
    %   set of feature vector centres which can be used to create
    %   histograms with BOW_APPLY_1D. Input x is a matrix containing the
    %   dataset, with feature vectors as rows. The extracted centres are
    %   returned in c (again as rows), as a field of model.
    %
    %   model = BOW_TRAIN_1D(x, k) specifies the number of centres to
    %   output (i.e. the rows of y). Default value is 10% of x (i.e.
    %   k = round(0.1 * size(k, 1)).
    %
    %   model = BOW_TRAIN_1D(x, k, distance_function) also specifies the
    %   distance function (default is euclidian distance). Note that the
    %   function should be able to compute distances of one point from
    %   multiple ones (see specifications of DISTFUN for pdist).
    %
    %   See also BOW_TRAIN_2D.
    
    % Input argument handling
    if nargin < 2
        k = round(0.1 * size(x, 1));
    end
    
    % Useful variables
    n = size(x, 2);  % feature vector length
    
    % Model initialization
    model.c = nan([k, n]);
    model.k = k;
    
    % Main part
    if nargin < 3
        idx = kmeans(x, k);
    else
        idx = kmeans(x, k, distance_function);
    end
    
    for i = 1:k
        b = idx == i;
        model.c(i, :) = mean(x(b, :));
    end
end
