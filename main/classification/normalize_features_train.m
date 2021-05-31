function model = normalize_features_train(x, mode)
    %NORMALIZE_FEATURES_TRAIN Create a feature normalization model
    %
    %   model = NORMALIZE_FEATURES_TRAIN(x) creates a model for feature
    %   normalization. The model can then be used with
    %   NORMALIZE_FEATURES_APPLY.
    %
    %   model = NORMALIZE_FEATURES_TRAIN(x, mode) specifies the
    %   normalization mode; it can be 'linear' (default) or 'z').
   
    if nargin < 2
        mode = 'linear';
    end

    model.mode = mode;
    
    if strcmp(mode, 'linear')
        model.type = 'linear';
        model.a = min(x);
        model.b = max(x) - model.a;
        
    elseif strcmp(mode, 'z')
        model.type = 'linear';
        model.a = mean(x);
        model.b = std(x);
        
    else
        error(['Unknown mode: ' mode])
        
    end
end
