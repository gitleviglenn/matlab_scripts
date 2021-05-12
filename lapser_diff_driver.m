%-----------------------------------------------------------------------
% lapser_diff_driver.m
%
% driver to calculate adiabats, moist adiabats and the difference
% between them when a vertical mass weighted average is taken 
% between 300-700 hPa.
%
% trying to learn how to use 'structures' in matlab!!
%
% calls the function lapser_diff.m
%
% levi silvers                                4-15-21
%-----------------------------------------------------------------------

source_m1a='~/Downloads/CAM5-GCM_large295-profiles.nc';
source_m1b='~/Downloads/CAM5-GCM_large300-profiles.nc';
source_m1c='~/Downloads/CAM5-GCM_large305-profiles.nc';
source_m2a='~/Downloads/CAM6-GCM_large295-profiles.nc';
source_m2b='~/Downloads/CAM6-GCM_large300-profiles.nc';
source_m2c='~/Downloads/CAM6-GCM_large305-profiles.nc';
source_m6a='~/Downloads/ECHAM6-GCM_large295-profiles.nc';
source_m6b='~/Downloads/ECHAM6-GCM_large300-profiles.nc';
source_m6c='~/Downloads/ECHAM6-GCM_large305-profiles.nc';
source_m4a='~/Downloads/CNRM-CM6_large295-profiles.nc';
source_m4b='~/Downloads/CNRM-CM6_large300-profiles.nc';
source_m4c='~/Downloads/CNRM-CM6_large305-profiles.nc';
source_m8a='~/Downloads/GEOS-GCM_large295-profiles.nc';
source_m8b='~/Downloads/GEOS-GCM_large300-profiles.nc';
source_m8c='~/Downloads/GEOS-GCM_large305-profiles.nc';
source_m9a='~/Downloads/ICON-GCM_large295-profiles.nc';
source_m9b='~/Downloads/ICON-GCM_large300-profiles.nc';
source_m9c='~/Downloads/ICON-GCM_large305-profiles.nc';
source_m12a='~/Downloads/IPSL-CM6_large295-profiles.nc';
source_m12b='~/Downloads/IPSL-CM6_large300-profiles.nc';
source_m12c='~/Downloads/IPSL-CM6_large305-profiles.nc';
source_m16a='~/Downloads/SAM0-UNICON_large295-profiles.nc';
source_m16b='~/Downloads/SAM0-UNICON_large300-profiles.nc';
source_m16c='~/Downloads/SAM0-UNICON_large305-profiles.nc';
source_m20a='~/Downloads/SP-CAM_large295-profiles.nc';
source_m20b='~/Downloads/SP-CAM_large300-profiles.nc';
source_m20c='~/Downloads/SP-CAM_large305-profiles.nc';
source_m21a='~/Downloads/SPX-CAM_large295-profiles.nc';
source_m21b='~/Downloads/SPX-CAM_large300-profiles.nc';
source_m21c='~/Downloads/SPX-CAM_large305-profiles.nc';
source_m23a='~/Downloads/UKMO-GA7.1_large295-profiles.nc';
source_m23b='~/Downloads/UKMO-GA7.1_large300-profiles.nc';
source_m23c='~/Downloads/UKMO-GA7.1_large305-profiles.nc';

mindex=11;
modelnum=[1 2 4 6 8 9 12 16 20 21 23];
for mi=1:mindex;
  %indexst=int2str(mi)
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
mindex=11;
for mi=1:mindex;
  % A -> 295K; B -> 300K; C -> 305K
  string=[Table295K.Model(modelnum(mi)) 'SST=295K'];
  [A(mi).gam,A(mi).mgam,A(mi).diffgam]=lapser_diff(temp(mi).first,pres(mi).first,string);
  string=[Table300K.Model(modelnum(mi)) 'SST=300K'];
  [B(mi).gam,B(mi).mgam,B(mi).diffgam]=lapser_diff(temp(mi).second,pres(mi).second,string);
  string=[Table305K.Model(modelnum(mi)) 'SST=305K'];
  [C(mi).gam,C(mi).mgam,C(mi).diffgam]=lapser_diff(temp(mi).third,pres(mi).third,string);
end

gam_scatter=zeros(33,1);
mgam_scatter_A=zeros(1,11);
mgam_scatter_B=zeros(1,11);
mgam_scatter_C=zeros(1,11);
dgam_scatter=zeros(1,11)-9.8;

yax=linspace(1,11,11);

for mi=1:mindex;
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




