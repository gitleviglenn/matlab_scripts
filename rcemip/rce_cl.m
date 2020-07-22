%-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
% rce_cl.m
%
% script to compute the cosine weighted global mean of the 2D
% cloud fraction
%
% the mean values over some time period will be tabulated in the 
% CAM RCEMIP paper
%
% this script plots the time series of globally averaged cf.
%
% it should be possible to easily and quickly compute the cosine
% weighted average over a given time period with NCO...
%
% levi silvers                                               july 2020
%-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

source='/Users/silvers/data/CAM/';
model_generation='CAM5';
source_mod=strcat(source,model_generation,'_GCM_RCE/');

var1='cl'
SSTst="295"
exp_string_a_2D=strcat(model_generation,'_GCM_RCE_large',SSTst,'_2D_');
SSTst="300"
exp_string_b_2D=strcat(model_generation,'_GCM_RCE_large',SSTst,'_2D_');
SSTst="305"
exp_string_c_2D=strcat(model_generation,'_GCM_RCE_large',SSTst,'_2D_');
s_var_a=strcat(source_mod,exp_string_a_2D,var1,'.nc')
s_var_b=strcat(source_mod,exp_string_b_2D,var1,'.nc')
s_var_c=strcat(source_mod,exp_string_c_2D,var1,'.nc')

% this takes quite a while... it would probably be best to select
% the times of interest first and then read in only that data.
% actually I think that would only be possible by using cdo to 
% modify the file before matlab reads it in...

% reading in the full variables is slow... 
% only read these in the first time
cl_295  = ncread(s_var_a,var1);
cl_300  = ncread(s_var_b,var1);
cl_305  = ncread(s_var_c,var1);

vlat=ncread(s_var_a,'lat');
vlon=ncread(s_var_a,'lon');

global_weights   % creates the glblatweight_new array

% 26281 time steps
tstart=20000;
tend  =26000;

clear cl_gmn;
cl_a_gmn  = zeros(tend-tstart,1);
cl_b_gmn  = zeros(tend-tstart,1);
cl_c_gmn  = zeros(tend-tstart,1);
index=1;

for ti=tstart:tend
  fullfield=squeeze(cl_295(:,:,ti));
  glblatweight_gen=glblatweight_new;
  global_wmean_quick;
  cl_a_gmn(index)=wgt_mean;
  fullfield=squeeze(cl_300(:,:,ti));
  global_wmean_quick;
  cl_b_gmn(index)=wgt_mean;
  fullfield=squeeze(cl_305(:,:,ti));
  global_wmean_quick;
  cl_c_gmn(index)=wgt_mean;
  index=index+1;
end

figure
plot(cl_a_gmn)
hold on
plot(cl_b_gmn)
plot(cl_c_gmn)

xlim([0 10000])
ylim([0.45 0.7])

title(model_generation)


