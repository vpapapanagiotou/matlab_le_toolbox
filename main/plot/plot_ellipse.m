function h = plot_ellipse(x, y, a, b, n_points, clr, line_width)
    %PLOT_ELLIPSE Plots an ellipse on a figure
    %
    %   h = PLOT(x, y, a, b) plots an ellipse on a figure with centre at (x, y),
    %   horizontal radius a, and vertical radius b.
    %
    %   h = PLOT(x, y, a, b, n_points) specifies the number of points to draw
    %   (default 50).
    %
    %   h = PLOT(x, y, a, b, n_points, clr) also specifies the line and marker
    %   colors etc.
    
    if nargin < 5
        n_points = 50;
    end
    
    th = linspace(-pi(), pi(), n_points);
    xunit = x + a * cos(th);
    yunit = y + b * sin(th);
    
    if nargin <= 5
        h0 = plot(xunit, yunit);
    elseif nargin == 6
        h0 = plot(xunit, yunit, clr);
    elseif nargin == 7
        h0 = plot(xunit, yunit, clr, 'LineWidth', line_width);
    end
    
    if nargout > 0
        h = h0;
    end
end
