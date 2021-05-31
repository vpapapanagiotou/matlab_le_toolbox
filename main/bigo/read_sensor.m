function bundle = read_sensor(device_id, sessions, sensor, user_path)
    %READ_SENSOR Create a plot for accelerometer signal for a user
    %
    %   READ_SENSOR Creates a plot with all accelerometer signal from a user. It
    %   is assumed that the current working directory contains the session
    %   folders (folders of the form "<device_id>_<session_id>").
    %
    %   READ_SENSOR(device_id) specifies which device to plot (default is 1). It
    %   can be numerical (e.g. 1) or string (e.g. '1').
    %
    %   READ_SENSOR(device_id, sessions) also specifies which sessions to plot.
    %   If empty (default), all sessions are plotted. 
    %
    %   READ_SENSOR(device_id, sessions, sensor) also specifies a string mask
    %   (e.g. 'accel') used to select which sensor to read. Default is
    %   'accelerometer'.
    %
    %   READ_SENSOR(device_id, sessions, sensor, user_path) also specifies the
    %   path where the user's session folders (folders of the form
    %   '<device_id>_<session_id>') is. Default is ''.
    %
    %   bundle = READ_SENSOR(...) does not plot, but instead returns all read
    %   data in a bundle struct.
    
    %% Input argument handling
    if nargin < 1
        device_id = 1;
    end
    if nargin < 2
        sessions = [];
    end
    if nargin < 3
        sensor = 'accelerometer';
    end
    if nargin < 4
        user_path = '';
    end

    %% Config
    device_id = num2str(device_id);
    
    if ~isempty(user_path) && ~strcmp(user_path, '')
        user_path = append_filesep(user_path);
    end

    if isempty(sessions)
        file_list = dir2([user_path device_id '_*']);
        sessions = 1:length(file_list);
        if isempty(sessions)
            bundle = [];
            return
        end
    end
    
    %% Preallocation
    for i = length(sessions):-1:1
        bundle(i).session_id = nan;
        bundle(i).date = nan;
        bundle(i).t = nan;
        bundle(i).xyz = nan;
        bundle(i).dates = [nan nan];
    end

    %% Load data
    for i = 1:length(sessions)
        n = sessions(i);
        
        try
            disp(['*** Working with session ' num2str(n) ...
                ' (' num2str(i) '/' num2str(length(sessions)) ') ***'])
            
            [t, x, date, ~] = read_sensor_stream(sensor, [user_path device_id '_' num2str(n)]);
            if isempty(t)
                warning(['No data for device ' num2str(device_id) ' and session ' num2str(n)])
                continue
            end
            
            tt = reshape(t([1 end]), 1, []);
            
            bundle(i).session_id = n;
            bundle(i).date = date;
            bundle(i).t = t;
            bundle(i).xyz = x;
            bundle(i).dates = (tt - tt(1)) / (24 * 60 * 60) + date;
        catch ME
            warning(ME)
        end
    end
    
    %% Return bundle if not used for plotting
    if nargout > 0
        return
    end
    
    %% Prepare for plotting
    for i = 1:length(bundle)
        bundle(i).t = bundle(i).t / (24 * 60 * 60) + bundle(i).date;
        bundle(i).a = sqrt(sum(bundle(i).xyz.^2, 2));
        bundle(i).min_a = min(bundle(i).a);
        bundle(i).max_a = max(bundle(i).a);
    end
    
    %% Figure
    figure
    
    subplot(2, 1, 1)
    hold on
    ax = [min([bundle.min_a]) max([bundle.max_a])];
    for i = 1:length(bundle)
        patch(bundle(i).dates([1 1 2 2]), ax([1 2 2 1]), [.8, .8, .8], 'FaceAlpha', .5)
        text(bundle(i).dates(1), ax(2), num2str(bundle(i).session_id))
        plot(bundle(i).t, bundle(i).a, '.-')
    end
    hold off
    grid on
    ylabel('Acceleration (m/sec^2)')
    title(datestr(bundle(1).dates(1)))
    datetick('x')
    ax1 = axis();
    
    subplot(2, 1, 2)
    hold on
    for i = 1:length(bundle)
        plot(bundle(i).t(1:end - 1), diff(bundle(i).t * 24 * 60 * 60), '.-')
    end
    hold off
    grid on
    datetick('x')
    ax2 = axis();
    axis([ax1(1:2) 0 1])
    xlabel('t (s)')
    ylabel('dt (s)')
    
    %% Cleanup
    clear bundle
end
