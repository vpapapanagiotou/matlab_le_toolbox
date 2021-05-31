function bundle = read_battery(device_id, sessions, sensor, user_path)
    %READ_BATTERY Create a plot for battery level for a user
    %
    %   READ_BATTERY Creates a plot with battery level from a user. It is
    %   assumed that the current workign directory contains the session folders
    %   (folders of the form "<device_id>_<session_id>").
    %
    %   READ_BATTERY(device_id) specifies which device to plot (default is 1).
    %   It can be numerical (e.g. 1) or string (e.g. '1').
    %
    %   READ_BATTERY(device_id, sessions) also specifies which sessions to plot.
    %   If empty (default), all sessions are plotted. 
    %
    %   READ_BATTERY(device_id, sessions, sensor) is a dummy input argument used
    %   for consistently interfacing with reader functions, and is always
    %   ignored. You should set it to empty (default is []).
    %
    %   READ_BATTERY(device_id, sessions, sensor, user_path) also specifies the
    %   path where the user's session folders (folders of the form
    %   '<device_id>_<session_id>') is. Default is ''.
    %
    %   bundle = READ_BATTERY(...) does not plot, but instead returns all read
    %   data in a bundle struct.
    
    %% Input argument handling
    if nargin < 1
        device_id = 1;
    end
    if nargin < 2
        sessions = [];
    end
    if nargin < 3
        sensor = [];
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
        sessions = sessions_from_folders(file_list, device_id);
    end
    
    if ~isempty(sensor) && ~strcmp(sensor, '')
        warning(['Value of argument sensor is not used. It only exists for ' ...
            'mainting a persistent interface of all readers.'])
    end
    sensor = 'battery';
    
    %% Preallocation
    for i = length(sessions):-1:1
        bundle(i).session_id = nan;
        bundle(i).date = nan;
        bundle(i).t = nan;
        bundle(i).v = nan;
        bundle(i).dates = [nan nan];
    end
    
    %% Load data
    for i = 1:length(sessions)
        n = sessions(i);

        session_path = [user_path device_id '_' num2str(n) filesep()];
        battery_file = dir2([session_path sensor '*.*']);
        if length(battery_file) ~= 1
            warning(['Invalid number of files found: ' num2str(length(battery_file))])
            continue
        end
        
        battery = read_battery_txt([session_path battery_file.name]);

        bundle(i).session_id = n;
        bundle(i).date = battery.t(1);
        bundle(i).t = battery.t;
        bundle(i).v = battery.v;
        bundle(i).dates = battery.t([1 end]);
    end
    
    %% Return bundle if not used for plotting
    if nargout > 0
        return
    end
    
    %% Prepare for plotting
    for i = 1:length(bundle)
        bundle(i).min_v = min(bundle(i).v);
        bundle(i).max_v = max(bundle(i).v);
    end

    %% Figure
    figure
    hold on
    ax = [min([bundle.min_v]) max([bundle.max_v])];
    for i = 1:length(bundle)
        patch(bundle(i).dates([1 1 2 2]), ax([1 2 2 1]), [.8, .8, .8], 'FaceAlpha', .5)
        text(bundle(i).dates(1), ax(2), num2str(bundle(i).session_id))
        plot(bundle(i).t, bundle(i).v, '.-')
    end
    hold off
    grid on
    ylabel('Acceleration (m/sec^2)')
    % title(datestr(bundle(1).dates(1)))
    datetick('x')
    
    %% Cleanup
    clear bundle    
end
