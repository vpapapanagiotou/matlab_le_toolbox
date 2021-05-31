figure

%% Example 1
lat = 0;
lon = 10;
r = 1000;
[lat_dd, lon_dd] = earth_circle(lat, lon, r);

subplot(1, 2, 1)
plot_ellipse(lon, lat, lon_dd, lat_dd);
grid on
plot_google_map()
axis equal

%% Figure
lat = 80;
lon = 0;
r = 1000;
[lat_dd, lon_dd] = earth_circle(lat, lon, r);

subplot(1, 2, 2)
plot_ellipse(lon, lat, lon_dd, lat_dd);
grid on
plot_google_map()
axis equal

%% Figure
lats = 0:5:80;
lons = 0:40:80;

figure
hold on
for i = 1:length(lats)
    for j = 1:length(lons)
        [lat_dd, lon_dd] = earth_circle(lats(i), lons(j), 100000);
        plot_ellipse(lons(j), lats(i), lon_dd, lat_dd, 'r')
    end
end
grid on
plot_google_map()
