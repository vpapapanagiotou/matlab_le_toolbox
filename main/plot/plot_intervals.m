function h = plot_intervals(x, y, y_std, numbered, labels, c, face_alpha, send_to_back)
    %PLOT_INTERVALS Plot multiple intervals as boxes
    %
    %   PLOT_INTERVALS(x) plots intervals as boxes. Variable x must be a
    %   two-column matrix with start-stop values.
    %
    %   PLOT_INTERVALS(x, y) defines the lower and upper bound of the
    %   boxes. It can be a vector with two values, i.e. y=[min_height,
    %   max_height], or 'axis' (default) which sets the two values equal to
    %   axis(3:4).
    %   
    %   PLOT_INTERVALS(x, y, y_std) defines the standard deviation of the
    %   randomly drawn number that is added to each value of y in order to
    %   make consecutive boxes easier to see. It can be a number or 'auto'
    %   (default) which sets a sensible value based on y. Setting it to 0
    %   disables this feature.
    %
    %   PLOT_INTERVALS(x, y, y_std, numbered) defines if boxes should be
    %   numbered. Can be false (default) or true.
    %
    %   PLOT_INTERVALS(x, y, y_std, numbered, labels) defines labels for
    %   each box. It should be a cellstr with length equal to size(x, 1).
    %   Default is [] (no labels are printed).
    %
    %   PLOT_INTERVALS(x, y, y_std, numbered, labels, c) defines the color
    %   that is used to fill the boxes. Default is 'blue'. Can also be a
    %   3-numbered vector.
    %
    %   PLOT_INTERVALS(x, y, y_std, numbered, labels, c, face_alpha)
    %   defines face-alpha to allow transparency for the boxes. Default is
    %   0.
    %
    %   PLOT_INTERVALS(x, y, y_std, numbered, labels, c, face_alpha, send_to_back)
    %   is used to move all the boxes behind existing lines of the plot.
    %   Can be true (default) or false.
    %
    %   h = PLOT_INTERVALS(x) returns a list of handlers for the boxes.   

    %% INPUT ARGUMENT HANDLING
    if nargin < 2
        y = 'axis';
    end
    if nargin < 3
        y_std = 'auto';
    end
    if nargin < 4
        numbered = false;
    end
    if nargin < 5
        labels = [];
    end
    if nargin < 6
        c = 'blue';
    end
    if nargin < 7
        face_alpha = .8;
    end
    if nargin < 8
        send_to_back = true;
    end

    %% PROCESS DEFAULT ARGUMENTS
    if strcmp(y, 'axis')
        ax = axis();
        y = ax(3:4);
    end
    
    if strcmp(y_std, 'auto')
        y_std = (y(2) - y(1)) / 10;
    end

    %% INITIALIZATION
    n = size(x, 1);
    
    %% PREPARE NUMBERING AND LABELS
    should_print_text = numbered || ~isempty(labels);
    
    if numbered
        if isempty(labels)
            labels = cellfun(@num2str, num2cell(1:n), 'UniformOutput', false);
        else
            for i = 1:n
                labels{i} = [num2str(i) ': ' labels{i}];
            end
        end
    end
    
    %% MAIN PLOT LOOP
    handlers = nan([size(x, 1), 1]);
    for i = 1:n
        x1 = x(i, 1);
        x2 = x(i, 2);
        
        if y_std == 0
            r = 0;
        else
            r = randn() * y_std;
        end

        handlers(i) = fill([x1 x2 x2 x1], y([1 1 2 2]) + [-r -r r r], c, 'FaceAlpha', face_alpha);

        if should_print_text
            text(x1, y(2) + r, labels{i}, 'Color', 'm')
        end
    end
    
    %% Z-ORDERING
    if send_to_back
        children = get(gca(), 'Children');
        length_children = length(children);
        length_handlers = length(handlers);
        set(gca(), 'Children', children([length_handlers + 1:length_children, 1:length_handlers]));
    end
    
    %% OUTPUT ARGUMENT HANDLING
    if nargout > 0
        h = handlers;
    end
end
