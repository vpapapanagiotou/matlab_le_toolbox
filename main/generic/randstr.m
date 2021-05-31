function x = randstr(sz, imax)
    %RANDSRT Random string generator
    %
    %   x = RANDSTR(sz, imax) creates a cell array of random strings. The
    %   cell array size is sz. Variable imax defines the length of each
    %   string: if imax is a number, each string has a random length of
    %   1:imax. If imax is a two-element vector, each string has a random
    %   length of imax(1):imax(2). To obtain strings of fixed length k use
    %   imax=[k k].
    %
    %   The random strings contain english letters (low and upper cases)
    %   and numbers.
    
    x = cell(sz);
    
    for i = 1:numel(x)
        x{i} = randstr1(imax);
    end
end


function s = randstr1(IMAX)
    symbols = ['a':'z' 'A':'Z' '0':'9'];
    
    len = randi(IMAX);
    nums = randi(numel(symbols), [1 len]);
    s = symbols (nums);
end
