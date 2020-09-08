%===========================================================================
% compute the subsidence fraction for the WalkerCell experiments
%
% look at subsidence fraction 
%
% levi silvers                                            sep 2020
%===========================================================================

% use the same paths as defined in WalkerCell.m

basepath='/Users/silvers/data/WalkerCell/testing_20181203/';

% lwstring
lwstring_a="_4K";
lwstring_b="_ent0p9";
lwstring_c="_ent0p9_noconv";

%lwstring_a="_4K_lwoff";
%lwstring_b="_ent0p9_lwoff";
%lwstring_c="_ent0p9_noconv_lwoff";

o_source_1km_daily    =strcat(basepath,'c10x4000L33_am4p0_1km_wlkr',lwstring_a,'/1979.6mn.atmos_daily_selvars.nc');
o_source_2km_daily    =strcat(basepath,'c50x2000L33_am4p0_2km_wlkr',lwstring_a,'/1979.6mn.atmos_daily_selvars.nc');

o_source_25km_daily   =strcat(basepath,'c8x160L33_am4p0_25km_wlkr',lwstring_b,'/1979th1983_daily.nc');
o_source_25km_l_daily =strcat(basepath,'c8x640L33_am4p0_25km_wlkr',lwstring_b,'/1979th1983_daily.nc');
o_source_E25km_daily  =strcat(basepath,'c8x160L33_am4p0_25km_wlkr',lwstring_c,'/1979th1983_daily.nc');

o_source_100km_s_daily=strcat(basepath,'c8x40L33_am4p0_100km_wlkr',lwstring_b,'/1979th1983_daily.nc');
o_source_100km_l_daily=strcat(basepath,'c8x160L33_am4p0_100km_wlkr',lwstring_b,'/1979th1983_daily.nc');

% read the data
omega_s_100km   = ncread(o_source_100km_s_daily,'w500');
omega_l_100km   = ncread(o_source_100km_l_daily,'w500');

omega_25km      = ncread(o_source_25km_daily,'w500');
omega_l_25km    = ncread(o_source_25km_l_daily,'w500');
omega_E25km     = ncread(o_source_E25km_daily,'w500');

omega_2km       = ncread(o_source_2km_daily,'w500');
omega_1km       = ncread(o_source_1km_daily,'w500');

% P1 domain
sub_1km_s=zeros(size(omega_1km));
sub_1km_s(omega_1km>0.0)=1;
m1=mean(sub_1km_s);
m2=squeeze(mean(m1));
sf_1_ts=1-m2;
sf_1_s=1-mean(m2)
sf_1_s_last4m=1-mean(m2(61:181,1))

sf_1km_rm=apply_crm_runmn(sf_1_ts);

% P2 domain
sub_2km_s=zeros(size(omega_2km));
sub_2km_s(omega_2km>0.0)=1;
m1=mean(sub_2km_s);
m2=squeeze(mean(m1));
sf_2_ts=1-m2;
sf_2_s=1-mean(m2)
sf_2_s_last4m=1-mean(m2(61:181,1))

sf_2km_rm=apply_crm_runmn(sf_2_ts);

% P25 small domain
sub_25km_s=zeros(size(omega_25km));
sub_25km_s(omega_25km>0.0)=1;
m1=mean(sub_25km_s);
m2=squeeze(mean(m1));
sf_25_ts=1-m2;
sf_25_s=1-mean(m2)
sf_25_s_last4y=1-mean(m2(365:1826,1))

sf_25km_rm=apply_gcm_runmn(sf_25_ts);

% E25 small domain
sub_E25km_s=zeros(size(omega_E25km));
sub_E25km_s(omega_E25km>0.0)=1;
m1=mean(sub_E25km_s);
m2=squeeze(mean(m1));
sf_E25_ts=1-m2;
sf_E25_s=1-mean(m2)
sf_E25_s_last4y=1-mean(m2(365:1826,1))

sf_E25km_rm=apply_gcm_runmn(sf_E25_ts);

% E25 large domain
sub_25km_l_s=zeros(size(omega_l_25km));
sub_25km_l_s(omega_l_25km>0.0)=1;
m1=mean(sub_25km_l_s);
m2=squeeze(mean(m1));
sf_25_l_ts=1-m2;
sf_25_l_s=1-mean(m2)
sf_25_l_s_last4y=1-mean(m2(365:1826,1))

sf_25km_l_rm=apply_gcm_runmn(sf_25_l_ts);

% E100 small domain
sub_100km_s_s=zeros(size(omega_s_100km));
sub_100km_s_s(omega_s_100km>0.0)=1;
m1=mean(sub_100km_s_s);
m2=squeeze(mean(m1));
sf_100_s_ts=1-m2;
sf_100_s_s=1-mean(m2)
sf_100_s_s_last4y=1-mean(m2(365:1826,1))

sf_100km_s_rm=apply_gcm_runmn(sf_100_s_ts);

% E100 large domain
sub_100km_l_s=zeros(size(omega_l_100km));
sub_100km_l_s(omega_l_100km>0.0)=1;
m1=mean(sub_100km_l_s);
m2=squeeze(mean(m1));
sf_100_l_ts=1-m2;
sf_100_l_s=1-mean(m2)
sf_100_l_s_last4y=1-mean(m2(365:1826,1))

sf_100km_l_rm=apply_gcm_runmn(sf_100_l_ts);


figure
plot(sf_100km_l_rm,'--r','LineWidth',1.5)
hold on
plot(sf_100km_s_rm,'r','LineWidth',1.5)
plot(sf_25km_l_rm,'--','Color',colyel,'LineWidth',1.5)
plot(sf_E25km_rm,'Color',colpur,'LineWidth',1.5)
plot(sf_25km_rm,'Color',colyel,'LineWidth',1.5)
plot(sf_2km_rm,'Color',colblu,'LineWidth',1.5)
plot(sf_1km_rm,'Color',colgrn,'LineWidth',1.5)
ylabel('Subsidence Fraction')
xlabel('days')
xlim([0 730])
ylim([0.5 0.9])
title('Walker Circulation Experiments with LWCRE on ')

