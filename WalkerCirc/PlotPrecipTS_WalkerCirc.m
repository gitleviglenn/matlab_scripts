%-------------------------------------------------------------------------------
% PlotPrecipTS_WalkerCirc.m
%
% levi silvers                                   may 2020
%-------------------------------------------------------------------------------

path_new='/Users/silvers/data/WalkerCell/testing_20181203';


% read in newer data from the 1km and 2km simululations

path_2km_ctl=strcat(path_new,'/c50x2000L33_am4p0_2km_wlkr_4K/','1979.6mn.atmos_daily_selvars.nc');
prec_2km_ctl_full=ncread(path_2km_ctl,'precip');
prec_2km_ctl_a=squeeze(mean(prec_2km_ctl_full,1));
prec_2km_ctl=squeeze(mean(prec_2km_ctl_a,1));

path_2km_lwoff=strcat(path_new,'/c50x2000L33_am4p0_2km_wlkr_4K_lwoff/','1979.6mn.atmos_daily_selvars.nc');
prec_2km_lwoff_full=ncread(path_2km_lwoff,'precip');
prec_2km_lwoff_a=squeeze(mean(prec_2km_lwoff_full,1));
prec_2km_lwoff=squeeze(mean(prec_2km_lwoff_a,1));

path_1km_ctl=strcat(path_new,'/c10x4000L33_am4p0_1km_wlkr_4K/','1979.6mn.atmos_daily_selvars.nc');
prec_1km_ctl_full=ncread(path_1km_ctl,'precip');
prec_1km_ctl_a=squeeze(mean(prec_1km_ctl_full,1));
prec_1km_ctl=squeeze(mean(prec_1km_ctl_a,1));

path_1km_lwoff=strcat(path_new,'/c10x4000L33_am4p0_1km_wlkr_4K_lwoff/','1979.6mn.atmos_daily_selvars.nc');
prec_1km_lwoff_full=ncread(path_1km_lwoff,'precip');
prec_1km_lwoff_a=squeeze(mean(prec_1km_lwoff_full,1));
prec_1km_lwoff=squeeze(mean(prec_1km_lwoff_a,1));

prec_2km_ctl_sm   =apply_crm_runmn(prec_2km_ctl);
prec_2km_lwoff_sm =apply_crm_runmn(prec_2km_lwoff);
prec_1km_ctl_sm   =apply_crm_runmn(prec_1km_ctl);
prec_1km_lwoff_sm =apply_crm_runmn(prec_1km_lwoff);
% code to plot 5 years of daily mean precip

path_exp_noconv_lwoff='/c8x160L33_am4p0_25km_wlkr_ent0p9_noconv_lwoff';
path_exp_ctl='/c8x160L33_am4p0_25km_wlkr_ent0p9';
path_exp_noconv='/c8x160L33_am4p0_25km_wlkr_ent0p9_noconv';
path_exp_lwoff='/c8x160L33_am4p0_25km_wlkr_ent0p9_lwoff';

path_fname='/1979th1983_daily.nc';

path_ctl=strcat(path_new,path_exp_ctl,path_fname);
path_lwoff=strcat(path_new,path_exp_lwoff,path_fname);
path_noconv=strcat(path_new,path_exp_noconv,path_fname);
path_noconv_lwoff=strcat(path_new,path_exp_noconv_lwoff,path_fname);

precip_25km_ctl_raw          =ncread(path_ctl,'precip');
precip_25km_lwoff_raw        =ncread(path_lwoff,'precip');
precip_25km_noconv_lwoff_raw =ncread(path_noconv_lwoff,'precip');
precip_25km_noconv_raw       =ncread(path_noconv,'precip');

%source_100km_sm_lwoff_daily  =strcat(path_100km_small_dly_lwoff,'/1979th1983_daily.nc');
%source_100km_sm_daily  =strcat(path_100km_small_dly,'/1979th1983_daily.nc');

precip_100km_sm_raw          =ncread(source_100km_sm_daily,'precip');
precip_100km_sm_lwoff_raw    =ncread(source_100km_sm_lwoff_daily,'precip');

precip_100km_sm_ztmn         =read_1var_ztmn(source_100km_sm_daily,'precip');
precip_100km_sm_lwoff_ztmn   =read_1var_ztmn(source_100km_sm_lwoff_daily,'precip');


% ctl
precip_25km_ctl_znm=mean(precip_25km_ctl_raw,2);

% ctl
precip_25km_ctl_znm=mean(precip_25km_ctl_raw,2);
p_25km_ctl_znm=scale.*(squeeze(precip_25km_ctl_znm));
precip_daily_ctl=squeeze(mean(p_25km_ctl_znm,1));

precip_daily_100km=scale.*(squeeze(mean(precip_100km_sm_ztmn,1)));

% lwoff 
precip_znm=mean(precip_25km_lwoff_raw,2);
p_znm=scale.*(squeeze(precip_znm));
precip_daily_lwoff=squeeze(mean(p_znm,1));

precip_daily_100km_lwoff=scale.*(squeeze(mean(precip_100km_sm_lwoff_ztmn,1)));

% noconv_lwoff 
precip_znm=mean(precip_25km_noconv_lwoff_raw,2);
p_znm=scale.*(squeeze(precip_znm));
precip_daily_noconv_lwoff=squeeze(mean(p_znm,1));

% noconv
precip_znm=mean(precip_25km_noconv_raw,2);
p_znm=scale.*(squeeze(precip_znm));
precip_daily_noconv=squeeze(mean(p_znm,1));

clear precip_25km_ctl_rm;
clear precip_25km_lwoff_rm;
clear precip_100km_ctl_rm;
clear precip_100km_lwoff_rm;




% perform running means
precip_25km_ctl_rm=apply_gcm_runmn(precip_daily_ctl);
precip_25km_lwoff_rm=apply_gcm_runmn(precip_daily_lwoff);
precip_100km_ctl_rm=apply_gcm_runmn(precip_daily_100km);
precip_100km_lwoff_rm=apply_gcm_runmn(precip_daily_100km_lwoff);

% calculate the mean precip values over the equilibrated period
yr1=365;
yr5=1826;
mn_100km_ctl=mean(precip_daily_100km(yr1:yr5))
mn_100km_lwoff=mean(precip_daily_100km_lwoff(yr1:yr5))
mn_25km_ctl=mean(precip_daily_ctl(yr1:yr5))
mn_25km_lwoff=mean(precip_daily_lwoff(yr1:yr5))
mn1=30;
mn6=181;
mn_2km_ctl=scale*mean(prec_2km_ctl(mn1:mn6))
mn_2km_lwoff=scale*mean(prec_2km_lwoff(mn1:mn6))
mn_1km_ctl=scale*mean(prec_1km_ctl(mn1:mn6))
mn_1km_lwoff=scale*mean(prec_1km_lwoff(mn1:mn6))

figure
plot(scale*prec_1km_ctl_sm,'Color',colgrn,'LineWidth',2)
hold on
plot(scale*prec_1km_lwoff_sm,'--','Color',colgrn,'LineWidth',2)
plot(scale*prec_2km_ctl_sm,'Color',colblu,'LineWidth',2)
plot(scale*prec_2km_lwoff_sm,'--','Color',colblu,'LineWidth',2)
plot(precip_25km_ctl_rm(1:730),'Color',colyel,'LineWidth',2)
plot(precip_25km_lwoff_rm(1:730),'--','Color',colyel,'LineWidth',2)
plot(precip_100km_ctl_rm(1:730),'r','LineWidth',2);
plot(precip_100km_lwoff_rm(1:730),'--r','LineWidth',2);
scatter(745,mn_1km_lwoff,100,'MarkerEdgeColor',[0.4660 0.6740 0.1880])
scatter(745,mn_1km_ctl,100,'MarkerEdgeColor',[0.4660 0.6740 0.1880],'MarkerFaceColor',[0.4660 0.6740 0.1880])
scatter(745,mn_2km_lwoff,100,'MarkerEdgeColor',[0.3010 0.7450 0.9330])
scatter(745,mn_2km_ctl,100,'MarkerEdgeColor',[0.3010 0.7450 0.9330],'MarkerFaceColor',[0.3010 0.7450 0.9330])
scatter(745,mn_25km_ctl,100,'MarkerEdgeColor',[0.9290 0.6940,0.1250],'MarkerFaceColor',[0.9290 0.6940,0.1250])
scatter(745,mn_25km_lwoff,100,'MarkerEdgeColor',[0.9290 0.6940 0.1250])
scatter(745,mn_100km_ctl,100,'MarkerFaceColor','r','MarkerEdgeColor','r')
scatter(745,mn_100km_lwoff,100,'MarkerEdgeColor','r')
%ytitle('mm/day')
%xtitle('days')
xlabel('days')
xlim([0 760])
ylim([1 6])
ylabel('mm/day')
title('Domain Mean Precipitation')

%colyel=[0.9290,0.6940,0.1250];  % used for 25km runs
%colblu=[0.3010,0.7450,0.9330];  % 2 km runs
%colgrn=[0.4660,0.6740,0.1880];  % 1 km runs



