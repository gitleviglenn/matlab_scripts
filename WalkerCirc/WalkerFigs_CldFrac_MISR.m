% little black train

source_MISR='/Users/silvers/data/SatData/MISR_fromRoj/clMISR_obs4MIPs_MISR_V7_20191101_20191130.nc';

source_gcm_month_noconv='/Users/silvers/data/WalkerCell/testing_20181203/c8x160L33_am4p0_25km_wlkr_ent0p9_noconv/1980th1983.atmos_month_tmn.nc';

source_gcm_month='/Users/silvers/data/WalkerCell/testing_20181203/c8x160L33_am4p0_25km_wlkr_ent0p9/1980th1983.atmos_month_tmn.nc';

source_100km_sm_month='/Users/silvers/data/WalkerCell/testing_20181203/c8x40L33_am4p0_100km_wlkr_ent0p9/1980th1983.atmos_month_tmn.nc';

source_100km_lg_month='/Users/silvers/data/WalkerCell/testing_20181203/c8x160L33_am4p0_100km_wlkr_ent0p9/1980th1983.atmos_month_tmn.nc';

source_2km_month='/Users/silvers/data/WalkerCell/testing_20181203/c50x2000L33_am4p0_2km_wlkr_4K/1979_6mn.atmos_month.nc';

source_1km_month='/Users/silvers/data/WalkerCell/testing_20181203/c10x4000L33_am4p0_1km_wlkr_4K/1979_6mn.atmos_month.nc';


% cloud fraction

cl_MISR  =ncread(source_MISR,'clMISR');
cth_MISR =ncread(source_MISR,'cth');
lat_MISR =ncread(source_MISR,'lat');

clt_2km=ncread(source_2km_month,'cld_amt');
zfull_2km=ncread(source_2km_month,'z_full');
clt_1km=ncread(source_1km_month,'cld_amt');
clt_25km=ncread(source_gcm_month,'cld_amt');
zfull_25km=ncread(source_gcm_month,'z_full');
clt_E25km=ncread(source_gcm_month_noconv,'cld_amt');

clear vaxis_misr;
clear vaxis_mod;
vaxis_misr=cth_MISR(:)/1000.;

clear vaxis_misr_b;
vaxis_misr(16)=18000.;
vaxis_misr_b=flip(vaxis_misr);
%%vaxis_misr_b(1)=18000.;
vaxis_misr_c=vaxis_misr_b(2:16);

vaxis_mod=zfull_2km(1000,25,:,1);
vaxis_mod=squeeze(vaxis_mod);

cl_MISR_tau=nansum(cl_MISR,4);
cl_MISR_tau_window=cl_MISR_tau(:,80:125,:);
cl_MISR_tau_window_a=squeeze(nanmean(cl_MISR_tau_window,1));
cl_MISR_tau_window_b=squeeze(nanmean(cl_MISR_tau_window_a,1));

clt_100km_ztmn = read_1var_ztmn(source_100km_sm_month,'cld_amt');
clt_100km_sm_znm_tmn=cltscale.*clt_100km_ztmn;
clt_100km_sm_prof_ztmn=mean(clt_100km_sm_znm_tmn,1);

clt_100km_lg_ztmn = read_1var_ztmn(source_100km_lg_month,'cld_amt');
clt_100km_lg_znm_tmn=cltscale.*clt_100km_lg_ztmn;
clt_100km_lg_prof_ztmn=mean(clt_100km_lg_znm_tmn,1);

clt_25km_znm=cltscale.*squeeze(mean(clt_25km,2));
clt_25km_ztmn=squeeze(mean(clt_25km_znm,3));
clt_25km_prof_ztmn=mean(clt_25km_ztmn,1); % this is over a full year...

clt_E25km_znm=cltscale.*squeeze(mean(clt_E25km,2));
clt_E25km_ztnm=squeeze(mean(clt_E25km_znm,3));
clt_E25km_prof_ztmn=mean(clt_E25km_ztnm,1); % this is over a full year...

clt_2km_znm=cltscale.*squeeze(mean(clt_2km,2));
%clt_2km_znm_end=clt_2km_znm(:,:,t_mid:t_end);
%clt_2km_znm_start=clt_2km_znm(:,:,1:t_mid);
clt_2km_znm_eq=clt_2km_znm(:,:,t_mid:t_end);
clt_2km_znm_eq_tmn=mean(clt_2km_znm_eq,3);
clt_2km_znm_eq_prof=mean(clt_2km_znm_eq_tmn,1);

%clt_2km_znm_st_tmn=mean(clt_2km_znm_start,3);
%clt_2km_znm_end_tmn=mean(clt_2km_znm_end,3);

clt_1km_znm=cltscale.*squeeze(mean(clt_1km,2));
clt_1km_znm_eq=clt_1km_znm(:,:,t_mid:t_end);
clt_1km_znm_eq_tmn=mean(clt_1km_znm_eq,3);
clt_1km_znm_eq_prof=mean(clt_1km_znm_eq_tmn,1);

figure
plot(clt_1km_znm_eq_prof,pfull_2km,'Color',colgrn,'LineWidth',1.5)
ax1=gca;
set(ax1,'YScale','Log')
set(ax1,'Ydir','reverse')
ylim(ax1,[10000 100000]);
ax1.YTick = [10000 20000 30000 40000 50000 60000 70000 80000 90000 100000]
ax1.YTickLabels = [100 200 300 " " 500 " " 700 " " 900 1000]
ax1.FontSize = 14;
hold on
plot(clt_2km_znm_eq_prof,pfull_2km,'Color',colblu,'LineWidth',1.5)
plot(clt_25km_prof_ztmn,pfull_2km,'Color',colyel,'LineWidth',1.5)
plot(clt_E25km_prof_ztmn,pfull_2km,'Color',colpur,'LineWidth',1.5)
plot(clt_100km_sm_prof_ztmn,pfull_2km,'r','LineWidth',1.5)
ax1.XLim=[0 40];
xlabel('%')
ylabel('hPa')
tit_clt=strcat('Cloud Fraction');

clear vaxis_misr_b;
vaxis_misr_b=flip(vaxis_misr);
%vaxis_misr_b(16)=18000.;
vaxis_misr_c=vaxis_misr_b(2:16);
cl_MISR_tau_window_b=flip(cl_MISR_tau_window_b);

figure
%plot(clt_2km_znm_eq_prof,vaxis_mod,'Color',colblu,'LineWidth',1.5)
plot(cl_MISR_tau_window_b(2:16),vaxis_misr_b(2:16),'k','LineWidth',1.5)
%plot(cl_MISR_tau_window_b(:),vaxis_misr_b(:),'k','LineWidth',1.5)



