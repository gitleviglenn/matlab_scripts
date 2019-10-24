%---------------------------------------------------------------------------------
% running_mean_24yr.m
%---------------------------------------------------------------------------------
% smooths an incoming time series with a 24 point (12 on each side of t=0) 
% running mean
%
% usage example: 
% 
%  tendindex=26281;
%  incoming_ts=toa_cre;
%  running_mean_30yr;
%  toa_cre_sm=idiotbox;
%
% levi silvers                                                           oct 2019
%---------------------------------------------------------------------------------

rough_ts=incoming_ts;
halftime=12;
fulltime=2*halftime+1;
clear ts_smooth;
clear idiotbox;
for ti=halftime+1:tendindex-halftime
  ts_smooth(ti-halftime)=(rough_ts(ti-12)+...
		    rough_ts(ti-11)+rough_ts(ti-10)+...
		    rough_ts(ti-9)+rough_ts(ti-8)+...
		    rough_ts(ti-7)+rough_ts(ti-6)+...
		    rough_ts(ti-5)+rough_ts(ti-4)+...
		    rough_ts(ti-3)+rough_ts(ti-2)+rough_ts(ti-1)+...
		    rough_ts(ti)+...
		    rough_ts(ti+1)+rough_ts(ti+2)+...
		    rough_ts(ti+3)+rough_ts(ti+4)+...
		    rough_ts(ti+5)+rough_ts(ti+6)+...
		    rough_ts(ti+7)+rough_ts(ti+8)+...
		    rough_ts(ti+9)+rough_ts(ti+10)+...
		    rough_ts(ti+11)+rough_ts(ti+12))/fulltime;
end
idiotbox=ts_smooth;

'one more idiotbox computed'

