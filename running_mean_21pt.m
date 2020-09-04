rough_ts=incoming_ts;
% 21 point running mean
for ti=11:tendindex-10
  ts_smooth(ti-10)=(rough_ts(ti-10)+rough_ts(ti-9)+...
                   rough_ts(ti-8)+rough_ts(ti-7)+...
                   rough_ts(ti-6)+rough_ts(ti-5)+...
                   rough_ts(ti-4)+rough_ts(ti-3)+...
                   rough_ts(ti-2)+rough_ts(ti-1)+...
                   rough_ts(ti)+...
                   rough_ts(ti+1)+rough_ts(ti+2)+...
                   rough_ts(ti+3)+rough_ts(ti+4)+...
                   rough_ts(ti+5)+rough_ts(ti+6)+...
                   rough_ts(ti+7)+rough_ts(ti+8)+...
                   rough_ts(ti+9)+rough_ts(ti+10))/21.;
end
output_ts=ts_smooth;
clear rough_ts; clear ts_smooth;