%---------------------------------------------------------------------------------------- 
% This script produces the final figures that were used in the Silvers, Reed, and Wing 
% paper that uses RCEMIP to investigate overturning circulations.
%
% run using Matlab2019b
%
% Scripts that must be executed first:
%           create_RCEMIP_colors.m
%           openRCEprofiles.m
%
% Using the below ghostscript command can help to reduce the useless white space that
% is often inserted around eps figures.
% gs -dNOPAUSE -dBATCH -q -sDEVICE=bbox filename.eps
%
% levi silvers                                                             nov 2021
%---------------------------------------------------------------------------------------- 

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


% create a arrays for each of the models at each SST value
sst_full_295=zeros(34,1)+295;
sst_full_300=zeros(34,1)+300;
sst_full_305=zeros(34,1)+305;

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

%--------

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

%---------------


% Figure 1
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
xlabel('$T_s \, (\rm{K}) $','interpreter','latex','FontSize',14,'FontWeight','bold')
ylabel('$PW \,(\rm{kg} \,\rm{m}^{-2})$','interpreter','latex','FontSize',14,'FontWeight','bold')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)
subplot(1,3,2)
scatter(DelPrecipT(modelnum(mnum_gcm)),DeldPWT(modelnum(mnum_gcm)),[],col34(gcm_num,:),'filled','o','SizeData',120);
hold on
scatter(DelPrecipT(modelnum(mnum_crm)),DeldPWT(modelnum(mnum_crm)),[],col34(crm_num,:),'filled','h','SizeData',200);
xlabel('$\delta P \, \rm{K}^{-1} $','interpreter','latex','FontSize',14,'FontWeight','bold')
ylabel('$\delta PW \, \rm{K}^{-1}$','interpreter','latex','FontSize',14)
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
%yrightaxis=1/Cycle1(modelnum(mnum_gcm(1)))
%yyaxis right
xlabel('$T_s \, (\rm{K}) $','interpreter','latex','FontSize',14,'FontWeight','bold')
ylabel('$C_{wv}  \, (\rm{day}^{-1})$','interpreter','latex','FontSize',14,'FontWeight','bold')
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



%-------------------------------------------------------------------------------
% Figure 2
%-------------------------------------------------------------------------------
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
ylabel('Circulation Intensity, $I \, (\rm{hPa \> d^{-1}})$','interpreter','latex','FontSize',12,'FontWeight','bold')
xlabel('$T_s \, (\rm{K}) $','interpreter','latex','FontSize',14,'FontWeight','bold')
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
%ylabel('Circulation Intensity, I (hPa/d)')
ylabel('Circulation Intensity, $I \, (\rm{hPa} \> \rm{d}^{-1})$','interpreter','latex','FontSize',12,'FontWeight','bold')
xlabel('$\omega \, (\rm{hPa \> d^{-1}})$','interpreter','latex','FontSize',12,'FontWeight','bold')
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
%ylabel('Circulation Intensity, I (hPa/d)')
ylabel('Circulation Intensity, $I \, (\rm{hPa \> d^{-1}})$','interpreter','latex','FontSize',12,'FontWeight','bold')
xlabel('$\omega_d \, (\rm{hPa \> d^{-1}})$','interpreter','latex','FontSize',12,'FontWeight','bold')
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)
ylim([0 150])
xlim([15 60])
%sgtitle('Overturning Circulation at 500 hPa','FontSize',16,'FontWeight','bold')
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

%-------------------------------------------------------------------------------
% Figure 3
%-------------------------------------------------------------------------------
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
%-------------------------------------------------------------------------------
% Figure 4
%-------------------------------------------------------------------------------
%-------------------------------------------------------------------------------
% Figure 5
%-------------------------------------------------------------------------------
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
%-------------------------------------------------------------------------------
% Figure 6
%-------------------------------------------------------------------------------
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
%-------------------------------------------------------------------------------
% Figure 7
%-------------------------------------------------------------------------------
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
%-------------------------------------------------------------------------------
% Figure 8
%-------------------------------------------------------------------------------
figure1 = figure
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
%-------------------------------------------------------------------------------
% Figure 9
%-------------------------------------------------------------------------------

