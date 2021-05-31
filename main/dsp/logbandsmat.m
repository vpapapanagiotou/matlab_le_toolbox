function I = logbandsmat(fI, f, extend)
    %LOGBANDSMAT Create a transformation matrix from all frequencies to
    %logband frequencies
    
    % Input argument handling
    if nargin < 3
        extend = false;
    end
    
    % Prepare input
    fI = fI(:);
    f = f(:);
    
    % Extend bands to +/- infinity if required
    if extend
        fI = [-Inf; fI(:); +Inf];
    end
    
    % Initialize matrix
    I = false(length(f), length(fI) - 1);
    
    for i = 1:length(fI) - 1
        b = fI(i) < f & f <= fI(i + 1);
        I(b, i + 1) = true;
    end
    
    emptybands = sum(I) == 0;
    I(:, emptybands) = [];
end
