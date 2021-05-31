% Setup
lat = 40.66;
lon = 22.9;

% Find distance in radius
r1 = radius2deg(lat, lon, 20);
r2 = radius2deg(lat, lon, 40);
r3 = radius2deg(lat, lon, 50);

% Plots
close all

figure
hold on
plot(lon, lat, 'x');
plot_circle(lon, lat, r1);
plot_circle(lon, lat, r2);
plot_circle(lon, lat, r3);
hold off
grid on
plot_google_map()
offset = .01;
% axis([lon - offset, lon + offset lat - offset, lat + offset])

figure
h = @(lat2) ((haversine_distance([lat lon], [lat2 lon]) - r)^2);
t_x = -pi():.01:pi();
t_y = h(t_x);
plot(t_x', h(t_x)', '.-')
grid on
