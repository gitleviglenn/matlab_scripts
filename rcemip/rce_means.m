%-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
% general script to list and possibly tabulate statistics from rce runs.
% 
% variables with the _avg suffix indicate a domain mean has been taken         
%
% it looks like I still haven't downloaded the data for 295K pr in CAM5
%
% levi silvers                                                  Dec 2019       
%-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

source='/Users/silvers/data/CAM/';

model_generation='CAM5';
source_mod=strcat(source,model_generation,'_GCM_RCE/');

var1='pr_avg';          

% rad_ts_array=zeros(5,26281);                                                 
                             
% create string          
SSTst="295";
exp_string=strcat(model_generation,'_GCM_RCE_large',SSTst,'_0D_');
s_var1=strcat(source_mod,exp_string,var1,'.nc') 

% read data
pr_295    =ncread(s_var1,var1);
SSTst="300";
exp_string=strcat(model_generation,'_GCM_RCE_large',SSTst,'_0D_');
s_var1=strcat(source_mod,exp_string,var1,'.nc') 
pr_300    =ncread(s_var1,var1);
SSTst="305";
exp_string=strcat(model_generation,'_GCM_RCE_large',SSTst,'_0D_');
s_var1=strcat(source_mod,exp_string,var1,'.nc') 
pr_305    =ncread(s_var1,var1);

% scale precip to mm/day
86400*mean(pr_295)
86400*mean(pr_300)
86400*mean(pr_305)
