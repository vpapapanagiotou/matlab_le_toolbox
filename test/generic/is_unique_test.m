x.x = {'a', 'b', 'c', 'b', 'd', 'e'}';

[~, ~, ix] = unique(x.x);
x.b = is_unique(ix);

struct2table(x)