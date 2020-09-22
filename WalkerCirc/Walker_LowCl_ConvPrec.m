% compute correlations between low clouds and convective precip

%lwstring='4K_lwoff/';
lwstring='4K/';

lwcreonoff=' with LWCRE';

path='/Users/silvers/data/WalkerCell/testing_20181203/';

% for experiments with a grid-spacing of 25km
source_gcm_noconv      =strcat(path,'c8x160L33_am4p0_25km_wlkr_ent0p9_noconv/',yearstr,'.atmos_month_tmn.nc');
source_gcm_noconv_lwoff  =strcat(path,'c8x160L33_am4p0_25km_wlkr_ent0p9_noconv_lwoff/',yearstr,'.atmos_month_tmn.nc');
source_gcm_ctl         =strcat(path,'c8x160L33_am4p0_25km_wlkr_ent0p9/',yearstr,'.atmos_month_tmn.nc');
source_gcm_lg_ctl      =strcat(path,'c8x640L33_am4p0_25km_wlkr_ent0p9/',yearstr,'.atmos_month_tmn.nc');
source_gcm_lwoff       =strcat(path,'c8x160L33_am4p0_25km_wlkr_ent0p9_lwoff/',yearstr,'.atmos_month_tmn.nc');
source_gcm_lg_ctl_lwoff=strcat(path,'c8x640L33_am4p0_25km_wlkr_ent0p9_lwoff/',yearstr,'.atmos_month_tmn.nc');

% for experiments with a grid-spacing of 100km
source_100km_sm_month          =strcat(path,'c8x40L33_am4p0_100km_wlkr_ent0p9/19810101.atmos_month.nc');
source_100km_sm_month_lwoff    =strcat(path,'c8x40L33_am4p0_100km_wlkr_ent0p9_lwoff/19810101.atmos_month.nc');

source_100km_lg_month          =strcat(path,'c8x160L33_am4p0_100km_wlkr_ent0p9/19810101.atmos_month.nc');
source_100km_lg_month_lwoff    =strcat(path,'c8x160L33_am4p0_100km_wlkr_ent0p9_lwoff/19810101.atmos_month.nc');

% P25 small domain
source_general=source_gcm_ctl;
lowcloud_corr

source_general=source_gcm_lwoff;
lowcloud_corr

% P25 large domain
source_general=source_gcm_lg_ctl;
lowcloud_corr 

source_general=source_gcm_lg_ctl_lwoff;
lowcloud_corr

% P100 small domain
source_general=source_100km_sm_month;
lowcloud_corr

source_general=source_100km_sm_month_lwoff;
lowcloud_corr

% P100 large domain
source_general=source_100km_lg_month;
lowcloud_corr

source_general=source_100km_lg_month_lwoff;
lowcloud_corr

%clear low_cld,high_cld,conv_p
%clear low_cld_b,high_cld_b,conv_p_b
%
%low_cld  =ncread(source_100km_sm_month,'low_cld_amt');
%high_cld =ncread(source_100km_sm_month,'high_cld_amt');
%conv_p   =ncread(source_100km_sm_month,'prec_conv');
%%conv_p   =ncread(source_100km_sm_month,'prec_ls');
%
%low_cld_a=squeeze(mean(low_cld,1));
%low_cld_b=squeeze(mean(low_cld_a,1));
%low_cld_b
%high_cld_a=squeeze(mean(high_cld,1));
%high_cld_b=squeeze(mean(high_cld_a,1));
%high_cld_b
%conv_p_a=squeeze(mean(conv_p,1));
%conv_p_b=squeeze(mean(conv_p_a,1));
%conv_p_b
%
%'correlation of conv precip and low clouds'
%corrcoef(conv_p_b,low_cld_b)
%'correlation of conv precip and high clouds'
%corrcoef(conv_p_b,high_cld_b)
