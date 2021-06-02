function x = colored_noise(n, color)
    %COLORED_NOISE Generate random samples with colored distribution
    %
    %   x = COLORED_NOISE(n, color) returns a row vector of 'n' samples whose
    %   distribution is defined by 'color'. Parameter 'color' can be any of
    %   'blue', 'violet', 'brownian', 'pink'.

    % Prepare psd function
    if strcmp(color, 'blue')
        psd = @(x) sqrt(x);
    elseif strcmp(color, 'violet')
        psd = @(x) x;
    elseif strcmp(color, 'brownian')
        psd = @(x) 1 ./ x;
    elseif strcmp(color, 'pink')
        psd = @(x) 1 ./ sqrt(x);
    end
    
    x_white = fft(randn([1, n]));
    
    s = abs(dftfreqs(n, 1));
    s = psd(s);
    s(isinf(s)) = 0;
    s = s / sqrt(mean(s.^2));
    
    x_colored = x_white .* s;
    
    x = ifft(x_colored);
    x = real(x);
end
