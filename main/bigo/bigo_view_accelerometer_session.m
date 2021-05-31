clear

%% Read data
[t, x, date, toff] = read_sensor_stream('accele');

%% Get magnitudes
a = sqrt(sum(x.^2, 2));

% Get histograms
fs = 1 ./ diff(t);
[hx, hn] = hist(fs, 0:200);

%% Plots
close all
figure

subplot(1, 2, 1)
hold on
plot(t / 3600, a, '.-')
xlabel('Time (h)')
ylabel('Acceleration (m/sec^2)')
if ~isempty(date)
    title(datestr(date))
end
hold off
grid on

subplot(1, 2, 2)
hold on
stem(hn, hx / sum(hx), '.')
hold off
grid on
xlabel('Frequency (Hz)')
legend([num2str(sum(hx)) ' samples'])
