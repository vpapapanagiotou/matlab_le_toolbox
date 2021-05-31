x = [1, 2];
y1 = [2, 4];
y2 = [3, 2];
y3 = [1, 1];
y = [y1; y2; y3];

d1 = haversine_distance(x, y1);
d2 = haversine_distance(x, y2);
d3 = haversine_distance(x, y3);
d = haversine_distance(x, y);

d - [d1; d2; d3]

