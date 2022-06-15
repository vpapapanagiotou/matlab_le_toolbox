function rgb = nice_colors(clr)
    
    if strcmp(clr, 'blue')
        rgb = [0.0000 0.4470 0.7410];
    elseif strcmp(clr, 'red')
        rgb = [0.8500 0.3250 0.0980];
    elseif strcmp(clr, 'yellow')
        rgb = [0.9290 0.6940 0.1250];
    elseif strcmp(clr, 'magenta')
        rgb = [0.4940 0.1840 0.5560];
    elseif strcmp(clr, 'green')
        rgb = [0.4660 0.6740 0.1880];
    elseif strcmp(clr, 'cyan')
        rgb = [0.3010 0.7450 0.9330];
    elseif strcmp(clr, 'purple')
        rgb = [0.6350 0.0780 0.1840];
    else
        error(['Unknown color: ' clr])
    end
end
