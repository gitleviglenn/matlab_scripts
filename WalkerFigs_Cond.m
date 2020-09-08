% plots domain mean vertical profiles for the total condensate

path_base='/Users/silvers/data/WalkerCell/'

path=strcat(path_base,'gauss_d/');
path_n=strcat(path_base,'testing_20181203/');

% default values for the first time WalkerCell is run:
experi=3 % experi=3 uses the ent0p9 experiment
exptype=0 % 0 is the default experimental configuration (lwcre is on)
% 2 corresponds to lwoff

%lwstring='4K_lwoff/';
lwstring='4K/';

lwcreonoff=' with LWCRE';

source_gcm_noconv=strcat('/Users/silvers/data/WalkerCell/testing_20181203/c8x160L33_am4p0_25km_wlkr_ent0p9_noconv/',yearstr,'.atmos_month_tmn.nc');
source_gcm_noconv_lwoff=strcat('/Users/silvers/data/WalkerCell/testing_20181203/c8x160L33_am4p0_25km_wlkr_ent0p9_noconv_lwoff/',yearstr,'.atmos_month_tmn.nc');
source_gcm_ctl=strcat('/Users/silvers/data/WalkerCell/testing_20181203/c8x160L33_am4p0_25km_wlkr_ent0p9/',yearstr,'.atmos_month_tmn.nc');
source_gcm_lwoff=strcat('/Users/silvers/data/WalkerCell/testing_20181203/c8x160L33_am4p0_25km_wlkr_ent0p9_lwoff/',yearstr,'.atmos_month_tmn.nc');

source_1km_month=strcat(path_n,'c10x4000L33_am4p0_1km_wlkr_',lwstring,'1979_6mn.atmos_month.nc');
source_2km_month=strcat(path_n,'c50x2000L33_am4p0_2km_wlkr_',lwstring,'1979_6mn.atmos_month.nc');
lwstring='4K_lwoff/';
source_1km_month_lwoff=strcat(path_n,'c10x4000L33_am4p0_1km_wlkr_',lwstring,'1979_6mn.atmos_month.nc');
source_2km_month_lwoff=strcat(path_n,'c50x2000L33_am4p0_2km_wlkr_',lwstring,'1979_6mn.atmos_month.nc');

source_25km_lg_month='/Users/silvers/data/WalkerCell/testing_20181203/c8x640L33_am4p0_25km_wlkr_ent0p9/1980th1983.atmos_month_tmn.nc';
source_25km_lg_month_lwoff='/Users/silvers/data/WalkerCell/testing_20181203/c8x640L33_am4p0_25km_wlkr_ent0p9_lwoff/1980th1983.atmos_month_tmn.nc';

% 100km domains
source_100km_sm_month='/Users/silvers/data/WalkerCell/testing_20181203/c8x40L33_am4p0_100km_wlkr_ent0p9/1980th1983.atmos_month_tmn.nc';
source_100km_sm_month_lwoff='/Users/silvers/data/WalkerCell/testing_20181203/c8x40L33_am4p0_100km_wlkr_ent0p9_lwoff/1980th1983.atmos_month_tmn.nc';
source_100km_lg_month='/Users/silvers/data/WalkerCell/testing_20181203/c8x160L33_am4p0_100km_wlkr_ent0p9/1980th1983.atmos_month_tmn.nc';
source_100km_lg_month_lwoff='/Users/silvers/data/WalkerCell/testing_20181203/c8x160L33_am4p0_100km_wlkr_ent0p9_lwoff/1980th1983.atmos_month_tmn.nc';

% 100km small
% lwcre on
liq_100km_ztmn=read_1var_ztmn(source_100km_sm_month,'tot_liq_amt');
liq_100km_prof=squeeze(mean(liq_100km_ztmn,1));
ice_100km_ztmn=read_1var_ztmn(source_100km_sm_month,'tot_ice_amt');
ice_100km_prof=squeeze(mean(ice_100km_ztmn,1));

% lwcre off
liq_100km_ztmn=read_1var_ztmn(source_100km_sm_month_lwoff,'tot_liq_amt');
liq_100km_lwoff_prof=squeeze(mean(liq_100km_ztmn,1));
ice_100km_ztmn=read_1var_ztmn(source_100km_sm_month_lwoff,'tot_ice_amt');
ice_100km_lwoff_prof=squeeze(mean(ice_100km_ztmn,1));

cond_100km_prof_ctl=ice_100km_prof+liq_100km_prof;
cond_100km_prof_lwoff=ice_100km_lwoff_prof+liq_100km_lwoff_prof;

% 100km large
% lwcre on
liq_100km_lg_ztmn=read_1var_ztmn(source_100km_lg_month,'tot_liq_amt');
liq_100km_lg_prof=squeeze(mean(liq_100km_lg_ztmn,1));
ice_100km_lg_ztmn=read_1var_ztmn(source_100km_lg_month,'tot_ice_amt');
ice_100km_lg_prof=squeeze(mean(ice_100km_lg_ztmn,1));

% lwcre off
liq_100km_lg_ztmn=read_1var_ztmn(source_100km_lg_month_lwoff,'tot_liq_amt');
liq_100km_lg_lwoff_prof=squeeze(mean(liq_100km_lg_ztmn,1));
ice_100km_lg_ztmn=read_1var_ztmn(source_100km_lg_month_lwoff,'tot_ice_amt');
ice_100km_lg_lwoff_prof=squeeze(mean(ice_100km_lg_ztmn,1));

cond_100km_lg_prof_ctl=ice_100km_lg_prof+liq_100km_lg_prof;
cond_100km_lg_prof_lwoff=ice_100km_lg_lwoff_prof+liq_100km_lg_lwoff_prof;

% 25km large domain
% lwcre on
liq_25km_lg_ztmn=read_1var_ztmn(source_25km_lg_month,'tot_liq_amt');
liq_25km_lg_prof=squeeze(mean(liq_25km_lg_ztmn,1));
ice_25km_lg_ztmn=read_1var_ztmn(source_25km_lg_month,'tot_ice_amt');
ice_25km_lg_prof=squeeze(mean(ice_25km_lg_ztmn,1));

% lwcre off
liq_25km_lg_ztmn=read_1var_ztmn(source_25km_lg_month_lwoff,'tot_liq_amt');
liq_25km_lg_lwoff_prof=squeeze(mean(liq_25km_lg_ztmn,1));
ice_25km_lg_ztmn=read_1var_ztmn(source_25km_lg_month_lwoff,'tot_ice_amt');
ice_25km_lg_lwoff_prof=squeeze(mean(ice_25km_lg_ztmn,1));

cond_25km_lg_prof_ctl=ice_25km_lg_prof+liq_25km_lg_prof;
cond_25km_lg_prof_lwoff=ice_25km_lg_lwoff_prof+liq_25km_lg_lwoff_prof;

%===========

liq_25km_ztmn=read_1var_ztmn(source_gcm_ctl,'tot_liq_amt');
liq_25km_prof=squeeze(mean(liq_25km_ztmn,1));
ice_25km_ztmn=read_1var_ztmn(source_gcm_ctl,'tot_ice_amt');
ice_25km_prof=squeeze(mean(ice_25km_ztmn,1));

cond_25km_prof_ctl=ice_25km_prof+liq_25km_prof;

liq_25km_ztmn=read_1var_ztmn(source_gcm_noconv,'tot_liq_amt');
liq_25km_prof=squeeze(mean(liq_25km_ztmn,1));
ice_25km_ztmn=read_1var_ztmn(source_gcm_noconv,'tot_ice_amt');
ice_25km_prof=squeeze(mean(ice_25km_ztmn,1));

cond_25km_prof_noconv=ice_25km_prof+liq_25km_prof;

liq_25km_ztmn=read_1var_ztmn(source_gcm_lwoff,'tot_liq_amt');
liq_25km_prof=squeeze(mean(liq_25km_ztmn,1));
ice_25km_ztmn=read_1var_ztmn(source_gcm_lwoff,'tot_ice_amt');
ice_25km_prof=squeeze(mean(ice_25km_ztmn,1));

cond_25km_prof_lwoff=ice_25km_prof+liq_25km_prof;

liq_25km_ztmn=read_1var_ztmn(source_gcm_noconv_lwoff,'tot_liq_amt');
liq_25km_prof=squeeze(mean(liq_25km_ztmn,1));
ice_25km_ztmn=read_1var_ztmn(source_gcm_noconv_lwoff,'tot_ice_amt');
ice_25km_prof=squeeze(mean(ice_25km_ztmn,1));

cond_25km_prof_noconv_lwoff=ice_25km_prof+liq_25km_prof;

liq_2km_ztmn=read_1var_ztmn(source_2km_month,'tot_liq_amt');
liq_2km_prof=squeeze(mean(liq_2km_ztmn,1));
ice_2km_ztmn=read_1var_ztmn(source_2km_month,'tot_ice_amt');
ice_2km_prof=squeeze(mean(ice_2km_ztmn,1));

cond_2km_prof_ctl=ice_2km_prof+liq_2km_prof;

liq_2km_ztmn=read_1var_ztmn(source_2km_month_lwoff,'tot_liq_amt');
liq_2km_prof=squeeze(mean(liq_2km_ztmn,1));
ice_2km_ztmn=read_1var_ztmn(source_2km_month_lwoff,'tot_ice_amt');
ice_2km_prof=squeeze(mean(ice_2km_ztmn,1));

cond_2km_prof_lwoff=ice_2km_prof+liq_2km_prof;

liq_1km_ztmn=read_1var_ztmn(source_1km_month,'tot_liq_amt');
liq_1km_prof=squeeze(mean(liq_1km_ztmn,1));
ice_1km_ztmn=read_1var_ztmn(source_1km_month,'tot_ice_amt');
ice_1km_prof=squeeze(mean(ice_1km_ztmn,1));

cond_1km_prof_ctl=ice_1km_prof+liq_1km_prof;

liq_1km_ztmn=read_1var_ztmn(source_1km_month_lwoff,'tot_liq_amt');
liq_1km_prof=squeeze(mean(liq_1km_ztmn,1));
ice_1km_ztmn=read_1var_ztmn(source_1km_month_lwoff,'tot_ice_amt');
ice_1km_prof=squeeze(mean(ice_1km_ztmn,1));

cond_1km_prof_lwoff=ice_1km_prof+liq_1km_prof;

% total zonal time mean condensate
liq_25km_tot_ztmn=liq_25km_ztmn+ice_25km_ztmn;

% scale the condensate to be g/kg rather than kg/kg
scfac=1000.

    %'YTickLabel',{'100','200','300','400','500','600','700','800','900','1000'},...
figure_condensation=figure
axes2 = axes('Parent',figure_condensation,'BoxStyle','full','YMinorTick','on',...
    'YTickLabel',{'100','200','','400','','600','','800','','1000'},...
    'YScale','log',...
    'YTick',[10000 20000 30000 40000 50000 60000 70000 80000 90000 100000],...
    'Layer','top',...
    'YDir','reverse',...
    'FontWeight','bold',...
    'FontSize',16);%,...
% apparently the position of the plot command makes a big difference
    %plot(cond_1km_prof_ctl,pfull_2km,'Color',colgrn,'LineWidth',2)
ylim(axes2,[10000 100000]);
box(axes2,'on');
hold(axes2,'on');
plot(scfac.*cond_1km_prof_ctl,pfull_2km,'Color',colgrn,'LineWidth',2)
set(gca,'Ydir','reverse')
set(gca,'YScale','log')
hold on
plot(scfac.*cond_1km_prof_lwoff,pfull_2km,'--','Color',colgrn,'LineWidth',2)
plot(scfac.*cond_2km_prof_ctl,pfull_2km,'Color',colblu,'LineWidth',2)
plot(scfac.*cond_2km_prof_lwoff,pfull_2km,'--','Color',colblu,'LineWidth',2)
plot(scfac.*cond_25km_prof_noconv,pfull_2km,'Color',colpur,'LineWidth',2)
plot(scfac.*cond_25km_prof_noconv_lwoff,pfull_2km,'--','Color',colpur,'LineWidth',2)
plot(scfac.*cond_25km_prof_ctl,pfull_2km,'Color',colyel,'LineWidth',2)
plot(scfac.*cond_25km_prof_lwoff,pfull_2km,'--','Color',colyel,'LineWidth',2)
title('Domain Mean Liq + Ice ')
xlabel('g/kg')
ylabel('presssure (hPa)')

figure_25km_condensation=figure
axes2 = axes('Parent',figure_25km_condensation,'BoxStyle','full','YMinorTick','on',...
    'YTickLabel',{'100','200','','400','','600','','800','','1000'},...
    'YScale','log',...
    'YTick',[10000 20000 30000 40000 50000 60000 70000 80000 90000 100000],...
    'Layer','top',...
    'YDir','reverse',...
    'FontWeight','bold',...
    'FontSize',16);%,...
% apparently the position of the plot command makes a big difference
    %plot(cond_1km_prof_ctl,pfull_2km,'Color',colgrn,'LineWidth',2)
ylim(axes2,[10000 100000]);
box(axes2,'on');
hold(axes2,'on');
plot(scfac.*cond_25km_prof_ctl,pfull_2km,'Color',colyel,'LineWidth',2)
set(gca,'Ydir','reverse')
set(gca,'YScale','log')
hold on
plot(scfac.*cond_25km_prof_lwoff,pfull_2km,'--','Color',colyel,'LineWidth',2)
plot(scfac.*cond_25km_lg_prof_ctl,pfull_2km,'Color',colyel,'LineWidth',3)
plot(scfac.*cond_25km_lg_prof_lwoff,pfull_2km,'--','Color',colyel,'LineWidth',3)
plot(scfac.*cond_100km_prof_ctl,pfull_2km,'red','LineWidth',2)
plot(scfac.*cond_100km_prof_lwoff,pfull_2km,'--','Color','red','LineWidth',2)
plot(scfac.*cond_100km_lg_prof_ctl,pfull_2km,'Color','red','LineWidth',3)
plot(scfac.*cond_100km_lg_prof_lwoff,pfull_2km,'--','Color','red','LineWidth',3)
title('Domain Mean Liq + Ice ')
xlabel('g/kg')
ylabel('presssure (hPa)')

figure_lg_condensation=figure
axes2 = axes('Parent',figure_lg_condensation,'BoxStyle','full','YMinorTick','on',...
    'YTickLabel',{'100','200','','400','','600','','800','','1000'},...
    'YScale','log',...
    'YTick',[10000 20000 30000 40000 50000 60000 70000 80000 90000 100000],...
    'Layer','top',...
    'YDir','reverse',...
    'FontWeight','bold',...
    'FontSize',16);%,...
% apparently the position of the plot command makes a big difference
    %plot(cond_1km_prof_ctl,pfull_2km,'Color',colgrn,'LineWidth',2)
ylim(axes2,[10000 100000]);
box(axes2,'on');
hold(axes2,'on');
plot(scfac.*cond_25km_lg_prof_ctl,pfull_2km,'Color',colyel,'LineWidth',2)
set(gca,'Ydir','reverse')
set(gca,'YScale','log')
hold on
%plot(scfac.*cond_25km_prof_lwoff,pfull_2km,'--','Color',colyel,'LineWidth',2)
%plot(scfac.*cond_25km_lg_prof_ctl,pfull_2km,'Color',colyel,'LineWidth',3)
plot(scfac.*cond_25km_lg_prof_lwoff,pfull_2km,'--','Color',colyel,'LineWidth',2)
%plot(scfac.*cond_100km_prof_ctl,pfull_2km,'red','LineWidth',2)
%plot(scfac.*cond_100km_prof_lwoff,pfull_2km,'--','Color','red','LineWidth',2)
plot(scfac.*cond_100km_lg_prof_ctl,pfull_2km,'Color','red','LineWidth',2)
plot(scfac.*cond_100km_lg_prof_lwoff,pfull_2km,'--','Color','red','LineWidth',2)
title('Domain Mean Liq + Ice ')
xlabel('g/kg')
ylabel('presssure (hPa)')


figure_sm_condensation=figure
axes2 = axes('Parent',figure_sm_condensation,'BoxStyle','full','YMinorTick','on',...
    'YTickLabel',{'100','200','','400','','600','','800','','1000'},...
    'YScale','log',...
    'YTick',[10000 20000 30000 40000 50000 60000 70000 80000 90000 100000],...
    'Layer','top',...
    'YDir','reverse',...
    'FontWeight','bold',...
    'FontSize',16);%,...
% apparently the position of the plot command makes a big difference
    %plot(cond_1km_prof_ctl,pfull_2km,'Color',colgrn,'LineWidth',2)
ylim(axes2,[10000 100000]);
box(axes2,'on');
hold(axes2,'on');
plot(scfac.*cond_25km_prof_ctl,pfull_2km,'Color',colyel,'LineWidth',2)
set(gca,'Ydir','reverse')
set(gca,'YScale','log')
hold on
plot(scfac.*cond_25km_prof_lwoff,pfull_2km,'--','Color',colyel,'LineWidth',2)
%plot(scfac.*cond_25km_lg_prof_ctl,pfull_2km,'Color',colyel,'LineWidth',3)
%plot(scfac.*cond_25km_lg_prof_lwoff,pfull_2km,'--','Color',colyel,'LineWidth',3)
plot(scfac.*cond_100km_prof_ctl,pfull_2km,'red','LineWidth',2)
plot(scfac.*cond_100km_prof_lwoff,pfull_2km,'--','Color','red','LineWidth',2)
%plot(scfac.*cond_100km_lg_prof_ctl,pfull_2km,'Color','red','LineWidth',3)
%plot(scfac.*cond_100km_lg_prof_lwoff,pfull_2km,'--','Color','red','LineWidth',3)
title('Domain Mean Liq + Ice ')
xlabel('g/kg')
ylabel('presssure (hPa)')

figure_25km_condensation=figure
axes2 = axes('Parent',figure_25km_condensation,'BoxStyle','full','YMinorTick','on',...
    'YTickLabel',{'100','200','','400','','600','','800','','1000'},...
    'YScale','log',...
    'YTick',[10000 20000 30000 40000 50000 60000 70000 80000 90000 100000],...
    'Layer','top',...
    'YDir','reverse',...
    'FontWeight','bold',...
    'FontSize',16);%,...
% apparently the position of the plot command makes a big difference
    %plot(cond_1km_prof_ctl,pfull_2km,'Color',colgrn,'LineWidth',2)
ylim(axes2,[10000 100000]);
box(axes2,'on');
hold(axes2,'on');
plot(scfac.*cond_25km_prof_ctl,pfull_2km,'Color',colyel,'LineWidth',2)
set(gca,'Ydir','reverse')
set(gca,'YScale','log')
hold on
plot(scfac.*cond_25km_prof_lwoff,pfull_2km,'--','Color',colyel,'LineWidth',2)
plot(scfac.*cond_25km_lg_prof_ctl,pfull_2km,'Color',colyel,'LineWidth',3)
plot(scfac.*cond_25km_lg_prof_lwoff,pfull_2km,'--','Color',colyel,'LineWidth',3)
%plot(scfac.*cond_100km_prof_ctl,pfull_2km,'red','LineWidth',2)
%plot(scfac.*cond_100km_prof_lwoff,pfull_2km,'--','Color','red','LineWidth',2)
%plot(scfac.*cond_100km_lg_prof_ctl,pfull_2km,'Color','red','LineWidth',3)
%plot(scfac.*cond_100km_lg_prof_lwoff,pfull_2km,'--','Color','red','LineWidth',3)
title('Domain Mean Liq + Ice ')
xlabel('g/kg')
ylabel('presssure (hPa)')

figure_100km_condensation=figure
axes2 = axes('Parent',figure_100km_condensation,'BoxStyle','full','YMinorTick','on',...
    'YTickLabel',{'100','200','','400','','600','','800','','1000'},...
    'YScale','log',...
    'YTick',[10000 20000 30000 40000 50000 60000 70000 80000 90000 100000],...
    'Layer','top',...
    'YDir','reverse',...
    'FontWeight','bold',...
    'FontSize',16);%,...
% apparently the position of the plot command makes a big difference
    %plot(cond_1km_prof_ctl,pfull_2km,'Color',colgrn,'LineWidth',2)
ylim(axes2,[10000 100000]);
box(axes2,'on');
hold(axes2,'on');
%plot(scfac.*cond_25km_prof_ctl,pfull_2km,'Color',colyel,'LineWidth',2)
plot(scfac.*cond_100km_prof_ctl,pfull_2km,'red','LineWidth',2)
set(gca,'Ydir','reverse')
set(gca,'YScale','log')
hold on
%plot(scfac.*cond_25km_prof_lwoff,pfull_2km,'--','Color',colyel,'LineWidth',2)
%plot(scfac.*cond_25km_lg_prof_ctl,pfull_2km,'Color',colyel,'LineWidth',3)
%plot(scfac.*cond_25km_lg_prof_lwoff,pfull_2km,'--','Color',colyel,'LineWidth',3)
plot(scfac.*cond_100km_prof_ctl,pfull_2km,'red','LineWidth',2)
plot(scfac.*cond_100km_prof_lwoff,pfull_2km,'--','Color','red','LineWidth',2)
plot(scfac.*cond_100km_lg_prof_ctl,pfull_2km,'Color','red','LineWidth',3)
plot(scfac.*cond_100km_lg_prof_lwoff,pfull_2km,'--','Color','red','LineWidth',3)
title('Domain Mean Liq + Ice ')
xlabel('g/kg')
ylabel('presssure (hPa)')




