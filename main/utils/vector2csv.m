function s = vector2csv(x, prec)
    
    if isempty(x)
        s = '';
        return
    end

    if nargin < 2
        s = num2str(x(1));
        for i = 2:length(x)
            s = [s ', ' num2str(x(i))];
        end
    else
        s = num2str(x(1), prec);
        for i = 2:length(x)
            s = [s ', ' num2str(x(i), prec)];
        end
    end
end
