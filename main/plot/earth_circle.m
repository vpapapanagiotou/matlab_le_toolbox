function [lat_dd, lon_dd] = earth_circle(lat, lon, r)
    %EARTH_CIRCLE Helper to draw a circle of specific radius on a lat-lon plot
    %
    %   [lat_dd, lon_dd] = EARTH_CIRCLE(lat, lon, r) is used to draw a "circle"
    %   of specific radious r (in meters) centred at (lat, lon) (in degrees).
    %   You can use the result to draw an ellipse at (lat, lon) with horizontal
    %   radius lat_dd and vertical radius lon_dd.
    
    h1 = @(x) ((haversine_distance([lat, lon], [lat + x, lon]) - r)^2);
    lat_dd = fminsearch(h1, lat);
    
    h2 = @(x) ((haversine_distance([lat lon], [lat, lon + x]) - r)^2);
    lon_dd = fminsearch(h2, lon);
end
