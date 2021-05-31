function Data  = ReadSigmaTxtFiles(Plot,Check,path,file)
%
% Example: Data = ReadSigmaTxtFiles(0,0,PathToCSVfile,CSVfile);
%

Path = 'data/*.csv';

if nargin == 0
    Plot = 1;
    Check = 0;
    file = [];
else if nargin == 1
        Check = 0;
        file = [];
    elseif nargin == 2
        path = [];
        file = [];
    end
end

%close all;
if isempty(file)
    % Get session name to read
    [file,path] = uigetfile(Path);
    if file == 0
        disp('Operation aborted by the user')
        return;
    end
end
index = strfind(file,'_');
CommonFileName = file(1:index(end));
% Get channels info
[x]=dir(fullfile(path,[CommonFileName,'*.dat']));

NbChannels = length(x);
Data(NbChannels) = struct('SignalValue',zeros(),'SignalTime',zeros(),'SignalName','');
%Gain = [1;1;1;1;1/4095*2.4/200;1;1;1;1];
Gain = ones(NbChannels,1);
for i = 1:NbChannels
    % Get signal name
    Data(i).SignalName = x(i).name(index(end)+1:end-4);
    if (~strcmp(Data(i).SignalName,'rawdata'))  % excluding rawdata
        % Read signal file
        fid = fopen(fullfile(path,x(i).name),'rb');
        RawData = fread(fid,'int64');
        fclose(fid);
        % Store signal data in the structure
        Data(i).SignalTime = zeros(1,ceil(length(RawData)/2));
        Data(i).SignalValue = zeros(1,ceil(length(RawData)/2));
        Data(i).SignalTime = RawData(21:2:end)/1000;                       % LeBill: throw away fist 10 samples
        Data(i).SignalValue = RawData(22:2:end);
        % plot it
        if Plot == 1 && ~isempty(Data(i).SignalTime)
            if (~isempty(strfind(Data(i).SignalName,'marker')))
                figure(i+100)
                stem(Data(i).SignalTime,Data(i).SignalValue*Gain(i))
                xlabel('Time(s)')
                ylabel(Data(i).SignalName)
            else
                figure(i+100)
                plot(Data(i).SignalTime,Data(i).SignalValue*Gain(i))
                xlabel('Time(s)')
                ylabel(Data(i).SignalName)
            end
        end
    end
end

if Check == 1
    Name = {'ACC AMP', 'ACC X', 'ACC Y', 'ACC Z', 'ACTIVITY QI', 'ACTIVITY', 'Bat lvl', 'BATT LVL', 'BR Qi', 'BR',...
        'Cadence avg', 'Distance', 'Ecg filtered', 'ECG', 'HR avg', 'HR QI', 'HR', 'Markers M', 'MostUsedClass', 'PACE',...
        'rawdata', 'Rsp filtered', 'RSP', 'SKIN DET', 'Speed avg', 'Speed', 'Steps', 'VREF', 'BR avg'};
    
    % LeBill: Fix the wrong Names
    Name={'Acc x','Acc y','Acc z','Activity class','Activity class Qi',...
        'Activity counter','Activity integral','Band-pass subbans 1 acc',...
        'Band-pass subband 2 acc','Band-pass subband 3 acc',...
        'Band-pass subband 4 acc','Energy expenditure','Energy expenditure Qi',...
        'Heart rate','Heart rate delay','Heart rate Qi','Ppg 1','Ppg 2',...
        'Ppg 3','Step counter','Step counter Qi'};
    
    
    Inc = [1,1,1,1,1,1,1,1,1,1,...
        1,1,1,1,1,1,1,1,1,1,...
        1,1,1,1,1,1,1,1,1];
    Start = [130, 200, 210, 220, 110, 100, 210, 326, 80, 70,...
        170, 190, 200, 0, 60, 50, 40, NaN, 160, 120, ...
        NaN, 0, 125, 255, 180, 140, 150, 0, 90];
    Max = [2^16-1, 2^11-1, 2^11-1, 2^11-1, 2^8-1, 2^8-1, 2^16-1, 2^12-1, 2^8-1, 2^8-1, ...
        2^8-1, 2^16-1, 2^11-1, 2^12-1, 2^8-1, 2^8-1, 2^8-1, 2^8-1, 2^8-1, 2^8-1,...
        2^8-1, 2^15-1, 2^12-1, 2^12-1, 2^8-1, 2^8-1, 2^32-1, 2^12-1, 2^8-1];
    Min = [0, -2^11, -2^11, -2^11, 0, 0, 0, 0, 0 , 0,...
        0, 0, -2^11, 0, 0 ,0 ,0 ,0 ,0 ,0 ,...
        0, -2^15, 0, 0, 0, 0, 0, 0, 0];
    fs = [0.2, 100, 100, 100, 0.2, 0.2, 0.2, 32768/1020, 0.2, 0.2,...
        0.2, 0.2, 32768/102/3, 32768/102, 0.2, 0.2, 0.2, NaN, 0.2, 0.2,...
        NaN, 32768/1020/3, 32768/1020, 32768/1020, 0.2, 0.2, 0.2, 32768/1020, 0.2];
    % Check results
    for i = 1:length(Data)
        % Get index value
        index = find(strcmp(Name,Data(i).SignalName),1);
        if length(index) == 1
            % Check amplitude values
            DeltaValue = Data(i).SignalValue(2:end)-Data(i).SignalValue(1:end-1);
            Index = find(DeltaValue ~= Inc(index));
            if any(Data(i).SignalValue(Index) ~= Max(index)) || any(Data(i).SignalValue(Index+1) ~= Min(index))
                %if any(abs(DeltaValue(Index)-DeltaValue(Index+1)) ~= (Max(index) - Min(index)))
                %x=DeltaValue(Index(1:end-1))-DeltaValue(Index(2:end));
                x = find(Data(i).SignalValue(Index) ~= Max(index) & Data(i).SignalValue(Index+1) ~= Min(index));
                disp([Data(i).SignalName,'- Amplitude error: ',num2str(DeltaValue(Index(x))')])
                beep;
                figure
                a(1)=subplot(211);
                plot(Data(i).SignalTime,Data(i).SignalValue)
                title(Data(i).SignalName)
                ylabel('Signal')
                a(2)=subplot(212);
                plot(Data(i).SignalTime(1:end-1),DeltaValue)
                ylabel('Values diff')
                linkaxes(a,'x');
            end
            % Check timestamp values
            if ~isnan(fs(index))
                DeltaTime = Data(i).SignalTime(2:end)-Data(i).SignalTime(1:end-1);
                if ~isempty(DeltaTime)
                    MeanFs(i) = 1/mean(DeltaTime);
                    Err(i) = max(abs((mean(DeltaTime) - (DeltaTime))))/mean(DeltaTime)*100;
                    if any(diff(DeltaTime ~= 1/fs(index)))
                        disp([Data(i).SignalName,' - Timestamp error'])
                        beep;
                        figure
                        a(1)=subplot(211);
                        plot(Data(i).SignalTime,Data(i).SignalValue)
                        ylabel('Signal')
                        title(Data(i).SignalName)
                        a(2)=subplot(212);
                        plot(Data(i).SignalTime(1:end-1),DeltaTime)
                        ylabel('Timestamp diff')
                        linkaxes(a,'x');
                    end
                else
                    MeanFs(i) = NaN;
                    Err(i) = NaN;
                end
            else
                MeanFs(i) = NaN;
                Err(i) = NaN;
            end
        else
            disp([Data(i).SignalName,' - Cannot check it! (' num2str(i) ')'])
        end
    end
    name = strvcat(Data(:).SignalName);
    % Gen sampling time report
    disp('*****************************************************************');
    disp('* Channel sampling frequency analysis report');
    disp('*');
    disp(['* Channel name','    fs average (Hz)','    Max error (%)'])
    disp('*****************************************************************');
    for i = 1:NbChannels-1
        %disp(['* ',Data(i).SignalName,' - ',num2str(MeanFs(i)), ' - ',num2str(Err(i))])
        disp(sprintf('* %s \t %6.2f \t\t %6.2f',name(i,:),MeanFs(i),Err(i)))
    end
    disp('*****************************************************************');
end
