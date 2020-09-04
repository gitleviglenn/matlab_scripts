%% define colors
colyel=[0.9290,0.6940,0.1250];  % 25km
colblu=[0.3010,0.7450,0.9330];  % 2km
colgrn=[0.4660,0.6740,0.1880];  % 1km
colpur=[0.50,0.39,0.94]; % used for E25km

conv=60*60*24; % convert to Kelvin per day
cltscale=100. % convert to cloud fraction

% define paths: 

source_gcm_month='/Users/silvers/data/WalkerCell/testing_20181203/c8x160L33_am4p0_25km_wlkr_ent0p9/1980th1983.atmos_month_tmn.nc';
source_gcm_month_noconv='/Users/silvers/data/WalkerCell/testing_20181203/c8x160L33_am4p0_25km_wlkr_ent0p9_noconv/1980th1983.atmos_month_tmn.nc';
source_gcm_month='/Users/silvers/data/WalkerCell/testing_20181203/c8x160L33_am4p0_25km_wlkr_ent0p9/1980th1983.atmos_month_tmn.nc';
source_100km_sm_month='/Users/silvers/data/WalkerCell/testing_20181203/c8x40L33_am4p0_100km_wlkr_ent0p9/1980th1983.atmos_month_tmn.nc';
source_100km_lg_month='/Users/silvers/data/WalkerCell/testing_20181203/c8x160L33_am4p0_100km_wlkr_ent0p9/1980th1983.atmos_month_tmn.nc';
source_2km_month='/Users/silvers/data/WalkerCell/testing_20181203/c50x2000L33_am4p0_2km_wlkr_4K/1979_6mn.atmos_month.nc';
source_1km_month='/Users/silvers/data/WalkerCell/testing_20181203/c10x4000L33_am4p0_1km_wlkr_4K/1979_6mn.atmos_month.nc';

% call the script that will open and process data: 
cf_tdtlw_open

tdtlw_ctl_1km_sub_prof=tdtlw_1km_sub_prof;
tdtlw_ctl_2km_sub_prof=tdtlw_2km_sub_prof;
tdtlw_ctl_25km_sub_prof=tdtlw_25km_sub_prof;
tdtlw_ctl_E25km_sub_prof=tdtlw_E25km_sub_prof;
tdtlw_ctl_100km_sub_prof=tdtlw_100km_sub_prof;

clt_ctl_1km_sub_prof=clt_1km_sub_prof;
clt_ctl_2km_sub_prof=clt_2km_sub_prof;
clt_ctl_25km_sub_prof=clt_25km_sub_prof;
clt_ctl_E25km_sub_prof=clt_E25km_sub_prof;
clt_ctl_100km_sub_prof=clt_100km_sub_prof;

% define source paths for files from the lwoff experiments: 
source_gcm_month='/Users/silvers/data/WalkerCell/testing_20181203/c8x160L33_am4p0_25km_wlkr_ent0p9_lwoff/1980th1983.atmos_month_tmn.nc';
source_gcm_month_noconv='/Users/silvers/data/WalkerCell/testing_20181203/c8x160L33_am4p0_25km_wlkr_ent0p9_noconv_lwoff/1980th1983.atmos_month_tmn.nc';
source_100km_sm_month='/Users/silvers/data/WalkerCell/testing_20181203/c8x40L33_am4p0_100km_wlkr_ent0p9_lwoff/1980th1983.atmos_month_tmn.nc';
source_100km_lg_month='/Users/silvers/data/WalkerCell/testing_20181203/c8x160L33_am4p0_100km_wlkr_ent0p9_lwoff/1980th1983.atmos_month_tmn.nc';
source_2km_month='/Users/silvers/data/WalkerCell/testing_20181203/c50x2000L33_am4p0_2km_wlkr_4K_lwoff/1979_6mn.atmos_month.nc';
source_1km_month='/Users/silvers/data/WalkerCell/testing_20181203/c10x4000L33_am4p0_1km_wlkr_4K_lwoff/1979_6mn.atmos_month.nc';

% call the script that will open and process data: 
cf_tdtlw_open

tdtlw_lwoff_1km_sub_prof=tdtlw_1km_sub_prof;
tdtlw_lwoff_2km_sub_prof=tdtlw_2km_sub_prof;
tdtlw_lwoff_25km_sub_prof=tdtlw_25km_sub_prof;
tdtlw_lwoff_E25km_sub_prof=tdtlw_E25km_sub_prof;
tdtlw_lwoff_100km_sub_prof=tdtlw_100km_sub_prof;

clt_lwoff_1km_sub_prof=clt_1km_sub_prof;
clt_lwoff_2km_sub_prof=clt_2km_sub_prof;
clt_lwoff_25km_sub_prof=clt_25km_sub_prof;
clt_lwoff_E25km_sub_prof=clt_E25km_sub_prof;
clt_lwoff_100km_sub_prof=clt_100km_sub_prof;



figure_clftdt_prof=figure
subplot(2,2,2)
ax2=gca
plot(tdtlw_ctl_1km_sub_prof,pfull_2km,'Color',colgrn,'LineWidth',1.5)
set(ax2,'YScale','Log')
set(ax2,'Ydir','reverse')
ylim(ax2,[10000 100000]);
ax2.YTick = [10000 20000 30000 40000 50000 60000 70000 80000 90000 100000]
%ax2.YTickLabels = [100 200 300 " " 500 " " 700 " " 900 1000]
ax2.YTickLabels = [" " " " " " " " " " " " " " " " " " " "]
ax2.FontSize = 14;
hold on
plot(tdtlw_ctl_2km_sub_prof,pfull_2km,'Color',colblu,'LineWidth',1.5)
plot(tdtlw_ctl_25km_sub_prof,pfull_2km,'Color',colyel,'LineWidth',1.5)
plot(tdtlw_ctl_E25km_sub_prof,pfull_2km,'Color',colpur,'LineWidth',1.5)
plot(tdtlw_ctl_100km_sub_prof,pfull_2km,'r','LineWidth',1.5)
ax2.XLim=[-10 0];
%title('tdtlw in Subsiding region with LWCRE')
xlabel('K/day')
tit_tdtlw=strcat('LW Radiative Heating');
title(tit_tdtlw)

subplot(2,2,1)
plot(clt_ctl_1km_sub_prof,pfull_2km,'Color',colgrn,'LineWidth',1.5)
ax1=gca;
set(ax1,'YScale','Log')
set(ax1,'Ydir','reverse')
ylim(ax1,[10000 100000]);
ax1.YTick = [10000 20000 30000 40000 50000 60000 70000 80000 90000 100000]
ax1.YTickLabels = [100 200 300 " " 500 " " 700 " " 900 1000]
ax1.FontSize = 14;
hold on
plot(clt_ctl_2km_sub_prof,pfull_2km,'Color',colblu,'LineWidth',1.5)
plot(clt_ctl_25km_sub_prof,pfull_2km,'Color',colyel,'LineWidth',1.5)
plot(clt_ctl_E25km_sub_prof,pfull_2km,'Color',colpur,'LineWidth',1.5)
plot(clt_ctl_100km_sub_prof,pfull_2km,'r','LineWidth',1.5)
ax1.XLim=[0 30];
xlabel('%')
ylabel('hPa')
tit_clt=strcat('Cloud Fraction');
title(tit_clt)

subplot(2,2,3)
ax3=gca;
plot(clt_lwoff_1km_sub_prof,pfull_2km,'Color',colgrn,'LineWidth',1.5)
set(ax3,'YScale','Log')
set(ax3,'Ydir','reverse')
ylim(ax3,[10000 100000]);
ax3.YTick = [10000 20000 30000 40000 50000 60000 70000 80000 90000 100000]
ax3.YTickLabels = [100 200 300 " " 500 " " 700 " " 900 1000]
%ax3.YTickLabels = [" " " " " " " " " " " " " " " " " " " "]
ax3.FontSize = 14;
ax3.XLim=[0 20];
hold on
plot(clt_lwoff_2km_sub_prof,pfull_2km,'Color',colblu,'LineWidth',1.5)
plot(clt_lwoff_25km_sub_prof,pfull_2km,'Color',colyel,'LineWidth',1.5)
plot(clt_lwoff_E25km_sub_prof,pfull_2km,'Color',colpur,'LineWidth',1.5)
plot(clt_lwoff_100km_sub_prof,pfull_2km,'r','LineWidth',1.5)
xlabel('%')
ylabel('hPa')
tit_clt=strcat('Cloud Fraction');
title(tit_clt)

subplot(2,2,4)
plot(tdtlw_lwoff_1km_sub_prof,pfull_2km,'Color',colgrn,'LineWidth',1.5)
ax4=gca;
set(ax4,'YScale','Log')
set(ax4,'Ydir','reverse')
ylim(ax4,[10000 100000]);
ax4.YTick = [10000 20000 30000 40000 50000 60000 70000 80000 90000 100000]
%ax4.YTickLabels = [100 200 300 " " 500 " " 700 " " 900 1000]
ax4.YTickLabels = [" " " " " " " " " " " " " " " " " " " "]
ax4.FontSize = 14;
ax4.XLim=[-10 0];
hold on
plot(tdtlw_lwoff_2km_sub_prof,pfull_2km,'Color',colblu,'LineWidth',1.5)
plot(tdtlw_lwoff_25km_sub_prof,pfull_2km,'Color',colyel,'LineWidth',1.5)
plot(tdtlw_lwoff_E25km_sub_prof,pfull_2km,'Color',colpur,'LineWidth',1.5)
plot(tdtlw_lwoff_100km_sub_prof,pfull_2km,'r','LineWidth',1.5)
tit_tdtlw=strcat('LW Radiative Heating');
xlabel('K/day')
title(tit_tdtlw)


