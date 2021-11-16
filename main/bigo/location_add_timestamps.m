function loc = location_add_timestamps(loc, start_iso_timestamp)
    
    if height(loc) == 0
        return
    end
    
    % Create timestamps
    [start_utc_timestamp, start_local_timestamp] = decode_iso8601_timestamp(start_iso_timestamp);
    t = loc.elapsed_realtime_nanos;
    t = t - t(1);
    t = in_days(t, 'nanos');

    loc.utc_timestamp = start_utc_timestamp + t;
    loc.local_timestamp = start_local_timestamp + t;
end    
