%------------------------------------------------------------------
%
% produces a handful of figures that are hopefully near final..
%
% levi silvers                                      july 2021
%------------------------------------------------------------------

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
sgtitle('Overturning Circulation at 500 hPa','FontSize',16,'FontWeight','bold')

%----------------------------------------------------------------------------
% plot lapse rates 
% for CRMs..
figure
plot(B_CRM(1).mgam_prof,B_CRM(1).press,'Color',colCRM4(1,:),'LineWidth',2)
set(gca,'Ydir','reverse')
ylabel('pressure (hPa)')
xlabel('Lapse Rate')
set(gca,'FontWeight','bold')
ylim([100,1000])
xlim([-10.,0.0])
hold on
plot(B_CRM(1).gam_prof,B_CRM(1).press,'Color',colCRM4(1,:),'LineWidth',2)
%line([sst_5a(1),sst_5b(1),sst_5c(1)],[Circ_omega_CRMs_295.I(1),Circ_omega_CRMs_300.I(1),Circ_omega_CRMs_305.I(1)],'Color',colCRM(1,:),'LineWidth',2)
plot(B_CRM(2).mgam_prof,B_CRM(2).press,'Color',colCRM4(2,:),'LineWidth',2)
plot(B_CRM(2).gam_prof,B_CRM(2).press,'Color',colCRM4(2,:),'LineWidth',2)
plot(B_CRM(3).mgam_prof,B_CRM(3).press,'Color',colCRM4(3,:),'LineWidth',2)
plot(B_CRM(3).gam_prof,B_CRM(3).press,'Color',colCRM4(3,:),'LineWidth',2)
plot(B_CRM(4).mgam_prof,B_CRM(4).press,'Color',colCRM4(4,:),'LineWidth',2)
plot(B_CRM(4).gam_prof,B_CRM(4).press,'Color',colCRM4(4,:),'LineWidth',2)

% and for GCMs
figure
plot(B(1).mgam_prof,B(1).press,'Color',colGCMfull(1,:),'LineWidth',2)
set(gca,'Ydir','reverse')
ylabel('pressure (hPa)')
xlabel('Lapse Rate')
set(gca,'FontWeight','bold')
ylim([100,1000])
xlim([-10.,0.0])
hold on
plot(B(1).gam_prof,B(1).press,'Color',colGCMfull(1,:),'LineWidth',2)
plot(B(2).mgam_prof,B(2).press,'Color',colGCMfull(2,:),'LineWidth',2)
plot(B(2).gam_prof,B(2).press,'Color',colGCMfull(2,:),'LineWidth',2)
plot(B(3).mgam_prof,B(3).press,'Color',colGCMfull(3,:),'LineWidth',2)
plot(B(3).gam_prof,B(3).press,'Color',colGCMfull(3,:),'LineWidth',2)
plot(B(4).mgam_prof,B(4).press,'Color',colGCMfull(4,:),'LineWidth',2)
plot(B(4).gam_prof,B(4).press,'Color',colGCMfull(4,:),'LineWidth',2)
plot(B(5).mgam_prof,B(5).press,'Color',colGCMfull(5,:),'LineWidth',2)
plot(B(5).gam_prof,B(5).press,'Color',colGCMfull(5,:),'LineWidth',2)
plot(B(6).mgam_prof,B(6).press,'Color',colGCMfull(6,:),'LineWidth',2)
plot(B(6).gam_prof,B(6).press,'Color',colGCMfull(6,:),'LineWidth',2)
plot(B(7).mgam_prof,B(7).press,'Color',colGCMfull(7,:),'LineWidth',2)
plot(B(7).gam_prof,B(7).press,'Color',colGCMfull(7,:),'LineWidth',2)
plot(B(8).mgam_prof,B(8).press,'Color',colGCMfull(8,:),'LineWidth',2)
plot(B(8).gam_prof,B(8).press,'Color',colGCMfull(8,:),'LineWidth',2)
plot(B(9).mgam_prof,B(9).press,'Color',colGCMfull(9,:),'LineWidth',2)
plot(B(9).gam_prof,B(9).press,'Color',colGCMfull(9,:),'LineWidth',2)
plot(B(10).mgam_prof,B(10).press,'Color',colGCMfull(10,:),'LineWidth',2)
plot(B(10).gam_prof,B(10).press,'Color',colGCMfull(10,:),'LineWidth',2)
plot(B(11).mgam_prof,B(11).press,'Color',colGCMfull(11,:),'LineWidth',2)
plot(B(11).gam_prof,B(11).press,'Color',colGCMfull(11,:),'LineWidth',2)
%----------------------------------------------------------------------------

%% compute anomalies relative to 300K
%CircSF295anom=abs(CircSF295.omega_db)-abs(CircSF300.omega_db);
%CircSF300anom=abs(CircSF300.omega_db)-abs(CircSF300.omega_db);
%CircSF305anom=abs(CircSF305.omega_db)-abs(CircSF300.omega_db);
%CircSF295_CRM_anom=abs(Circ_omega_CRMs_295.omega_db)-abs(Circ_omega_CRMs_300.omega_db);
%CircSF300_CRM_anom=abs(Circ_omega_CRMs_300.omega_db)-abs(Circ_omega_CRMs_300.omega_db);
%CircSF305_CRM_anom=abs(Circ_omega_CRMs_305.omega_db)-abs(Circ_omega_CRMs_300.omega_db);
%Circ295_GCM=CircSF295.I-CircSF300.I;
%Circ300_GCM=CircSF300.I-CircSF300.I;
%Circ305_GCM=CircSF305.I-CircSF300.I;
%Circ295_CRM=Circ_omega_CRMs_295.I-Circ_omega_CRMs_300.I;
%Circ300_CRM=Circ_omega_CRMs_300.I-Circ_omega_CRMs_300.I;
%Circ305_CRM=Circ_omega_CRMs_305.I-Circ_omega_CRMs_300.I;
%
%% anomalous omega db values
%figure
%scatter(CircSF295anom,CircSF295.I,[],colGCM,'filled','o','SizeData',70)
%hold on
%scatter(CircSF300anom,CircSF300.I,[],colGCM,'filled','o','SizeData',120)
%scatter(CircSF305anom,CircSF305.I,[],colGCM,'filled','o','SizeData',170)
%scatter(CircSF295_CRM_anom,Circ_omega_CRMs_295.I,[],colCRM,'filled','v','SizeData',70)
%scatter(CircSF295_CRM_anom,Circ_omega_CRMs_295.I,[],colCRM,'filled','^','SizeData',70)
%scatter(CircSF300_CRM_anom,Circ_omega_CRMs_300.I,[],colCRM,'filled','^','SizeData',120)
%scatter(CircSF300_CRM_anom,Circ_omega_CRMs_300.I,[],colCRM,'filled','v','SizeData',120)
%scatter(CircSF305_CRM_anom,Circ_omega_CRMs_305.I,[],colCRM,'filled','^','SizeData',170)
%scatter(CircSF305_CRM_anom,Circ_omega_CRMs_305.I,[],colCRM,'filled','v','SizeData',170)
%ylabel('Circulation Intensity, I (hPa/d)')
%xlabel('diabatic velocity (hPa/d)')
%set(gca,'FontWeight','bold')
%set(gca,'FontSize',14)
%%title('Overturning Circulation vs Diabatic Velocity')
%sgtitle('Overturning Circulation at 500 hPa','FontSize',16,'FontWeight','bold')
%
%% anomalous omega db and circulation intensity values
%figure
%scatter(CircSF295anom,Circ295_GCM,[],colGCM,'filled','o','SizeData',70)
%hold on
%scatter(CircSF300anom,Circ300_GCM,[],colGCM,'filled','o','SizeData',120)
%scatter(CircSF305anom,Circ305_GCM,[],colGCM,'filled','o','SizeData',170)
%scatter(CircSF295_CRM_anom,Circ295_CRM,[],colCRM,'filled','v','SizeData',70)
%scatter(CircSF295_CRM_anom,Circ295_CRM,[],colCRM,'filled','^','SizeData',70)
%scatter(CircSF300_CRM_anom,Circ300_CRM,[],colCRM,'filled','^','SizeData',120)
%scatter(CircSF300_CRM_anom,Circ300_CRM,[],colCRM,'filled','v','SizeData',120)
%scatter(CircSF305_CRM_anom,Circ305_CRM,[],colCRM,'filled','^','SizeData',170)
%scatter(CircSF305_CRM_anom,Circ305_CRM,[],colCRM,'filled','v','SizeData',170)
%ylabel('Circulation Intensity, I (hPa/d)')
%xlabel('diabatic velocity (hPa/d)')
%set(gca,'FontWeight','bold')
%set(gca,'FontSize',14)
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
