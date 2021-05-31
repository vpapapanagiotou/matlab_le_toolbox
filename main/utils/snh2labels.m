function [t, l] = snh2labels(t, l, q)
    %SNH2LABELS Convert sample-and-hold signal to labels
    %
    %   [t, l] = SHN2LABELS(t, l) converts a sample-and-hold signal to a label
    %   signal.
    %
    %   [t, l] = SHN2LABELS(t, l, q) specifies the time quantization step q
    %   that is used to add new sample points (default is 1e3 * eps()).
    
    if nargin < 3
        q = 1e3 * eps();
    end
    
    t = [t; t(2:end) - q];
    l = [l; l(1:end-1)];
    [t, idx] = sort(t);
    l = l(idx);
end
