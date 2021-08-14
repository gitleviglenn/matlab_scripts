%------------------------------------------------------------------
%
% produces a handful of figures that are hopefully near final..
%
% levi silvers                                      july 2021
%------------------------------------------------------------------

mnvelocity = linspace(0,150,150);
sf=0.8;
%I_up_a=abs(mnvelocity.*(sf-2));
I_up_a=abs(mnvelocity./(sf));
%I_dn_a=abs(mnvelocity.*((2-sf)/(1-sf)));
I_dn_a=abs(mnvelocity./(1-sf));
sf=0.5;
I_up_b=abs(mnvelocity./(sf));
I_dn_b=abs(mnvelocity./(1-sf));
%I_up_b=abs(mnvelocity.*(sf-2));
%I_dn_b=abs(mnvelocity.*((2-sf)/(1-sf)));

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
plot(mnvelocity,I_up_a,'k','LineWidth',3)
%scatter(CircSF295.omega_dn,CircSF295.I,[],colGCM,'filled','v','SizeData',70)
hold on
plot(mnvelocity,I_up_b,'k','LineWidth',2)
plot(mnvelocity,I_dn_a,'k','LineWidth',3)
plot(mnvelocity,I_dn_b,'k','LineWidth',2)
scatter(CircSF295.omega_dn,CircSF295.I,[],colGCM,'filled','o','SizeData',70)
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

%-------------------------------------------------------------------

figure
subplot(1,3,1)
scatter(sst_10a,CircSF295.omega_db,[],colGCM,'filled','o','SizeData',70);
hold on
scatter(sst_5a,Circ_omega_CRMs_295.omega_db,[],colCRM,'filled','^','SizeData',70);
scatter(sst_5a,Circ_omega_CRMs_295.omega_db,[],colCRM,'filled','v','SizeData',70);
scatter(sst_10b,CircSF300.omega_db,[],colGCM,'filled','o','SizeData',120);
scatter(sst_5b,Circ_omega_CRMs_300.omega_db,[],colCRM,'filled','^','SizeData',120);
scatter(sst_5b,Circ_omega_CRMs_300.omega_db,[],colCRM,'filled','v','SizeData',120);
scatter(sst_10c,CircSF305.omega_db,[],colGCM,'filled','o','SizeData',170);
scatter(sst_5c,Circ_omega_CRMs_305.omega_db,[],colCRM,'filled','^','SizeData',170);
scatter(sst_5c,Circ_omega_CRMs_305.omega_db,[],colCRM,'filled','v','SizeData',170);

%-------------------------------
figure
scatter(sst_10a,CircSF295.omega_db,[],colGCM,'filled','o','SizeData',70);
hold on
scatter(sst_5a,abs(Circ_omega_CRMs_295.omega_db),[],colCRM,'filled','^','SizeData',70);
scatter(sst_5a,abs(Circ_omega_CRMs_295.omega_db),[],colCRM,'filled','v','SizeData',70);
scatter(sst_10b,CircSF300.omega_db,[],colGCM,'filled','o','SizeData',120);
scatter(sst_5b,abs(Circ_omega_CRMs_300.omega_db),[],colCRM,'filled','^','SizeData',120);
scatter(sst_5b,abs(Circ_omega_CRMs_300.omega_db),[],colCRM,'filled','v','SizeData',120);
scatter(sst_10c,CircSF305.omega_db,[],colGCM,'filled','o','SizeData',170);
scatter(sst_5c,abs(Circ_omega_CRMs_305.omega_db),[],colCRM,'filled','^','SizeData',170);
scatter(sst_5c,abs(Circ_omega_CRMs_305.omega_db),[],colCRM,'filled','v','SizeData',170);
line([sst_10a(1),sst_10b(1),sst_10c(1)],[abs(CircSF295.omega_db(1)),abs(CircSF300.omega_db(1)),abs(CircSF305.omega_db(1))],'Color',colGCM(1,:),'LineWidth',3)
line([sst_10a(1),sst_10b(1),sst_10c(1)],[abs(CircSF295.omega_db(2)),abs(CircSF300.omega_db(2)),abs(CircSF305.omega_db(2))],'Color',colGCM(2,:),'LineWidth',3)
line([sst_10a(1),sst_10b(1),sst_10c(1)],[abs(CircSF295.omega_db(3)),abs(CircSF300.omega_db(3)),abs(CircSF305.omega_db(3))],'Color',colGCM(3,:),'LineWidth',3)
line([sst_10a(1),sst_10b(1),sst_10c(1)],[abs(CircSF295.omega_db(4)),abs(CircSF300.omega_db(4)),abs(CircSF305.omega_db(4))],'Color',colGCM(4,:),'LineWidth',3)
line([sst_10a(1),sst_10b(1),sst_10c(1)],[abs(CircSF295.omega_db(5)),abs(CircSF300.omega_db(5)),abs(CircSF305.omega_db(5))],'Color',colGCM(5,:),'LineWidth',3)
line([sst_10a(1),sst_10b(1),sst_10c(1)],[abs(CircSF295.omega_db(6)),abs(CircSF300.omega_db(6)),abs(CircSF305.omega_db(6))],'Color',colGCM(6,:),'LineWidth',3)
line([sst_10a(1),sst_10b(1),sst_10c(1)],[abs(CircSF295.omega_db(7)),abs(CircSF300.omega_db(7)),abs(CircSF305.omega_db(7))],'Color',colGCM(7,:),'LineWidth',3)
line([sst_10a(1),sst_10b(1),sst_10c(1)],[abs(CircSF295.omega_db(8)),abs(CircSF300.omega_db(8)),abs(CircSF305.omega_db(8))],'Color',colGCM(8,:),'LineWidth',3)
line([sst_10a(1),sst_10b(1),sst_10c(1)],[abs(CircSF295.omega_db(9)),abs(CircSF300.omega_db(9)),abs(CircSF305.omega_db(9))],'Color',colGCM(9,:),'LineWidth',3)
line([sst_10a(1),sst_10b(1),sst_10c(1)],[abs(CircSF295.omega_db(10)),abs(CircSF300.omega_db(10)),abs(CircSF305.omega_db(10))],'Color',colGCM(10,:),'LineWidth',3)
%
xlabel('SST (K)')
%ylabel('diabatic velocity (hPa/d)')
scatter(sst_10a,abs(CircSF295.omega_up),[],colGCM,'o','SizeData',70);
scatter(sst_5a,abs(Circ_omega_CRMs_295.omega_up),[],colCRM,'^','SizeData',70);
scatter(sst_5a,abs(Circ_omega_CRMs_295.omega_up),[],colCRM,'v','SizeData',70);
scatter(sst_10b,abs(CircSF300.omega_up),[],colGCM,'o','SizeData',120);
scatter(sst_5b,abs(Circ_omega_CRMs_300.omega_up),[],colCRM,'^','SizeData',120);
scatter(sst_5b,abs(Circ_omega_CRMs_300.omega_up),[],colCRM,'v','SizeData',120);
scatter(sst_10c,abs(CircSF305.omega_up),[],colGCM,'o','SizeData',170);
scatter(sst_5c,abs(Circ_omega_CRMs_305.omega_up),[],colCRM,'^','SizeData',170);
scatter(sst_5c,abs(Circ_omega_CRMs_305.omega_up),[],colCRM,'v','SizeData',170);
line([sst_10a(1),sst_10b(1),sst_10c(1)],[abs(CircSF295.omega_up(1)),abs(CircSF300.omega_up(1)),abs(CircSF305.omega_up(1))],'Color',colGCM(1,:),'LineWidth',1)
line([sst_10a(1),sst_10b(1),sst_10c(1)],[abs(CircSF295.omega_up(2)),abs(CircSF300.omega_up(2)),abs(CircSF305.omega_up(2))],'Color',colGCM(2,:),'LineWidth',1)
line([sst_10a(1),sst_10b(1),sst_10c(1)],[abs(CircSF295.omega_up(3)),abs(CircSF300.omega_up(3)),abs(CircSF305.omega_up(3))],'Color',colGCM(3,:),'LineWidth',1)
line([sst_10a(1),sst_10b(1),sst_10c(1)],[abs(CircSF295.omega_up(4)),abs(CircSF300.omega_up(4)),abs(CircSF305.omega_up(4))],'Color',colGCM(4,:),'LineWidth',1)
line([sst_10a(1),sst_10b(1),sst_10c(1)],[abs(CircSF295.omega_up(5)),abs(CircSF300.omega_up(5)),abs(CircSF305.omega_up(5))],'Color',colGCM(5,:),'LineWidth',1)
line([sst_10a(1),sst_10b(1),sst_10c(1)],[abs(CircSF295.omega_up(6)),abs(CircSF300.omega_up(6)),abs(CircSF305.omega_up(6))],'Color',colGCM(6,:),'LineWidth',1)
line([sst_10a(1),sst_10b(1),sst_10c(1)],[abs(CircSF295.omega_up(7)),abs(CircSF300.omega_up(7)),abs(CircSF305.omega_up(7))],'Color',colGCM(7,:),'LineWidth',1)
line([sst_10a(1),sst_10b(1),sst_10c(1)],[abs(CircSF295.omega_up(8)),abs(CircSF300.omega_up(8)),abs(CircSF305.omega_up(8))],'Color',colGCM(8,:),'LineWidth',1)
line([sst_10a(1),sst_10b(1),sst_10c(1)],[abs(CircSF295.omega_up(9)),abs(CircSF300.omega_up(9)),abs(CircSF305.omega_up(9))],'Color',colGCM(9,:),'LineWidth',1)
line([sst_10a(1),sst_10b(1),sst_10c(1)],[abs(CircSF295.omega_up(10)),abs(CircSF300.omega_up(10)),abs(CircSF305.omega_up(10))],'Color',colGCM(10,:),'LineWidth',1)
%
scatter(sst_10a,abs(CircSF295.omega_up),[],colGCM,'o','SizeData',70);
scatter(sst_5a,abs(Circ_omega_CRMs_295.omega_dn),[],colCRM,'^','SizeData',70);
scatter(sst_5a,abs(Circ_omega_CRMs_295.omega_dn),[],colCRM,'v','SizeData',70);
scatter(sst_10b,CircSF300.omega_dn,[],colGCM,'o','SizeData',120);
scatter(sst_5b,abs(Circ_omega_CRMs_300.omega_dn),[],colCRM,'^','SizeData',120);
scatter(sst_5b,abs(Circ_omega_CRMs_300.omega_dn),[],colCRM,'v','SizeData',120);
scatter(sst_10c,CircSF305.omega_dn,[],colGCM,'o','SizeData',170);
scatter(sst_5c,abs(Circ_omega_CRMs_305.omega_dn),[],colCRM,'^','SizeData',170);
scatter(sst_5c,abs(Circ_omega_CRMs_305.omega_dn),[],colCRM,'v','SizeData',170);
line([sst_10a(1),sst_10b(1),sst_10c(1)],[abs(CircSF295.omega_dn(1)),abs(CircSF300.omega_dn(1)),abs(CircSF305.omega_dn(1))],'Color',colGCM(1,:),'LineWidth',2)
line([sst_10a(1),sst_10b(1),sst_10c(1)],[abs(CircSF295.omega_dn(2)),abs(CircSF300.omega_dn(2)),abs(CircSF305.omega_dn(2))],'Color',colGCM(2,:),'LineWidth',2)
line([sst_10a(1),sst_10b(1),sst_10c(1)],[abs(CircSF295.omega_dn(3)),abs(CircSF300.omega_dn(3)),abs(CircSF305.omega_dn(3))],'Color',colGCM(3,:),'LineWidth',2)
line([sst_10a(1),sst_10b(1),sst_10c(1)],[abs(CircSF295.omega_dn(4)),abs(CircSF300.omega_dn(4)),abs(CircSF305.omega_dn(4))],'Color',colGCM(4,:),'LineWidth',2)
line([sst_10a(1),sst_10b(1),sst_10c(1)],[abs(CircSF295.omega_dn(5)),abs(CircSF300.omega_dn(5)),abs(CircSF305.omega_dn(5))],'Color',colGCM(5,:),'LineWidth',2)
line([sst_10a(1),sst_10b(1),sst_10c(1)],[abs(CircSF295.omega_dn(6)),abs(CircSF300.omega_dn(6)),abs(CircSF305.omega_dn(6))],'Color',colGCM(6,:),'LineWidth',2)
line([sst_10a(1),sst_10b(1),sst_10c(1)],[abs(CircSF295.omega_dn(7)),abs(CircSF300.omega_dn(7)),abs(CircSF305.omega_dn(7))],'Color',colGCM(7,:),'LineWidth',2)
line([sst_10a(1),sst_10b(1),sst_10c(1)],[abs(CircSF295.omega_dn(8)),abs(CircSF300.omega_dn(8)),abs(CircSF305.omega_dn(8))],'Color',colGCM(8,:),'LineWidth',2)
line([sst_10a(1),sst_10b(1),sst_10c(1)],[abs(CircSF295.omega_dn(9)),abs(CircSF300.omega_dn(9)),abs(CircSF305.omega_dn(9))],'Color',colGCM(9,:),'LineWidth',2)
line([sst_10a(1),sst_10b(1),sst_10c(1)],[abs(CircSF295.omega_dn(10)),abs(CircSF300.omega_dn(10)),abs(CircSF305.omega_dn(10))],'Color',colGCM(10,:),'LineWidth',2)
%


% 
% Plot the slopes of the mean upward, downward, and diabatic omega:
%
slope1_I=(CircSF300.I-CircSF295.I)/5;
slope2_I=(CircSF305.I-CircSF300.I)/5;
slope1_omegadn=(CircSF300.omega_dn-CircSF295.omega_dn)/5;
slope2_omegadn=(CircSF305.omega_dn-CircSF300.omega_dn)/5;
slope1_omegaup=(CircSF300.omega_up-CircSF295.omega_up)/5;
slope2_omegaup=(CircSF305.omega_up-CircSF300.omega_up)/5;
slope1_omegadb=(CircSF300.omega_db-CircSF295.omega_db)/5;
slope2_omegadb=(CircSF305.omega_db-CircSF300.omega_db)/5;

slope1_crm_I=(-Circ_omega_CRMs_300.I+Circ_omega_CRMs_295.I)/5;
slope2_crm_I=(-Circ_omega_CRMs_305.I+Circ_omega_CRMs_300.I)/5;
slope1_crm_omegadn=(-Circ_omega_CRMs_300.omega_dn+Circ_omega_CRMs_295.omega_dn)/5;
slope2_crm_omegadn=(-Circ_omega_CRMs_305.omega_dn+Circ_omega_CRMs_300.omega_dn)/5;
slope1_crm_omegaup=(-Circ_omega_CRMs_300.omega_up+Circ_omega_CRMs_295.omega_up)/5;
slope2_crm_omegaup=(-Circ_omega_CRMs_305.omega_up+Circ_omega_CRMs_300.omega_up)/5;
slope1_crm_omegadb=(-Circ_omega_CRMs_300.omega_db+Circ_omega_CRMs_295.omega_db)/5;
slope2_crm_omegadb=(-Circ_omega_CRMs_305.omega_db+Circ_omega_CRMs_300.omega_db)/5;

% this just concatinates the results from the CRMs to the GCMs
slope1_tot_I=[slope1_I' -slope1_crm_I'];
slope2_tot_I=[slope2_I' -slope2_crm_I'];
slope1_tot_omegadn=[slope1_omegadn' slope1_crm_omegadn'];
slope2_tot_omegadn=[slope2_omegadn' slope2_crm_omegadn'];
slope1_tot_omegaup=[slope1_omegaup' slope1_crm_omegaup'];
slope2_tot_omegaup=[slope2_omegaup' slope2_crm_omegaup'];
slope1_tot_omegadb=[slope1_omegadb' slope1_crm_omegadb'];
slope2_tot_omegadb=[slope2_omegadb' slope2_crm_omegadb'];

modelnumber=linspace(1,15,15);
figure
plot(modelnumber,-slope1_tot_I,'--g','LineWidth',2)
hold on
plot(modelnumber,-slope2_tot_I,'g','LineWidth',2)
plot(modelnumber,slope1_tot_omegadn,'--b','LineWidth',2)
plot(modelnumber,slope1_tot_omegadb,'--k','LineWidth',2)
plot(modelnumber,slope1_tot_omegaup,'--r','LineWidth',2)
plot(modelnumber,slope2_tot_omegadn,'b','LineWidth',2)
plot(modelnumber,slope2_tot_omegadb,'k','LineWidth',2)
plot(modelnumber,slope2_tot_omegaup,'r','LineWidth',2)
xlim([1 15])
xlabel('model index')
ylabel('slope (hPa/d K)')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)

% diabatic velocity vs SST.  
figure
subplot(1,3,1)
scatter(sst_10a,CircSF295.omega_db,[],colGCM,'filled','o','SizeData',70);
hold on
scatter(sst_5a,abs(Circ_omega_CRMs_295.omega_db),[],colCRM,'filled','^','SizeData',70);
scatter(sst_5a,abs(Circ_omega_CRMs_295.omega_db),[],colCRM,'filled','v','SizeData',70);
scatter(sst_10b,CircSF300.omega_db,[],colGCM,'filled','o','SizeData',120);
scatter(sst_5b,abs(Circ_omega_CRMs_300.omega_db),[],colCRM,'filled','^','SizeData',120);
scatter(sst_5b,abs(Circ_omega_CRMs_300.omega_db),[],colCRM,'filled','v','SizeData',120);
scatter(sst_10c,CircSF305.omega_db,[],colGCM,'filled','o','SizeData',170);
scatter(sst_5c,abs(Circ_omega_CRMs_305.omega_db),[],colCRM,'filled','^','SizeData',170);
scatter(sst_5c,abs(Circ_omega_CRMs_305.omega_db),[],colCRM,'filled','v','SizeData',170);
xlabel('SST (K)')
ylabel('diabatic velocity (hPa/d)')

subplot(1,3,2)
scatter(sst_10a,abs(CircSF295.omega_up),[],colGCM,'filled','o','SizeData',70);
hold on
scatter(sst_5a,abs(Circ_omega_CRMs_295.omega_up),[],colCRM,'filled','^','SizeData',70);
scatter(sst_5a,abs(Circ_omega_CRMs_295.omega_up),[],colCRM,'filled','v','SizeData',70);
scatter(sst_10b,abs(CircSF300.omega_up),[],colGCM,'filled','o','SizeData',120);
scatter(sst_5b,abs(Circ_omega_CRMs_300.omega_up),[],colCRM,'filled','^','SizeData',120);
scatter(sst_5b,abs(Circ_omega_CRMs_300.omega_up),[],colCRM,'filled','v','SizeData',120);
scatter(sst_10c,abs(CircSF305.omega_up),[],colGCM,'filled','o','SizeData',170);
scatter(sst_5c,abs(Circ_omega_CRMs_305.omega_up),[],colCRM,'filled','^','SizeData',170);
scatter(sst_5c,abs(Circ_omega_CRMs_305.omega_up),[],colCRM,'filled','v','SizeData',170);
xlabel('SST (K)')
ylabel('w-up (hPa/d)')

subplot(1,3,3)
scatter(sst_10a,CircSF295.omega_dn,[],colGCM,'filled','o','SizeData',70);
hold on
scatter(sst_5a,abs(Circ_omega_CRMs_295.omega_dn),[],colCRM,'filled','^','SizeData',70);
scatter(sst_5a,abs(Circ_omega_CRMs_295.omega_dn),[],colCRM,'filled','v','SizeData',70);
scatter(sst_10b,CircSF300.omega_dn,[],colGCM,'filled','o','SizeData',120);
scatter(sst_5b,abs(Circ_omega_CRMs_300.omega_dn),[],colCRM,'filled','^','SizeData',120);
scatter(sst_5b,abs(Circ_omega_CRMs_300.omega_dn),[],colCRM,'filled','v','SizeData',120);
scatter(sst_10c,CircSF305.omega_dn,[],colGCM,'filled','o','SizeData',170);
scatter(sst_5c,abs(Circ_omega_CRMs_305.omega_dn),[],colCRM,'filled','^','SizeData',170);
scatter(sst_5c,abs(Circ_omega_CRMs_305.omega_dn),[],colCRM,'filled','v','SizeData',170);
xlabel('SST (K)')
ylabel('w-dn (hPa/d)')


%----------------------------------------------------------------------------

% create a figure that plots precipitable water
sst_full_295=zeros(34,1)+295;
sst_full_300=zeros(34,1)+300;
sst_full_305=zeros(34,1)+305;

Cycle1=Table295K.Precip./Table295K.PW
Cycle2=Table300K.Precip./Table300K.PW
Cycle3=Table305K.Precip./Table305K.PW

specnum=[1 2 4 6 8 9 10 11 12 16 17 19 20 21 22 23];

figure
scatter(sst_full_295(specnum),Cycle1(specnum),[],col34(specnum,:),'filled','o','SizeData',170)
hold on
%scatter(sst_full_300,Cycle2,[],col34,'filled','o','SizeData',170)
%scatter(sst_full_305,Cycle3,[],col34,'filled','o','SizeData',170)
scatter(sst_full_300(specnum),Cycle2(specnum),[],col34(specnum,:),'filled','o','SizeData',170)
scatter(sst_full_305(specnum),Cycle3(specnum),[],col34(specnum,:),'filled','o','SizeData',170)
xlabel('SST (K)')
ylabel('Water vapor cycling rate (day^-1)')
xlim([294 306])
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)

figure
%scatter(sst_full_295,Table295K.PW,[],colGCM,'filled','o','SizeData',70);
scatter(sst_full_295,Table295K.PW,'filled','o','SizeData',70);
hold on
scatter(sst_full_300,Table300K.PW,'filled','o','SizeData',70);
scatter(sst_full_305,Table305K.PW,'filled','o','SizeData',70);
%scatter(sst_5a,Circ_omega_CRMs_295.I,[],colCRM,'filled','^','SizeData',70);
%scatter(sst_5a,Circ_omega_CRMs_295.I,[],colCRM,'filled','v','SizeData',70);
%scatter(sst_10b,CircSF300.I,[],colGCM,'filled','o','SizeData',120);
%scatter(sst_5b,Circ_omega_CRMs_300.I,[],colCRM,'filled','^','SizeData',120);
%scatter(sst_5b,Circ_omega_CRMs_300.I,[],colCRM,'filled','v','SizeData',120);
%scatter(sst_10c,CircSF305.I,[],colGCM,'filled','o','SizeData',170);
%scatter(sst_5c,Circ_omega_CRMs_305.I,[],colCRM,'filled','^','SizeData',170);
%scatter(sst_5c,Circ_omega_CRMs_305.I,[],colCRM,'filled','v','SizeData',170);
xlim([294 306])


% plots with colors from Wing et al., 2020
figure
scatter(sst_full_295,Table295K.PW,[],col34,'filled','o','SizeData',70);
hold on
scatter(sst_full_300,Table300K.PW,[],col34,'filled','o','SizeData',70);
scatter(sst_full_305,Table305K.PW,[],col34,'filled','o','SizeData',70);
xlabel('SST (K)')
ylabel('Precipitable Water')
xlim([294 306])

figure
scatter(Table295K.Precip,Table295K.PW,[],col34,'filled','o','SizeData',70);
hold on
scatter(Table300K.Precip,Table300K.PW,[],col34,'filled','o','SizeData',120);
scatter(Table305K.Precip,Table305K.PW,[],col34,'filled','o','SizeData',170);
xlabel('Precip ')
ylabel('Precipitable Water')

% Fractional ch of Precipitation vs. Fractional ch of PW
figure
scatter(DelPrecip1,DelPW1,[],col34,'filled','o','SizeData',120);
hold on
scatter(DelPrecip2,DelPW2,[],col34,'filled','o','SizeData',170);
xlabel('Del Precip %/K ')
ylabel('Del PW')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)

% see Stephens et al., 1990
tsfc=linspace(290,310,20)
p1=0.1
p2=0.064;  
pwater=108.2.*(p1).*exp(p2.*(tsfc-288.));
p1b=0.2
pwater_b=108.2.*(p1b).*exp(p2.*(tsfc-288.));
p1c=0.15
pwater_c=108.2.*(p1c).*exp(p2.*(tsfc-288.));

figure 
plot(tsfc,pwater,'k')
hold on
plot(tsfc,pwater_b,'k')
plot(tsfc,pwater_c,'k')
scatter(sst_full_295,Table295K.PW,[],col34,'filled','o','SizeData',70);
scatter(sst_full_300,Table300K.PW,[],col34,'filled','o','SizeData',120);
scatter(sst_full_305,Table305K.PW,[],col34,'filled','o','SizeData',150);
xlim([294 306])
ylim([0 100])
xlabel('SST K ')
ylabel('PW (kg/m2)')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)

%----------------------------------------------------------------------------
% plot lapse rates 
% for CRMs..
figure
subplot(1,2,1)
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
%figure
subplot(1,2,2)
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

figure
subplot(1,2,1)
plot(A_CRM(1).mgam_prof,A_CRM(1).press,'Color',colCRM4(1,:),'LineWidth',2)
set(gca,'Ydir','reverse')
ylabel('pressure (hPa)')
xlabel('Lapse Rate')
set(gca,'FontWeight','bold')
ylim([100,1000])
xlim([-10.,0.0])
hold on
plot(A_CRM(1).gam_prof,A_CRM(1).press,'Color',colCRM4(1,:),'LineWidth',2)
%line([sst_5a(1),sst_5b(1),sst_5c(1)],[Circ_omega_CRMs_295.I(1),Circ_omega_CRMs_300.I(1),Circ_omega_CRMs_305.I(1)],'Color',colCRM(1,:),'LineWidth',2)
plot(A_CRM(2).mgam_prof,A_CRM(2).press,'Color',colCRM4(2,:),'LineWidth',2)
plot(A_CRM(2).gam_prof,A_CRM(2).press,'Color',colCRM4(2,:),'LineWidth',2)
plot(A_CRM(3).mgam_prof,A_CRM(3).press,'Color',colCRM4(3,:),'LineWidth',2)
plot(A_CRM(3).gam_prof,A_CRM(3).press,'Color',colCRM4(3,:),'LineWidth',2)
plot(A_CRM(4).mgam_prof,A_CRM(4).press,'Color',colCRM4(4,:),'LineWidth',2)
plot(A_CRM(4).gam_prof,A_CRM(4).press,'Color',colCRM4(4,:),'LineWidth',2)

% and for GCMs
%figure
subplot(1,2,2)
plot(A(1).mgam_prof,A(1).press,'Color',colGCMfull(1,:),'LineWidth',2)
set(gca,'Ydir','reverse')
ylabel('pressure (hPa)')
xlabel('Lapse Rate')
set(gca,'FontWeight','bold')
ylim([100,1000])
xlim([-10.,0.0])
hold on
plot(A(1).gam_prof,A(1).press,'Color',colGCMfull(1,:),'LineWidth',2)
plot(A(2).mgam_prof,A(2).press,'Color',colGCMfull(2,:),'LineWidth',2)
plot(A(2).gam_prof,A(2).press,'Color',colGCMfull(2,:),'LineWidth',2)
plot(A(3).mgam_prof,A(3).press,'Color',colGCMfull(3,:),'LineWidth',2)
plot(A(3).gam_prof,A(3).press,'Color',colGCMfull(3,:),'LineWidth',2)
plot(A(4).mgam_prof,A(4).press,'Color',colGCMfull(4,:),'LineWidth',2)
plot(A(4).gam_prof,A(4).press,'Color',colGCMfull(4,:),'LineWidth',2)
plot(A(5).mgam_prof,A(5).press,'Color',colGCMfull(5,:),'LineWidth',2)
plot(A(5).gam_prof,A(5).press,'Color',colGCMfull(5,:),'LineWidth',2)
plot(A(6).mgam_prof,A(6).press,'Color',colGCMfull(6,:),'LineWidth',2)
plot(A(6).gam_prof,A(6).press,'Color',colGCMfull(6,:),'LineWidth',2)
plot(A(7).mgam_prof,A(7).press,'Color',colGCMfull(7,:),'LineWidth',2)
plot(A(7).gam_prof,A(7).press,'Color',colGCMfull(7,:),'LineWidth',2)
plot(A(8).mgam_prof,A(8).press,'Color',colGCMfull(8,:),'LineWidth',2)
plot(A(8).gam_prof,A(8).press,'Color',colGCMfull(8,:),'LineWidth',2)
plot(A(9).mgam_prof,A(9).press,'Color',colGCMfull(9,:),'LineWidth',2)
plot(A(9).gam_prof,A(9).press,'Color',colGCMfull(9,:),'LineWidth',2)
plot(A(10).mgam_prof,A(10).press,'Color',colGCMfull(10,:),'LineWidth',2)
plot(A(10).gam_prof,A(10).press,'Color',colGCMfull(10,:),'LineWidth',2)
plot(A(11).mgam_prof,A(11).press,'Color',colGCMfull(11,:),'LineWidth',2)
plot(A(11).gam_prof,A(11).press,'Color',colGCMfull(11,:),'LineWidth',2)
sgtitle('Moist and Actual Adiabat for 295K ','FontSize',16,'FontWeight','bold')

figure
subplot(1,2,1)
plot(C_CRM(1).mgam_prof,C_CRM(1).press,'Color',colCRM4(1,:),'LineWidth',2)
set(gca,'Ydir','reverse')
ylabel('pressure (hPa)')
xlabel('Lapse Rate')
set(gca,'FontWeight','bold')
ylim([100,1000])
xlim([-10.,0.0])
hold on
plot(C_CRM(1).gam_prof,C_CRM(1).press,'Color',colCRM4(1,:),'LineWidth',2)
%line([sst_5a(1),sst_5b(1),sst_5c(1)],[Circ_omega_CRMs_295.I(1),Circ_omega_CRMs_300.I(1),Circ_omega_CRMs_305.I(1)],'Color',colCRM(1,:),'LineWidth',2)
plot(C_CRM(2).mgam_prof,C_CRM(2).press,'Color',colCRM4(2,:),'LineWidth',2)
plot(C_CRM(2).gam_prof,C_CRM(2).press,'Color',colCRM4(2,:),'LineWidth',2)
plot(C_CRM(3).mgam_prof,C_CRM(3).press,'Color',colCRM4(3,:),'LineWidth',2)
plot(C_CRM(3).gam_prof,C_CRM(3).press,'Color',colCRM4(3,:),'LineWidth',2)
plot(C_CRM(4).mgam_prof,C_CRM(4).press,'Color',colCRM4(4,:),'LineWidth',2)
plot(C_CRM(4).gam_prof,C_CRM(4).press,'Color',colCRM4(4,:),'LineWidth',2)

% and for GCMs
%figure
subplot(1,2,2)
plot(C(1).mgam_prof,C(1).press,'Color',colGCMfull(1,:),'LineWidth',2)
set(gca,'Ydir','reverse')
ylabel('pressure (hPa)')
xlabel('Lapse Rate')
set(gca,'FontWeight','bold')
ylim([100,1000])
xlim([-10.,0.0])
hold on
plot(C(1).gam_prof,C(1).press,'Color',colGCMfull(1,:),'LineWidth',2)
plot(C(2).mgam_prof,C(2).press,'Color',colGCMfull(2,:),'LineWidth',2)
plot(C(2).gam_prof,C(2).press,'Color',colGCMfull(2,:),'LineWidth',2)
plot(C(3).mgam_prof,C(3).press,'Color',colGCMfull(3,:),'LineWidth',2)
plot(C(3).gam_prof,C(3).press,'Color',colGCMfull(3,:),'LineWidth',2)
plot(C(4).mgam_prof,C(4).press,'Color',colGCMfull(4,:),'LineWidth',2)
plot(C(4).gam_prof,C(4).press,'Color',colGCMfull(4,:),'LineWidth',2)
plot(C(5).mgam_prof,C(5).press,'Color',colGCMfull(5,:),'LineWidth',2)
plot(C(5).gam_prof,C(5).press,'Color',colGCMfull(5,:),'LineWidth',2)
plot(C(6).mgam_prof,C(6).press,'Color',colGCMfull(6,:),'LineWidth',2)
plot(C(6).gam_prof,C(6).press,'Color',colGCMfull(6,:),'LineWidth',2)
plot(C(7).mgam_prof,C(7).press,'Color',colGCMfull(7,:),'LineWidth',2)
plot(C(7).gam_prof,C(7).press,'Color',colGCMfull(7,:),'LineWidth',2)
plot(C(8).mgam_prof,C(8).press,'Color',colGCMfull(8,:),'LineWidth',2)
plot(C(8).gam_prof,C(8).press,'Color',colGCMfull(8,:),'LineWidth',2)
plot(C(9).mgam_prof,C(9).press,'Color',colGCMfull(9,:),'LineWidth',2)
plot(C(9).gam_prof,C(9).press,'Color',colGCMfull(9,:),'LineWidth',2)
plot(C(10).mgam_prof,C(10).press,'Color',colGCMfull(10,:),'LineWidth',2)
plot(C(10).gam_prof,C(10).press,'Color',colGCMfull(10,:),'LineWidth',2)
plot(C(11).mgam_prof,C(11).press,'Color',colGCMfull(11,:),'LineWidth',2)
plot(C(11).gam_prof,C(11).press,'Color',colGCMfull(11,:),'LineWidth',2)
sgtitle('Moist and Cctual Cdiabat for 305K ','FontSize',16,'FontWeight','bold')
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

%---------------------------------------------------
% plot static stability vs. omega up
figure
scatter(Circ_omega_CRMs_295.sig_mn,abs(Circ_omega_CRMs_295.omega_up),[],colCRM,'filled','^','SizeData',70);
hold on
scatter(Circ_omega_CRMs_295.sig_mn,abs(Circ_omega_CRMs_295.omega_up),[],colCRM,'filled','v','SizeData',70);
scatter(Circ_omega_CRMs_300.sig_mn,abs(Circ_omega_CRMs_300.omega_up),[],colCRM,'filled','^','SizeData',120);
scatter(Circ_omega_CRMs_300.sig_mn,abs(Circ_omega_CRMs_300.omega_up),[],colCRM,'filled','v','SizeData',120);
scatter(Circ_omega_CRMs_305.sig_mn,abs(Circ_omega_CRMs_305.omega_up),[],colCRM,'filled','^','SizeData',170);
scatter(Circ_omega_CRMs_305.sig_mn,abs(Circ_omega_CRMs_305.omega_up),[],colCRM,'filled','v','SizeData',170);
scatter(CircSF295.sig_mn,abs(CircSF295.omega_up),[],colGCM,'filled','o','SizeData',70)
scatter(CircSF300.sig_mn,abs(CircSF300.omega_up),[],colGCM,'filled','o','SizeData',120)
scatter(CircSF305.sig_mn,abs(CircSF305.omega_up),[],colGCM,'filled','o','SizeData',170)
ylabel('Mean Upward Omega (hPa/day)')
xlabel('Static Stability (K/hPa)')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)
title('Pressure Velocity and Static Stability')
%---------------------------------------------------
% plot static stability vs. omega down
figure
scatter(Circ_omega_CRMs_295.sig_mn,abs(Circ_omega_CRMs_295.omega_dn),[],colCRM,'filled','^','SizeData',70);
hold on
scatter(Circ_omega_CRMs_295.sig_mn,abs(Circ_omega_CRMs_295.omega_dn),[],colCRM,'filled','v','SizeData',70);
scatter(Circ_omega_CRMs_300.sig_mn,abs(Circ_omega_CRMs_300.omega_dn),[],colCRM,'filled','^','SizeData',120);
scatter(Circ_omega_CRMs_300.sig_mn,abs(Circ_omega_CRMs_300.omega_dn),[],colCRM,'filled','v','SizeData',120);
scatter(Circ_omega_CRMs_305.sig_mn,abs(Circ_omega_CRMs_305.omega_dn),[],colCRM,'filled','^','SizeData',170);
scatter(Circ_omega_CRMs_305.sig_mn,abs(Circ_omega_CRMs_305.omega_dn),[],colCRM,'filled','v','SizeData',170);
scatter(CircSF295.sig_mn,abs(CircSF295.omega_dn),[],colGCM,'filled','o','SizeData',70)
scatter(CircSF300.sig_mn,abs(CircSF300.omega_dn),[],colGCM,'filled','o','SizeData',120)
scatter(CircSF305.sig_mn,abs(CircSF305.omega_dn),[],colGCM,'filled','o','SizeData',170)
ylabel('Mean Downward Omega (hPa/day)')
xlabel('Static Stability (K/hPa)')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)
title('Pressure Velocity and Static Stability')
%---------------------------------------------------
figure
scatter(Circ_omega_CRMs_295.sig_mn,abs(Circ_omega_CRMs_295.omega_db),[],colCRM,'filled','^','SizeData',70);
hold on
scatter(Circ_omega_CRMs_295.sig_mn,abs(Circ_omega_CRMs_295.omega_db),[],colCRM,'filled','v','SizeData',70);
scatter(Circ_omega_CRMs_300.sig_mn,abs(Circ_omega_CRMs_300.omega_db),[],colCRM,'filled','^','SizeData',120);
scatter(Circ_omega_CRMs_300.sig_mn,abs(Circ_omega_CRMs_300.omega_db),[],colCRM,'filled','v','SizeData',120);
scatter(Circ_omega_CRMs_305.sig_mn,abs(Circ_omega_CRMs_305.omega_db),[],colCRM,'filled','^','SizeData',170);
scatter(Circ_omega_CRMs_305.sig_mn,abs(Circ_omega_CRMs_305.omega_db),[],colCRM,'filled','v','SizeData',170);
scatter(CircSF295.sig_mn,abs(CircSF295.omega_db),[],colGCM,'filled','o','SizeData',70)
scatter(CircSF300.sig_mn,abs(CircSF300.omega_db),[],colGCM,'filled','o','SizeData',120)
scatter(CircSF305.sig_mn,abs(CircSF305.omega_db),[],colGCM,'filled','o','SizeData',170)
ylabel('Mean Diabatic Omega (hPa/day)')
xlabel('Static Stability (K/hPa)')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)
title('Pressure Velocity and Static Stability')
%---------------------------------------------------

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
scatter(Circ_omega_CRMs_295.sig_mn-Circ_omega_CRMs_295.sig_mn,Circ_omega_CRMs_295.Qmn-Circ_omega_CRMs_295.Qmn,[],colCRM,'filled','^','SizeData',70);
hold on
scatter(Circ_omega_CRMs_295.sig_mn-Circ_omega_CRMs_295.sig_mn,Circ_omega_CRMs_295.Qmn-Circ_omega_CRMs_295.Qmn,[],colCRM,'filled','v','SizeData',70);
scatter(Circ_omega_CRMs_300.sig_mn-Circ_omega_CRMs_295.sig_mn,Circ_omega_CRMs_300.Qmn-Circ_omega_CRMs_295.Qmn,[],colCRM,'filled','^','SizeData',120);
scatter(Circ_omega_CRMs_300.sig_mn-Circ_omega_CRMs_295.sig_mn,Circ_omega_CRMs_300.Qmn-Circ_omega_CRMs_295.Qmn,[],colCRM,'filled','v','SizeData',120);
scatter(Circ_omega_CRMs_305.sig_mn-Circ_omega_CRMs_295.sig_mn,Circ_omega_CRMs_305.Qmn-Circ_omega_CRMs_295.Qmn,[],colCRM,'filled','^','SizeData',170);
scatter(Circ_omega_CRMs_305.sig_mn-Circ_omega_CRMs_295.sig_mn,Circ_omega_CRMs_305.Qmn-Circ_omega_CRMs_295.Qmn,[],colCRM,'filled','v','SizeData',170);
scatter(CircSF295.sig_mn-CircSF295.sig_mn,CircSF295.Qmn-CircSF295.Qmn,[],colGCM,'filled','o','SizeData',70)
scatter(CircSF300.sig_mn-CircSF295.sig_mn,CircSF300.Qmn-CircSF295.Qmn,[],colGCM,'filled','o','SizeData',120)
scatter(CircSF305.sig_mn-CircSF295.sig_mn,CircSF305.Qmn-CircSF295.Qmn,[],colGCM,'filled','o','SizeData',170)
ylabel('Net Radiative Cooling (K/day)')
xlabel('Static Stability (K/hPa)')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)
title('Radiative Heating and Static Stability Anomalies')

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
