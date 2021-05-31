function [hacc, hloc] = plot_day(user_path, day, day2, visible)
    %PLOT_DAY 
    %
    %   PLOT_DAY(user_path, day)

    %% Input argument handling
    if nargin < 3
        day2 = day;
    end
    if nargin < 4
        visible = true;
    end
    
    %% Config
    user_path = append_filesep(user_path);
    
    if isempty(day2)
        day2 = day;
    end
    
    if visible
        visible = 'on';
    else
        visible = 'off';
    end
    
    %% Data loading and processing

    % Load data (location and sessions)
    if ~exist([user_path 'sessions.csv'], 'file') || ~exist([user_path 'location.csv'], 'file')
        hacc = [];
        hloc = [];
        return
    end
    dev = read_devices_csv([user_path 'devices.csv']);
    ses = read_sessions_csv([user_path 'sessions.csv']);
    loc = read_location_csv([user_path 'location.csv']);
    
    % Time filtering (based on day and day2)
    b = day < ses.stop_local_timestamp & ses.start_local_timestamp < day2 + 1;
    ses = ses(b, :);
    
    b = day <= loc.local_timestamp & loc.local_timestamp <= day2 + 1;
    loc = loc(b, :);
    
    %% Sensor plot    
    % Process each device
    devices = unique(ses.device_id);
    
    % Figures
    h1 = nan([length(devices), 1]);

    for i = 1:length(devices)
        device_id = devices(i);
        h1(i) = figure('visible', visible);
        
        % Load data
        acc = read_sensor(devices(i), ses.session_id, 'accelerometer', user_path);
        bat = read_battery(devices(i), ses.session_id, '', user_path);
        
        % Process data
        for j = 1:length(acc)
            acc(j).a = sqrt(sum(acc(j).xyz.^2, 2));
            acc(j).min_a = min(acc(j).a);
            acc(j).max_a = max(acc(j).a);
            acc(j).t = acc(j).t / (24 * 60 * 60) + acc(j).date;
        end
        
        % Part 1
        subplot(3, 1, 1)
        hold on
        ax = [min([acc.min_a]) max([acc.max_a])];
        if isnan(ax(1))
            ax(1) = 0;
        end
        if isnan(ax(2))
            ax(2) = ax(1) + 1;
        end
        for j = 1:length(acc)
            patch(acc(j).dates([1 1 2 2]), ax([1 2 2 1]), [.8, .8, .8], 'FaceAlpha', .5)
            text(acc(j).dates(1), ax(2), num2str(acc(j).session_id))
            plot(acc(j).t, acc(j).a, '.-')
        end
        hold off
        grid on
        ylabel('Acceleration (m/sec^2)')
        title_str = [num2str(dev.device_id(i)) ' [' dev.model{i} '] : '];
        if day == day2
            title([title_str datestr(day)])
        else
            title([title_str datestr(day) ' - ' datestr(day2)])
        end
        datetick('x')
        axis([day, day2 + 1, ax(1), ax(2)])
        ca1 = gca();
        
        % Part 2
        subplot(3, 1, 2)
        hold on
        ax = [0, 100];
        for j = 1:length(bat)
            patch(bat(j).dates([1 1 2 2]), ax([1 2 2 1]), [.8, .8, .8], 'FaceAlpha', .5)
            text(bat(j).dates(1), ax(2), num2str(bat(j).session_id))
            plot(bat(j).t, 100 * bat(j).v, '.-')
        end
        hold off
        grid on
        ylabel('Battery level (%)')
        datetick('x')        
        axis([day, day + 1, ax(1), ax(2)])
        ca2 = gca();
        
        % Part 3
        subplot(3, 1, 3)
        
        if strcmp(dev.access_mode(device_id), 'LOCAL')
            sensor_type = 'LOCATION_MOBILE';
        else
            sensor_type = 'LOCATION_WATCH';
        end
        loc1 = loc(strcmp(loc.sensor_type, sensor_type), :);

        if height(loc1) > 0
            loc_dists = haversine_distance([loc1.latitude(1), loc1.longitude(1)], ...
                [loc1.latitude, loc1.longitude]);
        else
            loc_dists = [];
        end
        
        hold on
        if isempty(loc_dists)
            ax = [0, 1];
        else
            ax = [0, max(loc_dists)];
        end
        for j = 1:length(acc)
            patch(acc(j).dates([1 1 2 2]), ax([1 2 2 1]), [.8, .8, .8], 'FaceAlpha', .5)
            text(acc(j).dates(1), ax(2), num2str(acc(j).session_id))
        end
        
        plot(loc1.local_timestamp, loc_dists, '.')
        
        hold off
        grid on
        ylabel('Distance from first location (m)')
        datetick('x')       
        
        if ax(1) == 0 && ax(2) == 0
            ax(2) = 1;
        end
        axis([day, day + 1, ax(1), ax(2)])
        ca3 = gca();
        
        linkaxes([ca1, ca2, ca3], 'x');
    end
    
    %% Map plot
    % Process each source
    sources = {'LOCATION_MOBILE', 'LOCATION_WATCH'};
    modes = {'LOCAL', 'DATA_API'};
    sources_disp = {'mobile', 'watch'};
    
    % Figures
    h2 = nan([length(sources), 1]);
    
    for i = 1:length(sources)
        b = strcmp(loc.sensor_type, sources{i});
        if isempty(loc.longitude(b))
            disp(['! No location data for ' sources_disp{i}])
            continue
        end
        
        h2(i) = figure('visible', visible);
        plot(loc.longitude(b), loc.latitude(b), '.-g')
        plot_google_map()
        grid on
        
        if day == day2
            date_disp = datestr(day);
        else
            date_disp = [datestr(day) ' - ' datestr(day2)];
        end
        title([sources_disp{i} ': ' date_disp ', devices ids: ' ...
                num2str(dev.device_id(strcmp(dev.access_mode, modes{i})))'])
    end
    
    %% Output argument handling
    if nargout > 0
        hacc = h1;
    end
    if nargout > 1
        hloc = h2;
    end
end
