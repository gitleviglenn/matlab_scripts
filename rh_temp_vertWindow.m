%------------------------------------------------------------------------------------
% rh_temp_vertWindow.m
%
% analysis of multi-model data from RCEMIP, 21 models at time of writing
%
% creates plots of relative humidity, fractional detrainment rate, and wv lapse rate
% plotted as a function of temperature
%
% the water vapor lapse rate and fractional detrainment rate are as defined by 
% Romps, 2014.
%
% conditional statements are used to plot only data below a particular temperature,
% excluding values above the temperature defined tropopause (reversal of gradient)
% --> rh_plot, etc. 
%
% conditional statements are also used to select a particular region of the 
% troposphere from which to compute average RH values.   --> rh_trop 
%
% levi silvers                                         november 2021
%------------------------------------------------------------------------------------

% i need to select regions of the RH field in the midtroposphere, but cut off the upper 
% regions where the temperature starts to increase with height.

% each model has a different number of vertical levels...

% could I start near the surface, in temperature space, at 295, 300, or 305K... then check 
% each level and save it until the temperature drops below about 200K... then stop. 

% below will grab a sectin between two temperatures.  should be able to be used
% to average RH between two desired temps...
%modelnum=1;  % should cycle through all 21 models....
%modelnum      =[1 2 4 6 8 9 10 11 12 13 16 17 19 20 21 22 23 24 25 26 27 28]; % index numbers for col34 that are used in my study

clear rh_trop temp_plot rh_plot det_plot gam_wv_plot

% the loop below calculates the mean tropospheric RH after selected
% particular temperature levels.  
clear rh_trop
mindex=22;
for mi=1:mindex;
  boo=size(temp(mi).first)
  topindex=boo(1);
  index=1;
  while index < topindex
    if (temp(mi).first(index) < 280 & temp(mi).first(index) > 230) 
      %temp(mi).first(index)
      rh_trop(mi).first(index)=rh(mi).first(index);
      index=index+1;
    elseif (temp(mi).first(index) > 230)
      rh_trop(mi).first(index)=NaN;
      index=index+1;
    else 
      index=topindex+1; % exit for loop
    end
    index
  end
  boo=size(temp(mi).second)
  topindex=boo(1);
  index=1;
  while index < topindex
    if (temp(mi).second(index) < 280 & temp(mi).second(index) > 230) 
      %temp(mi).second(index)
      rh_trop(mi).second(index)=rh(mi).second(index);
      index=index+1;
    elseif (temp(mi).second(index) > 230)
      rh_trop(mi).second(index)=NaN;
      index=index+1;
    else 
      index=topindex+1; % exit for loop
    end
    index;
  end
  boo=size(temp(mi).third)
  topindex=boo(1);
  index=1;
  while index < topindex
    if (temp(mi).third(index) < 280 & temp(mi).third(index) > 230) 
      %temp(mi).third(index)
      rh_trop(mi).third(index)=rh(mi).third(index);
      index=index+1;
    elseif (temp(mi).third(index) > 230)
      rh_trop(mi).third(index)=NaN;
      index=index+1;
    else 
      index=topindex+1; % exit for loop
    end
    index;
  end
  %rh_trop_mean(mi).first=nanmean(rh_trop(mi).first)  % it seems like case of all nans messes this
  %nanmean(rh_trop(mi).first)
end 
% below should be used to plot values from the surface up to 200K, but cut off else 
%modelnum(mnum_gcm)


%
tempthresh=210

mindex=22;
for mi=1:mindex;
  boo=size(temp(mi).first)   % 295K
  topindex=boo(1);
  index=1;
  while index < topindex
    if (temp(mi).first(index) > 210)
      temp_plot(mi).first(index)=temp(mi).first(index);
      rh_plot(mi).first(index)=rh(mi).first(index);
      det_plot(mi).first(index)=delta_frac(mi).first(index);
      gam_wv_plot(mi).first(index)=gam_wv(mi).first(index);
      index=index+1;
    else 
      index=topindex+1; % exit for loop
    end
    index;
  end
  boo=size(temp(mi).second)  % 300K
  topindex=boo(1);
  index=1;
  while index < topindex
    if (temp(mi).second(index) > 210)
      temp_plot(mi).second(index)=temp(mi).second(index);
      rh_plot(mi).second(index)=rh(mi).second(index);
      det_plot(mi).second(index)=delta_frac(mi).second(index);
      gam_wv_plot(mi).second(index)=gam_wv(mi).second(index);
      index=index+1;
    else 
      index=topindex+1; % exit for loop
    end
    index;
  end
  boo=size(temp(mi).third)  % 305K
  topindex=boo(1);
  index=1;
  while index < topindex
    if (temp(mi).third(index) > 210)
      temp_plot(mi).third(index)=temp(mi).third(index);
      rh_plot(mi).third(index)=rh(mi).third(index);
      det_plot(mi).third(index)=delta_frac(mi).third(index);
      gam_wv_plot(mi).third(index)=gam_wv(mi).third(index);
      index=index+1;
    else 
      index=topindex+1; % exit for loop
    end
    index;
  end
end

% below is special code because the orientation of the GEOS vertical 
% axis is opposite that of all 20 other models!!
%mindex=22;
%for mi=1:mindex;
  botindex=1;
  newindex=1;
  index=72;
  while index > botindex
    if (temp(5).first(index) < 280 & temp(5).first(index) > 230) 
      %temp(5).first(index)
      rh_trop(5).first(newindex)=rh(5).first(index);
      newindex=newindex+1;
      index=index-1;
    elseif (temp(5).first(index) > 230)
      rh_trop(5).first(newindex)=NaN;
      newindex=newindex+1;
      index=index-1;
    else 
      index=botindex-1; % exit for loop
    end
    index;
  end
  botindex=1;
  newindex=1;
  index=72;
  while index > botindex
    if (temp(5).second(index) < 280 & temp(5).second(index) > 230) 
      %temp(5).second(index)
      rh_trop(5).second(newindex)=rh(5).second(index);
      newindex=newindex+1;
      index=index-1;
    elseif (temp(5).second(index) > 230)
      rh_trop(5).second(newindex)=NaN;
      newindex=newindex+1;
      index=index-1;
    else 
      index=botindex-1; % exit for loop
    end
    index;
  end
  botindex=1;
  newindex=1;
  index=72;
  while index > botindex
    if (temp(5).third(index) < 280 & temp(5).third(index) > 230) 
      %temp(5).third(index)
      rh_trop(5).third(newindex)=rh(5).third(index);
      newindex=newindex+1;
      index=index-1;
    elseif (temp(5).third(index) > 230)
      rh_trop(5).third(newindex)=NaN;
      newindex=newindex+1;
      index=index-1;
    else 
      index=botindex-1; % exit for loop
    end
    index;
  end
%end


% below selects the temp, rh, det, and gam_wv variables below a 
% particular temperature threshold, tempthresh
botindex=1
newindex=1
index=72
while index > botindex
  if (temp(5).first(index) > tempthresh)
    temp_plot(5).first(newindex)=temp(5).first(index);
    rh_plot(5).first(newindex)=rh(5).first(index);
    det_plot(5).first(newindex)=delta_frac(5).first(index);
    gam_wv_plot(5).first(newindex)=gam_wv(5).first(index);
    temp_plot(5).first(newindex);
    index=index-1;
    newindex=newindex+1;
  else
    index=botindex-1; % exit for loop
  end
  index;
end
botindex=1
newindex=1
index=72
while index > botindex
  if (temp(5).second(index) > tempthresh)
    temp_plot(5).second(newindex)=temp(5).second(index);
    rh_plot(5).second(newindex)=rh(5).second(index);
    det_plot(5).second(newindex)=delta_frac(5).second(index);
    gam_wv_plot(5).second(newindex)=gam_wv(5).second(index);
    index=index-1;
    newindex=newindex+1;
  else
    index=botindex-1; % exit for loop
  end
  index;
end
botindex=1
newindex=1
index=72
while index > botindex
  if (temp(5).third(index) > tempthresh)
    temp_plot(5).third(newindex)=temp(5).third(index);
    rh_plot(5).third(newindex)=rh(5).third(index);
    det_plot(5).third(newindex)=delta_frac(5).third(index);
    gam_wv_plot(5).third(newindex)=gam_wv(5).third(index);
    index=index-1;
    newindex=newindex+1;
  else
    index=botindex-1; % exit for loop
  end
  index;
end

% calculate and store the mean tropospheric humidity
clear rh_trop_mn;
mindex=22;
for mi=1:mindex;
  rh_trop_mean=nanmean(rh_trop(mi).first)
  rh_trop_mn(mi).first=rh_trop_mean
  rh_mn_trop_first(mi)=rh_trop_mean
  rh_trop_mean=nanmean(rh_trop(mi).second)
  rh_trop_mn(mi).second=rh_trop_mean
  rh_mn_trop_second(mi)=rh_trop_mean
  rh_trop_mean=nanmean(rh_trop(mi).third)
  rh_trop_mn(mi).third=rh_trop_mean
  rh_mn_trop_third(mi)=rh_trop_mean
end

%-------------------------------------------------------------------y
% below is code for figures and figures only....
%-------------------------------------------------------------------y

%% scatter plot of omega_db and mean RH 
figure9=figure
scatter(CircSF295.omega_db(GCM_cs),rh_mn_trop_first(mnum_gcm_cs),[],colGCM(GCM_cs,:),'filled','o','SizeData',70)
hold on
scatter(CircSF300.omega_db(GCM_cs),rh_mn_trop_second(mnum_gcm_cs),[],colGCM(GCM_cs,:),'filled','o','SizeData',120)
scatter(CircSF305.omega_db(GCM_cs),rh_mn_trop_third(mnum_gcm_cs),[],colGCM(GCM_cs,:),'filled','o','SizeData',170)
scatter(abs(Circ_omega_CRMs_295.omega_db(CRM_cs)),rh_mn_trop_first(mnum_crm_cs),[],colCRM(CRM_cs,:),'filled','h','SizeData',120)
scatter(abs(Circ_omega_CRMs_300.omega_db(CRM_cs)),rh_mn_trop_second(mnum_crm_cs),[],colCRM(CRM_cs,:),'filled','h','SizeData',170)
scatter(abs(Circ_omega_CRMs_305.omega_db(CRM_cs)),rh_mn_trop_third(mnum_crm_cs),[],colCRM(CRM_cs,:),'filled','h','SizeData',220)
ylabel('mean RH')
xlabel('\omega_{db}')
set(gca,'FontWeight','bold')

% RH vs. I 
figure9=figure
scatter(CircSF295.I(GCM_cs),rh_mn_trop_first(mnum_gcm_cs),[],colGCM(GCM_cs,:),'filled','o','SizeData',70)
hold on
scatter(CircSF300.I(GCM_cs),rh_mn_trop_second(mnum_gcm_cs),[],colGCM(GCM_cs,:),'filled','o','SizeData',120)
scatter(CircSF305.I(GCM_cs),rh_mn_trop_third(mnum_gcm_cs),[],colGCM(GCM_cs,:),'filled','o','SizeData',170)
scatter(abs(Circ_omega_CRMs_295.I(CRM_cs)),rh_mn_trop_first(mnum_crm_cs),[],colCRM(CRM_cs,:),'filled','h','SizeData',120)
scatter(abs(Circ_omega_CRMs_300.I(CRM_cs)),rh_mn_trop_second(mnum_crm_cs),[],colCRM(CRM_cs,:),'filled','h','SizeData',170)
scatter(abs(Circ_omega_CRMs_305.I(CRM_cs)),rh_mn_trop_third(mnum_crm_cs),[],colCRM(CRM_cs,:),'filled','h','SizeData',220)
ylabel('mean RH')
xlabel('I')
set(gca,'FontWeight','bold')

% RH vs Cycling Rate
figure9=figure
scatter(Cycle1(modelnum(mnum_gcm)),rh_mn_trop_first(mnum_gcm),[],col34(modelnum(mnum_gcm),:),'filled','o','SizeData',70)
hold on
scatter(Cycle2(modelnum(mnum_gcm)),rh_mn_trop_second(mnum_gcm),[],col34(modelnum(mnum_gcm),:),'filled','o','SizeData',120)
scatter(Cycle3(modelnum(mnum_gcm)),rh_mn_trop_third(mnum_gcm),[],col34(modelnum(mnum_gcm),:),'filled','o','SizeData',170)
scatter(Cycle1(modelnum(mnum_crm)),rh_mn_trop_first(mnum_crm),[],col34(modelnum(mnum_crm),:),'filled','h','SizeData',120)
scatter(Cycle2(modelnum(mnum_crm)),rh_mn_trop_second(mnum_crm),[],col34(modelnum(mnum_crm),:),'filled','h','SizeData',170)
scatter(Cycle3(modelnum(mnum_crm)),rh_mn_trop_third(mnum_crm),[],col34(modelnum(mnum_crm),:),'filled','h','SizeData',220)
ylabel('mean RH')
xlabel('Cycle WV')
set(gca,'FontWeight','bold')

% RH vs mean omega up
figure9=figure
scatter(abs(CircSF295.omega_up(GCM_num)),rh_mn_trop_first(mnum_gcm),[],col34(modelnum(mnum_gcm),:),'filled','o','SizeData',70)
hold on
scatter(abs(CircSF300.omega_up(GCM_num)),rh_mn_trop_second(mnum_gcm),[],col34(modelnum(mnum_gcm),:),'filled','o','SizeData',120)
scatter(abs(CircSF305.omega_up(GCM_num)),rh_mn_trop_third(mnum_gcm),[],col34(modelnum(mnum_gcm),:),'filled','o','SizeData',170)
scatter(Circ_omega_CRMs_295.omega_up(CRM_num),rh_mn_trop_first(mnum_crm),[],col34(modelnum(mnum_crm),:),'filled','h','SizeData',120)
scatter(Circ_omega_CRMs_300.omega_up(CRM_num),rh_mn_trop_second(mnum_crm),[],col34(modelnum(mnum_crm),:),'filled','h','SizeData',170)
scatter(Circ_omega_CRMs_305.omega_up(CRM_num),rh_mn_trop_third(mnum_crm),[],col34(modelnum(mnum_crm),:),'filled','h','SizeData',220)
ylabel('mean RH')
xlabel('omega up')
set(gca,'FontWeight','bold')

%% sigma vs mean omega up anomalies
%figure9=figure
%scatter(abs(CircSF295.omega_up(GCM_num))-abs(CircSF300.omega_up(GCM_num)),CircSF295.sig_mn(GCM_num),[],col34(modelnum(mnum_gcm),:),'filled','o','SizeData',70)
%hold on
%scatter(abs(CircSF300.omega_up(GCM_num))-abs(CircSF300.omega_up(GCM_num)),CircSF300.sig_mn(GCM_num),[],col34(modelnum(mnum_gcm),:),'filled','o','SizeData',120)
%scatter(abs(CircSF305.omega_up(GCM_num))-abs(CircSF300.omega_up(GCM_num)),CircSF305.sig_mn(GCM_num),[],col34(modelnum(mnum_gcm),:),'filled','o','SizeData',170)
%scatter(Circ_omega_CRMs_295.omega_up(CRM_num)-Circ_omega_CRMs_300.omega_up(CRM_num),Circ_omega_CRMs_295.sig_mn(CRM_num),[],col34(modelnum(mnum_crm),:),'filled','h','SizeData',120)
%scatter(Circ_omega_CRMs_300.omega_up(CRM_num)-Circ_omega_CRMs_300.omega_up(CRM_num),Circ_omega_CRMs_300.sig_mn(CRM_num),[],col34(modelnum(mnum_crm),:),'filled','h','SizeData',170)
%scatter(Circ_omega_CRMs_305.omega_up(CRM_num)-Circ_omega_CRMs_300.omega_up(CRM_num),Circ_omega_CRMs_305.sig_mn(CRM_num),[],col34(modelnum(mnum_crm),:),'filled','h','SizeData',220)
%ylabel('mean sigma')
%xlabel('omega up')
%set(gca,'FontWeight','bold')

% sigma vs mean omega up
figure9=figure
scatter(abs(CircSF295.omega_up(GCM_num)),CircSF295.sig_mn(GCM_num)-CircSF300.sig_mn(GCM_num),[],col34(modelnum(mnum_gcm),:),'filled','o','SizeData',70)
hold on
scatter(abs(CircSF300.omega_up(GCM_num)),CircSF300.sig_mn(GCM_num)-CircSF300.sig_mn(GCM_num),[],col34(modelnum(mnum_gcm),:),'filled','o','SizeData',120)
scatter(abs(CircSF305.omega_up(GCM_num)),CircSF305.sig_mn(GCM_num)-CircSF300.sig_mn(GCM_num),[],col34(modelnum(mnum_gcm),:),'filled','o','SizeData',170)
scatter(Circ_omega_CRMs_295.omega_up(CRM_num),Circ_omega_CRMs_295.sig_mn(CRM_num)-Circ_omega_CRMs_300.sig_mn(CRM_num),[],col34(modelnum(mnum_crm),:),'filled','h','SizeData',120)
scatter(Circ_omega_CRMs_300.omega_up(CRM_num),Circ_omega_CRMs_300.sig_mn(CRM_num)-Circ_omega_CRMs_300.sig_mn(CRM_num),[],col34(modelnum(mnum_crm),:),'filled','h','SizeData',170)
scatter(Circ_omega_CRMs_305.omega_up(CRM_num),Circ_omega_CRMs_305.sig_mn(CRM_num)-Circ_omega_CRMs_300.sig_mn(CRM_num),[],col34(modelnum(mnum_crm),:),'filled','h','SizeData',220)
ylabel('mean sigma')
xlabel('omega up')
set(gca,'FontWeight','bold')

% P vs Cycling Rate
figure9=figure
scatter(Cycle1(modelnum(mnum_gcm)),Table295K.Precip(modelnum(mnum_gcm)),[],col34(modelnum(mnum_gcm),:),'filled','o','SizeData',70)
hold on
scatter(Cycle2(modelnum(mnum_gcm)),Table300K.Precip(modelnum(mnum_gcm)),[],col34(modelnum(mnum_gcm),:),'filled','o','SizeData',120)
scatter(Cycle3(modelnum(mnum_gcm)),Table305K.Precip(modelnum(mnum_gcm)),[],col34(modelnum(mnum_gcm),:),'filled','o','SizeData',170)
scatter(Cycle1(modelnum(mnum_crm)),Table295K.Precip(modelnum(mnum_crm)),[],col34(modelnum(mnum_crm),:),'filled','h','SizeData',120)
scatter(Cycle2(modelnum(mnum_crm)),Table300K.Precip(modelnum(mnum_crm)),[],col34(modelnum(mnum_crm),:),'filled','h','SizeData',170)
scatter(Cycle3(modelnum(mnum_crm)),Table305K.Precip(modelnum(mnum_crm)),[],col34(modelnum(mnum_crm),:),'filled','h','SizeData',220)
ylabel('mean P')
xlabel('Cycle WV')
set(gca,'FontWeight','bold')

% PW vs Cycling Rate
figure9=figure
scatter(Cycle1(modelnum(mnum_gcm)),1./Table295K.PW(modelnum(mnum_gcm)),[],col34(modelnum(mnum_gcm),:),'filled','o','SizeData',70)
hold on
scatter(Cycle2(modelnum(mnum_gcm)),1./Table300K.PW(modelnum(mnum_gcm)),[],col34(modelnum(mnum_gcm),:),'filled','o','SizeData',120)
scatter(Cycle3(modelnum(mnum_gcm)),1./Table305K.PW(modelnum(mnum_gcm)),[],col34(modelnum(mnum_gcm),:),'filled','o','SizeData',170)
scatter(Cycle1(modelnum(mnum_crm)),1./Table295K.PW(modelnum(mnum_crm)),[],col34(modelnum(mnum_crm),:),'filled','h','SizeData',120)
scatter(Cycle2(modelnum(mnum_crm)),1./Table300K.PW(modelnum(mnum_crm)),[],col34(modelnum(mnum_crm),:),'filled','h','SizeData',170)
scatter(Cycle3(modelnum(mnum_crm)),1./Table305K.PW(modelnum(mnum_crm)),[],col34(modelnum(mnum_crm),:),'filled','h','SizeData',220)
ylabel('mean PW')
xlabel('Cycle WV')
set(gca,'FontWeight','bold')
%
%
%% begin profile plots
lowbound=300;
figure1=figure
subplot(2,3,1)
hold on
for mi=1:11
  plot(0.01.*rh_plot(mnum_crm(mi)).third,temp_plot(mnum_crm(mi)).third,'Color',col34(crm_num(mi),:),'LineWidth',2)
end
set(gca,'Ydir','reverse')
ylabel('$T \, (K)$','interpreter','latex','FontSize',14)
ylim([210 lowbound])
xlim([0 1])
xlabel('$RH$','interpreter','latex','FontSize',14)
set(gca,'FontWeight','bold')

subplot(2,3,2)
hold on
for mi=1:11
  plot(det_plot(mnum_crm(mi)).third,temp_plot(mnum_crm(mi)).third,'Color',col34(crm_num(mi),:),'LineWidth',2)
end
set(gca,'Ydir','reverse')
ylabel('$T \, (K)$','interpreter','latex','FontSize',14)
ylim([210 lowbound])
xlim([-2 0])
xlabel('$\delta \, (m^{-1})$','interpreter','latex','FontSize',14)
set(gca,'FontWeight','bold')

subplot(2,3,3)
hold on
for mi=1:11
  plot(gam_wv_plot(mnum_crm(mi)).third,temp_plot(mnum_crm(mi)).third,'Color',col34(crm_num(mi),:),'LineWidth',2)
end
set(gca,'Ydir','reverse')
ylim([210 lowbound])
xlim([-1.5 0])
ylabel('$T \, (K)$','interpreter','latex','FontSize',14)
%xlabel('wv lapse rate, (1/m)')
xlabel('$\gamma (m^{-1})$','interpreter','latex','FontSize',14)
set(gca,'FontWeight','bold')
%sgtitle('Sources and sinks of RH in CRMs at 305K','FontSize',16,'FontWeight','bold')

ypos=0.81;
xpos=0.13;
ydwn=0.5;
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
annotation(figure1,'textbox',...
    [xpos ypos-ydwn 0.0234171725932352 0.0761513353115727],...
    'String','(d)',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',16,...
    'FitBoxToText','off');
annotation(figure1,'textbox',...
    [xpos+0.29 ypos-ydwn 0.0234171725932352 0.0761513353115727],...
    'String','(e)',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',16,...
    'FitBoxToText','off');
annotation(figure1,'textbox',...
    [xpos+0.29+0.29 ypos-ydwn 0.0234171725932353 0.0761513353115727],...
    'String','(f)',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',16,...
    'FitBoxToText','off');

% GCMs
%figure2=figure
subplot(2,3,4)
hold on
for mi=1:10
  plot(0.01.*rh_plot(mnum_gcm(mi)).third,temp_plot(mnum_gcm(mi)).third,'Color',col34(gcm_num(mi),:),'LineWidth',2)
end
set(gca,'Ydir','reverse')
ylabel('$T \, (K)$','interpreter','latex','FontSize',14)
ylim([210 lowbound])
xlim([0 1])
xlabel('RH','interpreter','latex','FontSize',14)
set(gca,'FontWeight','bold')

subplot(2,3,5)
hold on
for mi=1:10
  plot(det_plot(mnum_gcm(mi)).third,temp_plot(mnum_gcm(mi)).third,'Color',col34(gcm_num(mi),:),'LineWidth',2)
end
set(gca,'Ydir','reverse')
ylabel('$T \, (K)$','interpreter','latex','FontSize',14)
ylim([210 lowbound])
xlim([-2 0])
xlabel('$\delta \, (m^{-1})$','interpreter','latex','FontSize',14)
set(gca,'FontWeight','bold')

subplot(2,3,6)
hold on
for mi=1:10
  plot(gam_wv_plot(mnum_gcm(mi)).third,temp_plot(mnum_gcm(mi)).third,'Color',col34(gcm_num(mi),:),'LineWidth',2)
end
set(gca,'Ydir','reverse')
ylim([210 lowbound])
xlim([-1.5 0])
ylabel('$T \, (K)$','interpreter','latex','FontSize',14)
xlabel('$\gamma \, (m^{-1})$','interpreter','latex','FontSize',14)
set(gca,'FontWeight','bold')
%sgtitle('Sources and sinks of RH in GCMs at 305K','FontSize',16,'FontWeight','bold')


% Below are plots for 295K simulations

lowbound=290;
figure2=figure
subplot(2,3,1)
hold on
for mi=1:11
  plot(0.01.*rh_plot(mnum_crm(mi)).first,temp_plot(mnum_crm(mi)).first,'Color',col34(crm_num(mi),:),'LineWidth',2)
end
set(gca,'Ydir','reverse')
ylabel('$T \, (K)$','interpreter','latex','FontSize',14)
ylim([210 lowbound])
xlim([0 1])
xlabel('$RH$','interpreter','latex','FontSize',14)
set(gca,'FontWeight','bold')

subplot(2,3,2)
hold on
for mi=1:11
  plot(det_plot(mnum_crm(mi)).first,temp_plot(mnum_crm(mi)).first,'Color',col34(crm_num(mi),:),'LineWidth',2)
end
set(gca,'Ydir','reverse')
ylabel('$T \, (K)$','interpreter','latex','FontSize',14)
ylim([210 lowbound])
xlim([-2 0])
xlabel('$\delta \, (m^{-1})$','interpreter','latex','FontSize',14)
set(gca,'FontWeight','bold')

subplot(2,3,3)
hold on
for mi=1:11
  plot(gam_wv_plot(mnum_crm(mi)).first,temp_plot(mnum_crm(mi)).first,'Color',col34(crm_num(mi),:),'LineWidth',2)
end
set(gca,'Ydir','reverse')
ylim([210 lowbound])
xlim([-1.5 0])
ylabel('$T \, (K)$','interpreter','latex','FontSize',14)
xlabel('$\gamma \, (m^{-1})$','interpreter','latex','FontSize',14)
set(gca,'FontWeight','bold')
%sgtitle('Sources and sinks of RH in CRMs at 295K','FontSize',16,'FontWeight','bold')

% GCMs
%figure
subplot(2,3,4)
hold on
for mi=1:10
  plot(0.01.*rh_plot(mnum_gcm(mi)).first,temp_plot(mnum_gcm(mi)).first,'Color',col34(gcm_num(mi),:),'LineWidth',2)
end
set(gca,'Ydir','reverse')
ylabel('$T \, (K)$','interpreter','latex','FontSize',14)
ylim([210 lowbound])
xlim([0 1])
xlabel('$RH $','interpreter','latex','FontSize',14)
set(gca,'FontWeight','bold')

subplot(2,3,5)
hold on
for mi=1:10
  plot(det_plot(mnum_gcm(mi)).first,temp_plot(mnum_gcm(mi)).first,'Color',col34(gcm_num(mi),:),'LineWidth',2)
end
set(gca,'Ydir','reverse')
ylabel('$T \, (K)$','interpreter','latex','FontSize',14)
ylim([210 lowbound])
xlim([-2 0])
xlabel('$\delta \, (m^{-1})$','interpreter','latex','FontSize',14)
set(gca,'FontWeight','bold')

subplot(2,3,6)
hold on
for mi=1:10
  plot(gam_wv_plot(mnum_gcm(mi)).first,temp_plot(mnum_gcm(mi)).first,'Color',col34(gcm_num(mi),:),'LineWidth',2)
end
set(gca,'Ydir','reverse')
ylim([210 lowbound])
xlim([-1.5 0])
ylabel('$T \, (K)$','interpreter','latex','FontSize',14)
xlabel('$\gamma \, (m^{-1})$','interpreter','latex','FontSize',14)
set(gca,'FontWeight','bold')
%sgtitle('Sources and sinks of RH in GCMs at 295K','FontSize',16,'FontWeight','bold')

annotation(figure2,'textbox',...
    [xpos ypos 0.0234171725932352 0.0761513353115727],...
    'String','(a)',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',16,...
    'FitBoxToText','off');
annotation(figure2,'textbox',...
    [xpos+0.29 ypos 0.0234171725932352 0.0761513353115727],...
    'String','(b)',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',16,...
    'FitBoxToText','off');
annotation(figure2,'textbox',...
    [xpos+0.29+0.29 ypos 0.0234171725932353 0.0761513353115727],...
    'String','(c)',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',16,...
    'FitBoxToText','off');
annotation(figure2,'textbox',...
    [xpos ypos-ydwn 0.0234171725932352 0.0761513353115727],...
    'String','(d)',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',16,...
    'FitBoxToText','off');
annotation(figure2,'textbox',...
    [xpos+0.29 ypos-ydwn 0.0234171725932352 0.0761513353115727],...
    'String','(e)',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',16,...
    'FitBoxToText','off');
annotation(figure2,'textbox',...
    [xpos+0.29+0.29 ypos-ydwn 0.0234171725932353 0.0761513353115727],...
    'String','(f)',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',16,...
    'FitBoxToText','off');

 
