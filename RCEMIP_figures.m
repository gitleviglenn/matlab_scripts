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

% scatter of Intensity vs omega_db
figure
scatter(mnomeg8ms295K.omega_db,mnomeg8ms295K.CircI,[],col8,'filled','o','SizeData',70)
fig=gca;
hold on
scatter(mnomeg8ms300K.omega_db,mnomeg8ms300K.CircI,[],col8,'filled','o','SizeData',120)
scatter(mnomeg8ms305K.omega_db,mnomeg8ms305K.CircI,[],col8,'filled','o','SizeData',170)
fig.FontSize = 14;
fig.FontWeight = 'bold';
xlabel('Diabatic Omega hPa/day')
ylabel('Circulation Intensity hPa/day')

% scatter of Intensity vs omega_d
figure
scatter(mnomeg8ms295K.omega_d,mnomeg8ms295K.CircI,[],col8,'filled','o','SizeData',70)
fig=gca;
hold on
scatter(mnomeg8ms300K.omega_d,mnomeg8ms300K.CircI,[],col8,'filled','o','SizeData',120)
scatter(mnomeg8ms305K.omega_d,mnomeg8ms305K.CircI,[],col8,'filled','o','SizeData',170)
fig.FontSize = 14;
fig.FontWeight = 'bold';
xlabel('Subsiding Omega hPa/day')
ylabel('Circulation Intensity hPa/day')

% scatter of Intensity vs omega_d
figure
scatter(mnomeg8ms295K.omega_u,mnomeg8ms295K.CircI,[],col8,'filled','o','SizeData',70)
fig=gca;
hold on
scatter(mnomeg8ms300K.omega_u,mnomeg8ms300K.CircI,[],col8,'filled','o','SizeData',120)
scatter(mnomeg8ms305K.omega_u,mnomeg8ms305K.CircI,[],col8,'filled','o','SizeData',170)
fig.FontSize = 14;
fig.FontWeight = 'bold';
xlabel('Ascending Omega hPa/day')
ylabel('Circulation Intensity hPa/day')

% scatter of Intensity vs omega_d
figure
scatter(mnomeg8ms295K.SF,mnomeg8ms295K.CircI,[],col8,'filled','o','SizeData',70)
fig=gca;
hold on
scatter(mnomeg8ms300K.SF,mnomeg8ms300K.CircI,[],col8,'filled','o','SizeData',120)
scatter(mnomeg8ms305K.SF,mnomeg8ms305K.CircI,[],col8,'filled','o','SizeData',170)
fig.FontSize = 14;
fig.FontWeight = 'bold';
xlabel('Subsidence Fraction')
ylabel('Circulation Intensity hPa/day')

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
scatter(CircSF295.omega_dn,CircSF295.I,[],colGCM,'filled','v','SizeData',70)
hold on
scatter(CircSF300.omega_dn,CircSF300.I,[],colGCM,'filled','v','SizeData',120)
scatter(CircSF305.omega_dn,CircSF305.I,[],colGCM,'filled','v','SizeData',170)
scatter(abs(CircSF295.omega_up),CircSF295.I,[],colGCM,'filled','^','SizeData',70)
scatter(abs(CircSF300.omega_up),CircSF300.I,[],colGCM,'filled','^','SizeData',120)
scatter(abs(CircSF305.omega_up),CircSF305.I,[],colGCM,'filled','^','SizeData',170)
scatter(abs(Circ_omega_CRMs_295.omega_up),Circ_omega_CRMs_295.I,[],colCRM,'filled','^','SizeData',70)
scatter(abs(Circ_omega_CRMs_295.omega_up),Circ_omega_CRMs_295.I,[],colCRM,'filled','^','SizeData',70)
scatter(abs(Circ_omega_CRMs_300.omega_up),Circ_omega_CRMs_300.I,[],colCRM,'filled','^','SizeData',120)
scatter(abs(Circ_omega_CRMs_305.omega_up),Circ_omega_CRMs_305.I,[],colCRM,'filled','^','SizeData',170)
scatter(abs(Circ_omega_CRMs_295.omega_dn),Circ_omega_CRMs_295.I,[],colCRM,'filled','v','SizeData',70)
scatter(abs(Circ_omega_CRMs_300.omega_dn),Circ_omega_CRMs_300.I,[],colCRM,'filled','v','SizeData',120)
scatter(abs(Circ_omega_CRMs_305.omega_dn),Circ_omega_CRMs_305.I,[],colCRM,'filled','v','SizeData',170)
%scatter(abs(Circ_omega_CRMs_295.omega_db),Circ_omega_CRMs_295.I,[],colCRM,'filled','o','SizeData',70)
%scatter(abs(Circ_omega_CRMs_300.omega_db),Circ_omega_CRMs_300.I,[],colCRM,'filled','o','SizeData',120)
%scatter(abs(Circ_omega_CRMs_305.omega_db),Circ_omega_CRMs_305.I,[],colCRM,'filled','o','SizeData',170)
%scatter(abs(CircSF305.omega_db),CircSF305.I,[],colGCM,'filled','o','SizeData',170)
%scatter(abs(CircSF300.omega_db),CircSF300.I,[],colGCM,'filled','o','SizeData',120)
%scatter(abs(CircSF295.omega_db),CircSF295.I,[],colGCM,'filled','o','SizeData',70)
%ylabel('Circlation Intensity hPa/d')
%xlabel('surface temperature (K)')
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

% compute anomalies relative to 300K
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

% anomalous omega db values
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
%title('Overturning Circulation vs Diabatic Velocity')
sgtitle('Overturning Circulation at 500 hPa','FontSize',16,'FontWeight','bold')

% anomalous omega db and circulation intensity values
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
%title('Overturning Circulation vs Diabatic Velocity')
sgtitle('Overturning Circulation at 500 hPa','FontSize',16,'FontWeight','bold')


% Relative humidity
figure1=figure;
subplot1=subplot(1,3,1,'Parent',figure1);
hold(subplot1,'on');
plot(rh(1).first,temp(1).first,'Parent',subplot1,'Color',colGCMfull(1,:),'LineWidth',2)
set(subplot1,'Ydir','reverse')
%hold on
set(subplot1,'FontWeight','bold')
plot(rh(2).first,temp(2).first,'Parent',subplot1,'Color',colGCMfull(2,:),'LineWidth',2)
plot(rh(3).first,temp(3).first,'Parent',subplot1,'Color',colGCMfull(3,:),'LineWidth',2)
plot(rh(4).first,temp(4).first,'Parent',subplot1,'Color',colGCMfull(4,:),'LineWidth',2)
plot(rh(5).first,temp(5).first,'Parent',subplot1,'Color',colGCMfull(5,:),'LineWidth',2)
plot(rh(6).first,temp(6).first,'Parent',subplot1,'Color',colGCMfull(6,:),'LineWidth',2)
plot(rh(7).first,temp(7).first,'Parent',subplot1,'Color',colGCMfull(7,:),'LineWidth',2)
plot(rh(8).first,temp(8).first,'Parent',subplot1,'Color',colGCMfull(8,:),'LineWidth',2)
plot(rh(9).first,temp(9).first,'Parent',subplot1,'Color',colGCMfull(9,:),'LineWidth',2)
plot(rh(10).first,temp(10).first,'Parent',subplot1,'Color',colGCMfull(10,:),'LineWidth',2)
plot(rh(11).first,temp(11).first,'Parent',subplot1,'Color',colGCMfull(11,:),'LineWidth',2)
set(subplot1,'FontWeight','bold')
ylim(subplot1,[200 305])
xlim(subplot1,[1 100])

subplot2=subplot(1,3,2,'Parent',figure1)
plot(rh(1).second,temp(1).second,'Parent',subplot2,'Color',colGCMfull(1,:),'LineWidth',2)
hold(subplot2,'on');
set(subplot2,'Ydir','reverse')
plot(rh(2).second,temp(2).second,'Parent',subplot2,'Color',colGCMfull(2,:),'LineWidth',2)
plot(rh(3).second,temp(3).second,'Parent',subplot2,'Color',colGCMfull(3,:),'LineWidth',2)
plot(rh(4).second,temp(4).second,'Parent',subplot2,'Color',colGCMfull(4,:),'LineWidth',2)
plot(rh(5).second,temp(5).second,'Parent',subplot2,'Color',colGCMfull(5,:),'LineWidth',2)
plot(rh(6).second,temp(6).second,'Parent',subplot2,'Color',colGCMfull(6,:),'LineWidth',2)
plot(rh(7).second,temp(7).second,'Parent',subplot2,'Color',colGCMfull(7,:),'LineWidth',2)
plot(rh(8).second,temp(8).second,'Parent',subplot2,'Color',colGCMfull(8,:),'LineWidth',2)
plot(rh(9).second,temp(9).second,'Parent',subplot2,'Color',colGCMfull(9,:),'LineWidth',2)
plot(rh(10).second,temp(10).second,'Parent',subplot2,'Color',colGCMfull(10,:),'LineWidth',2)
plot(rh(11).second,temp(11).second,'Parent',subplot2,'Color',colGCMfull(11,:),'LineWidth',2)
axis(subplot2,'ij');
set(subplot2,'FontWeight','bold');
ylim(subplot2,[200 305]);
xlim(subplot2,[1 100]);
box(subplot2,'off');

subplot3=subplot(1,3,3,'Parent',figure1);
hold(subplot3,'on');
plot(rh(1).third,temp(1).third,'DisplayName','CAM5','Parent',subplot3,'Color',colGCMfull(1,:),'LineWidth',2)
set(subplot3,'Ydir','reverse')
plot(rh(2).third,temp(2).third,'DisplayName','CAM6','Parent',subplot3,'Color',colGCMfull(2,:),'LineWidth',2)
plot(rh(3).third,temp(3).third,'DisplayName','CNRM','Parent',subplot3,'Color',colGCMfull(3,:),'LineWidth',2)
plot(rh(4).third,temp(4).third,'DisplayName','ECHAM6','Parent',subplot3,'Color',colGCMfull(4,:),'LineWidth',2)
plot(rh(5).third,temp(5).third,'DisplayName','GEOS','Parent',subplot3,'Color',colGCMfull(5,:),'LineWidth',2)
plot(rh(6).third,temp(6).third,'DisplayName','ICON','Parent',subplot3,'Color',colGCMfull(6,:),'LineWidth',2)
plot(rh(7).third,temp(7).third,'DisplayName','IPSL','Parent',subplot3,'Color',colGCMfull(7,:),'LineWidth',2)
plot(rh(8).third,temp(8).third,'DisplayName','SAM0-UNICON','Parent',subplot3,'Color',colGCMfull(8,:),'LineWidth',2)
plot(rh(9).third,temp(9).third,'DisplayName','SP-CAM','Parent',subplot3,'Color',colGCMfull(9,:),'LineWidth',2)
plot(rh(10).third,temp(10).third,'DisplayName','SPX-CAM','Parent',subplot3,'Color',colGCMfull(10,:),'LineWidth',2)
plot(rh(11).third,temp(11).third,'DisplayName','UKMO-GA7.1','Parent',subplot3,'Color',colGCMfull(11,:),'LineWidth',2)
axis(subplot3,'ij');
set(subplot3,'FontWeight','bold');
ylim(subplot3,[200 305]);
xlim(subplot3,[1 100]);
legend1=legend(subplot3,'show');
box(legend1,'off');
title(subplot1,'SST=295K')
title(subplot2,'SST=300K')
title(subplot3,'SST=305K')
ylabel(subplot1,'Temperature K')
xlabel(subplot1,'Relative Humidity %')
xlabel(subplot2,'Relative Humidity %')
xlabel(subplot3,'Relative Humidity %')


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


