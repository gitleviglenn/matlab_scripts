%-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
% basic analysis of wind field in RCE experiments from CAM
%
% it appears that cam5 has 30 vertical levels, with the 30th being 992.5
% cam6 has 32 levels, with the lowest being 992.5
%
% the time dimension is given in hours.  the original data has 
% 26281 time steps, which equals 1095 days
%
% the 3d data is output in 6hour instantaneous intervals according to teh output 
% clarification document.  there appear to be 101 time steps, which would
% correspond to about 25 days.  which 
%
% levi silvers                                                    Jan 2020
%-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

source='/Users/silvers/data/CAM/';
model_generation='CAM6';
SSTst="295";
source_mod=strcat(source,model_generation,'_GCM_RCE/');
source_mod_c5=strcat(source,'CAM5','_GCM_RCE/');
exp_string=strcat(model_generation,'_GCM_RCE_large',SSTst,'_1D_');

var1='ua_avg';          
s_var1=strcat(source_mod,exp_string,var1,'.nc') 
ua_295      =ncread(s_var1,var1);

test_u=ua_295(5,:);
%figure
plot(test_u)
xlabel('time [days]')
ylabel('m/s')
title('Eastward Mean Wind at one level')
hold on

% does not appear to show odd behavior on first blush, but the 3d data should
% be looked at.

var1='ua'; 
% ua(time, lev, lat, lon) ;         
exp_string=strcat(model_generation,'_GCM_RCE_large','295_3D_');
exp_string_cam5=strcat('CAM5_GCM_RCE_large','295_3D_');

s_var1=strcat(source_mod,exp_string,var1,'.nc') 
s_var1_c5=strcat(source_mod_c5,exp_string_cam5,var1,'.nc') 

ua_3d_295      =ncread(s_var1,var1);
ua_c5_3d_295      =ncread(s_var1_c5,var1);

ua_zmn_295=squeeze(mean(ua_3d_295,1));
ua_c5_zmn_295=squeeze(mean(ua_c5_3d_295,1));

ua_ztmn_295=squeeze(mean(ua_zmn_295,3));
ua_c5_ztmn_295=squeeze(mean(ua_c5_zmn_295,3));

%figure 
%ua_cons=[0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,15.0,20.0];
%contourf(1:192,plev,squeeze(ua_zmn_295(:,:,5))',ua_cons)
%set(gca,'Ydir','reverse')
%title('Eastward Mean Wind at one time')
%xlabel('latitude')
%ylabel('u wind (m/s)')
%colorbar

figure 
subplot(1,2,1)
ua_cons=[0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,15.0,20.0];
contourf(1:192,plev,ua_ztmn_295',ua_cons)
set(gca,'Ydir','reverse')
title('time mn Eastward Wind CAM6')
xlabel('latitude')
ylabel('u wind (m/s)')
colorbar

max(max(max(ua_zmn_295)))
max(max(max(ua_c5_zmn_295)))

%ua_ztmn_295=squeeze(mean(ua_c5_zmn_295,3));
%figure 
%ua_cons=[0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,15.0,20.0];
%contourf(1:192,plev_c5,squeeze(ua_c5_zmn_295(:,:,95))',ua_cons)
%set(gca,'Ydir','reverse')
%title('Eastward Wind CAM5')
%xlabel('latitude')
%ylabel('u wind (m/s)')
%colorbar

subplot(1,2,2)
%ua_c5_ztmn_295=squeeze(mean(ua_c5_zmn_295,3));
%figure 
ua_cons=[0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,15.0,20.0];
contourf(1:192,plev_c5,ua_c5_ztmn_295',ua_cons)
set(gca,'Ydir','reverse')
title('time mn Eastward Wind CAM5')
xlabel('latitude')
ylabel('u wind (m/s)')
colorbar


