source='/Users/silvers/data/cfmip_toafluxes/';

%exp_name='amip-m4K';
%exp_name='amip';

%amip_control=true;

if amip_control 
  testboolean='stop messing around you fool'
  timeend=72; % for 5 year chunks
  %exp_string=strcat('_Amon_GFDL-CM4_',exp_name,'_r1i1p1f1_gr1_197901-198412');
  %exp_string=strcat('_Amon_GFDL-CM4_',exp_name,'_r1i1p1f1_gr1_198501-199012');
  %exp_string=strcat('_Amon_GFDL-CM4_',exp_name,'_r1i1p1f1_gr1_199101-199612');
  %exp_string=strcat('_Amon_GFDL-CM4_',exp_name,'_r1i1p1f1_gr1_199701-200212');
  %exp_string=strcat('_Amon_GFDL-CM4_',exp_name,'_r1i1p1f1_gr1_200301-200812');
  %exp_string=strcat('_Amon_GFDL-CM4_',exp_name,'_r1i1p1f1_gr1_200901-201412');
else
  timeend=432; % for 36 year simulations
  exp_string=strcat('_Amon_GFDL-CM4_',exp_name,'_r1i1p1f1_gr1_197901-201412');
end

%exp_string=strcat('_Amon_GFDL-CM4_',exp_name,'_r1i1p1f1_gr1_197901-201412');
%exp_string=strcat('_Amon_GFDL-CM4_',exp_name,'_r1i1p1f1_gr1_197901-198412');
timelength=timeend;

var1='rlut';
var2='rlutcs';
var3='rsut';
var4='rsutcs';
var5='rsdt';

rad_ts_array=zeros(5,timelength); % if the running mean is run.

s_var1=strcat(source,var1,exp_string,'.nc');
s_var2=strcat(source,var2,exp_string,'.nc');
s_var3=strcat(source,var3,exp_string,'.nc');
s_var4=strcat(source,var4,exp_string,'.nc');
s_var5=strcat(source,var5,exp_string,'.nc');

rlut_ts   = ncread(s_var1,var1);
rlutcs_ts = ncread(s_var2,var2);
rsut_ts   = ncread(s_var3,var3);
rsutcs_ts = ncread(s_var4,var4);
rsdt_ts   = ncread(s_var5,var5);

% call global_weights (if the dimensions still work, they may be switched...)

vlon=ncread(s_var1,'lon');
vlat=ncread(s_var1,'lat');

global_weights

tindex=timeend;
nyears=tindex/12;

%fullfield=squeeze(rlut(:,:,1));
%global_wmean_script

clearvars rlut_gmn_ts rlutcs_gmn_ts rsut_gmn_ts rsutcs_gmn_ts rsdt_gmn_ts

for ti=1:tindex;

  fullfield=squeeze(rlut_ts(:,:,ti));
  glblatweight_gen=glblatweight_new; % this switches the dimensions used in m2009
  global_wmean_quick;
  rlut_gmn_ts(ti)=wgt_mean;

  fullfield=squeeze(rlutcs_ts(:,:,ti));
  glblatweight_gen=glblatweight_new; % this switches the dimensions used in m2009
  global_wmean_quick;
  rlutcs_gmn_ts(ti)=wgt_mean;

  fullfield=squeeze(rsut_ts(:,:,ti));
  glblatweight_gen=glblatweight_new; % this switches the dimensions used in m2009
  global_wmean_quick;
  rsut_gmn_ts(ti)=wgt_mean;

  fullfield=squeeze(rsutcs_ts(:,:,ti));
  glblatweight_gen=glblatweight_new; % this switches the dimensions used in m2009
  global_wmean_quick;
  rsutcs_gmn_ts(ti)=wgt_mean;

  fullfield=squeeze(rsdt_ts(:,:,ti));
  glblatweight_gen=glblatweight_new; % this switches the dimensions used in m2009
  global_wmean_quick;
  rsdt_gmn_ts(ti)=wgt_mean;

end

toa_R     =zeros(1,timelength); % if the running mean is run.
toa_clr   =zeros(1,timelength); % if the running mean is run.
toa_cre   =zeros(1,timelength); % if the running mean is run.
toa_lwcre =zeros(1,timelength); % if the running mean is run.
toa_swcre =zeros(1,timelength); % if the running mean is run.

toa_R     = rsdt_gmn_ts-rsut_gmn_ts-rlut_gmn_ts;
toa_clr   = rsdt_gmn_ts-rsutcs_gmn_ts-rlutcs_gmn_ts;
toa_cre   = toa_clr-toa_R;
toa_lwcre = rlutcs_gmn_ts - rlut_gmn_ts;
toa_swcre = rsutcs_gmn_ts - rsut_gmn_ts;

 rad_ts_array(1,:)=toa_R;
 rad_ts_array(2,:)=toa_clr; 
 rad_ts_array(3,:)=toa_cre;
 rad_ts_array(4,:)=toa_lwcre;
 rad_ts_array(5,:)=toa_swcre;
