function r = make_row(x, bold)

if nargin == 1
    bold = false(size(x));
end

r = [];

for i = 1:length(x)
    if bold(i)
        r = [r '\mathbf{' x{i} '} & '];
    else
        r = [r x{i} ' & '];
    end
end
r(end - 1:end) = '\\';
