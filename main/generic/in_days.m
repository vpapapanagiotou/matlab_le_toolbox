function t_days = in_days(t, time_unit)

    ns = {'ns', 'nanos', 'nsec', 'nanosec', 'nsecond', 'nanosecond', 'nseconds', 'nanoseconds'};
    ms = {'ms', 'msec', 'msecond', 'mseconds', 'millis'};
    s = {'s', 'sec', 'second', 'seconds'};
    min = {'min', 'minute', 'minutes'};
    h = {'h', 'hour', 'hours'};
    day = {'day', 'days'};
    
    if any(strcmpi(ns, time_unit))
        a = 1 / (24 * 60 * 60 * 1e9);
    elseif any(strcmpi(ms, time_unit))
        a = 1 / (24 * 60 * 60 * 1e3);
    elseif any(strcmpi(s, time_unit))
        a = 1 / (24 * 60 * 60);
    elseif any(strcmpi(min, time_unit))
        a = 1 / (24 * 60);
    elseif any(strcmpi(h, time_unit))
        a = 1 / 24;
    elseif any(strcmp(day, time_unit))
        a = 1;
    else
        error(['Unknown time_unit: ' time_unit])
    end
    
    t_days = a * t;
end
