%% Import data from text file
%
%    filename: /Users/silvers/data/RCEMIP_omegaSF_vals_CRMs_295.txt
%

%% Setup the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 8);

% Specify range and delimiter
opts.DataLines = [4, Inf];
opts.Delimiter = " ";

% Specify column names and types
opts.VariableNames = ["model", "omega_db", "I", "omega_dn", "omega_up", "SF", "Qmn", "sig_mn"];
opts.VariableTypes = ["string", "double", "double", "double", "double", "double", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
opts.ConsecutiveDelimitersRule = "join";
opts.LeadingDelimitersRule = "ignore";

% Specify variable properties
opts = setvaropts(opts, "model", "WhitespaceRule", "preserve");
opts = setvaropts(opts, "model", "EmptyFieldRule", "auto");

% Import the data
%Circ_omega_CRMs_295 = readtable("/Users/silvers/data/RCEMIP/tables/RCEMIP_omegaSF_vals_CRMs_295.txt", opts);
%Circ_omega_CRMs_295 = readtable("/Users/silvers/data/RCEMIP/tables/meanvals_5GCMs_900to1hPa_96km_5d_295.txt", opts);
Circ_omega_CRMs_295 = readtable("/Users/silvers/data/RCEMIP/tables/meanvals_7CRMs_600to200hPa_96km_5d_295.txt", opts);


%% Clear temporary variables
clear opts
