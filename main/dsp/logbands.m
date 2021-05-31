function fI = logbands(f1, f2, n)
    %LOGBANDS Group frequencies into log bands
    %
    %   fI = LOGBANDS(f1, f2, n) splits frequencies from f1 to f2 into n
    %   log bands. Note that it should be 0 < f1 < f2.
    
    if f1 <= 0
        error('f1 should be greater than zero')
    end
    if f1 >= f2
        error('f1 should be smaller than f2')
    end
    
    lf1 = log(f1);
    lf2 = log(f2);
    fI = exp(lf1:(lf2 - lf1) / n:lf2);
    fI([1 end]) = [f1 f2];
end
