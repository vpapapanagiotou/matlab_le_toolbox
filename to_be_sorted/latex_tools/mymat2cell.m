function c = mymat2cell(x, prec)

% c = mat2cell(x, ones([1 size(x, 1)]), ones([1 size(x, 2)]));

frmt = ['$%1.' num2str(prec) 'f$'];

for i = 1:size(x, 1)
    for j = 1:size(x, 2)
        c{i, j} = sprintf(frmt, x(i, j));
    end
end
