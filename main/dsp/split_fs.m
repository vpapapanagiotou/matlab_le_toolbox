function [aisf, s] = split_fs(t, uisf, medfilt1_n)
    %SPLIT_FS Split a signal of different sampling frequences
    %
    %   aisf = SPLIT_FS(t) approximates the instantaneous sampling
    %   frequency (ISF). It can be used to split a signal. Variable 't' is
    %   a [n x 1] vector that holds the signal timestamps (in sec) and
    %   variable 'asif'  is a [n-1 x 1] column vector that holds the
    %   approximated ISF.
    %
    %   SPLIT_FS opperates correctly under the following assumptions:
    %     a) There is an arbitrary partitioning of the signal; in each
    %     partition, samples are sampled with a constant sampling
    %     frequency.
    %     b) The sampling frequencies of the partitions are few, and not
    %     too close to each other.
    %     c) In each partition, the sampling frequency can vary around the
    %     actual value.
    %
    %   SPLIT_FS(t, uisf) specifies the unique ISFs in uisf to use for
    %   histogram construction (e.g. uisf = 1:100, or uisf = 10:5:50). If
    %   empty is passed (uisf = []) then all unique ISFs are used (min to
    %   max). A margin of +/-10 is always added internally for
    %   computational reasons. Default is [].
    %
    %   SPLIT_FS(t, uisf, medfilt1_n) also specifies the length of the
    %   median filter that is initially applied on the ISFs (default 20).
    %
    %   [aisf, s] = SPLIT_FS(...) also returns a [m x 2] matrix that
    %   contains start and stop indices (as rows) where each row is a
    %   partition.

    % Configuration
    if nargin < 2
        uisf = [];  % Unique ISFs
    end
    if nargin < 3
        medfilt1_n = 20;  % Median filter length
    end
    
    % Main part
    % Initialization
    t = t(:);
    
    % Rough estimate of ISF (instantaneous sampling frequency)
    isf = round(1 ./ diff(t));
    isf = round(medfilt1(isf, medfilt1_n));
    
    % Dominand ISF (i.e.: ISF with many samples)
    if isempty(uisf)
        uisf = min(isf) - 10:max(isf) + 10;
    else
        uisf = [uisf(1) - 10, uisf, uisf(end) + 10];
    end
    uisf_perc = hist(isf, uisf);  % Histogram of ISF
    uisf_perc = uisf_perc / sum(uisf_perc);  % Normalise histogram
    [~, disf] = findpeaks(uisf_perc, uisf, 'MinPeakDistance', 5);  % Peaks
    
    % Change each ISF to the closest Dominant ISF
    isf_rep = repmat(isf, [1, length(disf)]);  % Replicate ISF
    abs_dist = abs(bsxfun(@minus, isf_rep, disf));  % Absolute distance of each ISF to each Dominant ISF
    [~, idx] = min(abs_dist, [], 2);  % Select minimum absolute distance (indices)
    aisf = disf(idx);  % Approximated ISF (a.k.a. selected Dominant ISFs)

    if nargout > 1
        % Create segmentation table
        s = reshape([1; kron(find(diff(aisf(:)) ~= 0), [1; 1]); length(t)], 2, [])';
        % Remove empty rows
        s(s(:, 1) == s(:, 2), :) = [];
    end
end
