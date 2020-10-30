%==========================================================
%
% levi silvers                                            October 7, 2020 
%
% add additional models
% add colors for each model
% plot Circulation intensity (addition of up and down)
%==========================================================

import_RCEMIP_table_L300
import_RCEMIP_table_L295
import_RCEMIP_table_L305

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

% array of indices for GCMs in the RCEMIP tables
GCMs=[2,3,5,7,9,10,13,17,21,22,24]
% height (m) of the lowest atmospheric model levels.
GCM_ll=[64,64,10,33,64,20,49,64,64,64,10];

foo={TableA2RCElarge305{GCMs(:),8}};
foob=cell2mat(foo);

col(1,:)=c1;
col(2,:)=c2;
col(3,:)=c3;
col(4,:)=c4;
col(5,:)=c5;
col(6,:)=c6;
col(7,:)=c7;
col(8,:)=c8;
col(9,:)=c9;
col(10,:)=c10;
col(11,:)=c11;

% circulation strength values calculated with ncl script on casper
circ_gcm(:,:,1)=[6.3 6.7;17.8 31.9;16.3 23.6];   % CAM5
circ_gcm(:,:,2)=[8.1 8.5;8.3 8.0;15.3 12.6];     % CAM6
circ_gcm(:,:,10)=[6.7 6.5;5.6 6.9;5.6 6.1];      % SPX-CAM
circ_gcm(:,:,6)=[10.1 8.6;7.6 7.3;6.7 6.4];      % should be ICON
circ_gcm(:,:,11)=[10.1 8.6;7.6 7.3;6.7 6.4];     % should be UKMO-GA7 
circ_gcm(:,:,7)=[10.1 8.6;7.6 7.3;6.7 6.4];      % should be IPSL
circ_gcm(:,:,9)=[10.1 8.6;7.6 7.3;6.7 6.4];      % SP-CAM
circ_gcm(:,:,8)=[8.7 9.1;9.0 10.6;8.2 10.7];     % SAM0-UNICON
circ_gcm(:,:,3)=[12.2 10.2;10.2 8.6;9.6 10.3];   % CNRM-CM6-1 
circ_gcm(:,:,5)=[8.4 8.3;7.0 8.9;10.3 13.9];     % GEOS-GCM 
circ_gcm(:,:,4)=[8.9 8.4;8.8 8.8;8.9 9.3];       % ECHAM

sst_a=[295 295 295 295 295 295 295 295 295];
sst_c=[305 305 305 305 305 305 305 305 305];
sst_b=[300 300 300 300 300 300 300 300 300];

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
subplot(3,1,1)
scatter(foob,circ_gcm(3,1,:),[],col,'filled','SizeData',100)
xlabel('OLR')
ylabel('Circulation Strength')

foo={TableA2RCElarge305{GCMs(:),10}};
bar={TableA2RCElarge305{GCMs(:),11}};
foob=cell2mat(foo);
barf=cell2mat(bar);
enthalpy=foob+barf;
subplot(3,1,2)
scatter(enthalpy,circ_gcm(3,1,:),[],col,'filled','SizeData',100)
xlabel('Enthalpy Flux')
ylabel('Circulation Strength')

foo={TableA2RCElarge305{GCMs(:),17}};
foob=cell2mat(foo);
subplot(3,1,3)
scatter(foob,circ_gcm(3,1,:),[],col,'filled','SizeData',100)
xlabel('Lapse Rate')
ylabel('Circulation Strength')
sgtitle('SST = 305K')

figure
foo={TableA2RCElarge295{GCMs(:),8}};
foob=cell2mat(foo);
subplot(3,1,1)
scatter(foob,circ_gcm(1,1,:),[],col,'filled','SizeData',100)
xlabel('OLR')
ylabel('Circulation Strength')

foo={TableA2RCElarge295{GCMs(:),10}};
bar={TableA2RCElarge295{GCMs(:),11}};
foob=cell2mat(foo);
barf=cell2mat(bar);
enthalpy=foob+barf;
subplot(3,1,2)
scatter(enthalpy,circ_gcm(1,1,:),[],col,'filled','SizeData',100)
xlabel('Enthalpy Flux')
ylabel('Circulation Strength')

foo={TableA2RCElarge295{GCMs(:),17}};
foob=cell2mat(foo);
subplot(3,1,3)
scatter(foob,circ_gcm(1,1,:),[],col,'filled','SizeData',100)
xlabel('Lapse Rate')
ylabel('Circulation Strength')
sgtitle('SST = 295K')




