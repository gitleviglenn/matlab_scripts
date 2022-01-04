%-------------------------------------------------------------------------
%
% create plots using data and statistics that have been created/opened
% in the scripts: 
% openRCEprofiles.m
% lapser_diff.m
% lapser_diff_driver.m
% surface_fluxes.m
%
% levi silvers                                          april 2021
%-------------------------------------------------------------------------

%% these three scripts import data from 10 GCMs
%% data is read into variable structures: CircSF295...
%% import old, probably instantaneous hourly averaged values:
%%import_RCEMIP_table_10GCMs_L295
%%import_RCEMIP_table_10GCMs_L300
%%import_RCEMIP_table_10GCMs_L305
%import_RCEMIP_table_10GCMs_295_5d
%import_RCEMIP_table_10GCMs_300_5d
%import_RCEMIP_table_10GCMs_305_5d
%
%% import data for 5 CRMs
%% data is read into variable structures: Circ_omega_CRMs_295...
%import_RCEMIP_table_5CRMs_L295
%import_RCEMIP_table_5CRMs_L300
%import_RCEMIP_table_5CRMs_L305
%
%SF295  =CircSF295.SF;
%odn295 =CircSF295.omega_dn;
%SF300  =CircSF300.SF;
%odn300 =CircSF300.omega_dn;
%SF305  =CircSF305.SF;
%odn305 =CircSF305.omega_dn;
%scaleI295=(1./(1-SF295)).*odn295;
%scaleI300=(1./(1-SF300)).*odn300;
%scaleI305=(1./(1-SF305)).*odn305;

%figure
%plot(pa.m1a,gamma_m)
%plot(pa.m1a,gamma)
%plot(gamma,pa.m1a)
%set(gca,'Ydir','reverse')
%ylabel('pressure (hPa)')
%xlabel('Lapse Rate')
%set(gca,'FontWeight','bold')
%ylim([100,1000])
%xlim([-10.,0.0])
%hold on
%plot(gamma_m,pa.m1a)

% RH profiles
figure
plot(hur.m1a(5:16),pa.m1a(5:16),'Color',c1)
hold on
plot(hur.m2a(5:18),pa.m2a(5:18),'Color',c2)
plot(hur.m4a(5:40),pa.m4a(5:40),'Color','k')  % m4 has91 vertical levels! CNRM
plot(hur.m6a(5:22),pa.m6a(5:22),'Color',c6) % ECHAM 
plot(hur.m8a(42:65),pa.m8a(42:65),'Color',c8) % GOES has 72 levels
plot(hur.m9a(5:28),pa.m9a(5:28),'Color','r')
plot(hur.m12a(5:32),pa.m12a(5:32),'Color','g')
plot(hur.m16a(5:18),pa.m16a(5:18),'Color','b')
plot(hur.m20a(5:14),pa.m20a(5:14),'Color',c20)  % SP CAM
plot(hur.m21a(5:14),pa.m21a(5:14),'Color',c21)  % SPX CAM
plot(hur.m23a(5:42),pa.m23a(5:42),'--','Color','k')


figure
scatter(mLR_a,hrmin_a,[],col,'filled','o','SizeData',70)
fig=gca;
hold on
scatter(mLR_b,hrmin_b,[],col,'filled','o','SizeData',120)
scatter(mLR_c,hrmin_c,[],col,'filled','o','SizeData',170)
fig.FontSize = 14;
fig.FontWeight = 'bold';
xlabel('Lapse Rate, K/km')
ylabel('min RH, %')

% min RH vs. SST
figure
scatter(sst_a,hrmin_a,[],col,'filled','o','SizeData',70)
fig=gca;
hold on
scatter(sst_b,hrmin_b,[],col,'filled','o','SizeData',120)
scatter(sst_c,hrmin_c,[],col,'filled','o','SizeData',170)
fig.FontSize = 14;
fig.FontWeight = 'bold';
xlabel('SST, K')
fig.XTick = [295 300 305]
xlim([294 306])
ylabel('min RH, %')

% calculate the mean BR of the 300K experiments: 
mBR_300K=mean(mBR_b);
% calcualte anomalies relative to mBR_300K;
anomBR_a=mBR_a-mBR_b;
anomBR_b=mBR_b-mBR_b;
anomBR_c=mBR_c-mBR_b;

% Bowen ratio vs. min RH
figure
scatter(mBR_a,hrmin_a,[],col,'filled','o','SizeData',70)
fig=gca;
hold on
scatter(mBR_b,hrmin_b,[],col,'filled','o','SizeData',120)
scatter(mBR_c,hrmin_c,[],col,'filled','o','SizeData',170)
fig.FontSize = 14;
fig.FontWeight = 'bold';
xlabel('Bowen Ratio')
ylabel('min RH, %')

% anomalous BR 
figure
scatter(anomBR_a,hrmin_a-hrmin_b,[],col,'filled','o','SizeData',70)
fig=gca;
hold on
scatter(anomBR_b,hrmin_b-hrmin_b,[],col,'filled','o','SizeData',120)
scatter(anomBR_c,hrmin_c-hrmin_b,[],col,'filled','o','SizeData',170)
fig.FontSize = 14;
xlim([-0.06 0.06])
ylim([-15 15])
fig.FontWeight = 'bold';
xlabel('Bowen Ratio')
ylabel('min RH, %')


figure
scatter(mBR_a,mLR_a,[],col,'filled','o','SizeData',70)
fig=gca;
hold on
scatter(mBR_b,mLR_b,[],col,'filled','o','SizeData',120)
scatter(mBR_c,mLR_c,[],col,'filled','o','SizeData',170)
fig.FontSize = 14;
fig.FontWeight = 'bold';
xlabel('Bowen Ratio')
ylabel('Lapse Rate, K/kM')

% requires surface_fluxes.m to have been run...
figure
scatter(mBR_a,delT_a,[],col,'filled','o','SizeData',70)
fig=gca;
hold on
scatter(mBR_b,delT_b,[],col,'filled','o','SizeData',120)
scatter(mBR_c,delT_c,[],col,'filled','o','SizeData',170)
fig.FontSize = 14;
fig.FontWeight = 'bold';
xlabel('Bowen Ratio')
ylabel('delT, K')

figure
scatter(mBR_a,delq_a,[],col,'filled','o','SizeData',70)
fig=gca;
hold on
scatter(mBR_b,delq_b,[],col,'filled','o','SizeData',120)
scatter(mBR_c,delq_c,[],col,'filled','o','SizeData',170)
fig.FontSize = 14;
fig.FontWeight = 'bold';
xlabel('Bowen Ratio')
ylabel('delq, kg/kg')

% scatter of bowen ratio vs change in temperature
figure
scatter(mBR_a,delT_a./(1000.*delq_a),[],col,'filled','o','SizeData',70)
fig=gca;
hold on
scatter(mBR_b,delT_b./(1000.*delq_b),[],col,'filled','o','SizeData',120)
scatter(mBR_c,delT_c./(1000.*delq_c),[],col,'filled','o','SizeData',170)
fig.FontSize = 14;
fig.FontWeight = 'bold';
xlabel('Bowen Ratio')
ylabel('delT/delq, K kg/kg')

% scatter of sensible heat vs latent heat flux
figure
scatter(mshf_a,mlhf_a,[],col,'filled','o','SizeData',70)
fig=gca;
hold on
scatter(mshf_b,mlhf_b,[],col,'filled','o','SizeData',120)
scatter(mshf_c,mlhf_c,[],col,'filled','o','SizeData',170)
fig.FontSize = 14;
fig.FontWeight = 'bold';
xlabel('sensible heat flux')
ylabel('latent heat flux')

%% scatter of Intensity vs omega_db
%figure
%scatter(mnomeg8ms295K.omega_db,mnomeg8ms295K.CircI,[],col8,'filled','o','SizeData',70)
%fig=gca;
%hold on
%scatter(mnomeg8ms300K.omega_db,mnomeg8ms300K.CircI,[],col8,'filled','o','SizeData',120)
%scatter(mnomeg8ms305K.omega_db,mnomeg8ms305K.CircI,[],col8,'filled','o','SizeData',170)
%fig.FontSize = 14;
%fig.FontWeight = 'bold';
%xlabel('Diabatic Omega hPa/day')
%ylabel('Circulation Intensity hPa/day')
%
%% scatter of Intensity vs omega_d
%figure
%scatter(mnomeg8ms295K.omega_d,mnomeg8ms295K.CircI,[],col8,'filled','o','SizeData',70)
%fig=gca;
%hold on
%scatter(mnomeg8ms300K.omega_d,mnomeg8ms300K.CircI,[],col8,'filled','o','SizeData',120)
%scatter(mnomeg8ms305K.omega_d,mnomeg8ms305K.CircI,[],col8,'filled','o','SizeData',170)
%fig.FontSize = 14;
%fig.FontWeight = 'bold';
%xlabel('Subsiding Omega hPa/day')
%ylabel('Circulation Intensity hPa/day')

%% scatter of Intensity vs omega_d
%figure
%scatter(mnomeg8ms295K.omega_u,mnomeg8ms295K.CircI,[],col8,'filled','o','SizeData',70)
%fig=gca;
%hold on
%scatter(mnomeg8ms300K.omega_u,mnomeg8ms300K.CircI,[],col8,'filled','o','SizeData',120)
%scatter(mnomeg8ms305K.omega_u,mnomeg8ms305K.CircI,[],col8,'filled','o','SizeData',170)
%fig.FontSize = 14;
%fig.FontWeight = 'bold';
%xlabel('Ascending Omega hPa/day')
%ylabel('Circulation Intensity hPa/day')

%% scatter of Intensity vs omega_d
%figure
%scatter(mnomeg8ms295K.SF,mnomeg8ms295K.CircI,[],col8,'filled','o','SizeData',70)
%fig=gca;
%hold on
%scatter(mnomeg8ms300K.SF,mnomeg8ms300K.CircI,[],col8,'filled','o','SizeData',120)
%scatter(mnomeg8ms305K.SF,mnomeg8ms305K.CircI,[],col8,'filled','o','SizeData',170)
%fig.FontSize = 14;
%fig.FontWeight = 'bold';
%xlabel('Subsidence Fraction')
%ylabel('Circulation Intensity hPa/day')

% SHF vs. SST
figure
scatter(sst_a,mshf_a,[],col,'filled','o','SizeData',70)
fig=gca;
hold on
scatter(sst_b,mshf_b,[],col,'filled','o','SizeData',120)
scatter(sst_c,mshf_c,[],col,'filled','o','SizeData',170)
fig.FontSize = 14;
fig.FontWeight = 'bold';
xlabel('SST, K')
fig.XTick = [295 300 305]
xlim([294 306])
ylabel('Sensible Heat Flux, W/m2')

%% these three scripts import data from 10 GCMs
%% data is read into variable structures: CircSF295...
%% import old, probably instantaneous hourly averaged values:
%%import_RCEMIP_table_10GCMs_L295
%%import_RCEMIP_table_10GCMs_L300
%%import_RCEMIP_table_10GCMs_L305
%import_RCEMIP_table_10GCMs_295_5d
%import_RCEMIP_table_10GCMs_300_5d
%import_RCEMIP_table_10GCMs_305_5d
%
%% import data for 5 CRMs
%% data is read into variable structures: Circ_omega_CRMs_295...
%import_RCEMIP_table_5CRMs_L295
%import_RCEMIP_table_5CRMs_L300
%import_RCEMIP_table_5CRMs_L305
%
%SF295  =CircSF295.SF;
%odn295 =CircSF295.omega_dn;
%SF300  =CircSF300.SF;
%odn300 =CircSF300.omega_dn;
%SF305  =CircSF305.SF;
%odn305 =CircSF305.omega_dn;
%scaleI295=(1./(1-SF295)).*odn295;
%scaleI300=(1./(1-SF300)).*odn300;
%scaleI305=(1./(1-SF305)).*odn305;

%-------------------------------------------------------------------------------------------------------
%-------------------------------------------------------------------------------------------------------
%-------------------------------------------------------------------------------------------------------

% below creates a figure showing the circulation intensity as a function of SST for GCMs and CRMs...
% FIGURE 1
figure
subplot(1,3,1)
scatter(sst_10a,CircSF295.I,[],colGCM,'filled','o','SizeData',70);
%scatter(CircSF295.SST,CircSF295.I,[],col10,'s','SizeData',70);
hold on
scatter(sst_5a,Circ_omega_CRMs_295.I,[],colCRM,'filled','^','SizeData',70);
scatter(sst_5a,Circ_omega_CRMs_295.I,[],colCRM,'filled','v','SizeData',70);
scatter(sst_10b,CircSF300.I,[],colGCM,'filled','o','SizeData',120);
%scatter(CircSF300.SST,CircSF300.I,[],colGCM,'filled','s','SizeData',120);
scatter(sst_5b,Circ_omega_CRMs_300.I,[],colCRM,'filled','^','SizeData',120);
scatter(sst_5b,Circ_omega_CRMs_300.I,[],colCRM,'filled','v','SizeData',120);
scatter(sst_10c,CircSF305.I,[],colGCM,'filled','o','SizeData',170);
scatter(sst_5c,Circ_omega_CRMs_305.I,[],colCRM,'filled','^','SizeData',170);
scatter(sst_5c,Circ_omega_CRMs_305.I,[],colCRM,'filled','v','SizeData',170);
xlim([294 306])
line([sst_5a(1),sst_5b(1),sst_5c(1)],[Circ_omega_CRMs_295.I(1),Circ_omega_CRMs_300.I(1),Circ_omega_CRMs_305.I(1)],'Color',colCRM(1,:),'LineWidth',2)
line([sst_5a(1),sst_5b(1),sst_5c(1)],[Circ_omega_CRMs_295.I(2),Circ_omega_CRMs_300.I(2),Circ_omega_CRMs_305.I(2)],'Color',colCRM(2,:),'LineWidth',2)
line([sst_5a(1),sst_5b(1),sst_5c(1)],[Circ_omega_CRMs_295.I(3),Circ_omega_CRMs_300.I(3),Circ_omega_CRMs_305.I(3)],'Color',colCRM(3,:),'LineWidth',2)
line([sst_5a(1),sst_5b(1),sst_5c(1)],[Circ_omega_CRMs_295.I(4),Circ_omega_CRMs_300.I(4),Circ_omega_CRMs_305.I(4)],'Color',colCRM(4,:),'LineWidth',2)
line([sst_5a(1),sst_5b(1),sst_5c(1)],[Circ_omega_CRMs_295.I(5),Circ_omega_CRMs_300.I(5),Circ_omega_CRMs_305.I(5)],'Color',colCRM(5,:),'LineWidth',2)
line([sst_10a(1),sst_10b(1),sst_10c(1)],[CircSF295.I(1),CircSF300.I(1),CircSF305.I(1)],'Color',colGCM(1,:),'LineWidth',2)
line([sst_10a(1),sst_10b(1),sst_10c(1)],[CircSF295.I(2),CircSF300.I(2),CircSF305.I(2)],'Color',colGCM(2,:),'LineWidth',2)
line([sst_10a(1),sst_10b(1),sst_10c(1)],[CircSF295.I(3),CircSF300.I(3),CircSF305.I(3)],'Color',colGCM(3,:),'LineWidth',2)
line([sst_10a(1),sst_10b(1),sst_10c(1)],[CircSF295.I(4),CircSF300.I(4),CircSF305.I(4)],'Color',colGCM(4,:),'LineWidth',2)
line([sst_10a(1),sst_10b(1),sst_10c(1)],[CircSF295.I(5),CircSF300.I(5),CircSF305.I(5)],'Color',colGCM(5,:),'LineWidth',2)
line([sst_10a(1),sst_10b(1),sst_10c(1)],[CircSF295.I(6),CircSF300.I(6),CircSF305.I(6)],'Color',colGCM(6,:),'LineWidth',2)
line([sst_10a(1),sst_10b(1),sst_10c(1)],[CircSF295.I(7),CircSF300.I(7),CircSF305.I(7)],'Color',colGCM(7,:),'LineWidth',2)
line([sst_10a(1),sst_10b(1),sst_10c(1)],[CircSF295.I(8),CircSF300.I(8),CircSF305.I(8)],'Color',colGCM(8,:),'LineWidth',2)
line([sst_10a(1),sst_10b(1),sst_10c(1)],[CircSF295.I(9),CircSF300.I(9),CircSF305.I(9)],'Color',colGCM(9,:),'LineWidth',2)
line([sst_10a(1),sst_10b(1),sst_10c(1)],[CircSF295.I(10),CircSF300.I(10),CircSF305.I(10)],'Color',colGCM(10,:),'LineWidth',2)
ylabel('Circulation Intensity, I (hPa/d)')
xlabel('surface temperature (K)')
%set(gca,'YScale','log')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)
ylim([0 150])
%title('Large-Scale Overturning Circulation')


% plot the I as a function of the omega_up and omega_dn
% Figure 2
% diabatic velocity values are also here, but commented out at this time... to be
% plotted in Figure 3.
%figure
subplot(1,3,2)
%scatter(CircSF295.omega_dn,CircSF295.I,[],colGCM,'filled','v','SizeData',70)
scatter(CircSF295.omega_dn,CircSF295.I,[],colGCM,'filled','o','SizeData',70)
hold on
scatter(CircSF300.omega_dn,CircSF300.I,[],colGCM,'filled','o','SizeData',120)
scatter(CircSF305.omega_dn,CircSF305.I,[],colGCM,'filled','o','SizeData',170)
scatter(abs(CircSF295.omega_up),CircSF295.I,[],colGCM,'filled','o','SizeData',70)
scatter(abs(CircSF300.omega_up),CircSF300.I,[],colGCM,'filled','o','SizeData',120)
scatter(abs(CircSF305.omega_up),CircSF305.I,[],colGCM,'filled','o','SizeData',170)
%
scatter(abs(Circ_omega_CRMs_295.omega_up),Circ_omega_CRMs_295.I,[],colCRM,'filled','^','SizeData',70)
scatter(abs(Circ_omega_CRMs_295.omega_up),Circ_omega_CRMs_295.I,[],colCRM,'filled','v','SizeData',70)
scatter(abs(Circ_omega_CRMs_300.omega_up),Circ_omega_CRMs_300.I,[],colCRM,'filled','^','SizeData',120)
scatter(abs(Circ_omega_CRMs_300.omega_up),Circ_omega_CRMs_300.I,[],colCRM,'filled','v','SizeData',120)
scatter(abs(Circ_omega_CRMs_305.omega_up),Circ_omega_CRMs_305.I,[],colCRM,'filled','^','SizeData',170)
scatter(abs(Circ_omega_CRMs_305.omega_up),Circ_omega_CRMs_305.I,[],colCRM,'filled','v','SizeData',170)
%
scatter(abs(Circ_omega_CRMs_295.omega_dn),Circ_omega_CRMs_295.I,[],colCRM,'filled','v','SizeData',70)
scatter(abs(Circ_omega_CRMs_295.omega_dn),Circ_omega_CRMs_295.I,[],colCRM,'filled','^','SizeData',70)
scatter(abs(Circ_omega_CRMs_300.omega_dn),Circ_omega_CRMs_300.I,[],colCRM,'filled','v','SizeData',120)
scatter(abs(Circ_omega_CRMs_300.omega_dn),Circ_omega_CRMs_300.I,[],colCRM,'filled','^','SizeData',120)
scatter(abs(Circ_omega_CRMs_305.omega_dn),Circ_omega_CRMs_305.I,[],colCRM,'filled','v','SizeData',170)
scatter(abs(Circ_omega_CRMs_305.omega_dn),Circ_omega_CRMs_305.I,[],colCRM,'filled','^','SizeData',170)
ylabel('Circulation Intensity, I (hPa/d)')
xlabel('mean velocity (hPa/d)')
set(gca,'FontWeight','bold')
%set(gca,'YScale','log')
set(gca,'FontSize',14)
ylim([0 150])
%title('Components of Overturning Circulation')

% Figure 3
% plots Circulation intensity vs the diabatically driven velocity
%figure
subplot(1,3,3)
scatter(abs(CircSF295.omega_db),CircSF295.I,[],colGCM,'filled','o','SizeData',70)
hold on
scatter(abs(CircSF305.omega_db),CircSF305.I,[],colGCM,'filled','o','SizeData',170)
scatter(abs(CircSF300.omega_db),CircSF300.I,[],colGCM,'filled','o','SizeData',120)
scatter(abs(Circ_omega_CRMs_295.omega_db),Circ_omega_CRMs_295.I,[],colCRM,'filled','^','SizeData',70)
scatter(abs(Circ_omega_CRMs_295.omega_db),Circ_omega_CRMs_295.I,[],colCRM,'filled','v','SizeData',70)
scatter(abs(Circ_omega_CRMs_300.omega_db),Circ_omega_CRMs_300.I,[],colCRM,'filled','^','SizeData',120)
scatter(abs(Circ_omega_CRMs_300.omega_db),Circ_omega_CRMs_300.I,[],colCRM,'filled','v','SizeData',120)
scatter(abs(Circ_omega_CRMs_305.omega_db),Circ_omega_CRMs_305.I,[],colCRM,'filled','^','SizeData',170)
scatter(abs(Circ_omega_CRMs_305.omega_db),Circ_omega_CRMs_305.I,[],colCRM,'filled','v','SizeData',170)
ylabel('Circulation Intensity, I (hPa/d)')
xlabel('diabatic velocity (hPa/d)')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)
ylim([0 150])
%title('Overturning Circulation vs Diabatic Velocity')
sgtitle('Overturning Circulation at 500 hPa','FontSize',16,'FontWeight','bold')

%% compute anomalies relative to 300K
CircSF295anom=abs(CircSF295.omega_db)-abs(CircSF300.omega_db);
CircSF300anom=abs(CircSF300.omega_db)-abs(CircSF300.omega_db);
CircSF305anom=abs(CircSF305.omega_db)-abs(CircSF300.omega_db);
CircSF295_CRM_anom=abs(Circ_omega_CRMs_295.omega_db)-abs(Circ_omega_CRMs_300.omega_db);
CircSF300_CRM_anom=abs(Circ_omega_CRMs_300.omega_db)-abs(Circ_omega_CRMs_300.omega_db);
CircSF305_CRM_anom=abs(Circ_omega_CRMs_305.omega_db)-abs(Circ_omega_CRMs_300.omega_db);
Circ295_GCM=CircSF295.I-CircSF300.I;
Circ300_GCM=CircSF300.I-CircSF300.I;
Circ305_GCM=CircSF305.I-CircSF300.I;
Circ295_CRM=Circ_omega_CRMs_295.I-Circ_omega_CRMs_300.I;
Circ300_CRM=Circ_omega_CRMs_300.I-Circ_omega_CRMs_300.I;
Circ305_CRM=Circ_omega_CRMs_305.I-Circ_omega_CRMs_300.I;
%
%% anomalous omega db values
figure
scatter(CircSF295anom,CircSF295.I,[],colGCM,'filled','o','SizeData',70)
hold on
scatter(CircSF300anom,CircSF300.I,[],colGCM,'filled','o','SizeData',120)
scatter(CircSF305anom,CircSF305.I,[],colGCM,'filled','o','SizeData',170)
scatter(CircSF295_CRM_anom,Circ_omega_CRMs_295.I,[],colCRM,'filled','v','SizeData',70)
scatter(CircSF295_CRM_anom,Circ_omega_CRMs_295.I,[],colCRM,'filled','^','SizeData',70)
scatter(CircSF300_CRM_anom,Circ_omega_CRMs_300.I,[],colCRM,'filled','^','SizeData',120)
scatter(CircSF300_CRM_anom,Circ_omega_CRMs_300.I,[],colCRM,'filled','v','SizeData',120)
scatter(CircSF305_CRM_anom,Circ_omega_CRMs_305.I,[],colCRM,'filled','^','SizeData',170)
scatter(CircSF305_CRM_anom,Circ_omega_CRMs_305.I,[],colCRM,'filled','v','SizeData',170)
ylabel('Circulation Intensity, I (hPa/d)')
xlabel('diabatic velocity (hPa/d)')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)
%%title('Overturning Circulation vs Diabatic Velocity')
%sgtitle('Overturning Circulation at 500 hPa','FontSize',16,'FontWeight','bold')
%
%% anomalous omega db and circulation intensity values
figure
scatter(CircSF295anom,Circ295_GCM,[],colGCM,'filled','o','SizeData',70)
hold on
scatter(CircSF300anom,Circ300_GCM,[],colGCM,'filled','o','SizeData',120)
scatter(CircSF305anom,Circ305_GCM,[],colGCM,'filled','o','SizeData',170)
scatter(CircSF295_CRM_anom,Circ295_CRM,[],colCRM,'filled','v','SizeData',70)
scatter(CircSF295_CRM_anom,Circ295_CRM,[],colCRM,'filled','^','SizeData',70)
scatter(CircSF300_CRM_anom,Circ300_CRM,[],colCRM,'filled','^','SizeData',120)
scatter(CircSF300_CRM_anom,Circ300_CRM,[],colCRM,'filled','v','SizeData',120)
scatter(CircSF305_CRM_anom,Circ305_CRM,[],colCRM,'filled','^','SizeData',170)
scatter(CircSF305_CRM_anom,Circ305_CRM,[],colCRM,'filled','v','SizeData',170)
ylabel('Circulation Intensity, I (hPa/d)')
xlabel('diabatic velocity (hPa/d)')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)
%%title('Overturning Circulation vs Diabatic Velocity')
%sgtitle('Overturning Circulation at 500 hPa','FontSize',16,'FontWeight','bold')

% new scatter of Qmn and sigma
figure
scatter(Circ_omega_CRMs_295.sig_mn,Circ_omega_CRMs_295.Qmn,[],colCRM,'filled','^','SizeData',70);
hold on
scatter(Circ_omega_CRMs_295.sig_mn,Circ_omega_CRMs_295.Qmn,[],colCRM,'filled','v','SizeData',70);
scatter(Circ_omega_CRMs_300.sig_mn,Circ_omega_CRMs_300.Qmn,[],colCRM,'filled','^','SizeData',120);
scatter(Circ_omega_CRMs_300.sig_mn,Circ_omega_CRMs_300.Qmn,[],colCRM,'filled','v','SizeData',120);
scatter(Circ_omega_CRMs_305.sig_mn,Circ_omega_CRMs_305.Qmn,[],colCRM,'filled','^','SizeData',170);
scatter(Circ_omega_CRMs_305.sig_mn,Circ_omega_CRMs_305.Qmn,[],colCRM,'filled','v','SizeData',170);
scatter(CircSF295.sig_mn,CircSF295.Qmn,[],colGCM,'filled','o','SizeData',70)
scatter(CircSF300.sig_mn,CircSF300.Qmn,[],colGCM,'filled','o','SizeData',120)
scatter(CircSF305.sig_mn,CircSF305.Qmn,[],colGCM,'filled','o','SizeData',170)
ylabel('Net Radiative Cooling (K/day)')
xlabel('Static Stability (K/hPa)')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)
title('Radiative Heating and Static Stability')

% below is a scatter plot of Qmn vs sig_mn showing anomalies relative to sigma_mn
figure
scatter(Circ_omega_CRMs_295.sig_mn-Circ_omega_CRMs_295.sig_mn,Circ_omega_CRMs_295.Qmn,[],colCRM,'filled','^','SizeData',70);
hold on
scatter(Circ_omega_CRMs_295.sig_mn-Circ_omega_CRMs_295.sig_mn,Circ_omega_CRMs_295.Qmn,[],colCRM,'filled','v','SizeData',70);
scatter(Circ_omega_CRMs_300.sig_mn-Circ_omega_CRMs_295.sig_mn,Circ_omega_CRMs_300.Qmn,[],colCRM,'filled','^','SizeData',120);
scatter(Circ_omega_CRMs_300.sig_mn-Circ_omega_CRMs_295.sig_mn,Circ_omega_CRMs_300.Qmn,[],colCRM,'filled','v','SizeData',120);
scatter(Circ_omega_CRMs_305.sig_mn-Circ_omega_CRMs_295.sig_mn,Circ_omega_CRMs_305.Qmn,[],colCRM,'filled','^','SizeData',170);
scatter(Circ_omega_CRMs_305.sig_mn-Circ_omega_CRMs_295.sig_mn,Circ_omega_CRMs_305.Qmn,[],colCRM,'filled','v','SizeData',170);
scatter(CircSF295.sig_mn-CircSF295.sig_mn,CircSF295.Qmn,[],colGCM,'filled','o','SizeData',70)
scatter(CircSF300.sig_mn-CircSF295.sig_mn,CircSF300.Qmn,[],colGCM,'filled','o','SizeData',120)
scatter(CircSF305.sig_mn-CircSF295.sig_mn,CircSF305.Qmn,[],colGCM,'filled','o','SizeData',170)
ylabel('Net Radiative Cooling (K/day)')
xlabel('Static Stability (K/hPa)')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)
title('Radiative Heating and Static Stability')

figure
scatter(Circ_omega_CRMs_295.sig_mn,Circ_omega_CRMs_295.Qmn-Circ_omega_CRMs_295.Qmn,[],colCRM,'filled','^','SizeData',70);
hold on
scatter(Circ_omega_CRMs_295.sig_mn,Circ_omega_CRMs_295.Qmn-Circ_omega_CRMs_295.Qmn,[],colCRM,'filled','v','SizeData',70);
scatter(Circ_omega_CRMs_300.sig_mn,Circ_omega_CRMs_300.Qmn-Circ_omega_CRMs_295.Qmn,[],colCRM,'filled','^','SizeData',120);
scatter(Circ_omega_CRMs_300.sig_mn,Circ_omega_CRMs_300.Qmn-Circ_omega_CRMs_295.Qmn,[],colCRM,'filled','v','SizeData',120);
scatter(Circ_omega_CRMs_305.sig_mn,Circ_omega_CRMs_305.Qmn-Circ_omega_CRMs_295.Qmn,[],colCRM,'filled','^','SizeData',170);
scatter(Circ_omega_CRMs_305.sig_mn,Circ_omega_CRMs_305.Qmn-Circ_omega_CRMs_295.Qmn,[],colCRM,'filled','v','SizeData',170);
scatter(CircSF295.sig_mn,CircSF295.Qmn-CircSF295.Qmn,[],colGCM,'filled','o','SizeData',70)
scatter(CircSF300.sig_mn,CircSF300.Qmn-CircSF295.Qmn,[],colGCM,'filled','o','SizeData',120)
scatter(CircSF305.sig_mn,CircSF305.Qmn-CircSF295.Qmn,[],colGCM,'filled','o','SizeData',170)
ylabel('Net Radiative Cooling (K/day)')
xlabel('Static Stability (K/hPa)')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)
title('Radiative Heating and Static Stability')

figure
scatter(abs(Circ_omega_CRMs_295.omega_up),abs(Circ_omega_CRMs_295.omega_dn),[],colCRM,'filled','^','SizeData',70);
hold on
scatter(abs(Circ_omega_CRMs_295.omega_up),abs(Circ_omega_CRMs_295.omega_dn),[],colCRM,'filled','v','SizeData',70);
scatter(abs(Circ_omega_CRMs_300.omega_up),abs(Circ_omega_CRMs_300.omega_dn),[],colCRM,'filled','^','SizeData',120);
scatter(abs(Circ_omega_CRMs_300.omega_up),abs(Circ_omega_CRMs_300.omega_dn),[],colCRM,'filled','v','SizeData',120);
scatter(abs(Circ_omega_CRMs_305.omega_up),abs(Circ_omega_CRMs_305.omega_dn),[],colCRM,'filled','^','SizeData',170);
scatter(abs(Circ_omega_CRMs_305.omega_up),abs(Circ_omega_CRMs_305.omega_dn),[],colCRM,'filled','v','SizeData',170);
scatter(abs(CircSF295.omega_up),abs(CircSF295.omega_dn),[],colGCM,'filled','o','SizeData',70)
scatter(abs(CircSF300.omega_up),abs(CircSF300.omega_dn),[],colGCM,'filled','o','SizeData',120)
scatter(abs(CircSF305.omega_up),abs(CircSF305.omega_dn),[],colGCM,'filled','o','SizeData',170)
line([15,45,60],[15,45,60],'Color','k','LineWidth',1)
%title('diabatic velocity and downward velocity')
ylabel('omega dn (hPa/day)')
xlabel('omega up (hPa/day)')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)

% plot Circulation Intensity vs omega_up and vs omega_dn
%Circ_omega_CRMs_295.I
figure
scatter(abs(Circ_omega_CRMs_295.omega_up),Circ_omega_CRMs_295.I,[],colCRM,'filled','^','SizeData',70);
hold on
scatter(abs(Circ_omega_CRMs_295.omega_up),Circ_omega_CRMs_295.I,[],colCRM,'filled','v','SizeData',70);
scatter(abs(Circ_omega_CRMs_300.omega_up),Circ_omega_CRMs_300.I,[],colCRM,'filled','^','SizeData',120);
scatter(abs(Circ_omega_CRMs_300.omega_up),Circ_omega_CRMs_300.I,[],colCRM,'filled','v','SizeData',120);
scatter(abs(Circ_omega_CRMs_305.omega_up),Circ_omega_CRMs_305.I,[],colCRM,'filled','^','SizeData',170);
scatter(abs(Circ_omega_CRMs_305.omega_up),Circ_omega_CRMs_305.I,[],colCRM,'filled','v','SizeData',170);
scatter(abs(CircSF295.omega_up),CircSF295.I,[],colGCM,'filled','o','SizeData',70)
scatter(abs(CircSF300.omega_up),CircSF300.I,[],colGCM,'filled','o','SizeData',120)
scatter(abs(CircSF305.omega_up),CircSF305.I,[],colGCM,'filled','o','SizeData',170)
line([15,45,60],[15,45,60],'Color','k','LineWidth',1)
%title('diabatic velocity and downward velocity')
ylabel('I (hPa/day)')
xlabel('omega up (hPa/day)')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)

figure
subplot(1,2,1)
scatter(abs(Circ_omega_CRMs_295.omega_db),abs(Circ_omega_CRMs_295.omega_dn),[],colCRM,'filled','^','SizeData',70);
hold on
scatter(abs(Circ_omega_CRMs_295.omega_db),abs(Circ_omega_CRMs_295.omega_dn),[],colCRM,'filled','v','SizeData',70);
scatter(abs(Circ_omega_CRMs_300.omega_db),abs(Circ_omega_CRMs_300.omega_dn),[],colCRM,'filled','^','SizeData',120);
scatter(abs(Circ_omega_CRMs_300.omega_db),abs(Circ_omega_CRMs_300.omega_dn),[],colCRM,'filled','v','SizeData',120);
scatter(abs(Circ_omega_CRMs_305.omega_db),abs(Circ_omega_CRMs_305.omega_dn),[],colCRM,'filled','^','SizeData',170);
scatter(abs(Circ_omega_CRMs_305.omega_db),abs(Circ_omega_CRMs_305.omega_dn),[],colCRM,'filled','v','SizeData',170);
scatter(CircSF295.omega_db,CircSF295.omega_dn,[],colGCM,'filled','o','SizeData',70)
scatter(CircSF300.omega_db,CircSF300.omega_dn,[],colGCM,'filled','o','SizeData',120)
scatter(CircSF305.omega_db,CircSF305.omega_dn,[],colGCM,'filled','o','SizeData',170)
line([15,45,60],[15,45,60],'Color','k','LineWidth',1)
%title('diabatic velocity and downward velocity')
ylabel('omega dn (hPa/day)')
xlabel('omega diabatic (hPa/day)')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)
xlim([15 60])
ylim([10 60])

%figure
subplot(1,2,2)
scatter(abs(Circ_omega_CRMs_295.omega_db),abs(Circ_omega_CRMs_295.omega_up),[],colCRM,'filled','^','SizeData',70);
hold on
scatter(abs(Circ_omega_CRMs_295.omega_db),abs(Circ_omega_CRMs_295.omega_up),[],colCRM,'filled','v','SizeData',70);
scatter(abs(Circ_omega_CRMs_300.omega_db),abs(Circ_omega_CRMs_300.omega_up),[],colCRM,'filled','^','SizeData',120);
scatter(abs(Circ_omega_CRMs_300.omega_db),abs(Circ_omega_CRMs_300.omega_up),[],colCRM,'filled','v','SizeData',120);
scatter(abs(Circ_omega_CRMs_305.omega_db),abs(Circ_omega_CRMs_305.omega_up),[],colCRM,'filled','^','SizeData',170);
scatter(abs(Circ_omega_CRMs_305.omega_db),abs(Circ_omega_CRMs_305.omega_up),[],colCRM,'filled','v','SizeData',170);
scatter(abs(CircSF295.omega_db),abs(CircSF295.omega_up),[],colGCM,'filled','o','SizeData',70)
scatter(abs(CircSF300.omega_db),abs(CircSF300.omega_up),[],colGCM,'filled','o','SizeData',120)
scatter(abs(CircSF305.omega_db),abs(CircSF305.omega_up),[],colGCM,'filled','o','SizeData',170)
line([15,45,60],[15,45,60],'Color','k','LineWidth',1)
ylabel('omega up (hPa/day)')
xlabel('omega diabatic (hPa/day)')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)
%title('diabatic velocity and upward velocity')

%% looking at normalized scatter plot of I vs omega_db
%% doesn't seem to simplify much...
%I_CRMs_a=Circ_omega_CRMs_295.I./Circ_omega_CRMs_295.I
%I_CRMs_b=Circ_omega_CRMs_300.I./Circ_omega_CRMs_295.I
%I_CRMs_c=Circ_omega_CRMs_305.I./Circ_omega_CRMs_295.I
%I_GCMs_c=CircSF305.I./CircSF295.I
%I_GCMs_b=CircSF300.I./CircSF295.I
%I_GCMs_a=CircSF295.I./CircSF295.I
%Odb_CRMs_a=Circ_omega_CRMs_295.omega_db./Circ_omega_CRMs_295.omega_db
%Odb_CRMs_b=Circ_omega_CRMs_300.omega_db./Circ_omega_CRMs_295.omega_db
%Odb_CRMs_c=Circ_omega_CRMs_305.omega_db./Circ_omega_CRMs_295.omega_db
%Odb_GCMs_a=CircSF295.omega_db./CircSF295.omega_db
%Odb_GCMs_b=CircSF300.omega_db./CircSF295.omega_db
%Odb_GCMs_c=CircSF305.omega_db./CircSF295.omega_db
%figure
%scatter(I_CRMs_a,Odb_CRMs_a,[],colCRM,'filled','^','SizeData',70);
%hold on
%scatter(I_CRMs_a,Odb_CRMs_a,[],colCRM,'filled','v','SizeData',70);
%scatter(I_CRMs_b,Odb_CRMs_b,[],colCRM,'filled','^','SizeData',120);
%scatter(I_CRMs_b,Odb_CRMs_b,[],colCRM,'filled','v','SizeData',120);
%scatter(I_CRMs_c,Odb_CRMs_c,[],colCRM,'filled','^','SizeData',170);
%scatter(I_CRMs_c,Odb_CRMs_c,[],colCRM,'filled','v','SizeData',170);
%scatter(I_GCMs_a,Odb_GCMs_a,[],colGCM,'filled','o','SizeData',70);
%scatter(I_GCMs_b,Odb_GCMs_b,[],colGCM,'filled','o','SizeData',120);
%scatter(I_GCMs_c,Odb_GCMs_c,[],colGCM,'filled','o','SizeData',170);

%-------------------------------------------------------------------
% near Final Figure
%-------------------------------------------------------------------
% Relative humidity
% this is the old 6 panel RH figure which includes a legend. 

figure1=figure;
subplot1=subplot(2,3,1,'Parent',figure1);
hold(subplot1,'on');
for mi=1:10
  plot(rh(mnum_gcm(mi)).first,temp(mnum_gcm(mi)).first,'Parent',subplot1,'Color',col34(gcm_num(mi),:),'LineWidth',2)
end 
set(subplot1,'Ydir','reverse')
set(subplot1,'FontWeight','bold')
ylim(subplot1,[200 305])
xlim(subplot1,[1 100])

subplot2=subplot(2,3,2,'Parent',figure1)
hold(subplot2,'on');
for mi=1:10
  plot(rh(mnum_gcm(mi)).second,temp(mnum_gcm(mi)).second,'Parent',subplot2,'Color',col34(gcm_num(mi),:),'LineWidth',2)
end
set(subplot2,'Ydir','reverse')
%axis(subplot2,'ij');
set(subplot2,'FontWeight','bold');
ylim(subplot2,[200 305]);
xlim(subplot2,[1 100]);
box(subplot2,'off');

gcm_str=["CAM5" "CAM6" "CNRM" "ECHAM6" "GEOS" "ICON-GCM" "SAM0-UNICON" "SP-CAM" "SPX-CAM" "UKMO-GA7.1"]

subplot3=subplot(2,3,3,'Parent',figure1);
hold(subplot3,'on');
for mi=1:10
  plot(rh(mnum_gcm(mi)).third,temp(mnum_gcm(mi)).third,'DisplayName',gcm_str(mi),'Parent',subplot3,'Color',col34(gcm_num(mi),:),'LineWidth',2)
end
set(subplot3,'Ydir','reverse')
set(subplot3,'FontWeight','bold');
ylim(subplot3,[200 305]);
xlim(subplot3,[1 100]);
legend1=legend(subplot3,'show');
box(legend1,'off');
title(subplot1,'SST=295K')
title(subplot2,'SST=300K')
title(subplot3,'SST=305K')
ylabel(subplot1,'Temperature K')
%xlabel(subplot1,'Relative Humidity %')
%xlabel(subplot2,'Relative Humidity %')
%xlabel(subplot3,'Relative Humidity %')

subplot4=subplot(2,3,4,'Parent',figure1);
hold(subplot4,'on');
for mi=1:11
  plot(rh(mnum_crm(mi)).first,temp(mnum_crm(mi)).first,'Parent',subplot4,'Color',col34(crm_num(mi),:),'LineWidth',2)
end
set(subplot4,'Ydir','reverse')
set(subplot4,'FontWeight','bold')
ylim(subplot4,[200 305])
xlim(subplot4,[1 100])

subplot5=subplot(2,3,5,'Parent',figure1);
hold(subplot5,'on');
for mi=1:11
  plot(rh(mnum_crm(mi)).second,temp(mnum_crm(mi)).second,'Parent',subplot5,'Color',col34(crm_num(mi),:),'LineWidth',2)
end
set(subplot5,'Ydir','reverse')
set(subplot5,'FontWeight','bold')
ylim(subplot5,[200 305])
xlim(subplot5,[1 100])

subplot6=subplot(2,3,6,'Parent',figure1);
hold(subplot6,'on');
for mi=1:11
  plot(rh(mnum_crm(mi)).third,temp(mnum_crm(mi)).third,'Parent',subplot6,'Color',col34(crm_num(mi),:),'LineWidth',2)
end
set(subplot6,'Ydir','reverse')
set(subplot6,'FontWeight','bold')
ylim(subplot6,[200 305])
xlim(subplot6,[1 100])
ylabel(subplot4,'Temperature K')
xlabel(subplot4,'Relative Humidity %')
xlabel(subplot5,'Relative Humidity %')
xlabel(subplot6,'Relative Humidity %')

% create legend for GCMs
figure2=figure
%subplot1=subplot(2,1,1,'Parent',figure2);
%hold(subplot1,'on');
hold on
x=1:10;
y=NaN;
for mi=1:10
  plot(rh(mnum_gcm(1)).third,temp(mnum_gcm(1)).third,'DisplayName',gcm_str(mi),'Parent',subplot1,'Color',col34(gcm_num(mi),:),'LineWidth',2)
  %plot(x,y.*x,'DisplayName',gcm_str(mi),'Parent',subplot1,'Color',col34(gcm_num(mi),:),'LineWidth',2)
end
%set(gcf,'Position',[0,0,1024,1024]);
legend_handle = legend('Orientation','vertical');
%set(gcf,'Position',(get(legend_handle,'Position')...
%.*[0,0,1,1].*get(gcf,'Position')));
%set(legend_handle,'Position',[0,0,1,1]);
%set(gcf,'Position',get(gcf,'Position')+[500,400,0,0]);
set(gca,legend,'show');
set(gca,box,'off');

legend1=legend(figure2,'show');
box(legend1,'off');

% Precipitation Efficiency following Romps, 2014:  PE .gte. 1-RH
figure1=figure;
subplot1=subplot(2,3,1,'Parent',figure1);
hold(subplot1,'on');
for mi=1:10
  plot(1.-0.01.*rh(mnum_gcm(mi)).first,temp(mnum_gcm(mi)).first,'Parent',subplot1,'Color',col34(gcm_num(mi),:),'LineWidth',2)
end
set(subplot1,'Ydir','reverse')
set(subplot1,'FontWeight','bold')
ylim(subplot1,[200 305])
xlim(subplot1,[0 1])

subplot2=subplot(2,3,2,'Parent',figure1)
hold(subplot2,'on');
for mi=1:10
  plot(1.-0.01.*rh(mnum_gcm(mi)).second,temp(mnum_gcm(mi)).second,'Parent',subplot2,'Color',col34(gcm_num(mi),:),'LineWidth',2)
end
set(subplot2,'Ydir','reverse')
%axis(subplot2,'ij');
set(subplot2,'FontWeight','bold');
ylim(subplot2,[200 305]);
xlim(subplot2,[0 1]);
box(subplot2,'off');

gcm_str=["CAM5" "CAM6" "CNRM" "ECHAM6" "GEOS" "ICON-GCM" "SAM0-UNICON" "SP-CAM" "SPX-CAM" "UKMO-GA7.1"]

subplot3=subplot(2,3,3,'Parent',figure1);
hold(subplot3,'on');
for mi=1:10
  %plot(1.-0.01.*rh(mnum_gcm(mi)).third,temp(mnum_gcm(mi)).third,'DisplayName',gcm_str(mi),'Parent',subplot3,'Color',col34(gcm_num(mi),:),'LineWidth',2)
  plot(1.-0.01.*rh(mnum_gcm(mi)).third,temp(mnum_gcm(mi)).third,'Parent',subplot3,'Color',col34(gcm_num(mi),:),'LineWidth',2)
end
set(subplot3,'Ydir','reverse')
set(subplot3,'FontWeight','bold');
ylim(subplot3,[200 305]);
xlim(subplot3,[0 1]);
title(subplot1,'SST=295K')
title(subplot2,'SST=300K')
title(subplot3,'SST=305K')
ylabel(subplot1,'Temperature K')

subplot4=subplot(2,3,4,'Parent',figure1);
hold(subplot4,'on');
for mi=1:11
  plot(1.-0.01.*rh(mnum_crm(mi)).first,temp(mnum_crm(mi)).first,'Parent',subplot4,'Color',col34(crm_num(mi),:),'LineWidth',2)
end
set(subplot4,'Ydir','reverse')
set(subplot4,'FontWeight','bold')
ylim(subplot4,[200 305])
xlim(subplot4,[0 1])

subplot5=subplot(2,3,5,'Parent',figure1);
hold(subplot5,'on');
for mi=1:11
  plot(1.-0.01.*rh(mnum_crm(mi)).second,temp(mnum_crm(mi)).second,'Parent',subplot5,'Color',col34(crm_num(mi),:),'LineWidth',2)
end
set(subplot5,'Ydir','reverse')
set(subplot5,'FontWeight','bold')
ylim(subplot5,[200 305])
xlim(subplot5,[0 1])

subplot6=subplot(2,3,6,'Parent',figure1);
hold(subplot6,'on');
for mi=1:11
  plot(1.-0.01.*rh(mnum_crm(mi)).third,temp(mnum_crm(mi)).third,'Parent',subplot6,'Color',col34(crm_num(mi),:),'LineWidth',2)
end
set(subplot6,'Ydir','reverse')
set(subplot6,'FontWeight','bold')
ylim(subplot6,[200 305])
xlim(subplot6,[0 1])
ylabel(subplot4,'Temperature K')
xlabel(subplot4,'Precip Efficiency Constraint')
xlabel(subplot5,'Precip Efficiency Constraint')
xlabel(subplot6,'Precip Efficiency Constraint')
sgtitle('Lower Bound Precip Efficiency, Romps 2014')

%------------------------------------------------------
% change of relative humidity with warming RH
%------------------------------------------------------
% plot(rh(mnum_gcm(mi)).first,temp(mnum_gcm(mi)).first,'Parent',subplot1,'Color',col34(gcm_num(mi),:),'LineWidth',2)
figure2=figure;
subplot1=subplot(1,2,1,'Parent',figure2);
hold(subplot1,'on');
for mi=1:10
  %plot((rh(mnum_gcm(mi)).second-rh(mnum_gcm(mi)).first)./5,temp(mnum_gcm(mi)).first,'Parent',subplot1,'Color',col34(gcm_num(mi),:),'LineWidth',2)
  plot((rh(mnum_gcm(mi)).third-rh(mnum_gcm(mi)).first)./10,temp(mnum_gcm(mi)).first,'Parent',subplot1,'Color',col34(gcm_num(mi),:),'LineWidth',2)
end 
set(subplot1,'Ydir','reverse')
set(subplot1,'FontWeight','bold')
ylim(subplot1,[230 295])
xlim(subplot1,[-10 10])
subplot2=subplot(1,2,2,'Parent',figure2);
hold(subplot2,'on');
for mi=1:11
%  plot(rh(mnum_crm(mi)).third,temp(mnum_crm(mi)).third,'Parent',subplot6,'Color',col34(crm_num(mi),:),'LineWidth',2)
  %plot((rh(mnum_crm(mi)).second-rh(mnum_crm(mi)).first)./5,temp(mnum_crm(mi)).first,'Parent',subplot2,'Color',col34(crm_num(mi),:),'LineWidth',2)
  plot((rh(mnum_crm(mi)).third-rh(mnum_crm(mi)).first)./10,temp(mnum_crm(mi)).first,'Parent',subplot2,'Color',col34(crm_num(mi),:),'LineWidth',2)
end 
set(subplot2,'Ydir','reverse')
set(subplot2,'FontWeight','bold')
ylim(subplot2,[230 295])
xlim(subplot2,[-10 10])


% details about my indexing nightmare: 
% is the call to model numbers above correct?  
% these variables have been reindexed so their indices are different than in col34:
% rh.first, pres.first,temp.first,zg.first,cldfr.first, and also for second, and third
% the indexing maps back to col34 if one uses modelnum(mnum_gcm) and modelnum(mnum_crm)
% so as an example, 
% rh(mi).first where mi goes from 1:22 refer to these index numbers from col34: 
% modelnum      =[1 2 4 6 8 9 10 11 12 13 16 17 19 20 21 22 23 24 25 26 27 28];

% call the lapser_wv.m script...
% calculate the fractional detrainment rate
for mi=1:22
  [gam_dtdz(mi).first,gam_wv(mi).first,delta_frac(mi).first]=lapser_wv(295.,temp(mi).first,zg(mi).first,rh(mi).first,modelnum(mi));
  [gam_dtdz(mi).second,gam_wv(mi).second,delta_frac(mi).second]=lapser_wv(295.,temp(mi).second,zg(mi).second,rh(mi).second,modelnum(mi));
  [gam_dtdz(mi).third,gam_wv(mi).third,delta_frac(mi).third]=lapser_wv(295.,temp(mi).third,zg(mi).third,rh(mi).third,modelnum(mi));
end

%-------------------------------------------------------------------
% near Final Figure
%-------------------------------------------------------------------
% Relative humidity, delta frac (fractional detrainment), and wv lapse rate

%CRMs
% approaching Final figures....
% plot relative humidity, fractional detrainment as derived by Romps, 2014, and the wv
% lapse rate for CRMs.
%
%lowbound=fi(290);
lowbound=295;
figure
subplot(1,3,1)
hold on
%hold(subplot,'on');
for mi=1:11
  plot(0.01.*rh(mnum_crm(mi)).third,temp(mnum_crm(mi)).third,'Color',col34(crm_num(mi),:),'LineWidth',2)
end
set(gca,'Ydir','reverse')
ylabel('Temp (K)')
ylim([200 lowbound])
xlim([0 1])
xlabel('RH')
set(gca,'FontWeight','bold')

subplot(1,3,2)
hold on
for mi=1:11
  plot(delta_frac(mnum_crm(mi)).third,temp(mnum_crm(mi)).third,'Color',col34(crm_num(mi),:),'LineWidth',2)
end 
set(gca,'Ydir','reverse')
ylabel('Temp (K)')
ylim([200 lowbound])
xlim([-2 0])
xlabel('fract detrainment, (1/m)')
set(gca,'FontWeight','bold')

subplot(1,3,3)
hold on
for mi=1:11
  %plot(1./gam_wv(mnum_crm(mi)).third,temp(mnum_crm(mi)).third,'Color',col34(crm_num(mi),:),'LineWidth',2)
  plot(gam_wv(mnum_crm(mi)).third,temp(mnum_crm(mi)).third,'Color',col34(crm_num(mi),:),'LineWidth',2)
end 
set(gca,'Ydir','reverse')
ylim([200 lowbound])
xlim([-1.5 0])
ylabel('Temp(K)')
xlabel('wv lapse rate, (1/m)')
set(gca,'FontWeight','bold')
sgtitle('Sources and sinks of RH in CRMs at 305K','FontSize',16,'FontWeight','bold')

%GCMs at 295K
% plot relative humidity, fractional detrainment as derived by Romps, 2014, and the wv
% lapse rate for GCMs.
%
figure
subplot(1,3,1)
hold on
for mi=1:10
  plot(0.01.*rh(mnum_gcm(mi)).third,temp(mnum_gcm(mi)).third,'Color',col34(gcm_num(mi),:),'LineWidth',2)
end
set(gca,'Ydir','reverse')
ylabel('Temp (K)')
ylim([200 lowbound])
xlim([0 1])
xlabel('RH')
%title(modelnum)
set(gca,'FontWeight','bold')

%figure
subplot(1,3,2)
hold on
for mi=1:10
  plot(delta_frac(mnum_gcm(mi)).third,temp(mnum_gcm(mi)).third,'Color',col34(gcm_num(mi),:),'LineWidth',2)
end 
set(gca,'Ydir','reverse')
%ylabel('Temp (K)')
ylim([200 lowbound])
xlim([-2 0])
xlabel('fract detrainment (1/m)')
set(gca,'FontWeight','bold')

subplot(1,3,3)
hold on
for mi=1:10
  %plot(1./gam_wv(mnum_crm(mi)).third,temp(mnum_crm(mi)).third,'Color',col34(crm_num(mi),:),'LineWidth',2)
  plot(gam_wv(mnum_gcm(mi)).third,temp(mnum_gcm(mi)).third,'Color',col34(gcm_num(mi),:),'LineWidth',2)
end 
set(gca,'Ydir','reverse')
ylim([200 lowbound])
xlim([-1.5 0])
%ylabel('Temp(K)')
xlabel('wv lapse rate, (1/m)')
set(gca,'FontWeight','bold')
sgtitle('Sources and sinks of RH in GCMs at 305K','FontSize',16,'FontWeight','bold')



%=====================================================================================
% how much is the RH changing for particular models?  
figure1=figure;
subplot1=subplot(1,3,1,'Parent',figure1);
hold(subplot1,'on');
plot(rh(1).first,temp(1).first,'Parent',subplot1,'Color',colGCMfull(1,:),'LineWidth',2)
set(subplot1,'Ydir','reverse')
plot(rh(1).second,temp(1).second,'Parent',subplot1,'Color',colGCMfull(1,:),'LineWidth',2)
plot(rh(1).third,temp(1).third,'Parent',subplot1,'Color',colGCMfull(1,:),'LineWidth',2)
ylim(subplot1,[190 305]);

subplot2=subplot(1,3,2,'Parent',figure1);
hold(subplot2,'on');
plot(rh(10).first,temp(10).first,'Parent',subplot2,'Color',colGCMfull(10,:),'LineWidth',2)
set(subplot2,'Ydir','reverse')
plot(rh(10).second,temp(10).second,'Parent',subplot2,'Color',colGCMfull(10,:),'LineWidth',2)
plot(rh(10).third,temp(10).third,'Parent',subplot2,'Color',colGCMfull(10,:),'LineWidth',2)
ylim(subplot2,[190 305]);

subplot3=subplot(1,3,3,'Parent',figure1);
hold(subplot3,'on');
plot(rh(5).first,temp(5).first,'Parent',subplot3,'Color',colGCMfull(5,:),'LineWidth',2)
set(subplot3,'Ydir','reverse')
plot(rh(5).second,temp(5).second,'Parent',subplot3,'Color',colGCMfull(5,:),'LineWidth',2)
plot(rh(5).third,temp(5).third,'Parent',subplot3,'Color',colGCMfull(5,:),'LineWidth',2)
ylim(subplot3,[190 305]);

% how much is RH changing with warming? 
% plot(rh(mnum_gcm(mi)).first,temp(mnum_gcm(mi)).first,'Parent',subplot1,'Color',col34(gcm_num(mi),:),'LineWidth',2)
figure1=figure;
subplot1=subplot(1,2,1,'Parent',figure1);
hold(subplot1,'on');
plot((rh(1).second-rh(1).first)./5,temp(1).first,'Parent',subplot1,'Color',colGCMfull(1,:),'LineWidth',2)
set(subplot1,'Ydir','reverse')
plot((rh(2).second-rh(2).first)./5,temp(2).first,'Parent',subplot1,'Color',colGCMfull(2,:),'LineWidth',2)
plot((rh(3).second-rh(3).first)./5,temp(3).first,'Parent',subplot1,'Color',colGCMfull(3,:),'LineWidth',2)
plot((rh(4).second-rh(4).first)./5,temp(4).first,'Parent',subplot1,'Color',colGCMfull(4,:),'LineWidth',2)
plot((rh(5).second-rh(5).first)./5,temp(5).first,'Parent',subplot1,'Color',colGCMfull(5,:),'LineWidth',2)
plot((rh(6).second-rh(6).first)./5,temp(6).first,'Parent',subplot1,'Color',colGCMfull(6,:),'LineWidth',2)
plot((rh(7).second-rh(7).first)./5,temp(7).first,'Parent',subplot1,'Color',colGCMfull(7,:),'LineWidth',2)
plot((rh(8).second-rh(8).first)./5,temp(8).first,'Parent',subplot1,'Color',colGCMfull(8,:),'LineWidth',2)
plot((rh(9).second-rh(9).first)./5,temp(9).first,'Parent',subplot1,'Color',colGCMfull(9,:),'LineWidth',2)
plot((rh(10).second-rh(10).first)./5,temp(10).first,'Parent',subplot1,'Color',colGCMfull(10,:),'LineWidth',2)
plot((rh(11).second-rh(11).first)./5,temp(11).first,'Parent',subplot1,'Color',colGCMfull(11,:),'LineWidth',2)
ylim(subplot1,[220 300]);
xlim(subplot1,[-10 10]);

subplot1=subplot(1,2,2,'Parent',figure1);
hold(subplot1,'on');
plot((rh(1).third-rh(1).second)./5,temp(1).second,'Parent',subplot1,'Color',colGCMfull(1,:),'LineWidth',2)
set(subplot1,'Ydir','reverse')
plot((rh(2).third-rh(2).second)./5,temp(2).second,'Parent',subplot1,'Color',colGCMfull(2,:),'LineWidth',2)
plot((rh(3).third-rh(3).second)./5,temp(3).second,'Parent',subplot1,'Color',colGCMfull(3,:),'LineWidth',2)
plot((rh(4).third-rh(4).second)./5,temp(4).second,'Parent',subplot1,'Color',colGCMfull(4,:),'LineWidth',2)
plot((rh(5).third-rh(5).second)./5,temp(5).second,'Parent',subplot1,'Color',colGCMfull(5,:),'LineWidth',2)
plot((rh(6).third-rh(6).second)./5,temp(6).second,'Parent',subplot1,'Color',colGCMfull(6,:),'LineWidth',2)
plot((rh(7).third-rh(7).second)./5,temp(7).second,'Parent',subplot1,'Color',colGCMfull(7,:),'LineWidth',2)
plot((rh(8).third-rh(8).second)./5,temp(8).second,'Parent',subplot1,'Color',colGCMfull(8,:),'LineWidth',2)
plot((rh(9).third-rh(9).second)./5,temp(9).second,'Parent',subplot1,'Color',colGCMfull(9,:),'LineWidth',2)
plot((rh(10).third-rh(10).second)./5,temp(10).second,'Parent',subplot1,'Color',colGCMfull(10,:),'LineWidth',2)
plot((rh(11).third-rh(11).second)./5,temp(11).second,'Parent',subplot1,'Color',colGCMfull(11,:),'LineWidth',2)
ylim(subplot1,[220 305]);
xlim(subplot1,[-10 10]);


%-------------------------------------------------------------------------------------------------------
%-------------------------------------------------------------------------------------------------------
%-------------------------------------------------------------------------------------------------------



% below creates a figure showing only GCMs but also showing scaled values, assuming continuity and constant SF
figure
scatter(CircSF295.SST,CircSF295.I,[],col10,'filled','s','SizeData',70);
hold on
scatter(CircSF300.SST,CircSF300.I,[],col10,'filled','s','SizeData',120);
scatter(CircSF305.SST,CircSF305.I,[],col10,'filled','s','SizeData',170);
xlim([294 306])
line([CircSF295.SST(1),CircSF300.SST(1),CircSF305.SST(1)],[CircSF295.I(1),CircSF300.I(1),CircSF305.I(1)],'Color',col10(1,:),'LineWidth',2)
line([CircSF295.SST(2),CircSF300.SST(2),CircSF305.SST(2)],[CircSF295.I(2),CircSF300.I(2),CircSF305.I(2)],'Color',col10(2,:),'LineWidth',2)
line([CircSF295.SST(3),CircSF300.SST(3),CircSF305.SST(3)],[CircSF295.I(3),CircSF300.I(3),CircSF305.I(3)],'Color',col10(3,:),'LineWidth',2)
line([CircSF295.SST(4),CircSF300.SST(4),CircSF305.SST(4)],[CircSF295.I(4),CircSF300.I(4),CircSF305.I(4)],'Color',col10(4,:),'LineWidth',2)
line([CircSF295.SST(5),CircSF300.SST(5),CircSF305.SST(5)],[CircSF295.I(5),CircSF300.I(5),CircSF305.I(5)],'Color',col10(5,:),'LineWidth',2)
line([CircSF295.SST(6),CircSF300.SST(6),CircSF305.SST(6)],[CircSF295.I(6),CircSF300.I(6),CircSF305.I(6)],'Color',col10(6,:),'LineWidth',2)
line([CircSF295.SST(7),CircSF300.SST(7),CircSF305.SST(7)],[CircSF295.I(7),CircSF300.I(7),CircSF305.I(7)],'Color',col10(7,:),'LineWidth',2)
line([CircSF295.SST(8),CircSF300.SST(8),CircSF305.SST(8)],[CircSF295.I(8),CircSF300.I(8),CircSF305.I(8)],'Color',col10(8,:),'LineWidth',2)
line([CircSF295.SST(9),CircSF300.SST(9),CircSF305.SST(9)],[CircSF295.I(9),CircSF300.I(9),CircSF305.I(9)],'Color',col10(9,:),'LineWidth',2)
line([CircSF295.SST(10),CircSF300.SST(10),CircSF305.SST(10)],[CircSF295.I(10),CircSF300.I(10),CircSF305.I(10)],'Color',col10(10,:),'LineWidth',2)
% plot the scaled values
scatter(CircSF295.SST,scaleI295,[],col10,'filled','o','SizeData',70);
scatter(CircSF300.SST,scaleI300,[],col10,'filled','o','SizeData',120);
scatter(CircSF305.SST,scaleI305,[],col10,'filled','o','SizeData',170);
line([CircSF295.SST(1),CircSF300.SST(1),CircSF305.SST(1)],[scaleI295(1),scaleI300(1),scaleI305(1)],'Color',col10(1,:),'LineWidth',1)
line([CircSF295.SST(2),CircSF300.SST(2),CircSF305.SST(2)],[scaleI295(2),scaleI300(2),scaleI305(2)],'Color',col10(2,:),'LineWidth',1)
line([CircSF295.SST(3),CircSF300.SST(3),CircSF305.SST(3)],[scaleI295(3),scaleI300(3),scaleI305(3)],'Color',col10(3,:),'LineWidth',1)
line([CircSF295.SST(4),CircSF300.SST(4),CircSF305.SST(4)],[scaleI295(4),scaleI300(4),scaleI305(4)],'Color',col10(4,:),'LineWidth',1)
line([CircSF295.SST(5),CircSF300.SST(5),CircSF305.SST(5)],[scaleI295(5),scaleI300(5),scaleI305(5)],'Color',col10(5,:),'LineWidth',1)
line([CircSF295.SST(6),CircSF300.SST(6),CircSF305.SST(6)],[scaleI295(6),scaleI300(6),scaleI305(6)],'Color',col10(6,:),'LineWidth',1)
line([CircSF295.SST(7),CircSF300.SST(7),CircSF305.SST(7)],[scaleI295(7),scaleI300(7),scaleI305(7)],'Color',col10(7,:),'LineWidth',1)
line([CircSF295.SST(8),CircSF300.SST(8),CircSF305.SST(8)],[scaleI295(8),scaleI300(8),scaleI305(8)],'Color',col10(8,:),'LineWidth',1)
line([CircSF295.SST(9),CircSF300.SST(9),CircSF305.SST(9)],[scaleI295(9),scaleI300(9),scaleI305(9)],'Color',col10(9,:),'LineWidth',1)
line([CircSF295.SST(10),CircSF300.SST(10),CircSF305.SST(10)],[scaleI295(10),scaleI300(10),scaleI305(10)],'Color',col10(10,:),'LineWidth',1)
ylabel('hPa/d')
xlabel('surface temperature (K)')
set(gca,'YScale','log')
set(gca,'FontWeight','bold')
xlabel('surface temperature (K)')
set(gca,'FontSize',14)
ylim([80 250])
title('Large-Scale Circulation')


% below shows the mean upward velocity vs I for the CRMs: 
% plotted on  log y axis.
figure
scatter(abs(Circ_omega_CRMs_295.omega_up),Circ_omega_CRMs_295.I,[],colCRM,'filled','^','SizeData',70)
hold on
scatter(abs(Circ_omega_CRMs_295.omega_up),Circ_omega_CRMs_295.I,[],colCRM,'filled','^','SizeData',70)
scatter(abs(Circ_omega_CRMs_300.omega_up),Circ_omega_CRMs_300.I,[],colCRM,'filled','^','SizeData',120)
scatter(abs(Circ_omega_CRMs_305.omega_up),Circ_omega_CRMs_305.I,[],colCRM,'filled','^','SizeData',170)
scatter(abs(Circ_omega_CRMs_295.omega_dn),Circ_omega_CRMs_295.I,[],colCRM,'filled','v','SizeData',70)
scatter(abs(Circ_omega_CRMs_300.omega_dn),Circ_omega_CRMs_300.I,[],colCRM,'filled','v','SizeData',120)
scatter(abs(Circ_omega_CRMs_305.omega_dn),Circ_omega_CRMs_305.I,[],colCRM,'filled','v','SizeData',170)
%scatter(abs(Circ_omega_CRMs_295.omega_db),Circ_omega_CRMs_295.I,[],colCRM,'filled','o','SizeData',70)
%scatter(abs(Circ_omega_CRMs_300.omega_db),Circ_omega_CRMs_300.I,[],colCRM,'filled','o','SizeData',120)
%scatter(abs(Circ_omega_CRMs_305.omega_db),Circ_omega_CRMs_305.I,[],colCRM,'filled','o','SizeData',170)
ylabel('Circlation Intensity hPa/d')
xlabel('surface temperature (K)')
set(gca,'YScale','log')
set(gca,'FontWeight','bold')
xlabel('hPa/d')
set(gca,'FontSize',14)
%ylim([80 250])

% figures below are using the original colors that I came up with.  See above for colors
% using those from Wing et al., 2020
figure
scatter(CircSF295.omega_db,CircSF295.I,[],col10,'filled','o','SizeData',70)
hold on
scatter(CircSF300.omega_db,CircSF300.I,[],col10,'filled','o','SizeData',120)
scatter(CircSF305.omega_db,CircSF305.I,[],col10,'filled','o','SizeData',170)
set(gca,'FontSize',14)

% plot the I as a function of the omega_up and omega_dn
figure
scatter(CircSF295.omega_dn,CircSF295.I,[],col10,'filled','v','SizeData',70)
hold on
scatter(CircSF300.omega_dn,CircSF300.I,[],col10,'filled','v','SizeData',120)
scatter(CircSF305.omega_dn,CircSF305.I,[],col10,'filled','v','SizeData',170)
scatter(abs(CircSF295.omega_up),CircSF295.I,[],col10,'filled','^','SizeData',70)
scatter(abs(CircSF300.omega_up),CircSF300.I,[],col10,'filled','^','SizeData',120)
scatter(abs(CircSF305.omega_up),CircSF305.I,[],col10,'filled','^','SizeData',170)
ylabel('Circulation Intensity (hPa/d)')
xlabel('mean upward/downward velocity (hPa/d)')
set(gca,'FontSize',14)





figure
scatter(CircSF295.omega_up,CircSF295.I,[],col10,'filled','o','SizeData',70)
hold on
scatter(CircSF300.omega_up,CircSF300.I,[],col10,'filled','o','SizeData',120)
scatter(CircSF305.omega_up,CircSF305.I,[],col10,'filled','o','SizeData',170)
set(gca,'FontSize',14)
ylabel('Circulation Intensity (hPa/d)')
xlabel('mean upward velocity (hPa/d)')
set(gca,'FontSize',14)

figure
scatter(RCEMIPomega295.VarName6,RCEMIPomega295.VarName3,[],col9,'filled','s','SizeData',70);
hold on
scatter(RCEMIPomega295.VarName6,RCEMIPomega295.VarName4,[],col9,'filled','v','SizeData',70);
scatter(RCEMIPomega295.VarName6,-RCEMIPomega295.VarName5,[],col9,'filled','^','SizeData',70);
scatter(RCEMIPomega300.VarName6,RCEMIPomega300.VarName3,[],col9,'filled','s','SizeData',120);
scatter(RCEMIPomega300.VarName6,RCEMIPomega300.VarName4,[],col9,'filled','v','SizeData',120);
scatter(RCEMIPomega300.VarName6,-RCEMIPomega300.VarName5,[],col9,'filled','^','SizeData',120);
scatter(RCEMIPomega305.VarName6,RCEMIPomega305.VarName3,[],col9,'filled','s','SizeData',170);
scatter(RCEMIPomega305.VarName6,RCEMIPomega305.VarName4,[],col9,'filled','v','SizeData',170);
scatter(RCEMIPomega305.VarName6,-RCEMIPomega305.VarName5,[],col9,'filled','^','SizeData',170);
xlim([294 306])
line([RCEMIPomega295.VarName6(1),RCEMIPomega300.VarName6(1),RCEMIPomega305.VarName6(1)],[RCEMIPomega295.VarName3(1),RCEMIPomega300.VarName3(1),RCEMIPomega305.VarName3(1)],'Color',col9(1,:),'LineWidth',2)
line([RCEMIPomega295.VarName6(2),RCEMIPomega300.VarName6(2),RCEMIPomega305.VarName6(2)],[RCEMIPomega295.VarName3(2),RCEMIPomega300.VarName3(2),RCEMIPomega305.VarName3(2)],'Color',col9(2,:),'LineWidth',2)
line([RCEMIPomega295.VarName6(3),RCEMIPomega300.VarName6(3),RCEMIPomega305.VarName6(3)],[RCEMIPomega295.VarName3(3),RCEMIPomega300.VarName3(3),RCEMIPomega305.VarName3(3)],'Color',col9(3,:),'LineWidth',2)
line([RCEMIPomega295.VarName6(4),RCEMIPomega300.VarName6(4),RCEMIPomega305.VarName6(4)],[RCEMIPomega295.VarName3(4),RCEMIPomega300.VarName3(4),RCEMIPomega305.VarName3(4)],'Color',col9(4,:),'LineWidth',2)
line([RCEMIPomega295.VarName6(5),RCEMIPomega300.VarName6(5),RCEMIPomega305.VarName6(5)],[RCEMIPomega295.VarName3(5),RCEMIPomega300.VarName3(5),RCEMIPomega305.VarName3(5)],'Color',col9(5,:),'LineWidth',2)
line([RCEMIPomega295.VarName6(6),RCEMIPomega300.VarName6(6),RCEMIPomega305.VarName6(6)],[RCEMIPomega295.VarName3(6),RCEMIPomega300.VarName3(6),RCEMIPomega305.VarName3(6)],'Color',col9(6,:),'LineWidth',2)
line([RCEMIPomega295.VarName6(7),RCEMIPomega300.VarName6(7),RCEMIPomega305.VarName6(7)],[RCEMIPomega295.VarName3(7),RCEMIPomega300.VarName3(7),RCEMIPomega305.VarName3(7)],'Color',col9(7,:),'LineWidth',2)
line([RCEMIPomega295.VarName6(8),RCEMIPomega300.VarName6(8),RCEMIPomega305.VarName6(8)],[RCEMIPomega295.VarName3(8),RCEMIPomega300.VarName3(8),RCEMIPomega305.VarName3(8)],'Color',col9(8,:),'LineWidth',2)
line([RCEMIPomega295.VarName6(9),RCEMIPomega300.VarName6(9),RCEMIPomega305.VarName6(9)],[RCEMIPomega295.VarName3(9),RCEMIPomega300.VarName3(9),RCEMIPomega305.VarName3(9)],'Color',col9(9,:),'LineWidth',2)
ylabel('hPa/d')
line([RCEMIPomega295.VarName6(1),RCEMIPomega300.VarName6(1),RCEMIPomega305.VarName6(1)],[RCEMIPomega295.VarName4(1),RCEMIPomega300.VarName4(1),RCEMIPomega305.VarName4(1)],'Color',col9(1,:),'LineStyle','-.','LineWidth',1)
line([RCEMIPomega295.VarName6(2),RCEMIPomega300.VarName6(2),RCEMIPomega305.VarName6(2)],[RCEMIPomega295.VarName4(2),RCEMIPomega300.VarName4(2),RCEMIPomega305.VarName4(2)],'Color',col9(2,:),'LineStyle','-.','LineWidth',1)
line([RCEMIPomega295.VarName6(3),RCEMIPomega300.VarName6(3),RCEMIPomega305.VarName6(3)],[RCEMIPomega295.VarName4(3),RCEMIPomega300.VarName4(3),RCEMIPomega305.VarName4(3)],'Color',col9(3,:),'LineStyle','-.','LineWidth',1)
line([RCEMIPomega295.VarName6(4),RCEMIPomega300.VarName6(4),RCEMIPomega305.VarName6(4)],[RCEMIPomega295.VarName4(4),RCEMIPomega300.VarName4(4),RCEMIPomega305.VarName4(4)],'Color',col9(4,:),'LineStyle','-.','LineWidth',1)
line([RCEMIPomega295.VarName6(5),RCEMIPomega300.VarName6(5),RCEMIPomega305.VarName6(5)],[RCEMIPomega295.VarName4(5),RCEMIPomega300.VarName4(5),RCEMIPomega305.VarName4(5)],'Color',col9(5,:),'LineStyle','-.','LineWidth',1)
line([RCEMIPomega295.VarName6(6),RCEMIPomega300.VarName6(6),RCEMIPomega305.VarName6(6)],[RCEMIPomega295.VarName4(6),RCEMIPomega300.VarName4(6),RCEMIPomega305.VarName4(6)],'Color',col9(6,:),'LineStyle','-.','LineWidth',1)
line([RCEMIPomega295.VarName6(7),RCEMIPomega300.VarName6(7),RCEMIPomega305.VarName6(7)],[RCEMIPomega295.VarName4(7),RCEMIPomega300.VarName4(7),RCEMIPomega305.VarName4(7)],'Color',col9(7,:),'LineStyle','-.','LineWidth',1)
line([RCEMIPomega295.VarName6(8),RCEMIPomega300.VarName6(8),RCEMIPomega305.VarName6(8)],[RCEMIPomega295.VarName4(8),RCEMIPomega300.VarName4(8),RCEMIPomega305.VarName4(8)],'Color',col9(8,:),'LineStyle','-.','LineWidth',1)
line([RCEMIPomega295.VarName6(9),RCEMIPomega300.VarName6(9),RCEMIPomega305.VarName6(9)],[RCEMIPomega295.VarName4(9),RCEMIPomega300.VarName4(9),RCEMIPomega305.VarName4(9)],'Color',col9(9,:),'LineStyle','-.','LineWidth',1)
xlabel('surface temperature (K)')
line([RCEMIPomega295.VarName6(1),RCEMIPomega300.VarName6(1),RCEMIPomega305.VarName6(1)],[-RCEMIPomega295.VarName5(1),-RCEMIPomega300.VarName5(1),-RCEMIPomega305.VarName5(1)],'Color',col9(1,:),'LineStyle','--','LineWidth',1)
line([RCEMIPomega295.VarName6(2),RCEMIPomega300.VarName6(2),RCEMIPomega305.VarName6(2)],[-RCEMIPomega295.VarName5(2),-RCEMIPomega300.VarName5(2),-RCEMIPomega305.VarName5(2)],'Color',col9(2,:),'LineStyle','--','LineWidth',1)
line([RCEMIPomega295.VarName6(3),RCEMIPomega300.VarName6(3),RCEMIPomega305.VarName6(3)],[-RCEMIPomega295.VarName5(3),-RCEMIPomega300.VarName5(3),-RCEMIPomega305.VarName5(3)],'Color',col9(3,:),'LineStyle','--','LineWidth',1)
line([RCEMIPomega295.VarName6(4),RCEMIPomega300.VarName6(4),RCEMIPomega305.VarName6(4)],[-RCEMIPomega295.VarName5(4),-RCEMIPomega300.VarName5(4),-RCEMIPomega305.VarName5(4)],'Color',col9(4,:),'LineStyle','--','LineWidth',1)
line([RCEMIPomega295.VarName6(5),RCEMIPomega300.VarName6(5),RCEMIPomega305.VarName6(5)],[-RCEMIPomega295.VarName5(5),-RCEMIPomega300.VarName5(5),-RCEMIPomega305.VarName5(5)],'Color',col9(5,:),'LineStyle','--','LineWidth',1)
line([RCEMIPomega295.VarName6(6),RCEMIPomega300.VarName6(6),RCEMIPomega305.VarName6(6)],[-RCEMIPomega295.VarName5(6),-RCEMIPomega300.VarName5(6),-RCEMIPomega305.VarName5(6)],'Color',col9(6,:),'LineStyle','--','LineWidth',1)
line([RCEMIPomega295.VarName6(7),RCEMIPomega300.VarName6(7),RCEMIPomega305.VarName6(7)],[-RCEMIPomega295.VarName5(7),-RCEMIPomega300.VarName5(7),-RCEMIPomega305.VarName5(7)],'Color',col9(7,:),'LineStyle','--','LineWidth',1)
line([RCEMIPomega295.VarName6(8),RCEMIPomega300.VarName6(8),RCEMIPomega305.VarName6(8)],[-RCEMIPomega295.VarName5(8),-RCEMIPomega300.VarName5(8),-RCEMIPomega305.VarName5(8)],'Color',col9(8,:),'LineStyle','--','LineWidth',1)
line([RCEMIPomega295.VarName6(9),RCEMIPomega300.VarName6(9),RCEMIPomega305.VarName6(9)],[-RCEMIPomega295.VarName5(9),-RCEMIPomega300.VarName5(9),-RCEMIPomega305.VarName5(9)],'Color',col9(9,:),'LineStyle','--','LineWidth',1)
set(gca,'YScale','log')
set(gca,'FontWeight','bold')
xlabel('surface temperature (K)')
set(gca,'FontSize',14)
title('Large-Scale Circulation')


% LHF vs. SST
figure
scatter(sst_a,mlhf_a,[],col,'filled','o','SizeData',70)
fig=gca;
hold on
scatter(sst_b,mlhf_b,[],col,'filled','o','SizeData',120)
scatter(sst_c,mlhf_c,[],col,'filled','o','SizeData',170)
fig.FontSize = 14;
fig.FontWeight = 'bold';
xlabel('SST, K')
fig.XTick = [295 300 305]
xlim([294 306])
ylabel('Latent Heat Flux, W/m2')

% Sfc Enthalpy Flux vs. SST
figure
scatter(hrmin_a,mlhf_a+mshf_a,[],col,'filled','o','SizeData',70)
fig=gca;
hold on
scatter(hrmin_b,mlhf_b+mshf_b,[],col,'filled','o','SizeData',120)
scatter(hrmin_c,mlhf_c+mshf_c,[],col,'filled','o','SizeData',170)
fig.FontSize = 14;
fig.FontWeight = 'bold';
xlabel('min RH, %')
ylabel('Sfc Enthalpy Flux, W/m2')

% Sfc Enthalpy Flux vs. lapse rate 
figure
scatter(mLR_a,mlhf_a+mshf_a,[],col,'filled','o','SizeData',70)
fig=gca;
hold on
scatter(mLR_b,mlhf_b+mshf_b,[],col,'filled','o','SizeData',120)
scatter(mLR_c,mlhf_c+mshf_c,[],col,'filled','o','SizeData',170)
fig.FontSize = 14;
fig.FontWeight = 'bold';
xlabel('Lapse Rate, K/km')
ylabel('Sfc Enthalpy Flux, W/m2')

% Cloud Fraction
% IPSL
figure
plot(cldf.m12a,pa.m12a)
set(gca,'Ydir','reverse')
ylabel('pressure (hPa)')
xlabel('cloud fraction')
set(gca,'FontWeight','bold')
ylim([100,1000])
hold on
plot(cldf.m12b,pa.m12a)
plot(cldf.m12c,pa.m12a)

% CAM5 
figure
plot(cldfr(1).first,pres(1).first)
set(gca,'Ydir','reverse')
ylabel('pressure (hPa)')
xlabel('cloud fraction')
set(gca,'FontWeight','bold')
ylim([100,1000])
hold on
plot(cldfr(1).second,pres(1).first)
plot(cldfr(1).third,pres(1).first)
title('CldFrac CAM5')

% ECHAM
figure
plot(cldfr(6).first,pres(6).first)
set(gca,'Ydir','reverse')
ylabel('pressure (hPa)')
xlabel('cloud fraction')
set(gca,'FontWeight','bold')
ylim([100,1000])
hold on
plot(cldfr(6).second,pres(6).first)
plot(cldfr(6).third,pres(6).first)

% GEOS 
figure
plot(cldfr(8).first,pres(8).first)
set(gca,'Ydir','reverse')
ylabel('pressure (hPa)')
xlabel('cloud fraction')
set(gca,'FontWeight','bold')
ylim([100,1000])
hold on
plot(cldfr(8).second,pres(8).first)
plot(cldfr(8).third,pres(8).first)

% ICON 
figure
plot(cldfr(9).first,pres(9).first)
set(gca,'Ydir','reverse')
ylabel('pressure (hPa)')
xlabel('cloud fraction')
set(gca,'FontWeight','bold')
ylim([100,1000])
hold on
plot(cldfr(9).second,pres(9).first)
plot(cldfr(9).third,pres(9).first)


% Relative humidity
figure
plot(rh(1).first,pres(1).first,'Color',col(1,:),'LineWidth',2)
set(gca,'Ydir','reverse')
hold on
plot(rh(2).first,pres(2).first,'Color',col(2,:),'LineWidth',2)
plot(rh(3).first,pres(3).first,'Color',col(3,:),'LineWidth',2)
plot(rh(4).first,pres(4).first,'Color',col(4,:),'LineWidth',2)
plot(rh(5).first,pres(5).first,'Color',col(5,:),'LineWidth',2)
plot(rh(6).first,pres(6).first,'Color',col(6,:),'LineWidth',2)
plot(rh(7).first,pres(7).first,'Color',col(7,:),'LineWidth',2)
plot(rh(8).first,pres(8).first,'Color',col(8,:),'LineWidth',2)
plot(rh(9).first,pres(9).first,'Color',col(9,:),'LineWidth',2)
plot(rh(10).first,pres(10).first,'Color',col(10,:),'LineWidth',2)
plot(rh(11).first,pres(11).first,'Color',col(11,:),'LineWidth',2)
set(gca,'FontWeight','bold')
ylim([100 1000])


