%------------------------------------------------------------------
% RCEMIP_circ_figures.m
%
% produces a handful of figures that are hopefully near final..
%
% first run: 
%   openRCEprofiles.m
% 
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

qmnfixed=-1.3;

% i have so many indexing arrays here.... there must be a better way.
% define the models which will be plotted: 
% the integers in 'mnum' need to match the desired models in the col34 array, defined in create_RCEMIP_colors.m
mnum      =[1 2 4 6 8 9 10 11 13 16 17 19 20 21 22 23 24 25 26 27 28];
mnumcs    =[1 2 4 8 10 11 13 16 17 19 20 21 22 23 24 25 26];
GCM_cs    =[1 2 3 5 7 8 9 10];
CRM_cs    =[1 2 3 4 5 7 9 10 11];
GCM_num   =[1 2 3 4 5 6 7 8 9 10];
CRM_num   =[1 2 3 4 5 6 7 8 9 10 11];
%specnum =[1 2 4 6 8 9 10 11 12 16 17 19 20 21 22 23];

% which models do not have clear sky radiative fluxes?  ECHAM, ICON-GCM, WRF-COL-CRM, WRF-CRM

%these numbers should correspond to the row number+1 in the the Table295K structure
gcm_num=[1 2 4 6 8 9 16 20 21 23]; % 6 and 9, ECHAM and ICON-GCM don't have clear sky fluxes
crm_num=[17 19 10 11 22 28 13 27 24 25 26]; % 27 and 28 WRF-CRM and WRF-COL-CRM do not have clear sky fluxes.  
messy_num=[gcm_num crm_num];

% define water vapor cycling rate (C_wv)
Cycle1=Table295K.Precip./Table295K.PW
Cycle2=Table300K.Precip./Table300K.PW
Cycle3=Table305K.Precip./Table305K.PW

% for GCMs:
xx=[sst_10a(1),sst_10b(1),sst_10c(1)];
%xxx=[sst_full_295(1),sst_full_300(1),sst_full_305(1)];
y_cycle        =[Cycle1,Cycle2,Cycle3];
y_I        =[abs(CircSF295.I),abs(CircSF300.I),abs(CircSF305.I)];
y_omega_up =[abs(CircSF295.omega_up),abs(CircSF300.omega_up),abs(CircSF305.omega_up)];
y_omega_dn =[abs(CircSF295.omega_dn),abs(CircSF300.omega_dn),abs(CircSF305.omega_dn)];
y_omega_db =[abs(CircSF295.omega_db),abs(CircSF300.omega_db),abs(CircSF305.omega_db)];
%clear tempcoeff, coeff_gcm;
for ind=1:34;
   tempcoeff_cycle  =polyfit(xx,y_cycle(ind,:),1);
   coeff_cycle(ind)  =tempcoeff_cycle(1);  
end
slope_cycle=coeff_cycle(mnum);

% calculate the mean water vapor cycling rate for each model
% I want to calculate the fractional change of C_wv
modelmn_cycle_full=mean(y_cycle,2);
modelmn_cycle     =modelmn_cycle_full(mnum)';
% fractional change of the water vapor cycling rate: delta(C_wv)/mean(c_wv)
frac_cycle=slope_cycle./modelmn_cycle;


%-------------------------------------------------------------------------------------------------------
% Near Final 3 panel figure comparing circulation Intensity with SST, omega up, omega dn, and diab omega
%-------------------------------------------------------------------------------------------------------
figure2 = figure
%figure
subplot(1,3,1)
scatter(sst_10a,CircSF295.I,[],colGCM,'filled','o','SizeData',70);
hold on
scatter(sst_5a,Circ_omega_CRMs_295.I,[],colCRM,'filled','h','SizeData',120);
scatter(sst_10b,CircSF300.I,[],colGCM,'filled','o','SizeData',120);
scatter(sst_5b,Circ_omega_CRMs_300.I,[],colCRM,'filled','h','SizeData',170);
scatter(sst_10c,CircSF305.I,[],colGCM,'filled','o','SizeData',170);
scatter(sst_5c,Circ_omega_CRMs_305.I,[],colCRM,'filled','h','SizeData',220);
xlim([294 306])
line([sst_5a(1),sst_5b(1),sst_5c(1)],[Circ_omega_CRMs_295.I(1),Circ_omega_CRMs_300.I(1),Circ_omega_CRMs_305.I(1)],'Color',colCRM(1,:),'LineWidth',2)
line([sst_5a(1),sst_5b(1),sst_5c(1)],[Circ_omega_CRMs_295.I(2),Circ_omega_CRMs_300.I(2),Circ_omega_CRMs_305.I(2)],'Color',colCRM(2,:),'LineWidth',2)
line([sst_5a(1),sst_5b(1),sst_5c(1)],[Circ_omega_CRMs_295.I(3),Circ_omega_CRMs_300.I(3),Circ_omega_CRMs_305.I(3)],'Color',colCRM(3,:),'LineWidth',2)
line([sst_5a(1),sst_5b(1),sst_5c(1)],[Circ_omega_CRMs_295.I(4),Circ_omega_CRMs_300.I(4),Circ_omega_CRMs_305.I(4)],'Color',colCRM(4,:),'LineWidth',2)
line([sst_5a(1),sst_5b(1),sst_5c(1)],[Circ_omega_CRMs_295.I(5),Circ_omega_CRMs_300.I(5),Circ_omega_CRMs_305.I(5)],'Color',colCRM(5,:),'LineWidth',2)
line([sst_5a(1),sst_5b(1),sst_5c(1)],[Circ_omega_CRMs_295.I(6),Circ_omega_CRMs_300.I(6),Circ_omega_CRMs_305.I(6)],'Color',colCRM(6,:),'LineWidth',2)
line([sst_5a(1),sst_5b(1),sst_5c(1)],[Circ_omega_CRMs_295.I(7),Circ_omega_CRMs_300.I(7),Circ_omega_CRMs_305.I(7)],'Color',colCRM(7,:),'LineWidth',2)
line([sst_5a(1),sst_5b(1),sst_5c(1)],[Circ_omega_CRMs_295.I(8),Circ_omega_CRMs_300.I(8),Circ_omega_CRMs_305.I(8)],'Color',colCRM(8,:),'LineWidth',2)
line([sst_5a(1),sst_5b(1),sst_5c(1)],[Circ_omega_CRMs_295.I(9),Circ_omega_CRMs_300.I(9),Circ_omega_CRMs_305.I(9)],'Color',colCRM(9,:),'LineWidth',2)
line([sst_5a(1),sst_5b(1),sst_5c(1)],[Circ_omega_CRMs_295.I(10),Circ_omega_CRMs_300.I(10),Circ_omega_CRMs_305.I(10)],'Color',colCRM(10,:),'LineWidth',2)
line([sst_5a(1),sst_5b(1),sst_5c(1)],[Circ_omega_CRMs_295.I(11),Circ_omega_CRMs_300.I(11),Circ_omega_CRMs_305.I(11)],'Color',colCRM(11,:),'LineWidth',2)
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
xlabel('SST (K)')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)
ylim([0 150])

subplot(1,3,2)
plot(mnvelocity,I_up_a,'k','LineWidth',3)
hold on
plot(mnvelocity,I_up_b,'k','LineWidth',2)
plot(mnvelocity,I_dn_a,'k','LineWidth',3)
plot(mnvelocity,I_dn_b,'k','LineWidth',2)
scatter(CircSF295.omega_dn,CircSF295.I,[],colGCM,'o','LineWidth',2,'SizeData',70)
scatter(CircSF300.omega_dn,CircSF300.I,[],colGCM,'o','LineWidth',2,'SizeData',120)
scatter(CircSF305.omega_dn,CircSF305.I,[],colGCM,'o','LineWidth',2,'SizeData',170)
scatter(abs(CircSF295.omega_up),CircSF295.I,[],colGCM,'filled','o','SizeData',70)
scatter(abs(CircSF300.omega_up),CircSF300.I,[],colGCM,'filled','o','SizeData',120)
scatter(abs(CircSF305.omega_up),CircSF305.I,[],colGCM,'filled','o','SizeData',170)
scatter(abs(Circ_omega_CRMs_295.omega_up),Circ_omega_CRMs_295.I,[],colCRM,'filled','h','SizeData',120)
scatter(abs(Circ_omega_CRMs_300.omega_up),Circ_omega_CRMs_300.I,[],colCRM,'filled','h','SizeData',170)
scatter(abs(Circ_omega_CRMs_305.omega_up),Circ_omega_CRMs_305.I,[],colCRM,'filled','h','SizeData',220)
scatter(abs(Circ_omega_CRMs_295.omega_dn),Circ_omega_CRMs_295.I,[],colCRM,'h','LineWidth',2,'SizeData',120)
scatter(abs(Circ_omega_CRMs_300.omega_dn),Circ_omega_CRMs_300.I,[],colCRM,'h','LineWidth',2,'SizeData',170)
scatter(abs(Circ_omega_CRMs_305.omega_dn),Circ_omega_CRMs_305.I,[],colCRM,'h','LineWidth',2,'SizeData',220)
ylabel('Circulation Intensity, I (hPa/d)')
xlabel('mean velocity (\omega) (hPa/d)')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)
ylim([0 150])

subplot(1,3,3)
scatter(abs(CircSF295.omega_db(GCM_cs)),CircSF295.I(GCM_cs),[],colGCM(GCM_cs,:),'filled','o','SizeData',70)
hold on
scatter(abs(CircSF305.omega_db(GCM_cs)),CircSF305.I(GCM_cs),[],colGCM(GCM_cs,:),'filled','o','SizeData',170)
scatter(abs(CircSF300.omega_db(GCM_cs)),CircSF300.I(GCM_cs),[],colGCM(GCM_cs,:),'filled','o','SizeData',120)
scatter(abs(Circ_omega_CRMs_295.omega_db(CRM_cs)),Circ_omega_CRMs_295.I(CRM_cs),[],colCRM(CRM_cs,:),'filled','h','SizeData',120)
scatter(abs(Circ_omega_CRMs_300.omega_db(CRM_cs)),Circ_omega_CRMs_300.I(CRM_cs),[],colCRM(CRM_cs,:),'filled','h','SizeData',170)
scatter(abs(Circ_omega_CRMs_305.omega_db(CRM_cs)),Circ_omega_CRMs_305.I(CRM_cs),[],colCRM(CRM_cs,:),'filled','h','SizeData',220)
ylabel('Circulation Intensity, I (hPa/d)')
xlabel('diabatic velocity (\omega_d) (hPa/d)')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)
ylim([0 150])
xlim([15 60])
sgtitle('Overturning Circulation at 500 hPa','FontSize',16,'FontWeight','bold')

    %[0.306157849089332 0.780415430267062 0.0234171725932352 0.0761513353115727],...
    %[0.594102341717259 0.792284866468843 0.0234171725932352 0.0761513353115727],...
ypos=0.81;
% Create textbox
annotation(figure2,'textbox',...
    [0.306157849089332 ypos 0.0234171725932352 0.0761513353115727],...
    'String','(a)',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',16,...
    'FitBoxToText','off');

% Create textbox
annotation(figure2,'textbox',...
    [0.594102341717259 ypos 0.0234171725932352 0.0761513353115727],...
    'String','(b)',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',16,...
    'FitBoxToText','off');

% Create textbox
annotation(figure2,'textbox',...
    [0.872506504770163 ypos 0.0234171725932353 0.0761513353115727],...
    'String','(c)',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',16,...
    'FitBoxToText','off');


%
% test
%

%%these numbers should correspond to the row number+1 in the the Table295K structure
%gcm_num=[1 2 4 6 8 9 16 20 21 23];
%crm_num=[10 11 13 17 19 22 24 25 26 27 28];
%messy_num=[gcm_num crm_num];

% Plot of Omega_d vs P/sigma
% maybe final figure?
figure
scatter(Table295K.Precip(gcm_num)./CircSF295.sig_mn,CircSF295.omega_db,[],colGCM,'filled','o','LineWidth',2,'SizeData',70)
hold on
scatter(Table295K.Precip(crm_num)./Circ_omega_CRMs_295.sig_mn,-Circ_omega_CRMs_295.omega_db,[],colCRM,'filled','h','LineWidth',2,'SizeData',120)
scatter(Table300K.Precip(gcm_num)./CircSF300.sig_mn,CircSF300.omega_db,[],colGCM,'filled','o','LineWidth',2,'SizeData',120)
scatter(Table300K.Precip(crm_num)./Circ_omega_CRMs_300.sig_mn,-Circ_omega_CRMs_300.omega_db,[],colCRM,'filled','h','LineWidth',2,'SizeData',150)
scatter(Table305K.Precip(gcm_num)./CircSF305.sig_mn,CircSF305.omega_db,[],colGCM,'filled','o','LineWidth',2,'SizeData',150)
scatter(Table305K.Precip(crm_num)./Circ_omega_CRMs_305.sig_mn,-Circ_omega_CRMs_305.omega_db,[],colCRM,'filled','h','LineWidth',2,'SizeData',200)
ylabel('\omega_d (hPa/d)')
xlabel('P/\sigma ')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)

figure
subplot(1,2,1)
%scatter(Table295K.Precip(gcm_num),CircSF295.omega_db,[],colGCM,'filled','o','LineWidth',2,'SizeData',70)
%scatter(Table295K.Precip(gcm_num),CircSF295.omega_db-CircSF300.omega_db,[],colGCM,'filled','o','LineWidth',2,'SizeData',70)
scatter(Table295K.Precip(gcm_num)-Table300K.Precip(gcm_num),CircSF295.omega_db-CircSF300.omega_db,[],colGCM,'filled','o','LineWidth',2,'SizeData',70)
hold on
%scatter(Table295K.Precip(crm_num),-Circ_omega_CRMs_295.omega_db,[],colCRM,'filled','h','LineWidth',2,'SizeData',120)
scatter(Table295K.Precip(crm_num)-Table300K.Precip(crm_num),-Circ_omega_CRMs_295.omega_db+Circ_omega_CRMs_300.omega_db,[],colCRM,'filled','h','LineWidth',2,'SizeData',120)
%scatter(Table300K.Precip(gcm_num),CircSF300.omega_db,[],colGCM,'filled','o','LineWidth',2,'SizeData',120)
scatter(Table300K.Precip(gcm_num)-Table300K.Precip(gcm_num),CircSF300.omega_db-CircSF300.omega_db,[],colGCM,'filled','o','LineWidth',2,'SizeData',120)
%scatter(Table300K.Precip(crm_num),-Circ_omega_CRMs_300.omega_db,[],colCRM,'filled','h','LineWidth',2,'SizeData',150)
scatter(Table300K.Precip(crm_num)-Table300K.Precip(crm_num),-Circ_omega_CRMs_300.omega_db+Circ_omega_CRMs_300.omega_db,[],colCRM,'filled','h','LineWidth',2,'SizeData',150)
%scatter(Table305K.Precip(gcm_num),CircSF305.omega_db,[],colGCM,'filled','o','LineWidth',2,'SizeData',150)
scatter(Table305K.Precip(gcm_num)-Table300K.Precip(gcm_num),CircSF305.omega_db-CircSF300.omega_db,[],colGCM,'filled','o','LineWidth',2,'SizeData',150)
%scatter(Table305K.Precip(crm_num),-Circ_omega_CRMs_305.omega_db,[],colCRM,'filled','h','LineWidth',2,'SizeData',200)
scatter(Table305K.Precip(crm_num)-Table300K.Precip(crm_num),-Circ_omega_CRMs_305.omega_db+Circ_omega_CRMs_300.omega_db,[],colCRM,'filled','h','LineWidth',2,'SizeData',200)
scatter(Table305K.Precip(crm_num)-Table300K.Precip(crm_num),-Circ_omega_CRMs_305.omega_db+Circ_omega_CRMs_300.omega_db,[],colCRM,'filled','h','LineWidth',2,'SizeData',200)
ylabel('\omega_d (hPa/d)')
xlabel('P (mm/d)')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)
subplot(1,2,2)
scatter(CircSF295.sig_mn,CircSF295.omega_db,[],colGCM,'filled','o','LineWidth',2,'SizeData',70)
hold on
scatter(Circ_omega_CRMs_295.sig_mn,-Circ_omega_CRMs_295.omega_db,[],colCRM,'filled','h','LineWidth',2,'SizeData',120)
scatter(CircSF300.sig_mn,CircSF300.omega_db,[],colGCM,'filled','o','LineWidth',2,'SizeData',120)
scatter(Circ_omega_CRMs_300.sig_mn,-Circ_omega_CRMs_300.omega_db,[],colCRM,'filled','h','LineWidth',2,'SizeData',150)
scatter(CircSF305.sig_mn,CircSF305.omega_db,[],colGCM,'filled','o','LineWidth',2,'SizeData',150)
scatter(Circ_omega_CRMs_305.sig_mn,-Circ_omega_CRMs_305.omega_db,[],colCRM,'filled','h','LineWidth',2,'SizeData',200)
ylabel('\omega_d (hPa/d)')
xlabel('\sigma ')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)

%-------------------------------------------------------------------
% test omega_db
% deterimine what is driving the spread of omega_db: Qmn or sig_mn?

% compare omeag_db computed with tabluted values of Qmn and sig_mn... why the difference?
omega_db_test_295=Circ_omega_CRMs_295.Qmn./Circ_omega_CRMs_295.sig_mn
omega_db_test_300=Circ_omega_CRMs_300.Qmn./Circ_omega_CRMs_300.sig_mn
omega_db_test_305=Circ_omega_CRMs_305.Qmn./Circ_omega_CRMs_305.sig_mn

figure
scatter(abs(CircSF295.omega_db),CircSF295.I,[],colGCM,'filled','o','SizeData',70)
hold on
scatter(abs(CircSF305.omega_db),CircSF305.I,[],colGCM,'filled','o','SizeData',170)
scatter(abs(CircSF300.omega_db),CircSF300.I,[],colGCM,'filled','o','SizeData',120)
%scatter(abs(omega_db_test_295),Circ_omega_CRMs_295.I,[],colCRM,'filled','v','SizeData',70)
%scatter(abs(omega_db_test_295),Circ_omega_CRMs_295.I,[],colCRM,'filled','^','SizeData',70)
%scatter(abs(omega_db_test_300),Circ_omega_CRMs_300.I,[],colCRM,'filled','v','SizeData',120)
%scatter(abs(omega_db_test_300),Circ_omega_CRMs_300.I,[],colCRM,'filled','^','SizeData',120)
%scatter(abs(omega_db_test_305),Circ_omega_CRMs_305.I,[],colCRM,'filled','v','SizeData',170)
%scatter(abs(omega_db_test_305),Circ_omega_CRMs_305.I,[],colCRM,'filled','^','SizeData',170)
scatter(abs(Circ_omega_CRMs_295.omega_db),Circ_omega_CRMs_295.I,[],colCRM,'filled','h','SizeData',70)
scatter(abs(Circ_omega_CRMs_300.omega_db),Circ_omega_CRMs_300.I,[],colCRM,'filled','h','SizeData',120)
scatter(abs(Circ_omega_CRMs_305.omega_db),Circ_omega_CRMs_305.I,[],colCRM,'filled','h','SizeData',170)
ylabel('Circulation Intensity, I (hPa/d)')
xlabel('diabatic velocity (hPa/d)')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)
ylim([25 150])
xlim([15 60])
sgtitle('Overturning Circulation at 500 hPa','FontSize',16,'FontWeight','bold')

% plot the subsidence fraction vs the mean upward velocity
figure
scatter(abs(CircSF295.omega_up),CircSF295.SF,[],colGCM,'filled','o','SizeData',70)
hold on
scatter(abs(CircSF305.omega_up),CircSF305.SF,[],colGCM,'filled','o','SizeData',170)
scatter(abs(CircSF300.omega_up),CircSF300.SF,[],colGCM,'filled','o','SizeData',120)
scatter(abs(Circ_omega_CRMs_295.omega_up),Circ_omega_CRMs_295.SF,[],colCRM,'filled','h','SizeData',140)
scatter(abs(Circ_omega_CRMs_300.omega_up),Circ_omega_CRMs_300.SF,[],colCRM,'filled','h','SizeData',190)
scatter(abs(Circ_omega_CRMs_305.omega_up),Circ_omega_CRMs_305.SF,[],colCRM,'filled','h','SizeData',240)
ylabel('Subsidence Fraction')
xlabel('\omega^\uparrow (hPa/d)')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)
sgtitle('Overturning Circulation at 500 hPa','FontSize',16,'FontWeight','bold')

%-------------------------------------------------------------------

% diabatic omega vs SST
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
%------------------------------------------------------------------------------
% Scatter plots of I vs omega's for each SST...  probably redundant
%------------------------------------------------------------------------------

figure
subplot(3,3,1)
scatter(abs(CircSF295.omega_up),CircSF295.I,[],colGCM,'filled','o','SizeData',120);
hold on
scatter(abs(Circ_omega_CRMs_295.omega_up),Circ_omega_CRMs_295.I,[],colCRM,'filled','v','SizeData',120);
scatter(abs(Circ_omega_CRMs_295.omega_up),Circ_omega_CRMs_295.I,[],colCRM,'filled','^','SizeData',120);
xlabel('omega up (295K)')
ylabel('Circulation Intensity (hPa/d)')
ylim([20 150])
subplot(3,3,2)
scatter(abs(CircSF300.omega_up),CircSF300.I,[],colGCM,'filled','o','SizeData',120);
hold on
scatter(abs(Circ_omega_CRMs_300.omega_up),Circ_omega_CRMs_300.I,[],colCRM,'filled','v','SizeData',120);
scatter(abs(Circ_omega_CRMs_300.omega_up),Circ_omega_CRMs_300.I,[],colCRM,'filled','^','SizeData',120);
xlabel('omega up (300K)')
ylim([20 150])
subplot(3,3,3)
scatter(abs(CircSF305.omega_up),CircSF305.I,[],colGCM,'filled','o','SizeData',120);
hold on
scatter(abs(Circ_omega_CRMs_305.omega_up),Circ_omega_CRMs_305.I,[],colCRM,'filled','v','SizeData',120);
scatter(abs(Circ_omega_CRMs_305.omega_up),Circ_omega_CRMs_305.I,[],colCRM,'filled','^','SizeData',120);
xlabel('omega up (305K)')
ylim([20 150])
% second row
subplot(3,3,4)
scatter(abs(CircSF295.omega_dn),CircSF295.I,[],colGCM,'filled','o','SizeData',120);
hold on
scatter(abs(Circ_omega_CRMs_295.omega_dn),Circ_omega_CRMs_295.I,[],colCRM,'filled','v','SizeData',120);
scatter(abs(Circ_omega_CRMs_295.omega_dn),Circ_omega_CRMs_295.I,[],colCRM,'filled','^','SizeData',120);
xlabel('omega down (295K)')
ylabel('Circulation Intensity (hPa/d)')
ylim([20 150])
subplot(3,3,5)
scatter(abs(CircSF300.omega_dn),CircSF300.I,[],colGCM,'filled','o','SizeData',120);
hold on
scatter(abs(Circ_omega_CRMs_300.omega_dn),Circ_omega_CRMs_300.I,[],colCRM,'filled','v','SizeData',120);
scatter(abs(Circ_omega_CRMs_300.omega_dn),Circ_omega_CRMs_300.I,[],colCRM,'filled','^','SizeData',120);
xlabel('omega down (300K)')
ylim([20 150])
subplot(3,3,6)
scatter(abs(CircSF305.omega_dn),CircSF305.I,[],colGCM,'filled','o','SizeData',120);
hold on
scatter(abs(Circ_omega_CRMs_305.omega_dn),Circ_omega_CRMs_305.I,[],colCRM,'filled','v','SizeData',120);
scatter(abs(Circ_omega_CRMs_305.omega_dn),Circ_omega_CRMs_305.I,[],colCRM,'filled','^','SizeData',120);
xlabel('omega down (305K)')
ylim([20 150])
% third row
subplot(3,3,7)
scatter(abs(CircSF295.omega_db),CircSF295.I,[],colGCM,'filled','o','SizeData',120);
hold on
scatter(abs(Circ_omega_CRMs_295.omega_db),Circ_omega_CRMs_295.I,[],colCRM,'filled','v','SizeData',120);
scatter(abs(Circ_omega_CRMs_295.omega_db),Circ_omega_CRMs_295.I,[],colCRM,'filled','^','SizeData',120);
xlabel('omega diab (295K)')
ylabel('Circulation Intensity (hPa/d)')
ylim([20 150])
subplot(3,3,8)
scatter(abs(CircSF300.omega_db),CircSF300.I,[],colGCM,'filled','o','SizeData',120);
hold on
scatter(abs(Circ_omega_CRMs_300.omega_db),Circ_omega_CRMs_300.I,[],colCRM,'filled','v','SizeData',120);
scatter(abs(Circ_omega_CRMs_300.omega_db),Circ_omega_CRMs_300.I,[],colCRM,'filled','^','SizeData',120);
xlabel('omega diab (300K)')
ylim([20 150])
subplot(3,3,9)
scatter(abs(CircSF305.omega_db),CircSF305.I,[],colGCM,'filled','o','SizeData',120);
hold on
scatter(abs(Circ_omega_CRMs_305.omega_db),Circ_omega_CRMs_305.I,[],colCRM,'filled','v','SizeData',120);
scatter(abs(Circ_omega_CRMs_305.omega_db),Circ_omega_CRMs_305.I,[],colCRM,'filled','^','SizeData',120);
ylim([20 150])
xlabel('omega diab (305K)')

%
%------------------------------------------------------------------------------
% Regression and slopes vs. SST
%------------------------------------------------------------------------------
% this 4 panel figure is a bit redundant with the figure above and is mostly just for consistency checks with myself.
figure
subplot(2,2,1)
scatter(sst_10a,CircSF295.I,[],colGCM,'filled','o','SizeData',70);
hold on
scatter(sst_5a,Circ_omega_CRMs_295.I,[],colCRM,'filled','^','SizeData',70);
scatter(sst_5a,Circ_omega_CRMs_295.I,[],colCRM,'filled','v','SizeData',70);
scatter(sst_10b,CircSF300.I,[],colGCM,'filled','o','SizeData',120);
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
line([sst_5a(1),sst_5b(1),sst_5c(1)],[Circ_omega_CRMs_295.I(6),Circ_omega_CRMs_300.I(6),Circ_omega_CRMs_305.I(6)],'Color',colCRM(6,:),'LineWidth',2)
line([sst_5a(1),sst_5b(1),sst_5c(1)],[Circ_omega_CRMs_295.I(7),Circ_omega_CRMs_300.I(7),Circ_omega_CRMs_305.I(7)],'Color',colCRM(7,:),'LineWidth',2)
line([sst_5a(1),sst_5b(1),sst_5c(1)],[Circ_omega_CRMs_295.I(8),Circ_omega_CRMs_300.I(8),Circ_omega_CRMs_305.I(8)],'Color',colCRM(8,:),'LineWidth',2)
line([sst_5a(1),sst_5b(1),sst_5c(1)],[Circ_omega_CRMs_295.I(9),Circ_omega_CRMs_300.I(9),Circ_omega_CRMs_305.I(9)],'Color',colCRM(9,:),'LineWidth',2)
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
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)
ylim([0 150])

subplot(2,2,2)
scatter(sst_10a,abs(CircSF295.omega_up),[],colGCM,'filled','o','SizeData',70);
hold on
scatter(sst_5a,Circ_omega_CRMs_295.omega_up,[],colCRM,'filled','^','SizeData',70);
scatter(sst_5a,Circ_omega_CRMs_295.omega_up,[],colCRM,'filled','v','SizeData',70);
scatter(sst_10b,abs(CircSF300.omega_up),[],colGCM,'filled','o','SizeData',120);
scatter(sst_5b,Circ_omega_CRMs_300.omega_up,[],colCRM,'filled','^','SizeData',120);
scatter(sst_5b,Circ_omega_CRMs_300.omega_up,[],colCRM,'filled','v','SizeData',120);
scatter(sst_10c,abs(CircSF305.omega_up),[],colGCM,'filled','o','SizeData',170);
scatter(sst_5c,Circ_omega_CRMs_305.omega_up,[],colCRM,'filled','^','SizeData',170);
scatter(sst_5c,Circ_omega_CRMs_305.omega_up,[],colCRM,'filled','v','SizeData',170);
ylabel('omega up, (hPa/d)')
xlabel('surface temperature (K)')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)
xlim([294 306])

subplot(2,2,3)
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
ylabel('omega down, (hPa/d)')
xlabel('surface temperature (K)')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)
xlim([294 306])

subplot(2,2,4)
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
ylabel('diabatic omega, (hPa/d)')
xlabel('surface temperature (K)')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)
xlim([294 306])

% calculated the best fit slope to the three point lines: 
% use the matlab function polyfit to fit a first order polynomial to the three points
% that represent the 295, 300, and 305K experiments.  

% for GCMs:
xx=[sst_10a(1),sst_10b(1),sst_10c(1)];
y_I        =[abs(CircSF295.I),abs(CircSF300.I),abs(CircSF305.I)];
y_omega_up =[abs(CircSF295.omega_up),abs(CircSF300.omega_up),abs(CircSF305.omega_up)];
y_mn_omega_up = mean(y_omega_up,2);
y_mn_I     = mean(y_I,2);
y_omega_dn =[abs(CircSF295.omega_dn),abs(CircSF300.omega_dn),abs(CircSF305.omega_dn)];
y_omega_db =[abs(CircSF295.omega_db),abs(CircSF300.omega_db),abs(CircSF305.omega_db)];
%clear tempcoeff, coeff_gcm;
for ind=1:10;
  tempcoeff_I  =polyfit(xx,y_I(ind,:),1);
  tempcoeff_up =polyfit(xx,y_omega_up(ind,:),1);
  tempcoeff_dn =polyfit(xx,y_omega_dn(ind,:),1);
  tempcoeff_db =polyfit(xx,y_omega_db(ind,:),1);
  coeff_gcm_I(ind)  =tempcoeff_I(1);  % slope in (hPa/d)/K
  coeff_gcm_up(ind) =tempcoeff_up(1); % slope in (hPa/d)/K
  coeff_gcm_dn(ind) =tempcoeff_dn(1); % slope in (hPa/d)/K
  coeff_gcm_db(ind) =tempcoeff_db(1); % slope in (hPa/d)/K
end

% for CRMs:
y_CRM_I        =[abs(Circ_omega_CRMs_295.I),abs(Circ_omega_CRMs_300.I),abs(Circ_omega_CRMs_305.I)];
y_CRM_omega_up =[abs(Circ_omega_CRMs_295.omega_up),abs(Circ_omega_CRMs_300.omega_up),abs(Circ_omega_CRMs_305.omega_up)];
y_mn_CRM_omega_up = mean(y_CRM_omega_up,2);
y_mn_CRM_I     = mean(y_CRM_I,2);
y_CRM_omega_dn =[abs(Circ_omega_CRMs_295.omega_dn),abs(Circ_omega_CRMs_300.omega_dn),abs(Circ_omega_CRMs_305.omega_dn)];
y_CRM_omega_db =[abs(Circ_omega_CRMs_295.omega_db),abs(Circ_omega_CRMs_300.omega_db),abs(Circ_omega_CRMs_305.omega_db)];
%clear tempcoeff, coeff_gcm;
for ind=1:11;
  tempcoeff_I  =polyfit(xx,y_CRM_I(ind,:),1);
  tempcoeff_up =polyfit(xx,y_CRM_omega_up(ind,:),1);
  tempcoeff_dn =polyfit(xx,y_CRM_omega_dn(ind,:),1);
  tempcoeff_db =polyfit(xx,y_CRM_omega_db(ind,:),1);
  coeff_CRM_I(ind)  =tempcoeff_I(1);  % slope in (hPa/d)/K
  coeff_CRM_up(ind) =tempcoeff_up(1); % slope in (hPa/d)/K
  coeff_CRM_dn(ind) =tempcoeff_dn(1); % slope in (hPa/d)/K
  coeff_CRM_db(ind) =tempcoeff_db(1); % slope in (hPa/d)/K
end
slope_I        =[coeff_gcm_I coeff_CRM_I];
model_mn_I     =[y_mn_I' y_mn_CRM_I'];   % model_mn_I contains the mean I for each individual model.
slope_omega_up =[coeff_gcm_up coeff_CRM_up];
mn_omega_up    =[y_mn_omega_up' y_mn_CRM_omega_up'];
slope_omega_dn =[coeff_gcm_dn coeff_CRM_dn];
slope_omega_db =[coeff_gcm_db coeff_CRM_db];

coltemp=[colGCM' colCRM'];
%coltest=[colGCM' colortest'];
colGCMCRM=coltemp';
%colGCMCRM=coltest';

% calculate the fractional change of I using the mean from each individual model
frac_I=slope_I./model_mn_I;

% make scatter plots of the slope values...
%------------------------------------------
% Near Final Figure
% Probable Publication Figure
%------------------------------------------
figure1=figure
subplot(1,3,2)
scatter(slope_omega_dn(1:10),slope_I(1:10),[],colGCMCRM(1:10,:),'filled','o','SizeData',170);
hold on
scatter(slope_omega_dn(11:21),slope_I(11:21),[],colGCMCRM(11:21,:),'filled','h','SizeData',250);
%xlabel('$D \omega^\downarrow/D T_s$','interpreter','latex','FontSize',14,'FontWeight','bold')
%ylabel('$D I/D T_s$','interpreter','latex','FontSize',14,'FontWeight','bold')
xlabel('$\Delta \omega^\downarrow/\Delta T_s$','interpreter','latex','FontSize',14,'FontWeight','bold')
ylabel('$\Delta I/\Delta T_s$','interpreter','latex','FontSize',14,'FontWeight','bold')
ylim([-8 7])
xlim([-3 0])
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)
subplot(1,3,3)
scatter(slope_omega_db(1:10),slope_I(1:10),[],colGCMCRM(1:10,:),'filled','o','SizeData',170);
hold on
scatter(slope_omega_db(11:21),slope_I(11:21),[],colGCMCRM(11:21,:),'filled','h','SizeData',250);
%xlabel('$D(\omega_{d})/D(T_s)$','interpreter','latex')
%ylabel('$D(I)/D(T_s)$','interpreter','latex')
xlabel('$\Delta \omega_{d}/\Delta T_s$','interpreter','latex')
ylabel('$\Delta I/\Delta T_s$','interpreter','latex')
set(gca,'FontWeight','bold')
ylim([-8 7])
xlim([-2.5 0])
set(gca,'FontSize',14)
subplot(1,3,1)
scatter(slope_omega_up(1:10),slope_I(1:10),[],colGCMCRM(1:10,:),'filled','o','SizeData',170);
hold on
scatter(slope_omega_up(11:21),slope_I(11:21),[],colGCMCRM(11:21,:),'filled','h','SizeData',250);
%xlabel('$D(\omega^\uparrow)/D(T_s)$','interpreter','latex')
%ylabel('$D(I)/D(T_s)$','interpreter','latex')
xlabel('$\Delta \omega^\uparrow/\Delta T_s$','interpreter','latex')
ylabel('$\Delta I/\Delta T_s$','interpreter','latex')
xlim([-7 7])
ylim([-8 7])
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)

ypos=0.81;
xpos=0.13
annotation(figure1,'textbox',...
    [xpos ypos 0.0234171725932352 0.0761513353115727],...
    'String','(a)',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',16,...
    'FitBoxToText','off');
annotation(figure1,'textbox',...
    [xpos+0.29 ypos 0.0234171725932352 0.0761513353115727],...
    'String','(b)',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',16,...
    'FitBoxToText','off');
annotation(figure1,'textbox',...
    [xpos+0.29+0.29 ypos 0.0234171725932353 0.0761513353115727],...
    'String','(c)',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',16,...
    'FitBoxToText','off');



% plot scatter plot of the slope of I vs the slope of WV cycle
%------------------------------------------
% Near Final Probable Publication Figure
%------------------------------------------
figure
scatter(slope_cycle(1:10),slope_I(1:10),[],colGCMCRM(1:10,:),'filled','o','SizeData',170);
hold on
%scatter(slope_cycle(11:21),slope_I(11:21),[],colGCMCRM(11:21,:),'filled','v','SizeData',170);
scatter(slope_cycle(11:21),slope_I(11:21),[],colGCMCRM(11:21,:),'filled','h','SizeData',280);
xlabel('\Delta (WV cycle)/\Delta (SST)')
ylabel('\Delta(I)/\Delta(SST)')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)

figure
scatter(frac_cycle(1:10),frac_I(1:10),[],colGCMCRM(1:10,:),'filled','o','SizeData',170);
hold on
scatter(frac_cycle(11:21),frac_I(11:21),[],colGCMCRM(11:21,:),'filled','h','SizeData',280);
xlabel('(\Delta C_{wv})/C_{wv}')
ylabel('(\Delta I)/I')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)
xlim([-0.1 0.05])
ylim([-0.15 0.1])





% 3 panel figure showing scatter plots of the slopes of up vs dn, db vs dn, and 
% db vs up
figure
subplot(1,3,1)
scatter(slope_omega_up,slope_omega_dn,[],colGCMCRM,'filled','o','SizeData',120);
xlabel('D(omega up)/D(SST)')
ylabel('D(omega dn)/D(SST)')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)
subplot(1,3,2)
scatter(slope_omega_db,slope_omega_dn,[],colGCMCRM,'filled','o','SizeData',120);
xlabel('D(omega diabatic)/D(SST)')
ylabel('D(omega dn)/D(SST)')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)
subplot(1,3,3)
scatter(slope_omega_db,slope_omega_up,[],colGCMCRM,'filled','o','SizeData',120);
xlabel('D(omega diabatic)/D(SST)')
ylabel('D(omega up)/D(SST)')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)

% Create textbox
annotation(figure1,'textbox',...
    [0.306157849089332 0.780415430267062 0.0234171725932352 0.0761513353115727],...
    'String','(a)',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',16,...
    'FitBoxToText','off');

% Create textbox
annotation(figure1,'textbox',...
    [0.594102341717259 0.792284866468843 0.0234171725932352 0.0761513353115727],...
    'String','(b)',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',16,...
    'FitBoxToText','off');

% Create textbox
annotation(figure1,'textbox',...
    [0.872506504770163 0.786350148367954 0.0234171725932353 0.0761513353115727],...
    'String','(c)',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',16,...
    'FitBoxToText','off');

%------------------------------------------------------------------------------
%------------------------------------------------------------------------------
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

modelnumber=linspace(1,21,21);
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
xlim([1 21])
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
% plots of precipitation and precipitable water.  
% moonshine

% create a figure that plots precipitable water
sst_full_295=zeros(34,1)+295;
sst_full_300=zeros(34,1)+300;
sst_full_305=zeros(34,1)+305;

%Cycle1=Table295K.Precip./Table295K.PW
%Cycle2=Table300K.Precip./Table300K.PW
%Cycle3=Table305K.Precip./Table305K.PW

%specnum=[1 2 4 6 8 9 10 11 12 16 17 19 20 21 22 23];

% plots with colors from Wing et al., 2020
figure
scatter(sst_full_295,Table295K.PW,[],col34,'filled','o','SizeData',70);
hold on
scatter(sst_full_300,Table300K.PW,[],col34,'filled','o','SizeData',70);
scatter(sst_full_305,Table305K.PW,[],col34,'filled','o','SizeData',70);
xlabel('SST (K)')
ylabel('Precipitable Water')
xlim([294 306])

%maxLH=max(Table295K.LHF)
%meanLH=mean(Table295K.LHF)
%diff=maxLH-value


figure
subplot(1,2,1)
scatter(Table295K.LHF-Table295K.LHF,Table295K.PW,[],col34,'filled','o','SizeData',60)
hold on
scatter(Table300K.LHF-Table295K.LHF,Table300K.PW,[],col34,'filled','o','SizeData',140)
scatter(Table305K.LHF-Table295K.LHF,Table305K.PW,[],col34,'filled','o','SizeData',200)
xlabel('Latent Heat Flux (W/m2)')
ylabel('Precipitable Water')
subplot(1,2,2)
scatter(Table295K.LHF,Table295K.Precip,[],col34,'filled','o','SizeData',60)
hold on
scatter(Table300K.LHF,Table300K.Precip,[],col34,'filled','o','SizeData',140)
scatter(Table305K.LHF,Table305K.Precip,[],col34,'filled','o','SizeData',200)
xlabel('Latent Heat Flux (W/m2)')
ylabel('Precipitation')

figure
subplot(2,2,2)
scatter(Table295K.LHF+Table295K.SHF,Table295K.PW,[],col34,'filled','o','SizeData',60)
hold on
scatter(Table300K.LHF+Table300K.SHF,Table300K.PW,[],col34,'filled','o','SizeData',140)
scatter(Table305K.LHF+Table305K.SHF,Table305K.PW,[],col34,'filled','o','SizeData',200)
xlabel('Latent Heat Flux (W/m2)')
ylabel('Precipitable Water')
subplot(2,2,1)
scatter(Table295K.SHF./Table295K.LHF,Table295K.PW,[],col34,'filled','o','SizeData',60)
hold on
scatter(Table300K.SHF./Table300K.LHF,Table300K.PW,[],col34,'filled','o','SizeData',140)
scatter(Table305K.SHF./Table305K.LHF,Table305K.PW,[],col34,'filled','o','SizeData',200)
xlabel('Bowen ratio')
ylabel('PW')
subplot(2,2,3)
scatter(Table295K.SHF./Table295K.LHF,Table295K.Precip,[],col34,'filled','o','SizeData',60)
hold on
scatter(Table300K.SHF./Table300K.LHF,Table300K.Precip,[],col34,'filled','o','SizeData',140)
scatter(Table305K.SHF./Table305K.LHF,Table305K.Precip,[],col34,'filled','o','SizeData',200)
xlabel('Bowen ratio')
ylabel('Precipitation')
subplot(2,2,4)
scatter(Table295K.LHF,Table295K.Precip,[],col34,'filled','o','SizeData',60)
hold on
scatter(Table300K.LHF,Table300K.Precip,[],col34,'filled','o','SizeData',140)
scatter(Table305K.LHF,Table305K.Precip,[],col34,'filled','o','SizeData',200)
xlabel('Latent Heat Flux (W/m2)')
ylabel('Precipitation')

%--------------------------------------------------------------------------
% near Final Figure
%--------------------------------------------------------------------------

% plots precipitation vs bowen ratio in one panel and the
% precipitable water vs the latent heat flux in the other.
figure7=figure
subplot(1,2,2)
scatter(Table300K.SHF./Table300K.LHF,Table300K.Precip,[],col34,'filled','o','SizeData',140)
xlabel('\bf{Bowen ratio}','interpreter','latex')
ylabel('\bf{Precipitation} ($\bf{\rm{mm \, day}}^{-1}$)','interpreter','latex')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)
subplot(1,2,1)
scatter(Table300K.LHF,Table300K.PW,[],col34,'filled','o','SizeData',140)
xlabel('\bf{Latent Heat Flux} ($\rm{W \, m}^{-2}$)','interpreter','latex')
ylabel('\bf{Precipitable Water} ($\rm{kg \, m}^{-2}$)','interpreter','latex')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)
ypos=0.81;
xpos=0.13
% Create textbox
annotation(figure7,'textbox',...
    [xpos ypos 0.0234171725932352 0.0761513353115727],...
    'String','(a)',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',16,...
    'FitBoxToText','off');
annotation(figure7,'textbox',...
    [xpos+0.49 ypos 0.0234171725932352 0.0761513353115727],...
    'String','(b)',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',16,...
    'FitBoxToText','off');


% plots latent heat flux precipitable water in one panel
% and the latent heat flux and precipitation in the other panel.
figure
subplot(1,2,1)
scatter(Table295K.LHF,Table295K.PW,[],col34,'filled','o','SizeData',60)
hold on
scatter(Table300K.LHF,Table300K.PW,[],col34,'filled','o','SizeData',140)
scatter(Table305K.LHF,Table305K.PW,[],col34,'filled','o','SizeData',200)
xlabel('Latent Heat Flux (W/m2)')
ylabel('Precipitable Water')
subplot(1,2,2)
scatter(Table295K.LHF,Table295K.Precip,[],col34,'filled','o','SizeData',60)
hold on
scatter(Table300K.LHF,Table300K.Precip,[],col34,'filled','o','SizeData',140)
scatter(Table305K.LHF,Table305K.Precip,[],col34,'filled','o','SizeData',200)
xlabel('Latent Heat Flux (W/m2)')
ylabel('Precipitation')


% plots precipitation vs precipitable water. 
figure
scatter(Table295K.PW,Table295K.Precip,[],col34,'filled','o','SizeData',60);
hold on
scatter(Table300K.PW,Table300K.Precip,[],col34,'filled','o','SizeData',140);
scatter(Table305K.PW,Table305K.Precip,[],col34,'filled','o','SizeData',200);
ylabel('Precip ')
xlabel('Precipitable Water')

% Fractional ch of Precipitation vs. Fractional ch of PW
DelPrecip1=(Table300K.Precip-Table295K.Precip)./(5.*Table295K.Precip);
DelPrecip2=(Table305K.Precip-Table300K.Precip)./(5.*Table300K.Precip);
DelPrecipT=(Table305K.Precip-Table295K.Precip)./(10.*Table295K.Precip);
DelPW1=(Table300K.PW-Table295K.PW)./(5.*Table295K.PW);
DeldPW1=log(1+DelPW1*5.)/5.;
DelPW2=(Table305K.PW-Table300K.PW)./(5.*Table300K.PW);
DeldPW2=log(1+DelPW2*5.)/5.;
DelPWT=(Table305K.PW-Table295K.PW)./(10.*Table295K.PW);
DeldPWT=log(1+DelPWT*10.)/10.; %(Table305K.PW-Table295K.PW)./(10.*Table295K.PW);

%figure
%subplot(1,2,1)
%scatter(DelPrecip1,DelPW1,[],col34,'filled','o','SizeData',120);
%hold on
%scatter(DelPrecip2,DelPW2,[],col34,'filled','o','SizeData',170);
%xlabel('Del Precip %/K ')
%ylabel('Del PW')
%set(gca,'FontWeight','bold')
%set(gca,'FontSize',14)
%
%%figure
%subplot(1,2,2)
%scatter(sst_full_295(specnum),Cycle1(specnum),[],col34(specnum,:),'filled','o','SizeData',170)
%hold on
%scatter(sst_full_300(specnum),Cycle2(specnum),[],col34(specnum,:),'filled','o','SizeData',170)
%scatter(sst_full_305(specnum),Cycle3(specnum),[],col34(specnum,:),'filled','o','SizeData',170)
%xlabel('SST (K)')
%ylabel('Water vapor cycling rate (day^-1)')
%xlim([294 306])
%set(gca,'FontWeight','bold')
%set(gca,'FontSize',14)
%

% plots with colors from Wing et al., 2020

%--------------------------------------------------------------------
% test comparison to Clausius Clapeyron scaling...
% see Stephens et al., 1990
%--------------------------------------------------------------------

tsfc=linspace(290,310,20)
p1=0.1 % p1= r/(1+lambda) where r is the sfc RH and H/lambda is a scale height 
% of water vapor.  if the scale height of water vapor is 7km then 
% lambda is about 3.5 km as in Stephens 1990
p2=0.064; % 1/Kelvin 
% equation for precipitable water assuming CC scaling
pwater=108.2.*(p1).*exp(p2.*(tsfc-288.));
p1b=0.2 
pwater_b=108.2.*(p1b).*exp(p2.*(tsfc-288.));
p1c=0.15
pwater_c=108.2.*(p1c).*exp(p2.*(tsfc-288.));

p1_m5=(Table295K.PW(5)/108.2)*exp(p2.*(288-295.))
% calculate all the coefficients for 295K
pcoef=(Table295K.PW/108.2)*exp(p2.*(288-295.));
pwater_m5=108.2.*(p1_m5).*exp(p2.*(tsfc-288.));
pwater_cc_295=108.2.*(pcoef).*exp(p2.*(295-288.));
pwater_cc_300=108.2.*(pcoef).*exp(p2.*(300-288.));
pwater_cc_305=108.2.*(pcoef).*exp(p2.*(305-288.));

lambda_295=108.2.*(0.72./Table295K.PW).*exp(p2.*(295.-288))-1.;
% mean for 295 =4.8
lambda_300=108.2.*(0.82./Table300K.PW).*exp(p2.*(300.-288))-1.;
% mean for 300 =4.9
lambda_305=108.2.*(0.79./Table305K.PW).*exp(p2.*(305.-288))-1.;
% mean for 305 =4.0

PW_CC_295=108.2.*(0.72./(1+mean(lambda_295))).*exp(p2.*(295.-288));
PW_CC_300=108.2.*(0.82./(1+mean(lambda_300))).*exp(p2.*(300.-288));
PW_CC_305=108.2.*(0.79./(1+mean(lambda_305))).*exp(p2.*(305.-288));

% plot anomalous PW
figure 
hold on
scatter(sst_full_295,Table295K.PW-pwater_cc_295,[],col34,'filled','o','SizeData',70);
scatter(sst_full_300,Table300K.PW-pwater_cc_300,[],col34,'filled','o','SizeData',120);
scatter(sst_full_305,Table305K.PW-pwater_cc_305,[],col34,'filled','o','SizeData',150);
xlim([294 306])
xlabel('SST K ')
ylabel('PW (kg/m2)')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)

% subtract off the PW predicted by CC scaling for each SST and each model
CC_depart_300K=Table300K.PW(mnum)-PW_CC_300
CC_depart_305K=Table305K.PW(mnum)-PW_CC_305;
CC_depart_295K=Table295K.PW(mnum)-PW_CC_295;


figure 
scatter(sst_full_295(mnum),Table295K.PW(mnum)-PW_CC_295,[],col34(mnum,:),'filled','o','SizeData',70);
hold on
scatter(sst_full_300(mnum),Table300K.PW(mnum)-PW_CC_300,[],col34(mnum,:),'filled','o','SizeData',120);
scatter(sst_full_305(mnum),Table305K.PW(mnum)-PW_CC_305,[],col34(mnum,:),'filled','o','SizeData',150);
xlim([294 306])
%ylim([0 100])
xlabel('SST K ')
ylabel('PW (kg/m2)')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)

%-----------------------------------------------------------------------------------------------
% near Final figure 
%-----------------------------------------------------------------------------------------------
% Plot Precipitable Water (PW) vs SST with Stephens CC scaling
% Plot Del Precip vs Del PW
% Plot Water vapor cycling rate
figure1=figure 
subplot(1,3,1)
plot(tsfc,pwater,'k')
hold on
plot(tsfc,pwater_b,'k')
plot(tsfc,pwater_c,'k')
scatter(sst_full_295(modelnum(mnum_gcm)),Table295K.PW(modelnum(mnum_gcm)),[],col34(gcm_num,:),'filled','o','SizeData',70);
scatter(sst_full_295(modelnum(mnum_crm)),Table295K.PW(modelnum(mnum_crm)),[],col34(crm_num,:),'filled','h','SizeData',100);
scatter(sst_full_300(modelnum(mnum_gcm)),Table300K.PW(modelnum(mnum_gcm)),[],col34(gcm_num,:),'filled','o','SizeData',120);
scatter(sst_full_300(modelnum(mnum_crm)),Table300K.PW(modelnum(mnum_crm)),[],col34(crm_num,:),'filled','h','SizeData',150);
scatter(sst_full_305(modelnum(mnum_gcm)),Table305K.PW(modelnum(mnum_gcm)),[],col34(gcm_num,:),'filled','o','SizeData',150);
scatter(sst_full_305(modelnum(mnum_crm)),Table305K.PW(modelnum(mnum_crm)),[],col34(crm_num,:),'filled','h','SizeData',180);
xlim([294 306])
ylim([10 70])
xlabel('SST K ')
ylabel('PW (kg/m2)')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)
subplot(1,3,2)
scatter(DelPrecipT(modelnum(mnum_gcm)),DeldPWT(modelnum(mnum_gcm)),[],col34(gcm_num,:),'filled','o','SizeData',120);
hold on
%scatter(DelPrecip1(mnum(11:21)),DeldPW1(mnum(11:21)),[],col34(mnum(11:21),:),'filled','h','SizeData',150);
%scatter(DelPrecip2(mnum(1:10)),DeldPW2(mnum(1:10)),[],col34(mnum(1:10),:),'filled','o','SizeData',170);
scatter(DelPrecipT(modelnum(mnum_crm)),DeldPWT(modelnum(mnum_crm)),[],col34(crm_num,:),'filled','h','SizeData',200);
%scatter(DelPrecipT(mnum(1:10)),DelPWT(mnum(1:10)),[],col34(mnum(1:10),:),'filled','o','SizeData',200);
xlabel('Del Precip %/K ')
ylabel('Del PW %/K ')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)
subplot(1,3,3)
scatter(sst_full_295(modelnum(mnum_gcm)),Cycle1(modelnum(mnum_gcm)),[],col34(gcm_num,:),'filled','o','SizeData',70)
hold on
scatter(sst_full_295(modelnum(mnum_crm)),Cycle1(modelnum(mnum_crm)),[],col34(crm_num,:),'filled','h','SizeData',100)
scatter(sst_full_300(modelnum(mnum_gcm)),Cycle2(modelnum(mnum_gcm)),[],col34(gcm_num,:),'filled','o','SizeData',120)
scatter(sst_full_300(modelnum(mnum_crm)),Cycle2(modelnum(mnum_crm)),[],col34(crm_num,:),'filled','h','SizeData',150)
scatter(sst_full_305(modelnum(mnum_gcm)),Cycle3(modelnum(mnum_gcm)),[],col34(gcm_num,:),'filled','o','SizeData',170)
scatter(sst_full_305(modelnum(mnum_crm)),Cycle3(modelnum(mnum_crm)),[],col34(crm_num,:),'filled','h','SizeData',200)
xlabel('SST (K)')
ylabel('Water vapor cycling rate (day^-1)')
xlim([294 306])
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)

ypos=0.81;
xpos=0.13
% Create textbox
annotation(figure1,'textbox',...
    [xpos ypos 0.0234171725932352 0.0761513353115727],...
    'String','(a)',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',16,...
    'FitBoxToText','off');
annotation(figure1,'textbox',...
    [xpos+0.29 ypos 0.0234171725932352 0.0761513353115727],...
    'String','(b)',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',16,...
    'FitBoxToText','off');
annotation(figure1,'textbox',...
    [xpos+0.29+0.29 ypos 0.0234171725932353 0.0761513353115727],...
    'String','(c)',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',16,...
    'FitBoxToText','off');

%-----------------------------------------------------------------------------------------------

% plot the two components of Cwv: P and PW vs Cwv to compare the ascatter that each represents
% determine the source of variability in Cwv
Precip_3SST=[Table295K.Precip Table300K.Precip Table305K.Precip]
Precip_3SST_mn=mean(Precip_3SST,2);
PW_3SST=[Table295K.PW Table300K.PW Table305K.PW]
PW_3SST_mn=mean(PW_3SST,2);

figure
subplot(1,2,1)
scatter(1./Table295K.PW(gcm_num),Cycle1(gcm_num),[],col34(gcm_num,:),'filled','o','SizeData',70)
hold on
scatter(1./Table295K.PW(crm_num),Cycle1(crm_num),[],col34(crm_num,:),'filled','h','SizeData',120)
scatter(1./Table300K.PW(gcm_num),Cycle2(gcm_num),[],col34(gcm_num,:),'filled','o','SizeData',120)
scatter(1./Table300K.PW(crm_num),Cycle2(crm_num),[],col34(crm_num,:),'filled','h','SizeData',170)
scatter(1./Table305K.PW(gcm_num),Cycle3(gcm_num),[],col34(gcm_num,:),'filled','o','SizeData',170)
scatter(1./Table305K.PW(crm_num),Cycle3(crm_num),[],col34(crm_num,:),'filled','h','SizeData',220)
xlabel('1/PW')
ylabel('Water vapor cycling rate (day^-1)')
subplot(1,2,2)
scatter(Table295K.Precip(gcm_num),Cycle1(gcm_num),[],col34(gcm_num,:),'filled','o','SizeData',70)
hold on
scatter(Table300K.Precip(gcm_num),Cycle2(gcm_num),[],col34(gcm_num,:),'filled','o','SizeData',120)
scatter(Table305K.Precip(gcm_num),Cycle3(gcm_num),[],col34(gcm_num,:),'filled','o','SizeData',170)
scatter(Table295K.Precip(crm_num),Cycle1(crm_num),[],col34(crm_num,:),'filled','h','SizeData',120)
scatter(Table300K.Precip(crm_num),Cycle2(crm_num),[],col34(crm_num,:),'filled','h','SizeData',170)
scatter(Table305K.Precip(crm_num),Cycle3(crm_num),[],col34(crm_num,:),'filled','h','SizeData',220)
xlabel('P (mm/d)')
ylabel('Water vapor cycling rate (day^-1)')


figure
subplot(1,2,1)
scatter(Precip_3SST_mn(gcm_num)./Table295K.PW(gcm_num),Cycle1(gcm_num),[],col34(gcm_num,:),'filled','o','SizeData',70)
hold on
scatter(Precip_3SST_mn(crm_num)./Table295K.PW(crm_num),Cycle1(crm_num),[],col34(crm_num,:),'filled','h','SizeData',120)
scatter(Precip_3SST_mn(gcm_num)./Table300K.PW(gcm_num),Cycle2(gcm_num),[],col34(gcm_num,:),'filled','o','SizeData',120)
scatter(Precip_3SST_mn(crm_num)./Table300K.PW(crm_num),Cycle2(crm_num),[],col34(crm_num,:),'filled','h','SizeData',170)
scatter(Precip_3SST_mn(gcm_num)./Table305K.PW(gcm_num),Cycle3(gcm_num),[],col34(gcm_num,:),'filled','o','SizeData',170)
scatter(Precip_3SST_mn(crm_num)./Table305K.PW(crm_num),Cycle3(crm_num),[],col34(crm_num,:),'filled','h','SizeData',220)
line([0.05,0.1,0.2,0.3],[0.05,0.1,0.2,0.3],'Color','k','LineWidth',1)
xlabel('$P_{mn}/PW$','interpreter','latex')
ylabel('Water vapor cycling rate (day^-1)')
xlim([0.03 0.32])
ylim([0.05 0.25])
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)
subplot(1,2,2)
scatter(Table295K.Precip(gcm_num)./PW_3SST_mn(gcm_num),Cycle1(gcm_num),[],col34(gcm_num,:),'filled','o','SizeData',70)
hold on
scatter(Table300K.Precip(gcm_num)./PW_3SST_mn(gcm_num),Cycle2(gcm_num),[],col34(gcm_num,:),'filled','o','SizeData',120)
scatter(Table305K.Precip(gcm_num)./PW_3SST_mn(gcm_num),Cycle3(gcm_num),[],col34(gcm_num,:),'filled','o','SizeData',170)
scatter(Table295K.Precip(crm_num)./PW_3SST_mn(crm_num),Cycle1(crm_num),[],col34(crm_num,:),'filled','h','SizeData',120)
scatter(Table300K.Precip(crm_num)./PW_3SST_mn(crm_num),Cycle2(crm_num),[],col34(crm_num,:),'filled','h','SizeData',170)
scatter(Table305K.Precip(crm_num)./PW_3SST_mn(crm_num),Cycle3(crm_num),[],col34(crm_num,:),'filled','h','SizeData',220)
line([0.05,0.1,0.2,0.3],[0.05,0.1,0.2,0.3],'Color','k','LineWidth',1)
xlabel('$P/PW_{mn}$','interpreter','latex')
ylabel('Water vapor cycling rate (day^-1)')
xlim([0.03 0.32])
ylim([0.05 0.25])
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)

%Cycle1=Table295K.Precip./Table295K.PW

figure
scatter(DelPrecipT(mnum(1:10)),DeldPWT(mnum(1:10)),[],col34(mnum(1:10),:),'filled','o','SizeData',200);
hold on
%scatter(DelPrecipT(mnum(1:10)),DelPWT(mnum(1:10)),[],col34(mnum(1:10),:),'filled','o','SizeData',200);
%scatter(DelPrecipT(mnum(11:21)),DelPWT(mnum(11:21)),[],col34(mnum(11:21),:),'filled','p','SizeData',120);
scatter(DelPrecipT(mnum(11:21)),DeldPWT(mnum(11:21)),[],col34(mnum(11:21),:),'filled','p','SizeData',230);
%xlim([0 0.16])
%ylim([0.02 0.16])
xlabel('Del Precip %/K ')
ylabel('Del PW %/K ')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)


% plot the mean precipitation
figure 
scatter(sst_full_295,Table295K.Precip,[],col34,'filled','o','SizeData',70);
hold on
scatter(sst_full_300,Table300K.Precip,[],col34,'filled','o','SizeData',120);
scatter(sst_full_305,Table305K.Precip,[],col34,'filled','o','SizeData',150);
xlim([294 306])
ylim([0 10])
xlabel('SST K ')
ylabel('Precipitation (mm/day)')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)

% test scaling relationships proposed in Schneider et al. 2010 between
% omega_up and the mean precipitation.  first we have to concatinate the 
% GCM and CRM omega results and then create a numbered array that will 
% grab the correct Precipitation and PW amounts from Allisons tables since
% they are ordered in a different way than in my arrays...

mymodelnumbers=[1,2,4,6,8,9,16,20,21,23,17,19,10,11,22,28,13];
numbers_15    =[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17];

precip_295=Table295K.Precip(mymodelnumbers);
precip_300=Table300K.Precip(mymodelnumbers);
precip_305=Table305K.Precip(mymodelnumbers);

omega_up_295_15mods=[CircSF295.omega_up' -Circ_omega_CRMs_295.omega_up'];
omega_up_300_15mods=[CircSF300.omega_up' -Circ_omega_CRMs_300.omega_up'];
omega_up_305_15mods=[CircSF305.omega_up' -Circ_omega_CRMs_305.omega_up'];

% calculate the surface saturation specific humidity: 
qs_295 = 6.11*exp((latheat/Rv)*(1./273-1./295.));
qs_300 = 6.11*exp((latheat/Rv)*(1./273-1./300.));
qs_305 = 6.11*exp((latheat/Rv)*(1./273-1./305.));

% calculate the saturation specific humidity at model level closest to the surface
for mi=1:mindex
  tempfirst  = 6.11*exp((latheat/Rv)*(1./273-1./temp(mi).first(1)));
  tempsecond = 6.11*exp((latheat/Rv)*(1./273-1./temp(mi).second(1)));
  tempthird  = 6.11*exp((latheat/Rv)*(1./273-1./temp(mi).third(1)));
  %temp(mi).first(1)
  qsat(mi).first=tempfirst;
  qsat(mi).second=tempsecond;
  qsat(mi).third=tempthird;
end

tempfirst =6.11*exp((latheat/Rv)*(1./273-1./temp(5).first(72))); 
tempsecond=6.11*exp((latheat/Rv)*(1./273-1./temp(5).second(72))); 
tempthird =6.11*exp((latheat/Rv)*(1./273-1./temp(5).third(72))); 
qsat(5).first  =tempfirst
qsat(5).second =tempsecond
qsat(5).third  =tempthird

% calculate the reciprocal values
for mi=1:mindex
  rqsat(mi).first  =1/qsat(mi).first;
  rqsat(mi).second =1/qsat(mi).second;
  rqsat(mi).third  =1/qsat(mi).third;
end

figure
scatter(omega_up_295_15mods(numbers_15)./grav,precip_295(numbers_15)*rqsat(mi).first,[],col34(mymodelnumbers,:),'filled','o','SizeData',70);
hold on
scatter(omega_up_300_15mods(numbers_15)./grav,precip_300(numbers_15)*rqsat(mi).second,[],col34(mymodelnumbers,:),'filled','o','SizeData',120);
scatter(omega_up_305_15mods(numbers_15)./grav,precip_305(numbers_15)*rqsat(mi).third,[],col34(mymodelnumbers,:),'filled','o','SizeData',150);
xlabel('omega up ')
ylabel('Precip')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)



%----------------------------------------------------------------------------
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
sgtitle('Moist and Actual Cdiabat for 305K ','FontSize',16,'FontWeight','bold')
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

%---------------------------------------------------
%---------------------------------------------------
% plot static stability vs. Qmn, radiative cooling

%figure
%subplot(1,4,1)
%scatter(Circ_omega_CRMs_295.sig_mn,-Circ_omega_CRMs_295.Qmn./Circ_omega_CRMs_295.sig_mn,[],colCRM,'filled','^','SizeData',70);
%hold on
%scatter(Circ_omega_CRMs_295.sig_mn,-Circ_omega_CRMs_295.Qmn./Circ_omega_CRMs_295.sig_mn,[],colCRM,'filled','v','SizeData',70);
%scatter(Circ_omega_CRMs_300.sig_mn,-Circ_omega_CRMs_300.Qmn./Circ_omega_CRMs_300.sig_mn,[],colCRM,'filled','^','SizeData',120);
%scatter(Circ_omega_CRMs_300.sig_mn,-Circ_omega_CRMs_300.Qmn./Circ_omega_CRMs_300.sig_mn,[],colCRM,'filled','v','SizeData',120);
%scatter(Circ_omega_CRMs_305.sig_mn,-Circ_omega_CRMs_305.Qmn./Circ_omega_CRMs_305.sig_mn,[],colCRM,'filled','^','SizeData',170);
%scatter(Circ_omega_CRMs_305.sig_mn,-Circ_omega_CRMs_305.Qmn./Circ_omega_CRMs_305.sig_mn,[],colCRM,'filled','v','SizeData',170);
%scatter(CircSF295.sig_mn,-CircSF295.Qmn./CircSF295.sig_mn,[],colGCM,'filled','o','SizeData',70)
%scatter(CircSF300.sig_mn,-CircSF300.Qmn./CircSF300.sig_mn,[],colGCM,'filled','o','SizeData',120)
%scatter(CircSF305.sig_mn,-CircSF305.Qmn./CircSF305.sig_mn,[],colGCM,'filled','o','SizeData',170)
%ylim([15,55])
%ylabel('diabatically driven Omega db (hPa/day)')
%xlabel('Static Stability (K/hPa)')
%set(gca,'FontWeight','bold')
%set(gca,'FontSize',14)
%title('Radiative Heating and Static Stability')
%subplot(1,4,2)
%qmnfixed=-1.3;
%scatter(Circ_omega_CRMs_295.sig_mn,-qmnfixed./Circ_omega_CRMs_295.sig_mn,[],colCRM,'filled','^','SizeData',70);
%hold on
%scatter(Circ_omega_CRMs_295.sig_mn,-qmnfixed./Circ_omega_CRMs_295.sig_mn,[],colCRM,'filled','v','SizeData',70);
%scatter(Circ_omega_CRMs_300.sig_mn,-qmnfixed./Circ_omega_CRMs_300.sig_mn,[],colCRM,'filled','^','SizeData',120);
%scatter(Circ_omega_CRMs_300.sig_mn,-qmnfixed./Circ_omega_CRMs_300.sig_mn,[],colCRM,'filled','v','SizeData',120);
%scatter(Circ_omega_CRMs_305.sig_mn,-qmnfixed./Circ_omega_CRMs_305.sig_mn,[],colCRM,'filled','^','SizeData',170);
%scatter(Circ_omega_CRMs_305.sig_mn,-qmnfixed./Circ_omega_CRMs_305.sig_mn,[],colCRM,'filled','v','SizeData',170);
%scatter(CircSF295.sig_mn,-qmnfixed./CircSF295.sig_mn,[],colGCM,'filled','o','SizeData',70)
%scatter(CircSF300.sig_mn,-qmnfixed./CircSF300.sig_mn,[],colGCM,'filled','o','SizeData',120)
%scatter(CircSF305.sig_mn,-qmnfixed./CircSF305.sig_mn,[],colGCM,'filled','o','SizeData',170)
%ylim([15,55])
%ylabel('A diabatically driven Omega db (hPa/day)')
%xlabel('Static Stability (K/hPa)')
%set(gca,'FontWeight','bold')
%set(gca,'FontSize',14)
%title('Radiative Heating and Static Stability')
%subplot(1,4,3)
%scatter(Circ_omega_CRMs_295.Qmn,-Circ_omega_CRMs_295.Qmn./Circ_omega_CRMs_295.sig_mn,[],colCRM,'filled','^','SizeData',70);
%hold on
%scatter(Circ_omega_CRMs_295.Qmn,-Circ_omega_CRMs_295.Qmn./Circ_omega_CRMs_295.sig_mn,[],colCRM,'filled','v','SizeData',70);
%scatter(Circ_omega_CRMs_300.Qmn,-Circ_omega_CRMs_300.Qmn./Circ_omega_CRMs_300.sig_mn,[],colCRM,'filled','^','SizeData',120);
%scatter(Circ_omega_CRMs_300.Qmn,-Circ_omega_CRMs_300.Qmn./Circ_omega_CRMs_300.sig_mn,[],colCRM,'filled','v','SizeData',120);
%scatter(Circ_omega_CRMs_305.Qmn,-Circ_omega_CRMs_305.Qmn./Circ_omega_CRMs_305.sig_mn,[],colCRM,'filled','^','SizeData',170);
%scatter(Circ_omega_CRMs_305.Qmn,-Circ_omega_CRMs_305.Qmn./Circ_omega_CRMs_305.sig_mn,[],colCRM,'filled','v','SizeData',170);
%scatter(CircSF295.Qmn,-CircSF295.Qmn./CircSF295.sig_mn,[],colGCM,'filled','o','SizeData',70)
%scatter(CircSF300.Qmn,-CircSF300.Qmn./CircSF300.sig_mn,[],colGCM,'filled','o','SizeData',120)
%scatter(CircSF305.Qmn,-CircSF305.Qmn./CircSF305.sig_mn,[],colGCM,'filled','o','SizeData',170)
%ylim([15,55])
%ylabel('B diabatically driven Omega db (hPa/day)')
%xlabel('Radiative Cooling (K/day)')
%set(gca,'FontWeight','bold')
%set(gca,'FontSize',14)
%title('Radiative Heating and Static Stability')
%subplot(1,4,4)
%fixedsig=0.05;
%scatter(Circ_omega_CRMs_295.Qmn,-Circ_omega_CRMs_295.Qmn./fixedsig,[],colCRM,'filled','^','SizeData',70);
%hold on
%scatter(Circ_omega_CRMs_295.Qmn,-Circ_omega_CRMs_295.Qmn./fixedsig,[],colCRM,'filled','v','SizeData',70);
%scatter(Circ_omega_CRMs_300.Qmn,-Circ_omega_CRMs_300.Qmn./fixedsig,[],colCRM,'filled','^','SizeData',120);
%scatter(Circ_omega_CRMs_300.Qmn,-Circ_omega_CRMs_300.Qmn./fixedsig,[],colCRM,'filled','v','SizeData',120);
%scatter(Circ_omega_CRMs_305.Qmn,-Circ_omega_CRMs_305.Qmn./fixedsig,[],colCRM,'filled','^','SizeData',170);
%scatter(Circ_omega_CRMs_305.Qmn,-Circ_omega_CRMs_305.Qmn./fixedsig,[],colCRM,'filled','v','SizeData',170);
%scatter(CircSF295.Qmn,-CircSF295.Qmn./fixedsig,[],colGCM,'filled','o','SizeData',70)
%scatter(CircSF300.Qmn,-CircSF300.Qmn./fixedsig,[],colGCM,'filled','o','SizeData',120)
%scatter(CircSF305.Qmn,-CircSF305.Qmn./fixedsig,[],colGCM,'filled','o','SizeData',170)
%ylim([15,55])
%ylabel('C diabatically driven Omega db (hPa/day)')
%xlabel('Radiative Cooling (K/day)')
%set(gca,'FontWeight','bold')
%set(gca,'FontSize',14)
%title('Radiative Heating and Static Stability')

% calculate the mean omega_d for each model with which to scale the radiative cooling 
omega_CRMs_295=-Circ_omega_CRMs_295.Qmn./Circ_omega_CRMs_295.sig_mn;
omega_GCMs_295=-CircSF295.Qmn./CircSF295.sig_mn;
omega_295=[omega_GCMs_295' omega_CRMs_295'];
omega_CRMs_300=-Circ_omega_CRMs_300.Qmn./Circ_omega_CRMs_300.sig_mn;
omega_GCMs_300=-CircSF300.Qmn./CircSF300.sig_mn;
omega_300=[omega_GCMs_300' omega_CRMs_300'];
omega_CRMs_305=-Circ_omega_CRMs_305.Qmn./Circ_omega_CRMs_305.sig_mn;
omega_GCMs_305=-CircSF305.Qmn./CircSF305.sig_mn;
omega_305=[omega_GCMs_305' omega_CRMs_305'];

% test_omega_array is 21x3
test_omega_array=[omega_295' omega_300' omega_305'];
test_GCM_array  =[omega_GCMs_295 omega_GCMs_300 omega_GCMs_305];
test_CRM_array  =[omega_CRMs_295 omega_CRMs_300 omega_CRMs_305];
% meanomega_db is an array of the mean omega values for each of the 2 models.
meanomega_db=mean(test_omega_array,2)
meanomega_GCM_db=mean(test_GCM_array,2)
meanomega_CRM_db=mean(test_CRM_array,2)

% mean Qmn for individual models
Qmn_mods      =[CircSF295.Qmn CircSF300.Qmn CircSF305.Qmn];
Qmn_CRM_mods  =[Circ_omega_CRMs_295.Qmn Circ_omega_CRMs_300.Qmn Circ_omega_CRMs_305.Qmn];
Qmn_modmn     =mean(Qmn_mods,2);
Qmn_CRM_modmn =mean(Qmn_CRM_mods,2);
% mean sig_mn for individual models
sig_mn_mods        =[CircSF295.sig_mn CircSF300.sig_mn CircSF305.sig_mn];
sig_mn_CRM_mods    =[Circ_omega_CRMs_295.sig_mn Circ_omega_CRMs_300.sig_mn Circ_omega_CRMs_305.sig_mn];
sig_mn_modmn       =mean(sig_mn_mods,2);
sig_mn_CRMs_modmn  =mean(sig_mn_CRM_mods,2);

%------------------------------------------------------------------------------------
%------------------------------------------------------------------------------------
% what does this figure mean??

%subplot(1,3,2)
%scatter(CircSF295.sig_mn(GCM_cs),CircSF295.Qmn(GCM_cs)./meanomega_db(GCM_cs),[],colGCM(GCM_cs,:),'filled','o','SizeData',70)
%hold on
%scatter(CircSF300.sig_mn(GCM_cs),CircSF300.Qmn(GCM_cs)./meanomega_db(GCM_cs),[],colGCM(GCM_cs,:),'filled','o','SizeData',120)
%scatter(CircSF305.sig_mn(GCM_cs),CircSF305.Qmn(GCM_cs)./meanomega_db(GCM_cs),[],colGCM(GCM_cs,:),'filled','o','SizeData',170)
%scatter(Circ_omega_CRMs_295.sig_mn(CRM_cs),Circ_omega_CRMs_295.Qmn(CRM_cs)./meanomega_CRM_db(CRM_cs),[],colCRM(CRM_cs,:),'filled','h','SizeData',120);
%scatter(Circ_omega_CRMs_300.sig_mn(CRM_cs),Circ_omega_CRMs_300.Qmn(CRM_cs)./meanomega_CRM_db(CRM_cs),[],colCRM(CRM_cs,:),'filled','h','SizeData',170);
%scatter(Circ_omega_CRMs_305.sig_mn(CRM_cs),Circ_omega_CRMs_305.Qmn(CRM_cs)./meanomega_CRM_db(CRM_cs),[],colCRM(CRM_cs,:),'filled','h','SizeData',220);
%ylabel('$Q/\omega_d$ (K/hPa)','interpreter','latex')
%xlabel('$\sigma$ (K/hPa)','interpreter','latex','FontSize',14,'FontWeight','bold')
%ylim([-0.08 -0.02])
%set(gca,'FontWeight','bold')
%set(gca,'FontSize',14)

figure1 = figure
%------------------------------------------------------------------------------------
% Near Final figure
%------------------------------------------------------------------------------------
subplot(1,2,1)
scatter(CircSF295.sig_mn(GCM_cs),CircSF295.Qmn(GCM_cs),[],colGCM(GCM_cs,:),'filled','o','SizeData',70)
hold on
scatter(CircSF300.sig_mn(GCM_cs),CircSF300.Qmn(GCM_cs),[],colGCM(GCM_cs,:),'filled','o','SizeData',120)
scatter(CircSF305.sig_mn(GCM_cs),CircSF305.Qmn(GCM_cs),[],colGCM(GCM_cs,:),'filled','o','SizeData',170)
scatter(Circ_omega_CRMs_295.sig_mn(CRM_cs),Circ_omega_CRMs_295.Qmn(CRM_cs),[],colCRM(CRM_cs,:),'filled','h','SizeData',120);
scatter(Circ_omega_CRMs_300.sig_mn(CRM_cs),Circ_omega_CRMs_300.Qmn(CRM_cs),[],colCRM(CRM_cs,:),'filled','h','SizeData',150);
scatter(Circ_omega_CRMs_305.sig_mn(CRM_cs),Circ_omega_CRMs_305.Qmn(CRM_cs),[],colCRM(CRM_cs,:),'filled','h','SizeData',220);
ylabel('$Q$ (K/day)','interpreter','latex')
xlabel('$\sigma$ (K/hPa)','interpreter','latex','FontSize',14,'FontWeight','bold')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)

subplot(1,2,2)
scatter(CircSF295.sig_mn(GCM_cs).*meanomega_db(GCM_cs),CircSF295.Qmn(GCM_cs,:),[],colGCM(GCM_cs,:),'filled','o','SizeData',70)
hold on
scatter(CircSF300.sig_mn(GCM_cs).*meanomega_db(GCM_cs),CircSF300.Qmn(GCM_cs,:),[],colGCM(GCM_cs,:),'filled','o','SizeData',120)
scatter(CircSF305.sig_mn(GCM_cs).*meanomega_db(GCM_cs),CircSF305.Qmn(GCM_cs,:),[],colGCM(GCM_cs,:),'filled','o','SizeData',170)
scatter(Circ_omega_CRMs_295.sig_mn(CRM_cs).*meanomega_CRM_db(CRM_cs),Circ_omega_CRMs_295.Qmn(CRM_cs),[],colCRM(CRM_cs,:),'filled','h','SizeData',120);
scatter(Circ_omega_CRMs_300.sig_mn(CRM_cs).*meanomega_CRM_db(CRM_cs),Circ_omega_CRMs_300.Qmn(CRM_cs),[],colCRM(CRM_cs,:),'filled','h','SizeData',170);
scatter(Circ_omega_CRMs_305.sig_mn(CRM_cs).*meanomega_CRM_db(CRM_cs),Circ_omega_CRMs_305.Qmn(CRM_cs),[],colCRM(CRM_cs,:),'filled','h','SizeData',220);
ylabel('$Q$ (K/day)','interpreter','latex')
xlabel('$\omega_{d}\sigma$ (K/day)','interpreter','latex','FontSize',14,'FontWeight','bold')
ylim([-2.5 -0.5])
xlim([.5 2.5])
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)
sgtitle('Radiative Heating and Static Stability','FontSize',16,'FontWeight','bold')

annotation(figure1,'textbox',...
    [0.306157849089332 0.78 0.0234171725932352 0.0761513353115727],...
    'String','(a)',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',16,...
    'FitBoxToText','off');
annotation(figure1,'textbox',...
    [0.594102341717259 0.78 0.0234171725932352 0.0761513353115727],...
    'String','(b)',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',16,...
    'FitBoxToText','off');
%annotation(figure1,'textbox',...
%    [0.872506504770163 0.786350148367954 0.0234171725932353 0.0761513353115727],...
%    'String','(c)',...
%    'LineStyle','none',...
%    'FontWeight','bold',...
%    'FontSize',16,...
%    'FitBoxToText','off');

%--------------
figure1 = figure
subplot(1,2,1)
scatter(sst_a(GCM_cs),CircSF295.Qmn(GCM_cs),[],colGCM(GCM_cs,:),'filled','o','SizeData',70)
hold on
scatter(sst_b(GCM_cs),CircSF300.Qmn(GCM_cs),[],colGCM(GCM_cs,:),'filled','o','SizeData',120)
scatter(sst_c(GCM_cs),CircSF305.Qmn(GCM_cs),[],colGCM(GCM_cs,:),'filled','o','SizeData',120)
scatter(sst_a(CRM_cs),Circ_omega_CRMs_295.Qmn(CRM_cs),[],colCRM(CRM_cs,:),'filled','h','SizeData',120);
scatter(sst_b(CRM_cs),Circ_omega_CRMs_300.Qmn(CRM_cs),[],colCRM(CRM_cs,:),'filled','h','SizeData',150);
scatter(sst_c(CRM_cs),Circ_omega_CRMs_305.Qmn(CRM_cs),[],colCRM(CRM_cs,:),'filled','h','SizeData',220);
ylabel('$Q$ (K/day)','interpreter','latex')
xlabel('SST','interpreter','latex','FontSize',14,'FontWeight','bold')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)
subplot(1,2,2)
scatter(sst_a(GCM_cs),abs(CircSF295.sig_mn(GCM_cs)),[],colGCM(GCM_cs,:),'filled','o','SizeData',70)
hold on
scatter(sst_b(GCM_cs),abs(CircSF300.sig_mn(GCM_cs)),[],colGCM(GCM_cs,:),'filled','o','SizeData',120)
scatter(sst_c(GCM_cs),abs(CircSF305.sig_mn(GCM_cs)),[],colGCM(GCM_cs,:),'filled','o','SizeData',120)
scatter(sst_a(CRM_cs),abs(Circ_omega_CRMs_295.sig_mn(CRM_cs)),[],colCRM(CRM_cs,:),'filled','h','SizeData',120);
scatter(sst_b(CRM_cs),abs(Circ_omega_CRMs_300.sig_mn(CRM_cs)),[],colCRM(CRM_cs,:),'filled','h','SizeData',150);
scatter(sst_c(CRM_cs),abs(Circ_omega_CRMs_305.sig_mn(CRM_cs)),[],colCRM(CRM_cs,:),'filled','h','SizeData',220);
ylabel('$\sigma$ (hPa/day)','interpreter','latex')
xlabel('SST','interpreter','latex','FontSize',14,'FontWeight','bold')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)
%-----------------
% figure demonstrating that the decrease of omega_diabatic is due to the increase of sigma with warming, not the decrease of radiative cooling.

figure1 = figure
subplot(1,3,1)
scatter(sst_a(GCM_cs),abs(CircSF295.Qmn(GCM_cs)./CircSF295.sig_mn(GCM_cs)),[],colGCM(GCM_cs,:),'filled','o','SizeData',70)
hold on
scatter(sst_b(GCM_cs),abs(CircSF300.Qmn(GCM_cs)./CircSF300.sig_mn(GCM_cs)),[],colGCM(GCM_cs,:),'filled','o','SizeData',120)
scatter(sst_c(GCM_cs),abs(CircSF305.Qmn(GCM_cs)./CircSF305.sig_mn(GCM_cs)),[],colGCM(GCM_cs,:),'filled','o','SizeData',120)
scatter(sst_a(CRM_cs),abs(Circ_omega_CRMs_295.Qmn(CRM_cs)./Circ_omega_CRMs_295.sig_mn(CRM_cs)),[],colCRM(CRM_cs,:),'filled','h','SizeData',120);
scatter(sst_b(CRM_cs),abs(Circ_omega_CRMs_300.Qmn(CRM_cs)./Circ_omega_CRMs_300.sig_mn(CRM_cs)),[],colCRM(CRM_cs,:),'filled','h','SizeData',150);
scatter(sst_c(CRM_cs),abs(Circ_omega_CRMs_305.Qmn(CRM_cs)./Circ_omega_CRMs_305.sig_mn(CRM_cs)),[],colCRM(CRM_cs,:),'filled','h','SizeData',220);
ylabel('$Q_{mn}/\sigma_{mn}$ (hPa/day)','interpreter','latex')
xlabel('SST','interpreter','latex','FontSize',14,'FontWeight','bold')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)
subplot(1,3,2)
scatter(sst_a(GCM_cs),abs(CircSF295.Qmn(GCM_cs)./sig_mn_modmn(GCM_cs)),[],colGCM(GCM_cs,:),'filled','o','SizeData',70)
hold on
scatter(sst_b(GCM_cs),abs(CircSF300.Qmn(GCM_cs)./sig_mn_modmn(GCM_cs)),[],colGCM(GCM_cs,:),'filled','o','SizeData',120)
scatter(sst_c(GCM_cs),abs(CircSF305.Qmn(GCM_cs)./sig_mn_modmn(GCM_cs)),[],colGCM(GCM_cs,:),'filled','o','SizeData',120)
scatter(sst_a(CRM_cs),abs(Circ_omega_CRMs_295.Qmn(CRM_cs)./sig_mn_CRMs_modmn(CRM_cs)),[],colCRM(CRM_cs,:),'filled','h','SizeData',120);
scatter(sst_b(CRM_cs),abs(Circ_omega_CRMs_300.Qmn(CRM_cs)./sig_mn_CRMs_modmn(CRM_cs)),[],colCRM(CRM_cs,:),'filled','h','SizeData',150);
scatter(sst_c(CRM_cs),abs(Circ_omega_CRMs_305.Qmn(CRM_cs)./sig_mn_CRMs_modmn(CRM_cs)),[],colCRM(CRM_cs,:),'filled','h','SizeData',220);
ylabel('$Q_{mn}/\overline{\sigma_{mn}}$ (hPa/day)','interpreter','latex')
xlabel('SST','interpreter','latex','FontSize',14,'FontWeight','bold')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)
subplot(1,3,3)
scatter(sst_a(GCM_cs),abs(Qmn_modmn(GCM_cs)./CircSF295.sig_mn(GCM_cs)),[],colGCM(GCM_cs,:),'filled','o','SizeData',70)
hold on
scatter(sst_b(GCM_cs),abs(Qmn_modmn(GCM_cs)./CircSF300.sig_mn(GCM_cs)),[],colGCM(GCM_cs,:),'filled','o','SizeData',120)
scatter(sst_c(GCM_cs),abs(Qmn_modmn(GCM_cs)./CircSF305.sig_mn(GCM_cs)),[],colGCM(GCM_cs,:),'filled','o','SizeData',120)
scatter(sst_a(CRM_cs),abs(Qmn_CRM_modmn(CRM_cs)./Circ_omega_CRMs_295.sig_mn(CRM_cs)),[],colCRM(CRM_cs,:),'filled','h','SizeData',120);
scatter(sst_b(CRM_cs),abs(Qmn_CRM_modmn(CRM_cs)./Circ_omega_CRMs_300.sig_mn(CRM_cs)),[],colCRM(CRM_cs,:),'filled','h','SizeData',150);
scatter(sst_c(CRM_cs),abs(Qmn_CRM_modmn(CRM_cs)./Circ_omega_CRMs_305.sig_mn(CRM_cs)),[],colCRM(CRM_cs,:),'filled','h','SizeData',220);
ylabel('$\overline{Q_{mn}}/\sigma_{mn}$ (hPa/day)','interpreter','latex')
xlabel('SST','interpreter','latex','FontSize',14,'FontWeight','bold')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)

%-----------------


figure
subplot(1,3,1)
scatter(sst_10a,abs(CircSF295.Qmn./CircSF295.sig_mn),[],colGCM,'filled','o','SizeData',70);
hold on
scatter(sst_5a,abs(Circ_omega_CRMs_295.Qmn./Circ_omega_CRMs_295.sig_mn),[],colCRM,'filled','h','SizeData',70);
scatter(sst_10b,abs(CircSF300.Qmn./CircSF300.sig_mn),[],colGCM,'filled','o','SizeData',120);
scatter(sst_5b,abs(Circ_omega_CRMs_300.Qmn./Circ_omega_CRMs_300.sig_mn),[],colCRM,'filled','h','SizeData',120);
scatter(sst_10c,abs(CircSF305.Qmn./CircSF305.sig_mn),[],colGCM,'filled','o','SizeData',170);
scatter(sst_5c,abs(Circ_omega_CRMs_305.Qmn./Circ_omega_CRMs_305.sig_mn),[],colCRM,'filled','h','SizeData',170);
xlim([294 306])
%
subplot(1,3,2)
scatter(sst_10a,abs(CircSF295.Qmn./CircSF295.sig_mn),[],colGCM,'filled','o','SizeData',70);
hold on
scatter(sst_5a,abs(meanomega_CRM_295.Qmn./Circ_omega_CRMs_295.sig_mn),[],colCRM,'filled','h','SizeData',70);
%scatter(sst_10b,abs(CircSF300.Qmn./CircSF300.sig_mn),[],colGCM,'filled','o','SizeData',120);
%scatter(sst_5b,abs(Circ_omega_CRMs_300.Qmn./Circ_omega_CRMs_300.sig_mn),[],colCRM,'filled','h','SizeData',120);
%scatter(sst_10c,abs(CircSF305.Qmn./CircSF305.sig_mn),[],colGCM,'filled','o','SizeData',170);
%scatter(sst_5c,abs(Circ_omega_CRMs_305.Qmn./Circ_omega_CRMs_305.sig_mn),[],colCRM,'filled','h','SizeData',170);
%subplot(1,3,3)
%scatter(sst_10a,abs(CircSF295.Qmn./CircSF295.sig_mn),[],colGCM,'filled','o','SizeData',70);
%hold on
%scatter(sst_5a,abs(Circ_omega_CRMs_295.Qmn./Circ_omega_CRMs_295.sig_mn),[],colCRM,'filled','h','SizeData',70);
%scatter(sst_10b,abs(CircSF300.Qmn./CircSF300.sig_mn),[],colGCM,'filled','o','SizeData',120);
%scatter(sst_5b,abs(Circ_omega_CRMs_300.Qmn./Circ_omega_CRMs_300.sig_mn),[],colCRM,'filled','h','SizeData',120);
%scatter(sst_10c,abs(CircSF305.Qmn./CircSF305.sig_mn),[],colGCM,'filled','o','SizeData',170);
%scatter(sst_5c,abs(Circ_omega_CRMs_305.Qmn./Circ_omega_CRMs_305.sig_mn),[],colCRM,'filled','h','SizeData',170);


%scatter(sst_10a,CircSF295.omega_db,[],colGCM,'filled','o','SizeData',70);
%hold on
%scatter(sst_5a,abs(Circ_omega_CRMs_295.omega_db),[],colCRM,'filled','^','SizeData',70);
%scatter(sst_5a,abs(Circ_omega_CRMs_295.omega_db),[],colCRM,'filled','v','SizeData',70);
%scatter(sst_10b,CircSF300.omega_db,[],colGCM,'filled','o','SizeData',120);
%scatter(sst_5b,abs(Circ_omega_CRMs_300.omega_db),[],colCRM,'filled','^','SizeData',120);
%scatter(sst_5b,abs(Circ_omega_CRMs_300.omega_db),[],colCRM,'filled','v','SizeData',120);
%scatter(sst_10c,CircSF305.omega_db,[],colGCM,'filled','o','SizeData',170);
%scatter(sst_5c,abs(Circ_omega_CRMs_305.omega_db),[],colCRM,'filled','^','SizeData',170);
%scatter(sst_5c,abs(Circ_omega_CRMs_305.omega_db),[],colCRM,'filled','v','SizeData',170);
%line([sst_10a(1),sst_10b(1),sst_10c(1)],[abs(CircSF295.omega_db(1)),abs(CircSF300.omega_db(1)),abs(CircSF305.omega_db(1))],'Color',colGCM(1,:),'LineWidth',3)
%line([sst_10a(1),sst_10b(1),sst_10c(1)],[abs(CircSF295.omega_db(2)),abs(CircSF300.omega_db(2)),abs(CircSF305.omega_db(2))],'Color',colGCM(2,:),'LineWidth',3)
%line([sst_10a(1),sst_10b(1),sst_10c(1)],[abs(CircSF295.omega_db(3)),abs(CircSF300.omega_db(3)),abs(CircSF305.omega_db(3))],'Color',colGCM(3,:),'LineWidth',3)
%line([sst_10a(1),sst_10b(1),sst_10c(1)],[abs(CircSF295.omega_db(4)),abs(CircSF300.omega_db(4)),abs(CircSF305.omega_db(4))],'Color',colGCM(4,:),'LineWidth',3)
%line([sst_10a(1),sst_10b(1),sst_10c(1)],[abs(CircSF295.omega_db(5)),abs(CircSF300.omega_db(5)),abs(CircSF305.omega_db(5))],'Color',colGCM(5,:),'LineWidth',3)
%line([sst_10a(1),sst_10b(1),sst_10c(1)],[abs(CircSF295.omega_db(6)),abs(CircSF300.omega_db(6)),abs(CircSF305.omega_db(6))],'Color',colGCM(6,:),'LineWidth',3)
%line([sst_10a(1),sst_10b(1),sst_10c(1)],[abs(CircSF295.omega_db(7)),abs(CircSF300.omega_db(7)),abs(CircSF305.omega_db(7))],'Color',colGCM(7,:),'LineWidth',3)
%line([sst_10a(1),sst_10b(1),sst_10c(1)],[abs(CircSF295.omega_db(8)),abs(CircSF300.omega_db(8)),abs(CircSF305.omega_db(8))],'Color',colGCM(8,:),'LineWidth',3)
%line([sst_10a(1),sst_10b(1),sst_10c(1)],[abs(CircSF295.omega_db(9)),abs(CircSF300.omega_db(9)),abs(CircSF305.omega_db(9))],'Color',colGCM(9,:),'LineWidth',3)
%line([sst_10a(1),sst_10b(1),sst_10c(1)],[abs(CircSF295.omega_db(10)),abs(CircSF300.omega_db(10)),abs(CircSF305.omega_db(10))],'Color',colGCM(10,:),'LineWidth',3)








%% how does the scaled omega_d do scattered against I?  
%figure
%subplot(1,3,1)
%scatter(CircSF295.omega_db,CircSF295.I,[],colGCM,'filled','o','SizeData',70)
%hold on
%scatter(CircSF300.omega_db,CircSF300.I,[],colGCM,'filled','o','SizeData',120)
%scatter(CircSF305.omega_db,CircSF305.I,[],colGCM,'filled','o','SizeData',170)
%scatter(abs(Circ_omega_CRMs_295.omega_db),Circ_omega_CRMs_295.I,[],colCRM,'filled','h','SizeData',120);
%scatter(abs(Circ_omega_CRMs_300.omega_db),Circ_omega_CRMs_300.I,[],colCRM,'filled','h','SizeData',150);
%scatter(abs(Circ_omega_CRMs_305.omega_db),Circ_omega_CRMs_305.I,[],colCRM,'filled','h','SizeData',220);
%ylabel('$I$ (K/day)','interpreter','latex')
%xlabel('$\sigma$ (K/hPa)','interpreter','latex','FontSize',14,'FontWeight','bold')
%set(gca,'FontWeight','bold')
%set(gca,'FontSize',14)
%
%subplot(1,3,2)
%scatter(CircSF295.sig_mn,CircSF295.Qmn./meanomega_db(1:10),[],colGCM,'filled','o','SizeData',70)
%hold on
%scatter(CircSF300.sig_mn,CircSF300.Qmn./meanomega_db(1:10),[],colGCM,'filled','o','SizeData',120)
%scatter(CircSF305.sig_mn,CircSF305.Qmn./meanomega_db(1:10),[],colGCM,'filled','o','SizeData',170)
%scatter(Circ_omega_CRMs_295.sig_mn,Circ_omega_CRMs_295.Qmn./meanomega_db(11:21),[],colCRM,'filled','h','SizeData',120);
%scatter(Circ_omega_CRMs_300.sig_mn,Circ_omega_CRMs_300.Qmn./meanomega_db(11:21),[],colCRM,'filled','h','SizeData',170);
%scatter(Circ_omega_CRMs_305.sig_mn,Circ_omega_CRMs_305.Qmn./meanomega_db(11:21),[],colCRM,'filled','h','SizeData',220);
%ylabel('$Q_{mn}/\sigma$ (K/hPa)','interpreter','latex')
%xlabel('$\sigma$ (K/hPa)','interpreter','latex','FontSize',14,'FontWeight','bold')
%ylim([-0.08 -0.02])
%set(gca,'FontWeight','bold')
%set(gca,'FontSize',14)
%
%subplot(1,3,3)
%scatter(CircSF295.sig_mn.*meanomega_db(1:10),CircSF295.Qmn,[],colGCM,'filled','o','SizeData',70)
%hold on
%scatter(CircSF300.sig_mn.*meanomega_db(1:10),CircSF300.Qmn,[],colGCM,'filled','o','SizeData',120)
%scatter(CircSF305.sig_mn.*meanomega_db(1:10),CircSF305.Qmn,[],colGCM,'filled','o','SizeData',170)
%scatter(Circ_omega_CRMs_295.sig_mn.*meanomega_db(11:21),Circ_omega_CRMs_295.Qmn,[],colCRM,'filled','h','SizeData',120);
%scatter(Circ_omega_CRMs_300.sig_mn.*meanomega_db(11:21),Circ_omega_CRMs_300.Qmn,[],colCRM,'filled','h','SizeData',170);
%scatter(Circ_omega_CRMs_305.sig_mn.*meanomega_db(11:21),Circ_omega_CRMs_305.Qmn,[],colCRM,'filled','h','SizeData',220);
%ylabel('$Q_{mn}$ (K/day)','interpreter','latex')
%xlabel('$\omega_{d}\sigma$ (K/day)','interpreter','latex','FontSize',14,'FontWeight','bold')
%ylim([-2.5 -0.5])
%xlim([.5 2.5])
%set(gca,'FontWeight','bold')
%set(gca,'FontSize',14)
%sgtitle('Radiative Heating and Static Stability','FontSize',16,'FontWeight','bold')
%%title('Radiative Heating and Static Stability')
%


figure
scatter(Circ_omega_CRMs_295.sig_mn-Circ_omega_CRMs_295.sig_mn,Circ_omega_CRMs_295.Qmn./meanomega_db(11:15)-Circ_omega_CRMs_295.Qmn./meanomega_db(11:15),[],colCRM,'filled','^','SizeData',70);
hold on
scatter(Circ_omega_CRMs_295.sig_mn-Circ_omega_CRMs_295.sig_mn,Circ_omega_CRMs_295.Qmn./meanomega_db(11:15)-Circ_omega_CRMs_295.Qmn./meanomega_db(11:15),[],colCRM,'filled','v','SizeData',70);
scatter(Circ_omega_CRMs_300.sig_mn-Circ_omega_CRMs_295.sig_mn,Circ_omega_CRMs_300.Qmn./meanomega_db(11:15)-Circ_omega_CRMs_295.Qmn./meanomega_db(11:15),[],colCRM,'filled','^','SizeData',120);
scatter(Circ_omega_CRMs_300.sig_mn-Circ_omega_CRMs_295.sig_mn,Circ_omega_CRMs_300.Qmn./meanomega_db(11:15)-Circ_omega_CRMs_295.Qmn./meanomega_db(11:15),[],colCRM,'filled','v','SizeData',120);
scatter(Circ_omega_CRMs_305.sig_mn-Circ_omega_CRMs_295.sig_mn,Circ_omega_CRMs_305.Qmn./meanomega_db(11:15)-Circ_omega_CRMs_295.Qmn./meanomega_db(11:15),[],colCRM,'filled','^','SizeData',170);
scatter(Circ_omega_CRMs_305.sig_mn-Circ_omega_CRMs_295.sig_mn,Circ_omega_CRMs_305.Qmn./meanomega_db(11:15)-Circ_omega_CRMs_295.Qmn./meanomega_db(11:15),[],colCRM,'filled','v','SizeData',170);
scatter(CircSF295.sig_mn-CircSF295.sig_mn,CircSF295.Qmn./meanomega_db(1:10)-CircSF295.Qmn./meanomega_db(1:10),[],colGCM,'filled','o','SizeData',70)
scatter(CircSF300.sig_mn-CircSF295.sig_mn,CircSF300.Qmn./meanomega_db(1:10)-CircSF295.Qmn./meanomega_db(1:10),[],colGCM,'filled','o','SizeData',120)
scatter(CircSF305.sig_mn-CircSF295.sig_mn,CircSF305.Qmn./meanomega_db(1:10)-CircSF295.Qmn./meanomega_db(1:10),[],colGCM,'filled','o','SizeData',170)
%ylim([15,55])
ylabel('Scaled Radiative Cooling (K/hPa)')
xlabel('Static Stability (K/hPa)')
%ylim([-0.08 -0.02])
set(gca,'FontWeight','bold')

% plot omega_db as a function of SST with Qmn held fixed, and then with sigma_mn held fixed
figure
subplot(1,3,1)
fixedsig=0.05;
scatter(sst_10a,-CircSF295.Qmn./CircSF295.sig_mn,[],colGCM,'filled','o','SizeData',70);
hold on
scatter(sst_5a,-Circ_omega_CRMs_295.Qmn./Circ_omega_CRMs_295.sig_mn,[],colCRM,'filled','^','SizeData',70);
scatter(sst_5a,-Circ_omega_CRMs_295.Qmn./Circ_omega_CRMs_295.sig_mn,[],colCRM,'filled','v','SizeData',70);
scatter(sst_10b,-CircSF300.Qmn./CircSF300.sig_mn,[],colGCM,'filled','o','SizeData',120);
scatter(sst_5b,-Circ_omega_CRMs_300.Qmn./Circ_omega_CRMs_300.sig_mn,[],colCRM,'filled','^','SizeData',120);
scatter(sst_5b,-Circ_omega_CRMs_300.Qmn./Circ_omega_CRMs_300.sig_mn,[],colCRM,'filled','v','SizeData',120);
scatter(sst_10c,-CircSF305.Qmn./CircSF305.sig_mn,[],colGCM,'filled','o','SizeData',170);
scatter(sst_5c,-Circ_omega_CRMs_305.Qmn./Circ_omega_CRMs_305.sig_mn,[],colCRM,'filled','^','SizeData',170);
scatter(sst_5c,-Circ_omega_CRMs_305.Qmn./Circ_omega_CRMs_305.sig_mn,[],colCRM,'filled','v','SizeData',170);
ylim([15,55])
ylabel('\omega_d, (hPa/d)')
xlabel('T_s (K)')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)
xlim([294 306])
subplot(1,3,2)
scatter(sst_10a,-qmnfixed./CircSF295.sig_mn,[],colGCM,'filled','o','SizeData',70);
hold on
scatter(sst_5a,-qmnfixed./Circ_omega_CRMs_295.sig_mn,[],colCRM,'filled','^','SizeData',70);
scatter(sst_5a,-qmnfixed./Circ_omega_CRMs_295.sig_mn,[],colCRM,'filled','v','SizeData',70);
scatter(sst_10b,-qmnfixed./CircSF300.sig_mn,[],colGCM,'filled','o','SizeData',120);
scatter(sst_5b,-qmnfixed./Circ_omega_CRMs_300.sig_mn,[],colCRM,'filled','^','SizeData',120);
scatter(sst_5b,-qmnfixed./Circ_omega_CRMs_300.sig_mn,[],colCRM,'filled','v','SizeData',120);
scatter(sst_10c,-qmnfixed./CircSF305.sig_mn,[],colGCM,'filled','o','SizeData',170);
scatter(sst_5c,-qmnfixed./Circ_omega_CRMs_305.sig_mn,[],colCRM,'filled','^','SizeData',170);
scatter(sst_5c,-qmnfixed./Circ_omega_CRMs_305.sig_mn,[],colCRM,'filled','v','SizeData',170);
ylim([15,55])
ylabel('fixed Q; diabatic omega, (hPa/d)')
xlabel('T_s (K)')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)
xlim([294 306])
subplot(1,3,3)
scatter(sst_10a,-CircSF295.Qmn/fixedsig,[],colGCM,'filled','o','SizeData',70);
hold on
scatter(sst_5a,-Circ_omega_CRMs_295.Qmn/fixedsig,[],colCRM,'filled','^','SizeData',70);
scatter(sst_5a,-Circ_omega_CRMs_295.Qmn/fixedsig,[],colCRM,'filled','v','SizeData',70);
scatter(sst_10b,-CircSF300.Qmn/fixedsig,[],colGCM,'filled','o','SizeData',120);
scatter(sst_5b,-Circ_omega_CRMs_300.Qmn/fixedsig,[],colCRM,'filled','^','SizeData',120);
scatter(sst_5b,-Circ_omega_CRMs_300.Qmn/fixedsig,[],colCRM,'filled','v','SizeData',120);
scatter(sst_10c,-CircSF305.Qmn/fixedsig,[],colGCM,'filled','o','SizeData',170);
scatter(sst_5c,-Circ_omega_CRMs_305.Qmn/fixedsig,[],colCRM,'filled','^','SizeData',170);
scatter(sst_5c,-Circ_omega_CRMs_305.Qmn/fixedsig,[],colCRM,'filled','v','SizeData',170);
ylim([15,55])
ylabel('fixed sigma; diabatic omega, (hPa/d)')
xlabel('T_s (K)')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)
xlim([294 306])






%---------------------------------------------------
%---------------------------------------------------

%---------------------------------------------------
% plot static stability vs. omega up
figure
subplot(1,3,1)
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
%figure
subplot(1,3,2)
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
% plot static stability vs. omega diabatic
%figure
subplot(1,3,3)
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
subplot(1,3,1)
scatter(Circ_omega_CRMs_295.sig_mn-Circ_omega_CRMs_295.sig_mn,Circ_omega_CRMs_295.Qmn,[],colCRM,'filled','h','SizeData',120);
hold on
scatter(Circ_omega_CRMs_300.sig_mn-Circ_omega_CRMs_295.sig_mn,Circ_omega_CRMs_300.Qmn,[],colCRM,'filled','h','SizeData',170);
scatter(Circ_omega_CRMs_305.sig_mn-Circ_omega_CRMs_295.sig_mn,Circ_omega_CRMs_305.Qmn,[],colCRM,'filled','h','SizeData',220);
scatter(CircSF295.sig_mn-CircSF295.sig_mn,CircSF295.Qmn,[],colGCM,'filled','o','SizeData',70)
scatter(CircSF300.sig_mn-CircSF295.sig_mn,CircSF300.Qmn,[],colGCM,'filled','o','SizeData',120)
scatter(CircSF305.sig_mn-CircSF295.sig_mn,CircSF305.Qmn,[],colGCM,'filled','o','SizeData',170)
ylabel('Net Radiative Cooling (K/day)')
xlabel('Static Stability (K/hPa)')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)
title('Radiative Heating and Static Stability')

%figure
subplot(1,3,2)
scatter(Circ_omega_CRMs_295.sig_mn,Circ_omega_CRMs_295.Qmn-Circ_omega_CRMs_295.Qmn,[],colCRM,'filled','h','SizeData',120);
hold on
scatter(Circ_omega_CRMs_300.sig_mn,Circ_omega_CRMs_300.Qmn-Circ_omega_CRMs_295.Qmn,[],colCRM,'filled','h','SizeData',150);
scatter(Circ_omega_CRMs_305.sig_mn,Circ_omega_CRMs_305.Qmn-Circ_omega_CRMs_295.Qmn,[],colCRM,'filled','h','SizeData',220);
scatter(CircSF295.sig_mn,CircSF295.Qmn-CircSF295.Qmn,[],colGCM,'filled','o','SizeData',70)
scatter(CircSF300.sig_mn,CircSF300.Qmn-CircSF295.Qmn,[],colGCM,'filled','o','SizeData',120)
scatter(CircSF305.sig_mn,CircSF305.Qmn-CircSF295.Qmn,[],colGCM,'filled','o','SizeData',170)
ylabel('Net Radiative Cooling (K/day)')
xlabel('Static Stability (K/hPa)')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)
title('Radiative Heating and Static Stability')

%figure
subplot(1,3,3)
scatter(Circ_omega_CRMs_295.sig_mn-Circ_omega_CRMs_295.sig_mn,Circ_omega_CRMs_295.Qmn-Circ_omega_CRMs_295.Qmn,[],colCRM,'filled','h','SizeData',120);
hold on
scatter(Circ_omega_CRMs_300.sig_mn-Circ_omega_CRMs_295.sig_mn,Circ_omega_CRMs_300.Qmn-Circ_omega_CRMs_295.Qmn,[],colCRM,'filled','h','SizeData',170);
scatter(Circ_omega_CRMs_305.sig_mn-Circ_omega_CRMs_295.sig_mn,Circ_omega_CRMs_305.Qmn-Circ_omega_CRMs_295.Qmn,[],colCRM,'filled','h','SizeData',220);
scatter(CircSF295.sig_mn-CircSF295.sig_mn,CircSF295.Qmn-CircSF295.Qmn,[],colGCM,'filled','o','SizeData',70)
scatter(CircSF300.sig_mn-CircSF295.sig_mn,CircSF300.Qmn-CircSF295.Qmn,[],colGCM,'filled','o','SizeData',120)
scatter(CircSF305.sig_mn-CircSF295.sig_mn,CircSF305.Qmn-CircSF295.Qmn,[],colGCM,'filled','o','SizeData',170)
ylabel('Net Radiative Cooling (K/day)')
xlabel('Static Stability (K/hPa)')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)
title('Radiative Heating and Static Stability Anomalies')

% end of figures related to static stability and heating/cooling
%------------------------------------------------------------------------------

%-------------------------------------------------------------------------------------------------------------------------
% Near Final figure
%-------------------------------------------------------------------------------------------------------------------------
% Plot the relation between upward and downward omega with omega_db
% also plot the relation between upward and downward omega to each other
% on each panel plot a 1:1 line 
figure1=figure
subplot(1,3,1)
scatter(abs(Circ_omega_CRMs_295.omega_up),abs(Circ_omega_CRMs_295.omega_dn),[],colCRM,'filled','h','SizeData',100);
hold on
scatter(abs(Circ_omega_CRMs_300.omega_up),abs(Circ_omega_CRMs_300.omega_dn),[],colCRM,'filled','h','SizeData',150);
scatter(abs(Circ_omega_CRMs_305.omega_up),abs(Circ_omega_CRMs_305.omega_dn),[],colCRM,'filled','h','SizeData',200);
scatter(abs(CircSF295.omega_up),abs(CircSF295.omega_dn),[],colGCM,'filled','o','SizeData',70)
scatter(abs(CircSF300.omega_up),abs(CircSF300.omega_dn),[],colGCM,'filled','o','SizeData',120)
scatter(abs(CircSF305.omega_up),abs(CircSF305.omega_dn),[],colGCM,'filled','o','SizeData',170)
line([0,10,15,45,60],[0,10,15,45,60],'Color','k','LineWidth',1)
ylabel('\omega^\downarrow (hPa/day)')
xlabel('\omega^\uparrow (hPa/day)')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)

subplot(1,3,2)
scatter(abs(Circ_omega_CRMs_295.omega_db(CRM_cs)),abs(Circ_omega_CRMs_295.omega_dn(CRM_cs)),[],colCRM(CRM_cs,:),'filled','h','SizeData',100);
hold on
scatter(abs(Circ_omega_CRMs_300.omega_db(CRM_cs)),abs(Circ_omega_CRMs_300.omega_dn(CRM_cs)),[],colCRM(CRM_cs,:),'filled','h','SizeData',150);
scatter(abs(Circ_omega_CRMs_305.omega_db(CRM_cs)),abs(Circ_omega_CRMs_305.omega_dn(CRM_cs)),[],colCRM(CRM_cs,:),'filled','h','SizeData',200);
scatter(CircSF295.omega_db(GCM_cs),CircSF295.omega_dn(GCM_cs),[],colGCM(GCM_cs,:),'filled','o','SizeData',70)
scatter(CircSF300.omega_db(GCM_cs),CircSF300.omega_dn(GCM_cs),[],colGCM(GCM_cs,:),'filled','o','SizeData',120)
scatter(CircSF305.omega_db(GCM_cs),CircSF305.omega_dn(GCM_cs),[],colGCM(GCM_cs,:),'filled','o','SizeData',170)
line([15,45,60],[15,45,60],'Color','k','LineWidth',1)
ylabel('\omega^\downarrow (hPa/day)')
xlabel('\omega_d (hPa/day)')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)
xlim([15 60])
ylim([10 60])

subplot(1,3,3)
scatter(abs(Circ_omega_CRMs_295.omega_db(CRM_cs)),abs(Circ_omega_CRMs_295.omega_up(CRM_cs)),[],colCRM(CRM_cs,:),'filled','h','SizeData',100);
hold on
scatter(abs(Circ_omega_CRMs_300.omega_db(CRM_cs)),abs(Circ_omega_CRMs_300.omega_up(CRM_cs)),[],colCRM(CRM_cs,:),'filled','h','SizeData',150);
scatter(abs(Circ_omega_CRMs_305.omega_db(CRM_cs)),abs(Circ_omega_CRMs_305.omega_up(CRM_cs)),[],colCRM(CRM_cs,:),'filled','h','SizeData',200);
scatter(abs(CircSF295.omega_db(GCM_cs)),abs(CircSF295.omega_up(GCM_cs)),[],colGCM(GCM_cs,:),'filled','o','SizeData',70)
scatter(abs(CircSF300.omega_db(GCM_cs)),abs(CircSF300.omega_up(GCM_cs)),[],colGCM(GCM_cs,:),'filled','o','SizeData',120)
scatter(abs(CircSF305.omega_db(GCM_cs)),abs(CircSF305.omega_up(GCM_cs)),[],colGCM(GCM_cs,:),'filled','o','SizeData',170)
line([15,45,60],[15,45,60],'Color','k','LineWidth',1)
ylabel('\omega^\uparrow (hPa/day)')
xlabel('\omega_d (hPa/day)')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)
xlim([15 60])

ypos=0.81;
xpos=0.13
annotation(figure1,'textbox',...
    [xpos ypos 0.0234171725932352 0.0761513353115727],...
    'String','(a)',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',16,...
    'FitBoxToText','off');
annotation(figure1,'textbox',...
    [xpos+0.29 ypos 0.0234171725932352 0.0761513353115727],...
    'String','(b)',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',16,...
    'FitBoxToText','off');
annotation(figure1,'textbox',...
    [xpos+0.29+0.29 ypos 0.0234171725932353 0.0761513353115727],...
    'String','(c)',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',16,...
    'FitBoxToText','off');


%
