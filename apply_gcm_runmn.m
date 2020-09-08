function var=apply_gcm_runmn(boohiss)
% intended to be used on a GCM time series
% several scripts of varying length are available
% 1826 is the total length
%tendindex=1814;
tendindex=1826;
incoming_ts=boohiss;
running_mean
%running_mean_21pt
boohiss_sm=output_ts;

tendindex=tendindex-9;
%tendindex=tendindex-23;
incoming_ts=boohiss_sm;
running_mean;
var=output_ts;
