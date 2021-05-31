function [y, model] = normalize_features(x, mode)
    %NORMALIZE_FEATURES Apply normalization to each feature of a feature matrix
    %
    %   y = NORMALIZE_FEATURES(x, mode) normalizes each feature of feature
    %   matrix x. Matrix x contains feature vectors as rows, and mode
    %   specifies the normalization mode (can be 'linear' or 'z'). The
    %   normalized features are returned in matrix y.
    %
    %   y = NORMALIZE_FEATURES(x, model) applies the normalization based on
    %   the model.
    %
    %   [y, model] = NORMALIZE_FEATURES(...) also returns the model. The
    %   model can be used to apply the same normalization to other feature
    %   matrices.
    
    if isa(mode, 'char')
        if strcmp(mode, 'linear')
            [a, b, y] = apply_linear(x);
        elseif strcmp(mode, 'z')
            [a, b, y] = apply_z(x);
        else
            error(['Unknown mode: ' mode])
        end
        
        if nargout > 1
            model.a = a;
            model.b = b;
        end
        
    else
        model = mode;
        y = x;
        y = bsxfun(@minus, y, model.a);
        y = bsxfun(@rdivide, y, model.b);
        
    end
end


function [a, b, x] = apply_linear(x)
    a = min(x);
    x = bsxfun(@minus, x, a);
    b = max(x);
    x = bsxfun(@rdivide, x, b);
end
    
    
function [a, b, x] = apply_z(x)
    a = mean(x);
    x = bsxfun(@minus, x, a);
    b = std(x);
    x = bsxfun(@rdivide, x, b);
end
