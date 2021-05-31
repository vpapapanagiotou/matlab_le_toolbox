function d = haversine_distance_fast(x, y)
    %HAVERSHINE_DISTANCE_FAST
    %
    %   d = HAVERSHINE_DISTANCE_FAST(x, y) computes the distance in meters
    %   between two points of the earth, regarding the earth's shape to be a
    %   sphere. The two points are given by their co-ordinates in degrees
    %   (not radians or WGS84) and are in the form [lat, lon]. Note that y can
    %   be a table that contains multiple points (one point per row).
    %
    %   It is faster than HAVERSINE_DISTANCE.
    
    % Assuming (lat, lon) encoding
    
    x = x * pi() / 180;
    y = y * pi() / 180;
    d = (y - x) / 2;
    
    a = sin(d(:, 1)).^2;
    b = cos(x(1, 1)) .* cos(y(:, 1)) .* sin(d(:, 2)).^2;
    d = 2 * earthRadius() * asin(sqrt(a + b));

end
