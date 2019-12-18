% general sources on macbook air

% time period over which to take averages
% total length is 26281 hours
% 1200 hours is 50 days
ts=1200;
te=26281;


% -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
source='/Users/silvers/data/CAM/';
source_cam6=strcat(source,'CAM6_GCM_RCE/');
source_cam5=strcat(source,'CAM5_GCM_RCE/');

varname='hur_avg'

source_cam6_295_hur=strcat(source_cam6,'CAM6_GCM_RCE_large295_1D_',varname,'.nc');
source_cam5_295_hur=strcat(source_cam5,'CAM5_GCM_RCE_large295_1D_',varname,'.nc');
source_cam5_300_hur=strcat(source_cam5,'CAM5_GCM_RCE_large300_1D_',varname,'.nc');
source_cam5_305_hur=strcat(source_cam5,'CAM5_GCM_RCE_large305_1D_',varname,'.nc');
source_cam6_300_hur=strcat(source_cam6,'CAM6_GCM_RCE_large300_1D_',varname,'.nc');
source_cam6_305_hur=strcat(source_cam6,'CAM6_GCM_RCE_large305_1D_',varname,'.nc');

% read the data
% -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
plev=ncread(source_cam6_295_hur,'lev');
plev_c5=ncread(source_cam5_295_hur,'lev');

hur_cam5_295=ncread(source_cam5_295_hur,varname);
hur_cam5_300=ncread(source_cam5_300_hur,varname);
hur_cam5_305=ncread(source_cam5_305_hur,varname);

hur_cam6_295=ncread(source_cam6_295_hur,varname);
hur_cam6_300=ncread(source_cam6_300_hur,varname);
hur_cam6_305=ncread(source_cam6_305_hur,varname);

hur_c5_295=hur_cam5_295(:,ts:te);
hur_c5_300=hur_cam5_300(:,ts:te);
hur_c5_305=hur_cam5_305(:,ts:te);

hur_cam5_295_tmn=mean(hur_c5_295,2);
hur_cam5_300_tmn=mean(hur_c5_300,2);
hur_cam5_305_tmn=mean(hur_c5_305,2);

hur_c6_295=hur_cam6_295(:,ts:te);
hur_c6_300=hur_cam6_300(:,ts:te);
hur_c6_305=hur_cam6_305(:,ts:te);

hur_cam6_295_tmn=mean(hur_c6_295,2);
hur_cam6_300_tmn=mean(hur_c6_300,2);
hur_cam6_305_tmn=mean(hur_c6_305,2);

% -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
varname='cldfrac_avg'

source_cam6_295_cldf=strcat(source_cam6,'CAM6_GCM_RCE_large295_1D_',varname,'.nc');
source_cam5_295_cldf=strcat(source_cam5,'CAM5_GCM_RCE_large295_1D_',varname,'.nc');
source_cam5_300_cldf=strcat(source_cam5,'CAM5_GCM_RCE_large300_1D_',varname,'.nc');
source_cam5_305_cldf=strcat(source_cam5,'CAM5_GCM_RCE_large305_1D_',varname,'.nc');
source_cam6_300_cldf=strcat(source_cam6,'CAM6_GCM_RCE_large300_1D_',varname,'.nc');
source_cam6_305_cldf=strcat(source_cam6,'CAM6_GCM_RCE_large305_1D_',varname,'.nc');

% read the data
% -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
plev=ncread(source_cam6_295_cldf,'lev');
plev_c5=ncread(source_cam5_295_cldf,'lev');

cldf_cam5_295=ncread(source_cam5_295_cldf,varname);
cldf_cam5_300=ncread(source_cam5_300_cldf,varname);
cldf_cam5_305=ncread(source_cam5_305_cldf,varname);

cldf_cam6_295=ncread(source_cam6_295_cldf,varname);
cldf_cam6_300=ncread(source_cam6_300_cldf,varname);
cldf_cam6_305=ncread(source_cam6_305_cldf,varname);

cldf_c5_295=cldf_cam5_295(:,ts:te);
cldf_c5_300=cldf_cam5_300(:,ts:te);
cldf_c5_305=cldf_cam5_305(:,ts:te);

cldf_cam5_295_tmn=mean(cldf_c5_295,2);
cldf_cam5_300_tmn=mean(cldf_c5_300,2);
cldf_cam5_305_tmn=mean(cldf_c5_305,2);

cldf_c6_295=cldf_cam6_295(:,ts:te);
cldf_c6_300=cldf_cam6_300(:,ts:te);
cldf_c6_305=cldf_cam6_305(:,ts:te);

cldf_cam6_295_tmn=mean(cldf_c6_295,2);
cldf_cam6_300_tmn=mean(cldf_c6_300,2);
cldf_cam6_305_tmn=mean(cldf_c6_305,2);

% make a figure
% -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
figure
plot(hur_cam5_295_tmn(:),plev_c5(:),'r','LineWidth',1)
hold on
plot(hur_cam5_300_tmn(:),plev_c5(:),'r','LineWidth',1.5)
plot(hur_cam5_305_tmn(:),plev_c5(:),'r','LineWidth',2)
set(gca,'Ydir','reverse')
plot(hur_cam6_295_tmn(:),plev(:),'k','LineWidth',1)
plot(hur_cam6_300_tmn(:),plev(:),'k','LineWidth',1.5)
plot(hur_cam6_305_tmn(:),plev(:),'k','LineWidth',2)
title('CAM5(red) & CAM6(black')
xlim([0 100])
xlabel('RH [%]')
ylabel('[hPa]')

figure
plot(cldf_cam5_295_tmn(:),plev_c5(:),'r','LineWidth',1)
hold on
plot(cldf_cam5_300_tmn(:),plev_c5(:),'r','LineWidth',1.5)
plot(cldf_cam5_305_tmn(:),plev_c5(:),'r','LineWidth',2)
set(gca,'Ydir','reverse')
plot(cldf_cam6_295_tmn(:),plev(:),'k','LineWidth',1)
plot(cldf_cam6_300_tmn(:),plev(:),'k','LineWidth',1.5)
plot(cldf_cam6_305_tmn(:),plev(:),'k','LineWidth',2)
title('CAM5(red) & CAM6(black')
xlim([0 1])
xlabel('Cldfrac')
ylabel('[hPa]')


