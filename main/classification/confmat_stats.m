function s = confmat_stats(cm)
    
    s.accuracy = sum(diag(cm)) / sum(sum(cm));
    s.precision = bsxfun(@rdivide, diag(cm), sum(cm, 1)');
    s.recall = bsxfun(@rdivide, diag(cm), sum(cm, 2));
end
