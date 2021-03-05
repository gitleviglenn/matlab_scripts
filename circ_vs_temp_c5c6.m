%-------------------------------------------------------------------------
% circ_vs_temp_c5c6.m
%
% plots circulation intensity, omega bar up, omega bar down, and the 
% diabatic subsidence velocity as a function of SST.
%
% colors have been imported from ncl to match scripts using ncl.
% the file cb_9step.rgb contains the RGB values which need to be
% divided by 255 to be converted into the RGB form that matlab uses.
%
% levi silvers                                     march 2021
%-------------------------------------------------------------------------


%[red green blue]
c1=[0.4940 0.1840 0.5560]; % purple
c2=[0.25 0.32 0.65]; % 
%c3=[0 0.4470 0.7410]; % darkish blue          cam6
c3_a=[43 184 163]; % darkish blue          cam6
c3=c3_a/255;
c4=[0.42 0.38 0.4]; % 
%c5=[0.3010 0.7450 0.9330]; % light blue       cam5
c5_a=[ 209 105 31]; % NCL colortable cb_9step
c5=c5_a/255;
c6=[0.9290 0.6940 0.1250]; % gentle yellow
c7=[0.70 0.68 0.16]; % gentle yellow
c8=[0.8500 0.3250 0.0980]; % rusty
c9=[0.4660 0.6740 0.1880]; % green
c10=[0.6500 0.48 0.14]; % 
c11=[0.6350 0.0780 0.1840];

colors(1,:)  =c5;     % cam5
colors(2,:)  =c3;     % cam6
;col(3,:)  =c3;
;col(4,:)  =c4;
;col(5,:)  =c5;
;col(6,:)  =c6;
;col(7,:)  =c7;
;col(8,:)  =c8;
;col(9,:)  =c9;
;col(10,:) =c10;
;col(11,:) =c11;



test_scat =[295 295 295 295 295 295 295 295 295 295 295];

% omega down, omega up
omega_gcm(:,1:2,1)  =[37.3 89.1;31.5 82.9;29.4 69.9];  % CAM5
omega_gcm(:,1:2,2)  =[48.9 111.5;39.8 116.4;30.9 79.7]; % CAM6

omega_d_gcm = [28.4 24.2 20.9 29.8 26.7 18.1];   % first 3 values are CAM5, second 3 C6

  
sst_a=[295 295];
sst_c=[305 305];
sst_b=[300 300];

figure
scatter(sst_a,(omega_gcm(1,1,:)+omega_gcm(1,2,:)),[],colors,'filled','square','SizeData',160)
fig=gca;
hold on
scatter(sst_a,(omega_gcm(1,1,:)),[],colors,'filled','v','SizeData',160)
scatter(sst_a(1),(omega_d_gcm(1)),[],c5,'filled','o','SizeData',160)
scatter(sst_b(1),(omega_d_gcm(2)),[],c5,'filled','o','SizeData',160)
scatter(sst_c(1),(omega_d_gcm(3)),[],c5,'filled','o','SizeData',160)
scatter(sst_a(1),(omega_d_gcm(4)),[],c3,'filled','o','SizeData',160)
scatter(sst_b(1),(omega_d_gcm(5)),[],c3,'filled','o','SizeData',160)
scatter(sst_c(1),(omega_d_gcm(6)),[],c3,'filled','o','SizeData',160)
scatter(sst_b,(omega_gcm(2,1,:)),[],colors,'filled','v','SizeData',160)
scatter(sst_c,(omega_gcm(3,1,:)),[],colors,'filled','v','SizeData',160)
scatter(sst_a,(omega_gcm(1,2,:)),[],colors,'filled','^','SizeData',160)
scatter(sst_b,(omega_gcm(2,2,:)),[],colors,'filled','^','SizeData',160)
scatter(sst_c,(omega_gcm(3,2,:)),[],colors,'filled','^','SizeData',160)
xlim(fig,[294 306]);
xlabel('SST')
ylabel('Circulation Strength, hPa/day')
fig.XTick = [295 300 305]
%fig.XTickLabels =[" " " " " "]
fig.FontSize = 14;
fig.FontWeight = 'bold';
title('Circulation Intensity')
scatter(sst_b,(omega_gcm(2,1,:)+omega_gcm(2,2,:)),[],colors,'filled','square','SizeData',160)
scatter(sst_c,(omega_gcm(3,1,:)+omega_gcm(3,2,:)),[],colors,'filled','square','SizeData',160)
xlim([294 306])



