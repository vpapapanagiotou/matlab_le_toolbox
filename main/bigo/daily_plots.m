%% Scirpt for generating daily plots for a set of users

%% Config
input_path = '/home/lebill/Projects/work/BigO/data/cassandra-downloads/test-server/current/';
output_path = '/home/lebill/Desktop/html_out/';

% input_path = 'C:\Users\vassilis\workspace\work\BigO\data\cassandra-downloads\test-server\current';
% output_path = 'C:\Users\vassilis\Desktop\html_out';

days = datenum(2018, 11, 20):datenum(date());
users = {...
    '5bed4a20ec00a601fef0375c', 'BlueDolphin1'; ...
    '5bed4a20ec00a601fef0375e', 'BlueZepelin7'; ...
    '5bed4a20ec00a601fef03760', 'BlueUnicorn10'; ...
    '5bed4a20ec00a601fef03762', 'RedMamba8'; ...
    '5bed4a20ec00a601fef03764', 'CrimsonEagle1'; ...
    '5bed49fdec00a601fef0375b', 'PinkFlamingo15'; ...
    '5bed4a20ec00a601fef0376a', 'BlueKing1'; ...
    '5bed4a20ec00a601fef0376c', 'MagentaMamba17'; ...
    '5bed4a20ec00a601fef0376e', 'GreenLion1'};

%% Initialization
user_ids = users(:, 1);
user_names = users(:, 2);

%% Main part
for i = 1:size(users, 1)
    disp(['### Working with user ' user_names{i} ' (' user_ids{i} ') ###'])
    
    in_user_path = [append_filesep(input_path) user_ids{i}];
    out_user_path = [append_filesep(output_path) user_ids{i} '_' user_names{i}];
    mkdir(out_user_path)
    
    for j = 1:length(days)
        disp(['  > Working with day ' num2str(j) '/' num2str(length(days))])
        [hacc, hloc] = plot_day(in_user_path, days(j), [], false);
        out_day_path = [out_user_path filesep() datestr(days(j)) '_'];
        
        if ~isempty(hacc)
            for hi = 1:length(hacc)
                set(hacc(hi), 'outerposition', [0 0 1800 1000])
                set(hacc(hi), 'PaperPositionMode', 'auto')
                print(hacc(hi), [out_day_path num2str(hi) '_acc.png'], '-dpng')
                close(hacc(hi))
            end
        end
        if ~isempty(hloc)
            for hi = 1:length(hloc)
                set(hloc(hi), 'outerposition', [0 0 1800 1000])
                set(hloc(hi), 'PaperPositionMode', 'auto')
                print(hloc(hi), [out_day_path num2str(hi) '_loc.png'], '-dpng')
                close(hloc(hi))
            end
        end
    end
end
