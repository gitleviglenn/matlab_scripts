%-----------------------------------------------------------------------
% lapser_diff_driver.m
%
% driver to calculate adiabats, moist adiabats and the difference
% between them when a vertical mass weighted average is taken 
% between 300-700 hPa.
%
% trying to learn how to use 'structures' in matlab!!
%
% these scripts need to be called for this to work: 
%	openRCEprofiles
%	create_RCEMIP_colors
%
% calls the function lapser_diff.m
%
% levi silvers                                          july 2021
%-----------------------------------------------------------------------

source_m1a='~/data/RCEMIP/mn_profiles/CAM5-GCM_large295-profiles.nc';
source_m1b='~/data/RCEMIP/mn_profiles/CAM5-GCM_large300-profiles.nc';
source_m1c='~/data/RCEMIP/mn_profiles/CAM5-GCM_large305-profiles.nc';
source_m2a='~/data/RCEMIP/mn_profiles/CAM6-GCM_large295-profiles.nc';
source_m2b='~/data/RCEMIP/mn_profiles/CAM6-GCM_large300-profiles.nc';
source_m2c='~/data/RCEMIP/mn_profiles/CAM6-GCM_large305-profiles.nc';
source_m6a='~/data/RCEMIP/mn_profiles/ECHAM6-GCM_large295-profiles.nc';
source_m6b='~/data/RCEMIP/mn_profiles/ECHAM6-GCM_large300-profiles.nc';
source_m6c='~/data/RCEMIP/mn_profiles/ECHAM6-GCM_large305-profiles.nc';
source_m4a='~/data/RCEMIP/mn_profiles/CNRM-CM6_large295-profiles.nc';
source_m4b='~/data/RCEMIP/mn_profiles/CNRM-CM6_large300-profiles.nc';
source_m4c='~/data/RCEMIP/mn_profiles/CNRM-CM6_large305-profiles.nc';
source_m8a='~/data/RCEMIP/mn_profiles/GEOS-GCM_large295-profiles.nc';
source_m8b='~/data/RCEMIP/mn_profiles/GEOS-GCM_large300-profiles.nc';
source_m8c='~/data/RCEMIP/mn_profiles/GEOS-GCM_large305-profiles.nc';
source_m9a='~/data/RCEMIP/mn_profiles/ICON-GCM_large295-profiles.nc';
source_m9b='~/data/RCEMIP/mn_profiles/ICON-GCM_large300-profiles.nc';
source_m9c='~/data/RCEMIP/mn_profiles/ICON-GCM_large305-profiles.nc';
source_m10a='~/data/RCEMIP/mn_profiles/ICON-LEM-CRM_large295-profiles.nc';
source_m10b='~/data/RCEMIP/mn_profiles/ICON-LEM-CRM_large300-profiles.nc';
source_m10c='~/data/RCEMIP/mn_profiles/ICON-LEM-CRM_large305-profiles.nc';
source_m11a='~/data/RCEMIP/mn_profiles/ICON-NWP-CRM_large295-profiles.nc';
source_m11b='~/data/RCEMIP/mn_profiles/ICON-NWP-CRM_large300-profiles.nc';
source_m11c='~/data/RCEMIP/mn_profiles/ICON-NWP-CRM_large305-profiles.nc';
source_m12a='~/data/RCEMIP/mn_profiles/IPSL-CM6_large295-profiles.nc';
source_m12b='~/data/RCEMIP/mn_profiles/IPSL-CM6_large300-profiles.nc';
source_m12c='~/data/RCEMIP/mn_profiles/IPSL-CM6_large305-profiles.nc';
source_m16a='~/data/RCEMIP/mn_profiles/SAM0-UNICON_large295-profiles.nc';
source_m16b='~/data/RCEMIP/mn_profiles/SAM0-UNICON_large300-profiles.nc';
source_m16c='~/data/RCEMIP/mn_profiles/SAM0-UNICON_large305-profiles.nc';
source_m17a='~/data/RCEMIP/mn_profiles/SAM-CRM_large295-profiles.nc';
source_m17b='~/data/RCEMIP/mn_profiles/SAM-CRM_large300-profiles.nc';
source_m17c='~/data/RCEMIP/mn_profiles/SAM-CRM_large305-profiles.nc';
source_m19a='~/data/RCEMIP/mn_profiles/SCALE_large295-profiles.nc';
source_m19b='~/data/RCEMIP/mn_profiles/SCALE_large300-profiles.nc';
source_m19c='~/data/RCEMIP/mn_profiles/SCALE_large305-profiles.nc';
source_m20a='~/data/RCEMIP/mn_profiles/SP-CAM_large295-profiles.nc';
source_m20b='~/data/RCEMIP/mn_profiles/SP-CAM_large300-profiles.nc';
source_m20c='~/data/RCEMIP/mn_profiles/SP-CAM_large305-profiles.nc';
source_m21a='~/data/RCEMIP/mn_profiles/SPX-CAM_large295-profiles.nc';
source_m21b='~/data/RCEMIP/mn_profiles/SPX-CAM_large300-profiles.nc';
source_m21c='~/data/RCEMIP/mn_profiles/SPX-CAM_large305-profiles.nc';
%source_m22a='~/data/RCEMIP/mn_profiles/UCLA-CRM_large295-profiles.nc';
%source_m22b='~/data/RCEMIP/mn_profiles/UCLA-CRM_large300-profiles.nc';
%source_m22c='~/data/RCEMIP/mn_profiles/UCLA-CRM_large305-profiles.nc';
source_m23a='~/data/RCEMIP/mn_profiles/UKMO-GA7.1_large295-profiles.nc';
source_m23b='~/data/RCEMIP/mn_profiles/UKMO-GA7.1_large300-profiles.nc';
source_m23c='~/data/RCEMIP/mn_profiles/UKMO-GA7.1_large305-profiles.nc';

mindex=11;
% GCMs
%modelnum=[1 2 4 6 8 9 12 16 20 21 23];
modelnum=[1 2 4 6 8 9 12 16 21 20 23];
for mi=1:mindex;
  indexm =modelnum(mi)
  source=['source_m' num2str(indexm) 'a']; % SST of 295K
  rh(mi).first  = ncread(eval(source),'hur_avg');
  pres(mi).first   = ncread(eval(source),'pa_avg');
  temp(mi).first   = ncread(eval(source),'ta_avg');
  zg(mi).first    = ncread(eval(source),'z_avg');
  cldfr(mi).first = ncread(eval(source),'cldfrac_avg');
  source=['source_m' num2str(indexm) 'b']; % SST of 300K
  rh(mi).second = ncread(eval(source),'hur_avg');
  pres(mi).second   = ncread(eval(source),'pa_avg');
  temp(mi).second   = ncread(eval(source),'ta_avg');
  zg(mi).second    = ncread(eval(source),'z_avg');
  cldfr(mi).second = ncread(eval(source),'cldfrac_avg');
  source=['source_m' num2str(indexm) 'c']; % SST of 305K
  rh(mi).third = ncread(eval(source),'hur_avg');
  pres(mi).third   = ncread(eval(source),'pa_avg');
  temp(mi).third   = ncread(eval(source),'ta_avg');
  zg(mi).third    = ncread(eval(source),'z_avg');
  cldfr(mi).third = ncread(eval(source),'cldfrac_avg');
end

% mindy?

% there is a code for a figure of the lapse rate profiles within 
% lapser_diff.m; default is to have figure commented out...
%mindex=16;
for mi=1:mindex;
  % A -> 295K; B -> 300K; C -> 305K
  string=[Table295K.Model(modelnum(mi)) 'SST=295K'];
  [A(mi).gam,A(mi).mgam,A(mi).diffgam,A(mi).gam_prof,A(mi).mgam_prof]=lapser_diff(temp(mi).first,pres(mi).first,string);
  string=[Table300K.Model(modelnum(mi)) 'SST=300K']
  size(pres(mi).second)
  [B(mi).gam,B(mi).mgam,B(mi).diffgam,B(mi).gam_prof,B(mi).mgam_prof]=lapser_diff(temp(mi).second,pres(mi).second,string);
  B(mi).press=pres(mi).second;
  string=[Table305K.Model(modelnum(mi)) 'SST=305K'];
  [C(mi).gam,C(mi).mgam,C(mi).diffgam,C(mi).gam_prof,C(mi).mgam_prof]=lapser_diff(temp(mi).third,pres(mi).third,string);
end

% CRMs
mindex=4; % UCLA has an issue with the pressure values 
%modelnum=[10 11 17 19];
modelnum=[17 19 10 11];
for mi=1:mindex;
  indexm =modelnum(mi)
  source=['source_m' num2str(indexm) 'a']; % SST of 295K
  rh(mi).first  = ncread(eval(source),'hur_avg');
  pres(mi).first   = ncread(eval(source),'pa_avg');
  temp(mi).first   = ncread(eval(source),'ta_avg');
  zg(mi).first    = ncread(eval(source),'z_avg');
  cldfr(mi).first = ncread(eval(source),'cldfrac_avg');
  source=['source_m' num2str(indexm) 'b']; % SST of 300K
  rh(mi).second = ncread(eval(source),'hur_avg');
  pres(mi).second   = ncread(eval(source),'pa_avg');
  temp(mi).second   = ncread(eval(source),'ta_avg');
  zg(mi).second    = ncread(eval(source),'z_avg');
  cldfr(mi).second = ncread(eval(source),'cldfrac_avg');
  source=['source_m' num2str(indexm) 'c']; % SST of 305K
  rh(mi).third = ncread(eval(source),'hur_avg');
  pres(mi).third   = ncread(eval(source),'pa_avg');
  temp(mi).third   = ncread(eval(source),'ta_avg');
  zg(mi).third    = ncread(eval(source),'z_avg');
  cldfr(mi).third = ncread(eval(source),'cldfrac_avg');
end
for mi=1:mindex;
  % A -> 295K; B -> 300K; C -> 305K
  string=[Table295K.Model(modelnum(mi)) 'SST=295K'];
  [A_CRM(mi).gam,A_CRM(mi).mgam,A_CRM(mi).diffgam,A_CRM(mi).gam_prof,A_CRM(mi).mgam_prof]=lapser_diff(temp(mi).first,pres(mi).first,string);
  A_CRM(mi).press=pres(mi).first;
  string=[Table300K.Model(modelnum(mi)) 'SST=300K']
  size(pres(mi).second)
  [B_CRM(mi).gam,B_CRM(mi).mgam,B_CRM(mi).diffgam,B_CRM(mi).gam_prof,B_CRM(mi).mgam_prof]=lapser_diff(temp(mi).second,pres(mi).second,string);
  B_CRM(mi).press=pres(mi).second;
  string=[Table305K.Model(modelnum(mi)) 'SST=305K'];
  [C_CRM(mi).gam,C_CRM(mi).mgam,C_CRM(mi).diffgam,C_CRM(mi).gam_prof,C_CRM(mi).mgam_prof]=lapser_diff(temp(mi).third,pres(mi).third,string);
  C_CRM(mi).press=pres(mi).third;
end

% analysis below is for GCMs so the mindex is set back to 11
mindex=11;

gam_scatter=zeros(33,1);
mgam_scatter_A=zeros(1,11);
mgam_scatter_B=zeros(1,11);
mgam_scatter_C=zeros(1,11);
dgam_scatter=zeros(1,11)-9.8;

yax=linspace(1,11,11);

for mi=1:mindex
  mgam_scatter_A(mi)=A(mi).mgam;
  mgam_scatter_B(mi)=B(mi).mgam;
  mgam_scatter_C(mi)=C(mi).mgam;
  gam_scatter_A(mi)=A(mi).gam;
  gam_scatter_B(mi)=B(mi).gam;
  gam_scatter_C(mi)=C(mi).gam;
  scat_A(mi)=mgam_scatter_A(mi)-mgam_scatter_B(mi);
  scat_B(mi)=mgam_scatter_B(mi)-mgam_scatter_B(mi);
  scat_C(mi)=mgam_scatter_C(mi)-mgam_scatter_B(mi);
  %gscat_A(mi)=gam_scatter_A(mi)-mgam_scatter_B(mi);
  %gscat_B(mi)=gam_scatter_B(mi)-mgam_scatter_B(mi);
  %gscat_C(mi)=gam_scatter_C(mi)-mgam_scatter_B(mi);
  gscat_A(mi)=gam_scatter_A(mi)-scat_A(mi);
  gscat_B(mi)=gam_scatter_B(mi)-scat_B(mi);
  gscat_C(mi)=gam_scatter_C(mi)-scat_C(mi);
end

figure
scatter(mgam_scatter_A,yax,[],col,'filled','o','SizeData',70)
hold on
scatter(mgam_scatter_B,yax,[],col,'filled','o','SizeData',120)
scatter(mgam_scatter_C,yax,[],col,'filled','o','SizeData',170)

figure
scatter(scat_A,yax,[],col,'filled','o','SizeData',70)
hold on
scatter(gscat_A,yax,[],col,'filled','v','SizeData',70)
scatter(scat_B,yax,[],col,'filled','o','SizeData',120)
scatter(gscat_B,yax,[],col,'filled','v','SizeData',120)
scatter(scat_C,yax,[],col,'filled','o','SizeData',170)
scatter(gscat_C,yax,[],col,'filled','v','SizeData',170)

figure
scatter(mgam_scatter_A,yax,[],col,'filled','o','SizeData',70)
fig=gca;
hold on
scatter(gam_scatter_A,yax,[],col,'filled','v','SizeData',70)
scatter(mgam_scatter_B,yax,[],col,'filled','o','SizeData',120)
scatter(gam_scatter_B,yax,[],col,'filled','v','SizeData',120)
scatter(mgam_scatter_C,yax,[],col,'filled','o','SizeData',170)
scatter(gam_scatter_C,yax,[],col,'filled','v','SizeData',170)
scatter(dgam_scatter,yax,'k','filled','s','SizeData',120)
fig.FontSize = 14;
%fig.YTick([1 2 3 4 5 6 7 8 9 10 11])
%fig.YTickLabel(['one','two','three','four','five','six','seven','eight','nine','ten','eleven'])
%ylim([0 12])
set(gca,'YTick',[0 1 2 3 4 5 6 7 8 9 10 11 12])
set(gca,'YTickLabel',{'','CAM5','CAM6','CNRM','ECHAM','GEOS','ICON','IPSL','SAM0-UNICON','SPCAM','SPXCAM','UKMO',''})
%set(gca,'YTickLabel',{'CAM5','CAM6','CNRM','ECHAM','GEOS','ICON','IPSL','SAM0-UNICON','SPCAM','SPXCAM','UKMO'})
fig.FontWeight = 'bold';
xlabel('Lapse Rates, K/km')
title('Dry, Ambient, and Moist Lapse Rates')
%ylabel('models ')

% Sfc Enthalpy Flux vs. lapse rate
figure
scatter(mLR_a,mlhf_a+mshf_a,[],col,'filled','o','SizeData',70)
fig=gca;
hold on
scatter(mLR_b,mlhf_b+mshf_b,[],col,'filled','o','SizeData',120)
scatter(mLR_c,mlhf_c+mshf_c,[],col,'filled','o','SizeData',170)
fig.FontSize = 14;
fig.FontWeight = 'bold';
ylim([60 160])
xlim([-9 -5])
xlabel('Lapse Rate, K/km')
title('LR from sfc to TOA')
ylabel('Sfc Enthalpy Flux, W/m2')

figure
scatter(mgam_scatter_A,mlhf_a+mshf_a,[],col,'filled','o','SizeData',70)
fig=gca;
hold on
scatter(mgam_scatter_B,mlhf_b+mshf_b,[],col,'filled','o','SizeData',120)
scatter(mgam_scatter_C,mlhf_c+mshf_c,[],col,'filled','o','SizeData',170)
fig.FontSize = 14;
fig.FontWeight = 'bold';
ylim([60 160])
xlim([-9 -5])
xlabel('Lapse Rate, K/km')
title('LR between 300-700 hPa')
ylabel('Sfc Enthalpy Flux, W/m2')




