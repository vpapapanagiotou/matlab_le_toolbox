n = 1000000;

x = rand([1, 2]);
y = rand([n, 2]);

d1 = haversine_distance(x, y);
d2 = haversine_distance_fast(x, y);

sum(abs(d1 - d2))
