function [x, scale] = audiowrite_prepare(x)
%AUDIOWRITE_PREPARE Prepare audio to be writen in audio file
%
%   x = AUDIOWRITE_PREPARE(x) Prepares an audio signal to be writen in an
%   audio file such as wav or flac.
%
%   [x, scale] = AUDIOWRITE_PREPARE(x) returns the scale factor by which x is
%   divided to avoid clipping.

    m = max(abs(x(:)));

    if m > 1
        x = x / m;
    end

    if nargout > 1
        scale = min([1, 1 / m]);
    end
end
