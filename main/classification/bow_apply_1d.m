function y = bow_apply_1d(model, x, distance_function)
    %BOW_APPLY_1D Bag-of-words prediction (voting) for 1-D feature vectors
    %
    %   y = BOW_APPLY_1D(model, x) applies the bag-of-words model and
    %   computes the normalized histograms of feature vectors of x. Input 
    %   model is the model returned by BOW_TRAIN_1D, and matrix x contains
    %   the feature vectors as rows. Output matrix y has the same rows as
    %   x, and each row is the normalized histogram of the corresponding
    %   feature vector (of x) on the model centers.
    %
    %   y = BOW_APPLY_1D(model, x, distance_function) also specifies the
    %   distance function (default is Euclidian distance). Note that the
    %   function should be able to compute distances of one point from
    %   multiple ones (see specifications of DISTFUN for pdist).
    
    % Updated to rely on BOW_APPLY_1D_WEIGHTED
    if nargin < 3
        y = bow_apply_1d_weighted(model, x, []);
    else
        y = bow_apply_1d_weighted(model, x, [], distance_function);
    end
    
    %% Old version bellow
%     % Useful variables
%     n = size(x, 1);  % number of feature vectors to apply
%     
%     % Pre-allocation
%     y = zeros([1, model.k]);
% 
%     % Main part
%     if nargin < 3
%         d = pdist2(model.c, x);
%     else
%         d = pdist2(model.c, x, distance_function);
%     end
%     [~, idx] = min(d);
%     
%     for i = idx
%        y(i) = y(i) + 1; 
%     end
%     
%     y = y / sum(y);
end
