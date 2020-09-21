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


lcl_25km_lg=ncread(source_25km_lg_month,'low_cld_amt');
lcl_25km_lg_lwoff=ncread(source_25km_lg_month_lwoff,'low_cld_amt');
lcl_25km_sm=ncread(source_gcm_ctl,'low_cld_amt');
lcl_25km_sm_lwoff=ncread(source_gcm_lwoff,'low_cld_amt');
lcl_E25km = ncread(source_gcm_noconv,'low_cld_amt');
lcl_E25km_lwoff = ncread(source_gcm_noconv_lwoff,'low_cld_amt');

% average in space
lcl_E25km_a=squeeze(mean(lcl_E25km,1));
lcl_E25km_b=squeeze(mean(lcl_E25km_a,1));
lcl_E25km_c=squeeze(mean(lcl_E25km_b,1));

lcl_E25km_a=squeeze(mean(lcl_E25km_lwoff,1));
lcl_E25km_b=squeeze(mean(lcl_E25km_a,1));
lcl_E25km_lwoff_c=squeeze(mean(lcl_E25km_b,1));

lcl_25km_lg_a=squeeze(mean(lcl_25km_lg,1));
lcl_25km_lg_b=squeeze(mean(lcl_25km_lg_a,1));
lcl_25km_lg_c=squeeze(mean(lcl_25km_lg_b,1));

lcl_25km_lg_lwoff_a=squeeze(mean(lcl_25km_lg_lwoff,1));
lcl_25km_lg_lwoff_b=squeeze(mean(lcl_25km_lg_lwoff_a,1));
lcl_25km_lg_lwoff_c=squeeze(mean(lcl_25km_lg_lwoff_b,1));

lcl_25km_sm_a=squeeze(mean(lcl_25km_sm,1));
lcl_25km_sm_b=squeeze(mean(lcl_25km_sm_a,1));
lcl_25km_sm_c=squeeze(mean(lcl_25km_sm_b,1));

lcl_25km_sm_lwoff_a=squeeze(mean(lcl_25km_sm_lwoff,1));
lcl_25km_sm_lwoff_b=squeeze(mean(lcl_25km_sm_lwoff_a,1));
lcl_25km_sm_lwoff_c=squeeze(mean(lcl_25km_sm_lwoff_b,1));

%
lcl_100km_lg=ncread(source_100km_lg_month,'low_cld_amt');
lcl_100km_lg_lwoff=ncread(source_100km_lg_month_lwoff,'low_cld_amt');
lcl_100km_sm=ncread(source_100km_sm_month,'low_cld_amt');
lcl_100km_sm_lwoff=ncread(source_100km_sm_month_lwoff,'low_cld_amt');

% average in space
lcl_100km_lg_a=squeeze(mean(lcl_100km_lg,1));
lcl_100km_lg_b=squeeze(mean(lcl_100km_lg_a,1));
lcl_100km_lg_c=squeeze(mean(lcl_100km_lg_b,1));

lcl_100km_lg_lwoff_a=squeeze(mean(lcl_100km_lg_lwoff,1));
lcl_100km_lg_lwoff_b=squeeze(mean(lcl_100km_lg_lwoff_a,1));
lcl_100km_lg_lwoff_c=squeeze(mean(lcl_100km_lg_lwoff_b,1));

lcl_100km_sm_a=squeeze(mean(lcl_100km_sm,1));
lcl_100km_sm_b=squeeze(mean(lcl_100km_sm_a,1));
lcl_100km_sm_c=squeeze(mean(lcl_100km_sm_b,1));

lcl_100km_sm_lwoff_a=squeeze(mean(lcl_100km_sm_lwoff,1));
lcl_100km_sm_lwoff_b=squeeze(mean(lcl_100km_sm_lwoff_a,1));
lcl_100km_sm_lwoff_c=squeeze(mean(lcl_100km_sm_lwoff_b,1));



%===========

q_1km_ztmn_prof       =squeeze(mean(q_1km_ztmn,1));
q_2km_ztmn_prof       =squeeze(mean(q_2km_ztmn,1));
q_25km_ztmn_prof      =squeeze(mean(q_25km_ztmn,1));
q_E25km_ztmn_prof     =squeeze(mean(q_E25km_ztmn,1));
q_100km_ztmn_prof     =squeeze(mean(q_100km_ztmn,1));
q_100km_lg_ztmn_prof  =squeeze(mean(q_100km_lg_ztmn,1));

q_1km_lwoff_ztmn_prof       =squeeze(mean(q_1km_lwoff_ztmn,1));
q_2km_lwoff_ztmn_prof       =squeeze(mean(q_2km_lwoff_ztmn,1));
q_25km_lwoff_ztmn_prof      =squeeze(mean(q_25km_lwoff_ztmn,1));
q_E25km_lwoff_ztmn_prof     =squeeze(mean(q_E25km_lwoff_ztmn,1));

q_100km_bias    =q_100km_ztmn_prof-q_1km_ztmn_prof;
q_100km_lg_bias =q_100km_lg_ztmn_prof-q_1km_ztmn_prof;
q_25km_bias     =q_25km_ztmn_prof-q_1km_ztmn_prof;
q_E25km_bias    =q_E25km_ztmn_prof-q_1km_ztmn_prof;
q_2km_bias      =q_2km_ztmn_prof-q_1km_ztmn_prof;
q_1km_bias      =q_1km_ztmn_prof-q_1km_ztmn_prof;

q_25km_lwoff_bias     =q_25km_lwoff_ztmn_prof-q_1km_ztmn_prof;
q_E25km_lwoff_bias    =q_E25km_lwoff_ztmn_prof-q_1km_ztmn_prof;
q_2km_lwoff_bias      =q_2km_lwoff_ztmn_prof-q_1km_ztmn_prof;
q_1km_lwoff_bias      =q_1km_lwoff_ztmn_prof-q_1km_ztmn_prof;

%===========

liq_25km_ztmn=read_1var_ztmn(source_gcm_ctl,'tot_liq_amt');
liq_25km_prof=squeeze(mean(liq_25km_ztmn,1));
ice_25km_ztmn=read_1var_ztmn(source_gcm_ctl,'tot_ice_amt');
ice_25km_prof=squeeze(mean(ice_25km_ztmn,1));

cond_25km_prof_ctl=ice_25km_prof+liq_25km_prof;

liq_25km_ztmn=read_1var_ztmn(source_gcm_noconv,'tot_liq_amt');
liq_E25km_prof=squeeze(mean(liq_25km_ztmn,1));
ice_25km_ztmn=read_1var_ztmn(source_gcm_noconv,'tot_ice_amt');
ice_E25km_prof=squeeze(mean(ice_25km_ztmn,1));

cond_E25km_prof=ice_E25km_prof+liq_E25km_prof;

liq_25km_lwoff_ztmn=read_1var_ztmn(source_gcm_lwoff,'tot_liq_amt');
liq_25km_prof_lwoff=squeeze(mean(liq_25km_lwoff_ztmn,1));
ice_25km_lwoff_ztmn=read_1var_ztmn(source_gcm_lwoff,'tot_ice_amt');
ice_25km_prof_lwoff=squeeze(mean(ice_25km_lwoff_ztmn,1));

cond_25km_prof_lwoff=ice_25km_prof_lwoff+liq_25km_prof_lwoff;

liq_25km_ztmn=read_1var_ztmn(source_gcm_noconv_lwoff,'tot_liq_amt');
liq_E25km_prof_lwoff=squeeze(mean(liq_25km_ztmn,1));
ice_25km_ztmn=read_1var_ztmn(source_gcm_noconv_lwoff,'tot_ice_amt');
ice_E25km_prof_lwoff=squeeze(mean(ice_25km_ztmn,1));

cond_E25km_prof_lwoff=ice_E25km_prof_lwoff+liq_E25km_prof_lwoff;

liq_2km_ztmn=read_1var_ztmn(source_2km_month,'tot_liq_amt');
liq_2km_prof=squeeze(mean(liq_2km_ztmn,1));
ice_2km_ztmn=read_1var_ztmn(source_2km_month,'tot_ice_amt');
ice_2km_prof=squeeze(mean(ice_2km_ztmn,1));

cond_2km_prof_ctl=ice_2km_prof+liq_2km_prof;

liq_2km_lwoff_ztmn=read_1var_ztmn(source_2km_month_lwoff,'tot_liq_amt');
liq_2km_prof_lwoff=squeeze(mean(liq_2km_lwoff_ztmn,1));
ice_2km_lwoff_ztmn=read_1var_ztmn(source_2km_month_lwoff,'tot_ice_amt');
ice_2km_prof_lwoff=squeeze(mean(ice_2km_lwoff_ztmn,1));

cond_2km_prof_lwoff=ice_2km_prof_lwoff+liq_2km_prof_lwoff;

liq_1km_ztmn=read_1var_ztmn(source_1km_month,'tot_liq_amt');
liq_1km_prof=squeeze(mean(liq_1km_ztmn,1));
ice_1km_ztmn=read_1var_ztmn(source_1km_month,'tot_ice_amt');
ice_1km_prof=squeeze(mean(ice_1km_ztmn,1));

cond_1km_prof_ctl=ice_1km_prof+liq_1km_prof;

liq_1km_lwoff_ztmn=read_1var_ztmn(source_1km_month_lwoff,'tot_liq_amt');
liq_1km_prof_lwoff=squeeze(mean(liq_1km_lwoff_ztmn,1));
ice_1km_lwoff_ztmn=read_1var_ztmn(source_1km_month_lwoff,'tot_ice_amt');
ice_1km_prof_lwoff=squeeze(mean(ice_1km_lwoff_ztmn,1));

cond_1km_prof_lwoff=ice_1km_prof_lwoff+liq_1km_prof_lwoff;

% total zonal time mean condensate
liq_25km_tot_ztmn=liq_25km_ztmn+ice_25km_ztmn;

% scale the condensate to be g/kg rather than kg/kg
scfac=1000.

    %'YTickLabel',{'100','200','300','400','500','600','700','800','900','1000'},...
figure_condensation=figure
%subfigure(1,2,1)
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
plot(scfac.*cond_E25km_prof,pfull_2km,'Color',colpur,'LineWidth',2)
plot(scfac.*cond_E25km_prof_lwoff,pfull_2km,'--','Color',colpur,'LineWidth',2)
plot(scfac.*cond_25km_prof_ctl,pfull_2km,'Color',colyel,'LineWidth',2)
plot(scfac.*cond_25km_prof_lwoff,pfull_2km,'--','Color',colyel,'LineWidth',2)
title('Domain Mean Liq + Ice ')
xlabel('g/kg')
ylabel('presssure (hPa)')

% plot ice and liq individually
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
ylim(axes2,[10000 100000]);
box(axes2,'on');
hold(axes2,'on');
plot(scfac.*cond_1km_prof_ctl,pfull_2km,'Color',colgrn,'LineWidth',2)
set(gca,'Ydir','reverse')
set(gca,'YScale','log')
hold on
set(gca,'Ydir','reverse')
plot(scfac.*ice_1km_prof,pfull_2km,'Color',colgrn,'LineWidth',1)
plot(scfac.*liq_1km_prof,pfull_2km,'Color',colgrn,'LineWidth',1)
plot(scfac.*cond_1km_prof_lwoff,pfull_2km,'--','Color',colgrn,'LineWidth',2)
plot(scfac.*cond_2km_prof_ctl,pfull_2km,'Color',colblu,'LineWidth',2)
plot(scfac.*ice_2km_prof,pfull_2km,'Color',colblu,'LineWidth',1)
plot(scfac.*liq_2km_prof,pfull_2km,'Color',colblu,'LineWidth',1)
plot(scfac.*cond_2km_prof_lwoff,pfull_2km,'--','Color',colblu,'LineWidth',2)
plot(scfac.*cond_E25km_prof,pfull_2km,'Color',colpur,'LineWidth',2)
plot(scfac.*ice_E25km_prof,pfull_2km,'Color',colpur,'LineWidth',1)
plot(scfac.*liq_E25km_prof,pfull_2km,'Color',colpur,'LineWidth',1)
plot(scfac.*cond_E25km_prof_lwoff,pfull_2km,'--','Color',colpur,'LineWidth',2)
plot(scfac.*cond_25km_prof_ctl,pfull_2km,'Color',colyel,'LineWidth',2)
plot(scfac.*ice_25km_prof,pfull_2km,'Color',colyel,'LineWidth',1)
plot(scfac.*liq_25km_prof,pfull_2km,'Color',colyel,'LineWidth',1)
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



figure_25km_q=figure
axes2 = axes('Parent',figure_25km_q,'BoxStyle','full','YMinorTick','on',...
    'YTickLabel',{'100','200','','400','','600','','800','','1000'},...
    'YScale','log',...
    'XScale','log',...
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
plot(scfac.*q_25km_ztmn_prof,pfull_2km,'Color',colyel,'LineWidth',2)
set(gca,'Ydir','reverse')
set(gca,'YScale','log')
hold on
%plot(scfac.*q_25km_ztmn_prof,pfull_2km,'--','Color',colyel,'LineWidth',2)
plot(scfac.*q_E25km_ztmn_prof,pfull_2km,'Color',colpur,'LineWidth',3)
plot(scfac.*q_2km_ztmn_prof,pfull_2km,'Color',colblu,'LineWidth',3)
plot(scfac.*q_1km_ztmn_prof,pfull_2km,'Color',colgrn,'LineWidth',3)
%plot(scfac.*cond_25km_lg_prof_lwoff,pfull_2km,'--','Color',colyel,'LineWidth',3)
%plot(scfac.*cond_100km_prof_ctl,pfull_2km,'red','LineWidth',2)
%plot(scfac.*cond_100km_prof_lwoff,pfull_2km,'--','Color','red','LineWidth',2)
%plot(scfac.*cond_100km_lg_prof_ctl,pfull_2km,'Color','red','LineWidth',3)
%plot(scfac.*cond_100km_lg_prof_lwoff,pfull_2km,'--','Color','red','LineWidth',3)
title('Domain Mean q ')
xlabel('g/kg')
ylabel('presssure (hPa)')

% Two panel figure showing today domain mean liq+ice and domain mean 
% total condensate (liquid + ice) and the specific humidity (q)
figure_condensation=figure
subplot(1,2,1)
plot(scfac.*cond_1km_prof_ctl,pfull_2km,'Color',colgrn,'LineWidth',2)
ax1=gca;
set(ax1,'Ydir','reverse')
set(ax1,'YScale','log')
ylim(ax1,[10000 100000]);
ax1.YTick = [10000 20000 30000 40000 50000 60000 70000 80000 90000 100000]
ax1.YTickLabels = [100 200 300 " " 500 " " 700 " " 900 1000]
ax1.FontSize = 14;
ax1.FontWeight = 'bold';
hold on
plot(scfac.*cond_1km_prof_lwoff,pfull_2km,'--','Color',colgrn,'LineWidth',2)
plot(scfac.*cond_2km_prof_ctl,pfull_2km,'Color',colblu,'LineWidth',2)
plot(scfac.*cond_2km_prof_lwoff,pfull_2km,'--','Color',colblu,'LineWidth',2)
plot(scfac.*cond_E25km_prof,pfull_2km,'Color',colpur,'LineWidth',2)
plot(scfac.*cond_E25km_prof_lwoff,pfull_2km,'--','Color',colpur,'LineWidth',2)
plot(scfac.*cond_25km_prof_ctl,pfull_2km,'Color',colyel,'LineWidth',2)
plot(scfac.*cond_25km_prof_lwoff,pfull_2km,'--','Color',colyel,'LineWidth',2)
title('Total Condensate')
xlabel('g/kg')
ylabel('presssure (hPa)')

%figure_25km_q=figure
subplot(1,2,2)
plot(scfac.*q_25km_bias,pfull_2km,'Color',colyel,'LineWidth',2)
ax2=gca;
set(ax2,'Ydir','reverse')
set(ax2,'YScale','log')
ylim(ax2,[10000 100000]);
ax2.YTick = [10000 20000 30000 40000 50000 60000 70000 80000 90000 100000]
ax2.YTickLabels = [" " " " " " " " " " " " " " " " " " " "]
ax2.FontSize = 14;
ax2.FontWeight = 'bold';
hold on
%plot(scfac.*q_25km_lwoff_bias,pfull_2km,'--','Color',colyel,'LineWidth',2)
plot(scfac.*q_E25km_bias,pfull_2km,'Color',colpur,'LineWidth',2)
%plot(scfac.*q_E25km_lwoff_bias,pfull_2km,'--','Color',colpur,'LineWidth',2)
%plot(scfac.*q_100km_bias,pfull_2km,'r','LineWidth',2)
%plot(scfac.*q_100km_lg_bias,pfull_2km,'--r','LineWidth',2)
plot(scfac.*q_2km_bias,pfull_2km,'Color',colblu,'LineWidth',2)
%plot(scfac.*q_2km_lwoff_bias,pfull_2km,'--','Color',colblu,'LineWidth',2)
plot(scfac.*q_1km_bias,pfull_2km,'Color',colgrn,'LineWidth',2)
%plot(scfac.*q_1km_lwoff_bias,pfull_2km,'--','Color',colgrn,'LineWidth',2)
title('Specific Humidity Bias')
xlabel('g/kg')
%ylabel('presssure (hPa)')


