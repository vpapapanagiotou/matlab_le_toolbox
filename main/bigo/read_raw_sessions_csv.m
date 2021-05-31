function sessions = read_raw_sessions_csv(file_name)
    
    sessions = readtable(file_name, 'Delimiter', ',', 'HeaderLines', 0);
    
    if isempty(sessions)
        return
    end
    
    sessions.Properties.VariableNames = { ...
        'user_id', ...  text
        'device_id', ... int,
        'session_id', ...  int,
        'start_utc_timestamp', ...  timestamp,
        'algorithms', ...  set<text>,
        'duration_sec', ...  int,
        'noof_datablobs', ...  int,
        'noof_subsessions', ...  int,
        'session_type', ...  text,
        'start_local_timestamp', ...  timestamp,
        'stop_cause', ...  text,
        'stop_local_timestamp', ...  timestamp,
        'stop_utc_timestamp' ...  timestamp,
        };
    
    sessions.start_utc_timestamp = cassandra_timestamp2matlab(sessions.start_utc_timestamp);
    sessions.start_local_timestamp = cassandra_timestamp2matlab(sessions.start_local_timestamp);
    sessions.stop_utc_timestamp = cassandra_timestamp2matlab(sessions.stop_utc_timestamp);
    sessions.stop_local_timestamp = cassandra_timestamp2matlab(sessions.stop_local_timestamp);
end

