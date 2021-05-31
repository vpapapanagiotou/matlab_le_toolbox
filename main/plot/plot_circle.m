function h = plot_circle(x, y, r, n_points, clr)
    %PLOT_CIRCLE Plots a circle on a figure
    %
    %   h = PLOT(x, y, r) plots a circle on a figure with centre at (x, y) and
    %   radius r.
    %
    %   h = PLOT(x, y, r, n_points) specifies the number of points to draw
    %   (default 50).
    %
    %   h = PLOT(x, y, r, n_points, clr) also specifies the line and marker
    %   colors etc.
    
    if nargin < 4
        n_points = 50;
    end
    
    th = linspace(0, 2 * pi(), n_points);
    xunit = r * cos(th) + x;
    yunit = r * sin(th) + y;
    
    if nargin < 5
        h0 = plot(xunit, yunit);
    else
        h0 = plot(xunit, yunit, clr);
    end
    
    if nargout > 0
        h = h0;
    end
end
