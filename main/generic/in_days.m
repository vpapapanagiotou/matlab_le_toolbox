function t_days = in_days(t, time_unit)

    ms = {'ms', 'msec', 'msecond', 'mseconds', 'millis'};
    s = {'s', 'sec', 'second', 'seconds'};
    min = {'min', 'minute', 'minutes'};
    h = {'h', 'hour', 'hours'};
    day = {'day', 'days'};
    
    if any(strcmpi(ms, time_unit))
        a = 1 / (24 * 60 * 60 * 1000);
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
