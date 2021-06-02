%-----------------------------------------------------------------------
% read surface fluxes from RCEMIP data
%
% use the sensible and latent heat fluxes to infer what the 
% proportionality factor is in the bulk surface flux schemes.
%
% levi silvers                                     april 2021
%-----------------------------------------------------------------------


%% These path sources are defined in openRCEprofiles.m which should be
%% run to initialize and prepare the RCEMIP matlab analysis
%source_m1a='~/data/RCEMIP/mn_profiles/CAM5-GCM_large295-profiles.nc';
%source_m1b='~/data/RCEMIP/mn_profiles/CAM5-GCM_large300-profiles.nc';
%source_m1c='~/data/RCEMIP/mn_profiles/CAM5-GCM_large305-profiles.nc';
%source_m2a='~/data/RCEMIP/mn_profiles/CAM6-GCM_large295-profiles.nc';
%source_m2b='~/data/RCEMIP/mn_profiles/CAM6-GCM_large300-profiles.nc';
%source_m2c='~/data/RCEMIP/mn_profiles/CAM6-GCM_large305-profiles.nc';
%source_m6a='~/data/RCEMIP/mn_profiles/ECHAM6-GCM_large295-profiles.nc';
%source_m6b='~/data/RCEMIP/mn_profiles/ECHAM6-GCM_large300-profiles.nc';
%source_m6c='~/data/RCEMIP/mn_profiles/ECHAM6-GCM_large305-profiles.nc';
%source_m4a='~/data/RCEMIP/mn_profiles/CNRM-CM6_large295-profiles.nc';
%source_m4b='~/data/RCEMIP/mn_profiles/CNRM-CM6_large300-profiles.nc';
%source_m4c='~/data/RCEMIP/mn_profiles/CNRM-CM6_large305-profiles.nc';
%source_m8a='~/data/RCEMIP/mn_profiles/GEOS-GCM_large295-profiles.nc';
%source_m8b='~/data/RCEMIP/mn_profiles/GEOS-GCM_large300-profiles.nc';
%source_m8c='~/data/RCEMIP/mn_profiles/GEOS-GCM_large305-profiles.nc';
%source_m9a='~/data/RCEMIP/mn_profiles/ICON-GCM_large295-profiles.nc';
%source_m9b='~/data/RCEMIP/mn_profiles/ICON-GCM_large300-profiles.nc';
%source_m9c='~/data/RCEMIP/mn_profiles/ICON-GCM_large305-profiles.nc';
%source_m12a='~/data/RCEMIP/mn_profiles/IPSL-CM6_large295-profiles.nc';
%source_m12b='~/data/RCEMIP/mn_profiles/IPSL-CM6_large300-profiles.nc';
%source_m12c='~/data/RCEMIP/mn_profiles/IPSL-CM6_large305-profiles.nc';
%source_m16a='~/data/RCEMIP/mn_profiles/SAM0-UNICON_large295-profiles.nc';
%source_m16b='~/data/RCEMIP/mn_profiles/SAM0-UNICON_large300-profiles.nc';
%source_m16c='~/data/RCEMIP/mn_profiles/SAM0-UNICON_large305-profiles.nc';
%source_m20a='~/data/RCEMIP/mn_profiles/SP-CAM_large295-profiles.nc';
%source_m20b='~/data/RCEMIP/mn_profiles/SP-CAM_large300-profiles.nc';
%source_m20c='~/data/RCEMIP/mn_profiles/SP-CAM_large305-profiles.nc';
%source_m21a='~/data/RCEMIP/mn_profiles/SPX-CAM_large295-profiles.nc';
%source_m21b='~/data/RCEMIP/mn_profiles/SPX-CAM_large300-profiles.nc';
%source_m21c='~/data/RCEMIP/mn_profiles/SPX-CAM_large305-profiles.nc';
%source_m23a='~/data/RCEMIP/mn_profiles/UKMO-GA7.1_large295-profiles.nc';
%source_m23b='~/data/RCEMIP/mn_profiles/UKMO-GA7.1_large300-profiles.nc';
%source_m23c='~/data/RCEMIP/mn_profiles/UKMO-GA7.1_large305-profiles.nc';


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

%% this requires the Tables txt files to be read into the tables variables Table*
%LR295=Table295K.LapseRate;
%LR300=Table300K.LapseRate;
%LR305=Table305K.LapseRate;
%
%LHF295=Table295K.LHF;
%SHF295=Table295K.SHF;
%LHF300=Table300K.LHF;
%SHF300=Table300K.SHF;
%LHF305=Table305K.LHF;
%SHF305=Table305K.SHF;
%
%%%bowen295=Table295K.LHF./Table295K.SHF;
%%bowen295=LHF295./SHF295;
%%bowen300=LHF300./SHF300;
%%bowen305=LHF305./SHF305;
%bowen295=SHF295./LHF295;
%bowen300=SHF300./LHF300;
%bowen305=SHF305./LHF305;

%% grab the particular models we want:
%mshf_a=[SHF295(1) SHF295(2) SHF295(4) SHF295(6) SHF295(8) SHF295(9) SHF295(12) SHF295(16) SHF295(20) SHF295(21) SHF295(23)];
%mlhf_a=[LHF295(1) LHF295(2) LHF295(4) LHF295(6) LHF295(8) LHF295(9) LHF295(12) LHF295(16) LHF295(20) LHF295(21) LHF295(23)];
%mBR_a=[bowen295(1) bowen295(2) bowen295(4) bowen295(6) bowen295(8) bowen295(9) bowen295(12) bowen295(16) bowen295(20) bowen295(21) bowen295(23)];

sst_a=[295 295 295 295 295 295 295 295 295 295 295]
sst_b=[300 300 300 300 300 300 300 300 300 300 300]
sst_c=[305 305 305 305 305 305 305 305 305 305 305]
%
%% grab the particular models we want:
hrmin_a=[hrmin_m1a hrmin_m2a hrmin_m4a hrmin_m6a hrmin_m8a hrmin_m9a hrmin_m12a hrmin_m16a hrmin_m20a hrmin_m21a hrmin_m23a];
mLR_a=[LR295(1) LR295(2) LR295(4) LR295(6) LR295(8) LR295(9) LR295(12) LR295(16) LR295(20) LR295(21) LR295(23)];
mshf_a=[SHF295(1) SHF295(2) SHF295(4) SHF295(6) SHF295(8) SHF295(9) SHF295(12) SHF295(16) SHF295(20) SHF295(21) SHF295(23)];
mlhf_a=[LHF295(1) LHF295(2) LHF295(4) LHF295(6) LHF295(8) LHF295(9) LHF295(12) LHF295(16) LHF295(20) LHF295(21) LHF295(23)];
mBR_a=[bowen295(1) bowen295(2) bowen295(4) bowen295(6) bowen295(8) bowen295(9) bowen295(12) bowen295(16) bowen295(20) bowen295(21) bowen295(23)];

hrmin_b=[hrmin_m1b hrmin_m2b hrmin_m4b hrmin_m6b hrmin_m8b hrmin_m9b hrmin_m12b hrmin_m16b hrmin_m20b hrmin_m21b hrmin_m23b];
mLR_b=[LR300(1) LR300(2) LR300(4) LR300(6) LR300(8) LR300(9) LR300(12) LR300(16) LR300(20) LR300(21) LR300(23)];
mshf_b=[SHF300(1) SHF300(2) SHF300(4) SHF300(6) SHF300(8) SHF300(9) SHF300(12) SHF300(16) SHF300(20) SHF300(21) SHF300(23)];
mlhf_b=[LHF300(1) LHF300(2) LHF300(4) LHF300(6) LHF300(8) LHF300(9) LHF300(12) LHF300(16) LHF300(20) LHF300(21) LHF300(23)];
mBR_b=[bowen300(1) bowen300(2) bowen300(4) bowen300(6) bowen300(8) bowen300(9) bowen300(12) bowen300(16) bowen300(20) bowen300(21) bowen300(23)];

hrmin_c=[hrmin_m1c hrmin_m2c hrmin_m4c hrmin_m6c hrmin_m8c hrmin_m9c hrmin_m12c hrmin_m16c hrmin_m20c hrmin_m21c hrmin_m23c];
mLR_c=[LR305(1) LR305(2) LR305(4) LR305(6) LR305(8) LR305(9) LR305(12) LR305(16) LR305(20) LR305(21) LR305(23)];
mlhf_c=[LHF305(1) LHF305(2) LHF305(4) LHF305(6) LHF305(8) LHF305(9) LHF305(12) LHF305(16) LHF305(20) LHF305(21) LHF305(23)];
mshf_c=[SHF305(1) SHF305(2) SHF305(4) SHF305(6) SHF305(8) SHF305(9) SHF305(12) SHF305(16) SHF305(20) SHF305(21) SHF305(23)];
mBR_c=[bowen305(1) bowen305(2) bowen305(4) bowen305(6) bowen305(8) bowen305(9) bowen305(12) bowen305(16) bowen305(20) bowen305(21) bowen305(23)];



%q0=qs(295K)
%propFac=(mshf_a/mLHF_a)*(q1-q0)/(t1-295.);
psfc=1014.80 %hPa  % specified in Wing et al., 2018

% calculate the saturation vapor pressure and the saturation mixing ratio's
% this assumes that the index '1' corresponds to the model level nearest the sfc.
esfc_a   = 611*exp((latheat/Rv)*(1/273-1/295.)); % Pa
esfc_b   = 611*exp((latheat/Rv)*(1/273-1/300.)); % Pa
esfc_c   = 611*exp((latheat/Rv)*(1/273-1/305.)); % Pa
qsfc_a   = epsilon*esfc_a/(100.*psfc);
qsfc_b   = epsilon*esfc_b/(100.*psfc);
qsfc_c   = epsilon*esfc_c/(100.*psfc);

mindex=11;
for mi=1:mindex;
  if mi == 5
    levi=72% model 5 has the vertical levels flipped
  else
    levi=1;
  end 
  es_a(mi)   = 611*exp((latheat/Rv)*(1/273-1/temp(mi).first(levi))); % Pa
  qs_a(mi)   = epsilon*es_a(mi)/(100.*pres(mi).first(levi));
  es_b(mi)   = 611*exp((latheat/Rv)*(1/273-1/temp(mi).second(levi))); % Pa
  qs_b(mi)   = epsilon*es_b(mi)/(100.*pres(mi).second(levi));
  es_c(mi)   = 611*exp((latheat/Rv)*(1/273-1/temp(mi).third(levi))); % Pa
  qs_c(mi)   = epsilon*es_c(mi)/(100.*pres(mi).third(levi));
  delT_a(mi)=295-temp(mi).first(levi);
  delT_b(mi)=300-temp(mi).second(levi);
  delT_c(mi)=305-temp(mi).third(levi);
  delq_a(mi)=qsfc_a-qs_a(mi);
  delq_b(mi)=qsfc_b-qs_b(mi);
  delq_c(mi)=qsfc_c-qs_c(mi);
end

fake_BR_a=(cpd/latheat)*(delT_a./delq_a);
fake_BR_b=(cpd/latheat)*(delT_b./delq_b);
fake_BR_c=(cpd/latheat)*(delT_c./delq_c);                                   

% height (m) of lowest model level for the 11 GCMs:
GCM_ll=[64,64,10,33,64,20,49,64,64,64,10];

% Tsfc = 295,300, and 305K
%qsfc = qs(Tsfc)
%qair = qs(Tair)

%delT=Tsfc-Tair
%delq=qsfc-qair

%m1a_tdiff  =temp(1).first(1)-295
%m1b_tdiff  =temp(1).second(1)-300
%m1c_tdiff  =temp(1).third(1)-305
%m2_tdiff  =temp(2).third(1)-305
%m3_tdiff  =temp(3).third(1)-305
%m4_tdiff  =temp(4).third(1)-305
%m5_tdiff  =temp(5).third(1)-305
%m6_tdiff  =temp(6).third(1)-305
%m7_tdiff  =temp(7).third(1)-305
%m8_tdiff  =temp(8).third(1)-305
%m9_tdiff  =temp(9).third(1)-305
%m10_tdiff =temp(10).third(1)-305
%m11_tdiff =temp(11).third(1)-305
