function geohash = geohash_encode(lat, lon, prec)
    
    % Checks
    if isempty(lat) || isempty(lon)
        geohash = [];
        return
    end
    
    % Input argument handling 
    if nargin < 3
        prec = 12;
    end
    
    % Loop
    for i = length(lat):-1:1
        geohash{i, 1} = main(lat(i), lon(i), prec);
    end
    
end

function geohash = main(lat, lon, prec)
    
    % Initalization
    base32 = '0123456789bcdefghjkmnpqrstuvwxyz';
    lat_interval = [-90 90];
    lon_interval = [-180 180];
    geohash = blanks(prec);
    bits = 2.^(4:-1:0);
    bit = 1;
    ch = 0;
    even = true;
    
    i = 1;
    while i <= prec        
        if even
            mid = mean(lon_interval);
            if lon > mid
                ch = bitor(ch, bits(bit));
                lon_interval(1) = mid;
            else
                lon_interval(2) = mid;
            end
        else
            mid = mean(lat_interval);
            if lat > mid
                ch = bitor(ch, bits(bit));
                lat_interval(1) = mid;
            else
                lat_interval(2) = mid;
            end
        end
        even = ~even;
        if bit < 5
            bit = bit + 1;
        else
            geohash(i) = base32(ch + 1);
            i = i + 1;
            bit = 1;
            ch = 0;
        end
    end
end
