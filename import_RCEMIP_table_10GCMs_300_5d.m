%% Import data from text file
% Script for importing data from the following text file:
%
%    filename: /Users/silvers/data/RCEMIP_omegaSF_vals_300_5d.txt
%

%% Setup the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 10);

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = " ";

% Specify column names and types
opts.VariableNames = ["model", "omega_db", "I", "omega_dn", "omega_up", "SF", "SST", "omega_db2", "Qmn", "sig_mn"];
opts.VariableTypes = ["string", "double", "double", "double", "double", "double", "double", "double", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
opts.ConsecutiveDelimitersRule = "join";
opts.LeadingDelimitersRule = "ignore";

% Specify variable properties
opts = setvaropts(opts, "model", "WhitespaceRule", "preserve");
opts = setvaropts(opts, "model", "EmptyFieldRule", "auto");

% Import the data
%CircSF300 = readtable("/Users/silvers/data/RCEMIP/tables/RCEMIP_omegaSF_10GCMs_300_5d.txt", opts);
%CircSF300 = readtable("/Users/silvers/data/RCEMIP/tables/meanvals_10GCMs_900to1hPa_5d_300.txt", opts);
CircSF300 = readtable("/Users/silvers/data/RCEMIP/tables/meanvals_10GCMs_600to200hPa_5d_300.txt", opts);

%% Clear temporary variables
clear opts
