%-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
% general script to compute feedback and sensitivity for global mean variables.
%
% levi silvers                                                  Oct 2019  
%-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

source='/Users/silvers/data/CAM/';
%source_mod=strcat(source,'CAM6_GCM_RCE/');

% create an array to store the data
% rad_ts_array=zeros(5,26281);
rad_ts_array=zeros(5,26257); % if the running mean is run.

% variables with the _avg suffix indicate a domain mean has been taken

%exp_string='CAM6_GCM_RCE_large295_0D_';

% define variable names
var1='rlut_avg';
var2='rlutcs_avg';
var3='rsut_avg';
var4='rsutcs_avg';
var5='rsdt_avg';

s_var1=strcat(source_mod,exp_string,var1,'.nc')
s_var2=strcat(source_mod,exp_string,var2,'.nc')
s_var3=strcat(source_mod,exp_string,var3,'.nc')
s_var4=strcat(source_mod,exp_string,var4,'.nc')
s_var5=strcat(source_mod,exp_string,var5,'.nc')

rlut    =ncread(s_var1,var1);
rlutcs  =ncread(s_var2,var2);
rsut    =ncread(s_var3,var3);
rsutcs  =ncread(s_var4,var4);
rsdt    =ncread(s_var5,var5);

toa_R     = rsdt-rsut-rlut;
toa_clr   = rsdt-rsutcs-rlutcs;
toa_cre   = toa_clr_R-toa_R;
toa_lwcre = rlutcs - rlut;
toa_swcre = rsutcs - rsut;

% compute a running mean over a 24 hour period
tendindex=26281;
incoming_ts=toa_R;
running_mean_24pt
toa_R_sm=idiotbox; % 26257

incoming_ts=toa_clr;
running_mean_24pt
toa_clr_sm=idiotbox; % 26257

incoming_ts=toa_cre;
running_mean_24pt
toa_cre_sm=idiotbox; % 26257

incoming_ts=toa_lwcre;
running_mean_24pt
toa_lwcre_sm=idiotbox; % 26257

incoming_ts=toa_swcre;
running_mean_24pt
toa_swcre_sm=idiotbox; % 26257


rad_ts_array(1,:)=toa_R_sm;
rad_ts_array(2,:)=toa_clr_sm;
rad_ts_array(3,:)=toa_cre_sm;
rad_ts_array(4,:)=toa_lwcre_sm;
rad_ts_array(5,:)=toa_swcre_sm;

 
