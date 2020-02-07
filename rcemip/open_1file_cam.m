function var = open_1file_cam(camversion,varname,filein)
%-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
% general script used to open one file for checking purposes
%
% to be used in matlab on macbook air
% all input variables should be strings
%
% example usage: 
% >> twiav=open_1file_cam('CAM5','rsutcs','CAM5_GCM_RCE_large295_2D_rsutcs.nc');
% levi silvers					Feb 2020
%-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

source='/Users/silvers/data/CAM/';

model_generation=camversion;

filename=filein;

source_mod=strcat(source,model_generation,'_GCM_RCE','/',filename);

varn=varname;          

var=ncread(source_mod,varn);

