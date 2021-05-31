function b = is_numerical(x)
    
    b = false;
    
    if isempty(x)
        return
    end
    
    if sum(isnan(x)) > 0
        return
    end
    
    if sum(isinf(x)) > 0
        return
    end
    
    % All checks failed, so x is indeed numerical!
    b = true;
end
