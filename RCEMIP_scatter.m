%==========================================================
% create various scatter plots from the RCEMIP data
%
% levi silvers                          October 2020
%==========================================================

import_RCEMIP_table_L300
import_RCEMIP_table_L295
import_RCEMIP_table_L305

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


%GCMs=[2,3,5,7,9,10,13,17,20,21,23]
GCMs=[2,3,5,7,9,10,13,17,21,22,24]
%GCMs=[2,3,21,22,5,5,5,5,5,5,5]
%     CAM5,CAM6,CNRM-CM6,ECHAM6,GEOS-GCM,ICON-GCM,IPSL,SAM0-UNICON,SP-CAM,SPX-CAM,UKMO-GA7.1
GCM_ll=[64,64,10,33,64,20,49,64,64,64,10];

% index key: 
% 4  --> F_NET
% 8  --> OLR
% 10 --> LHF
% 11 --> SHF
% 12 --> PW
% 13 --> Precip
% 17 --> Lapse Rate


foo={TableA2RCElarge305{GCMs(:),10}};
bar={TableA2RCElarge305{GCMs(:),11}};

foob=cell2mat(foo);
barf=cell2mat(bar);

enthalpy=foob+barf;

%figure
%scatter(foob,barf,[],col,'filled','SizeData',100)
%figure
%scatter(foob,GCM_ll,[],col,'filled','SizeData',100)
%figure
%scatter(barf,GCM_ll,[],col,'filled','SizeData',100)


figure
subplot(3,2,1)
scatter(foob,barf,[],col,'filled','SizeData',100)
xlabel('Latent Heat Flux')
ylabel('Sensible Heat Flux')
subplot(3,2,2)
scatter(enthalpy,GCM_ll,[],col,'filled','SizeData',100)
xlabel('Enthalpy (LH+SH) Flux')
ylabel('Height of Lowest Level [m]')

clear foo;
clear bar;
foo={TableA2RCElarge305{GCMs(:),17}};
foob=cell2mat(foo);

subplot(3,2,4)
scatter(foob,GCM_ll,[],col,'filled','SizeData',100)
xlabel('Lapse Rate')
ylabel('Height of Lowest Level [m]')

clear foo;
clear bar;
foo={TableA2RCElarge305{GCMs(:),8}};
bar={TableA2RCElarge305{GCMs(:),13}};
foob=cell2mat(foo);
barf=cell2mat(bar);
subplot(3,2,3)
scatter(foob,barf,[],col,'filled','SizeData',100)
xlabel('OLR [W m^-2]')
ylabel('Precip [mm/d]')

clear foo;
clear bar;
foo={TableA2RCElarge305{GCMs(:),8}};
bar={TableA2RCElarge305{GCMs(:),10}};
foob=cell2mat(foo);
barf=cell2mat(bar);
subplot(3,2,5)
scatter(foob,barf,[],col,'filled','SizeData',100)
xlabel('OLR [W m^-2]')
ylabel('Latent Heat Flux [W m^-2]')

%4 is Fnet
clear foo;
clear bar;
foo={TableA2RCElarge305{GCMs(:),4}};
foob=cell2mat(foo);
subplot(3,2,6)
scatter(foob,GCM_ll,[],col,'filled','SizeData',100)
xlabel('Atm Imb [W m^-2]')
ylabel('Height of Lowest Level [m]')


