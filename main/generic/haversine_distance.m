function d = haversine_distance(x, y)
    %HAVERSINE_DISTANCE
    %
    %   d = HAVERSINE_DISTANCE(x, y) computes the distance in meters
    %   between two points of the earth, regarding the earth's shape to be a
    %   sphere. The two points are given by their co-ordinates in degrees
    %   (not radians or WGS84) and are in the form [lat, lon]. Note that y can
    %   be a table that contains multiple points (one point per row).
    
    lat1 = x(1, 1) * pi() / 180;
    lon1 = x(1, 2) * pi() / 180;
    lat2 = y(:, 1) * pi() / 180;
    lon2 = y(:, 2) * pi() / 180;
    
    dlat = (lat2 - lat1) / 2;
    dlon = (lon2 - lon1) / 2;
    
    a = sin(dlat).^2;
    b = cos(lat1) .* cos(lat2) .* sin(dlon).^2;
    d = 2 * earthRadius() * asin(sqrt(a + b));
end
