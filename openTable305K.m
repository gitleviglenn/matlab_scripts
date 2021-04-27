%----------------------------------------------------------------------------
%
% Import data from text file
%
%    filename: /Users/silvers/data/RCEMIP/tables/Table_A2_RCE_large305.txt
%
% based on Auto-generated by MATLAB on 23-Apr-2021 09:54:47
% levi silvers                                               april 2021
%----------------------------------------------------------------------------
%% Setup the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 17);

% Specify range and delimiter
opts.DataLines = [2, 35];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["VarName1", "VarName2", "Model", "F_NET", "R_TOA", "Q_OCN", "R_NET", "OLR", "ASR_TOA", "LHF", "SHF", "PW", "Precip", "LWP", "IWP", "clwvi_avg", "LapseRate"];
opts.VariableTypes = ["double", "categorical", "string", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, "Model", "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["VarName2", "Model"], "EmptyFieldRule", "auto");

% Import the data
Table305K = readtable("/Users/silvers/data/RCEMIP/tables/Table_A2_RCE_large305.txt", opts);


%% Clear temporary variables
clear opts


