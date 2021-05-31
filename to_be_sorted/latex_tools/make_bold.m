function bold = make_bold(x, method)

bold = false(size(x));

if strcmp(method, 'none')
    
elseif strcmp(method, 'colmax')
    for i = 1:size(x, 2)
        mx = max(x(:, i));
        I = x(:, i) == mx;
        bold(I, i) = true;
    end
   
else
    error('bad method')
    
end