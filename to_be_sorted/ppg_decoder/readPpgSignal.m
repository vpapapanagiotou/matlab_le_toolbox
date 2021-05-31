function [ppg_1, ppg_2, ppg_3, fs] = readPpgSignal(PathToCSVfile, CSVfile)
%
% Custom function for parsing the accelerometer data.
% For details contact Christos Diou (diou@mug.ee.auth.gr)

Data  = ReadSigmaTxtFiles(0,0,PathToCSVfile,CSVfile);

ppg_1 = [];
ppg_2 = [];
ppg_3 = [];
offset = 30;

fs_1 = [];
fs_2 = [];
fs_3 = [];

for iData = 1:numel(Data)
    if strcmp(Data(iData).SignalName,'Ppg 1')
        ppg_1 = Data(iData).SignalValue;
        fs_1 = 1 / mean(Data(iData).SignalTime(offset+1:end)-...
            Data(iData).SignalTime(offset:end-1));
    end
    if strcmp(Data(iData).SignalName,'Ppg 2')
        ppg_2 = Data(iData).SignalValue;
        fs_2 = 1 / mean(Data(iData).SignalTime(offset+1:end)-...
            Data(iData).SignalTime(offset:end-1));
    end
    if strcmp(Data(iData).SignalName,'Ppg 3')
        ppg_3 = Data(iData).SignalValue;
        fs_3 = 1 / mean(Data(iData).SignalTime(offset+1:end)-...
            Data(iData).SignalTime(offset:end-1));
    end
end

fs = 10 * (fs_1 + fs_2 + fs_3) / 3;

end
