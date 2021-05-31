function y = normalize_features_apply(x, model)
    %NORMALIZE_FEATURES_APPLY Apply a feature normalization model
    %
    %   y = NORMALIZE_FEATURES_APPLY(x, model) applies a feature
    %   normalization model to a feature matrix x and returns the
    %   normalized features in y. Both x and y contain feature vectors as
    %   rows.
   
    if strcmp(model.type, 'linear')
        y = x;
        y = bsxfun(@minus, y, model.a);
        y = bsxfun(@rdivide, y, model.b);
    
    else
        error('Unknown model type')
        
    end
end