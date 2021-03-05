%--------------------------------------------------------------------------
% circ_vs_temp.m
%
% this script creates scatter plots for the RCEMIP GCMs.  Shown are the 
% relationships between OLR, SST, anvil CF, and Circulation Strength.
%
% values are not calculated in this script but manually written into the
% arrays that are used for the scatter plots.  
%
% at the time of writing, the values come from an ncl script that is run 
% on casper utilizing the RCEMIP data stored there.  
%
% levi silvers                                            October 7, 2020 
%--------------------------------------------------------------------------
%
% add additional models
% add colors for each model
% plot Circulation intensity (addition of up and down)

% these colors are commonly used in matlab, some of them are nice. 
%c1=[0 0.4470 0.7410];
%c2=[0.3010 0.7450 0.9330];
%c3=[0.4660 0.6740 0.1880];
%c4=[0.4940 0.1840 0.5560]; 
%c5=[0.9290 0.6940 0.1250];
%c6=[0.8500 0.3250 0.0980];
%c7=[0.6350 0.0780 0.1840];

%[red green blue]
c1=[0.4940 0.1840 0.5560]; % purple
c2=[0.25 0.32 0.65]; % 
c3=[0 0.4470 0.7410]; % darkish blue
c4=[0.42 0.38 0.4]; % 
c5=[0.3010 0.7450 0.9330]; % light blue
c6=[0.9290 0.6940 0.1250]; % gentle yellow
c7=[0.70 0.68 0.16]; % gentle yellow
c8=[0.8500 0.3250 0.0980]; % rusty
c9=[0.4660 0.6740 0.1880]; % green
c10=[0.6500 0.48 0.14]; % 
c11=[0.6350 0.0780 0.1840];


col(1,:)  =c1;
col(2,:)  =c2;
col(3,:)  =c3;
col(4,:)  =c4;
col(5,:)  =c5;
col(6,:)  =c6;
col(7,:)  =c7;
col(8,:)  =c8;
col(9,:)  =c9;
col(10,:) =c10;
col(11,:) =c11;

col2(1,:)  =c1;
col2(2,:)  =c2;
col2(3,:)  =c3;
col2(4,:)  =c4;
col2(5,:)  =c5;
col2(6,:)  =c6;
col2(7,:)  =c7;
col2(8,:)  =c8;
col2(9,:)  =c9;
col2(10,:) =c10;
col2(11,:) =c11;

test_arr  =[20,21,22,23,24,25,26,27,28,29,30]
test_scat =[295 295 295 295 295 295 295 295 295 295 295];

% omega down, omega up, anvil CF, OLR 
circ_gcm(:,1:2,1)  =[6.3 6.7;17.8 31.9;16.3 23.6];  % CAM5
circ_gcm(:,3:4,1)=[0.32 239.6;0.23 258.0;0.17 271.6] % CAM5
circ_gcm(:,1:2,2)  =[8.1 8.5;8.3 8.0;15.3 12.6];    % CAM6
circ_gcm(:,3:4,2)  =[0.34 244.9;0.24 260.4;0.82 271.1];    % CAM6
circ_gcm(:,1:2,3)  =[12.2 10.2;10.2 8.6;9.6 10.3];  % CNRM-CM6-1 
circ_gcm(:,3:4,3)  =[0.16 252.8;0.13 270.5;0.13 279.9];  % CNRM-CM6-1 
circ_gcm(:,1:2,4)  =[8.9 8.4;8.8 8.8;8.9 9.3];      % ECHAM
circ_gcm(:,3:4,4)  =[0.14 262.9;0.18 273.6;0.18 284.5];      % ECHAM
circ_gcm(:,1:2,5)  =[8.4 8.3;7.0 8.9;10.3 13.9];    % GEOS-GCM 
circ_gcm(:,3:4,5)  =[0.27 229.5;0.23 244.2;0.15 290.5];    % GEOS-GCM 
circ_gcm(:,1:2,6)  =[NaN NaN;NaN NaN;NaN NaN];      % ICON
circ_gcm(:,3:4,6)  =[0.22 255.4;0.16 271.2;0.26 287.9];      % ICON
circ_gcm(:,1:2,7)  =[NaN NaN;NaN NaN;NaN NaN];      % IPSL
circ_gcm(:,3:4,7)  =[NaN NaN;NaN NaN;NaN NaN];      % IPSL
circ_gcm(:,1:2,8)  =[8.7 9.1;9.0 10.6;8.2 10.7];    % SAM0-UNICON
circ_gcm(:,3:4,8)  =[0.29 261.1;0.18 284.6;0.16 301.5];    % SAM0-UNICON
circ_gcm(:,1:2,9)  =[10.1 8.6;7.6 7.3;6.7 6.4];	  % SP-CAM
circ_gcm(:,3:4,9)  =[0.17 246.2;0.17 256.1;0.16 264.5];	  % SP-CAM
circ_gcm(:,1:2,10) =[6.7 6.5;5.6 6.9;5.6 6.1];      % SPX-CAM
circ_gcm(:,3:4,10) =[0.19 245.9;0.18 259.1;0.16 267.0];      % SPX-CAM
circ_gcm(:,1:2,11) =[NaN NaN;NaN NaN;NaN NaN];      % UKMO
circ_gcm(:,3:4,11) =[0.28 253.3;0.21 273.8;0.16 289.2];      % UKMO

%circ_gcm(:,:,1)  =[6.3 6.7;17.8 31.9;16.3 23.6];  % CAM5
%circ_gcm(:,:,2)  =[8.1 8.5;8.3 8.0;15.3 12.6];    % CAM6
%circ_gcm(:,:,3)  =[12.2 10.2;10.2 8.6;9.6 10.3];  % CNRM-CM6-1 
%circ_gcm(:,:,4)  =[8.9 8.4;8.8 8.8;8.9 9.3];      % ECHAM
%circ_gcm(:,:,5)  =[8.4 8.3;7.0 8.9;10.3 13.9];    % GEOS-GCM 
%circ_gcm(:,:,6)  =[NaN NaN;NaN NaN;NaN NaN];      % ICON
%circ_gcm(:,:,7)  =[NaN NaN;NaN NaN;NaN NaN];      % IPSL
%circ_gcm(:,:,8)  =[8.7 9.1;9.0 10.6;8.2 10.7];    % SAM0-UNICON
%circ_gcm(:,:,9)  =[10.1 8.6;7.6 7.3;6.7 6.4];	  % SP-CAM
%circ_gcm(:,:,10) =[6.7 6.5;5.6 6.9;5.6 6.1];      % SPX-CAM
%circ_gcm(:,:,11) =[NaN NaN;NaN NaN;NaN NaN];      % UKMO

sst_a=[295 295 295 295 295 295 295 295 295 295 295];
sst_c=[305 305 305 305 305 305 305 305 305 305 305];
sst_b=[300 300 300 300 300 300 300 300 300 300 300];

%figure
%scatter(test_scat,test_arr(1,:),[],col2,'filled','SizeData',150)
%%scatter(test_scat,test_arr(1,:),'filled','square')
%ylim([16 34])

%figure
%scatter(sst_a-0.5,circ_gcm(1,1,:),[],col,'filled','v','SizeData',100)
%fig=gca;
%hold on
%xlim(fig,[294 306]);
%xlabel('SST')
%ylabel('Circulation Strength, hPa/day')
%fig.XTick = [295 300 305]
%%fig.XTickLabels =[" " " " " "]
%fig.FontSize = 14;
%fig.FontWeight = 'bold';
%title('GCMs with Parameterized Convection')
%scatter(sst_a,squeeze(sum(circ_gcm(1,:,:))),[],col,'filled','square','SizeData',100)
%scatter(sst_b-0.5,circ_gcm(2,1,:),[],col,'filled','v','SizeData',100)
%scatter(sst_b,squeeze(sum(circ_gcm(2,:,:))),[],col,'filled','square','SizeData',100)
%scatter(sst_c-0.5,circ_gcm(3,1,:),[],col,'filled','v','SizeData',100)
%scatter(sst_c,squeeze(sum(circ_gcm(3,:,:))),[],col,'filled','square','SizeData',100)
%scatter(sst_a+0.5,circ_gcm(1,2,:),[],col,'filled','^','SizeData',100)
%scatter(sst_b+0.5,circ_gcm(2,2,:),[],col,'filled','^','SizeData',100)
%scatter(sst_c+0.5,circ_gcm(3,2,:),[],col,'filled','^','SizeData',100)
%xlim([294 306])

figure
scatter(sst_a,(circ_gcm(1,1,:)+circ_gcm(1,2,:)),[],col,'filled','square','SizeData',160)
fig=gca;
hold on
xlim(fig,[294 306]);
xlabel('SST')
ylabel('Circulation Strength, hPa/day')
fig.XTick = [295 300 305]
%fig.XTickLabels =[" " " " " "]
fig.FontSize = 14;
fig.FontWeight = 'bold';
title('Circulation Intensity')
scatter(sst_b,(circ_gcm(2,1,:)+circ_gcm(2,2,:)),[],col,'filled','square','SizeData',160)
scatter(sst_c,(circ_gcm(3,1,:)+circ_gcm(3,2,:)),[],col,'filled','square','SizeData',160)
xlim([294 306])

figure
scatter(sst_a,circ_gcm(1,1,:),[],col,'filled','v','SizeData',100)
fig=gca;
hold on
xlim(fig,[294 306]);
xlabel('SST')
ylabel('Circulation Strength, hPa/day')
fig.XTick = [295 300 305]
%fig.XTickLabels =[" " " " " "]
fig.FontSize = 14;
fig.FontWeight = 'bold';
title('Mean Descent')
scatter(sst_b,circ_gcm(2,1,:),[],col,'filled','v','SizeData',100)
scatter(sst_c,circ_gcm(3,1,:),[],col,'filled','v','SizeData',100)
xlim([294 306])
ylim([5 35])

figure
scatter(sst_a,circ_gcm(1,2,:),[],col,'filled','^','SizeData',100)
fig=gca;
hold on
xlim(fig,[294 306]);
xlabel('SST')
ylabel('Circulation Strength, hPa/day')
fig.XTick = [295 300 305]
fig.FontSize = 14;
fig.FontWeight = 'bold';
title('Mean Ascent')
scatter(sst_b,circ_gcm(2,2,:),[],col,'filled','^','SizeData',100)
scatter(sst_c,circ_gcm(3,2,:),[],col,'filled','^','SizeData',100)
xlim([294 306])
ylim([5 35])

figure
scatter(sst_a,circ_gcm(1,3,:),[],col,'filled','^','SizeData',100)
fig=gca;
hold on
xlim(fig,[294 306]);
xlabel('SST')
ylabel('anvil cloud fraction')
fig.XTick = [295 300 305]
fig.FontSize = 14;
fig.FontWeight = 'bold';
title('GCMs with Parameterized Convection')
scatter(sst_b,circ_gcm(2,3,:),[],col,'filled','^','SizeData',100)
scatter(sst_c,circ_gcm(3,3,:),[],col,'filled','^','SizeData',100)
xlim([294 306])
%ylim([5 15])

figure
scatter(sst_a,circ_gcm(1,4,:),[],col,'filled','^','SizeData',100)
fig=gca;
hold on
xlim(fig,[294 306]);
xlabel('SST')
ylabel('OLR')
fig.XTick = [295 300 305]
fig.FontSize = 14;
fig.FontWeight = 'bold';
title('Mean Ascent')
scatter(sst_b,circ_gcm(2,4,:),[],col,'filled','^','SizeData',100)
scatter(sst_c,circ_gcm(3,4,:),[],col,'filled','^','SizeData',100)
xlim([294 306])

figure
scatter(circ_gcm(1,3,:),circ_gcm(1,4,:),[],col,'filled','s','SizeData',60)
fig=gca;
hold on
%xlim(fig,[294 306]);
xlabel('Anvil CF')
ylabel('OLR')
fig.FontSize = 14;
fig.FontWeight = 'bold';
title('GCMs with Parameterized Convection')
scatter(circ_gcm(2,3,:),circ_gcm(2,4,:),[],col,'filled','s','SizeData',120)
scatter(circ_gcm(3,3,:),circ_gcm(3,4,:),[],col,'filled','s','SizeData',180)

% it seems like much of the increase in circulation occurs in the '^' component of the circulation with the exception of the SP-CAM and SPX-CAM models.

%figure
%scatter(sst_a,circ_gcm(1,1,:),'filled')
%hold on
%scatter(sst_b,circ_gcm(2,1,:),'filled')
%scatter(sst_c,circ_gcm(3,1,:),'filled')
%scatter(sst_c,circ_gcm(3,2,:),100,'*')
%scatter(sst_b,circ_gcm(2,2,:),100,'*')
%scatter(sst_a,circ_gcm(1,2,:),100,'*')
%xlim([294 306])
