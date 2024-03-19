function conf = wjn_maze_import_config(filename, startRow, endRow)
%IMPORTFILE Import numeric data from a text file as a matrix.
%   VMWMEXPERIMENTCONFIG = IMPORTFILE(FILENAME) Reads data from text file
%   FILENAME for the default selection.
%
%   VMWMEXPERIMENTCONFIG = IMPORTFILE(FILENAME, STARTROW, ENDROW) Reads
%   data from rows STARTROW through ENDROW of text file FILENAME.
%
% Example:
%   VMWMExperimentConfig = importfile('VMWM-Experiment-Config.csv', 2, 6);
%
%    See also TEXTSCAN.

% Auto-generated by MATLAB on 2019/01/09 09:41:08

%% Initialize variables.
delimiter = ';';
if nargin<=2
    startRow = 2;
    endRow = inf;
end

%% Format for each line of text:
%   column1: double (%f)
%	column2: double (%f)
%   column3: double (%f)
%	column4: double (%f)
%   column5: double (%f)
%	column6: text (%q)
%   column7: double (%f)
%	column8: text (%q)
%   column9: text (%q)
%	column10: text (%q)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%f%f%f%f%f%q%f%q%q%q%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to the format.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'HeaderLines', startRow(1)-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
for block=2:length(startRow)
    frewind(fileID);
    dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'HeaderLines', startRow(block)-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
    for col=1:length(dataArray)
        dataArray{col} = [dataArray{col};dataArrayBlock{col}];
    end
end

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

%% Create output variable
conf= table(dataArray{1:end-1}, 'VariableNames', {'Run_ID','Pos_Goal_Distance','Pos_Goal_Degree','Goal_Size','Pond_Size','Spatial_Cue_Presence','Time_Threshold','Scripted_Spawn_Points','Spatial_Cue_Visibility','Show_Target_Platform'});

