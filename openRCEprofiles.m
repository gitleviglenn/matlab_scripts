%-----------------------------------------------------------
% 
% opens domain mean profiles for an ensemble of models that 
% have run the RCEMIP experiments
%
% physical constants are defined in the create_RCEMIP_colors.m
% script
%
% when adding new models, the data needs to be imported via one of 
% the calls to the 'import' routines.  
% Then the mindex needs to be increased, and the 
% appropriate number needs to be added to 'modelnum' from the list of
% string labelled e.g. source_m27c

%
% levi silvers                         september 2021
%-----------------------------------------------------------

% call the script that defines the rgb colors to use
create_RCEMIP_colors

% physical constants:
grav      =9.81;
Rd        =287.;   % J/kg K gas constant for dry air 
Rv        =461.;   % J/(kg K) gas constant for water vapor
%latheat   =2.52e6; % J/kg latent heat of vaporization
latheat   =2.501e6; % J/kg latent heat of vaporization recommended by Wing et al. 2018
cpd       =1000.;  % J/kg K cp for dry air 
epsilon   =Rd/Rv;
psfc      =1015.0;
tsfc      =295;


% open Tables from Allison with profile mean statistics and save to structures
%--------------------------------------------------------------------------------------
% the scripts below create variables: Table295K, Table300K, and Table305K
openTable295K
openTable300K
openTable305K

% this requires the Tables txt files to be read into the tables variables Table*
LR295=Table295K.LapseRate;
LR300=Table300K.LapseRate;
LR305=Table305K.LapseRate;

LHF295=Table295K.LHF;
SHF295=Table295K.SHF;
LHF300=Table300K.LHF;
SHF300=Table300K.SHF;
LHF305=Table305K.LHF;
SHF305=Table305K.SHF;

%%bowen295=Table295K.LHF./Table295K.SHF;
%bowen295=LHF295./SHF295;
%bowen300=LHF300./SHF300;
%bowen305=LHF305./SHF305;
bowen295=SHF295./LHF295;
bowen300=SHF300./LHF300;
bowen305=SHF305./LHF305;
%---------------------------------------------------------------------------------------

% open Tables with data that has mostly been analyzed with ncl on casper.  this includes
% vertical profile data and information about omega, the diabatically driven omega and

% these three scripts import data from 10 GCMs
% data is read into variable structures: CircSF295...
% import old, probably instantaneous hourly averaged values:
%import_RCEMIP_table_10GCMs_L295
%import_RCEMIP_table_10GCMs_L300
%import_RCEMIP_table_10GCMs_L305
% import values averaged over chunks of 5 days.
import_RCEMIP_table_10GCMs_295_5d
import_RCEMIP_table_10GCMs_300_5d
import_RCEMIP_table_10GCMs_305_5d

% import data for 5 CRMs
% data is read into variable structures: Circ_omega_CRMs_295...
%import_RCEMIP_table_5CRMs_L295
%import_RCEMIP_table_5CRMs_L300
%import_RCEMIP_table_5CRMs_L305
import_RCEMIP_table_11CRMs_295_5d
import_RCEMIP_table_11CRMs_300_5d
import_RCEMIP_table_11CRMs_305_5d

SF295  =CircSF295.SF;
odn295 =CircSF295.omega_dn;
SF300  =CircSF300.SF;
odn300 =CircSF300.omega_dn;
SF305  =CircSF305.SF;
odn305 =CircSF305.omega_dn;
scaleI295=(1./(1-SF295)).*odn295;
scaleI300=(1./(1-SF300)).*odn300;
scaleI305=(1./(1-SF305)).*odn305;
% the subsidence fraction

%---------------------------------------------------------------------------------------
%CAM5                 col34 #1
source_m1a='~/data/RCEMIP/mn_profiles/CAM5-GCM_large295-profiles.nc';
source_m1b='~/data/RCEMIP/mn_profiles/CAM5-GCM_large300-profiles.nc';
source_m1c='~/data/RCEMIP/mn_profiles/CAM5-GCM_large305-profiles.nc';
%CAM6                 col34 #2
source_m2a='~/data/RCEMIP/mn_profiles/CAM6-GCM_large295-profiles.nc';
source_m2b='~/data/RCEMIP/mn_profiles/CAM6-GCM_large300-profiles.nc';
source_m2c='~/data/RCEMIP/mn_profiles/CAM6-GCM_large305-profiles.nc';
%CNRM                 col34 #4
source_m4a='~/data/RCEMIP/mn_profiles/CNRM-CM6_large295-profiles.nc';
source_m4b='~/data/RCEMIP/mn_profiles/CNRM-CM6_large300-profiles.nc';
source_m4c='~/data/RCEMIP/mn_profiles/CNRM-CM6_large305-profiles.nc';
%ECHAM                col34 #6
source_m6a='~/data/RCEMIP/mn_profiles/ECHAM6-GCM_large295-profiles.nc';
source_m6b='~/data/RCEMIP/mn_profiles/ECHAM6-GCM_large300-profiles.nc';
source_m6c='~/data/RCEMIP/mn_profiles/ECHAM6-GCM_large305-profiles.nc';
%GEOS                 col34 #8
source_m8a='~/data/RCEMIP/mn_profiles/GEOS-GCM_large295-profiles.nc';
source_m8b='~/data/RCEMIP/mn_profiles/GEOS-GCM_large300-profiles.nc';
source_m8c='~/data/RCEMIP/mn_profiles/GEOS-GCM_large305-profiles.nc';
%ICON-GCM             col34 #9
source_m9a='~/data/RCEMIP/mn_profiles/ICON-GCM_large295-profiles.nc';
source_m9b='~/data/RCEMIP/mn_profiles/ICON-GCM_large300-profiles.nc';
source_m9c='~/data/RCEMIP/mn_profiles/ICON-GCM_large305-profiles.nc';
%ICON-LEM-CRM         col34 #10
source_m10a='~/data/RCEMIP/mn_profiles/ICON-LEM-CRM_large295-profiles.nc';
source_m10b='~/data/RCEMIP/mn_profiles/ICON-LEM-CRM_large300-profiles.nc';
source_m10c='~/data/RCEMIP/mn_profiles/ICON-LEM-CRM_large305-profiles.nc';
%ICON-NWP-CRM         col34 #11
source_m11a='~/data/RCEMIP/mn_profiles/ICON-NWP-CRM_large295-profiles.nc';
source_m11b='~/data/RCEMIP/mn_profiles/ICON-NWP-CRM_large300-profiles.nc';
source_m11c='~/data/RCEMIP/mn_profiles/ICON-NWP-CRM_large305-profiles.nc';
%IPSL                 col34 #12
source_m12a='~/data/RCEMIP/mn_profiles/IPSL-CM6_large295-profiles.nc';
source_m12b='~/data/RCEMIP/mn_profiles/IPSL-CM6_large300-profiles.nc';
source_m12c='~/data/RCEMIP/mn_profiles/IPSL-CM6_large305-profiles.nc';
%MESONH               col34 #13
source_m13a='~/data/RCEMIP/mn_profiles/MESONH_large295-profiles.nc';
source_m13b='~/data/RCEMIP/mn_profiles/MESONH_large300-profiles.nc';
source_m13c='~/data/RCEMIP/mn_profiles/MESONH_large305-profiles.nc';
%SAM0-UNICON          col34 #16
source_m16a='~/data/RCEMIP/mn_profiles/SAM0-UNICON_large295-profiles.nc';
source_m16b='~/data/RCEMIP/mn_profiles/SAM0-UNICON_large300-profiles.nc';
source_m16c='~/data/RCEMIP/mn_profiles/SAM0-UNICON_large305-profiles.nc';
%SAM-CRM              col34 #17
source_m17a='~/data/RCEMIP/mn_profiles/SAM-CRM_large295-profiles.nc';
source_m17b='~/data/RCEMIP/mn_profiles/SAM-CRM_large300-profiles.nc';
source_m17c='~/data/RCEMIP/mn_profiles/SAM-CRM_large305-profiles.nc';
%SCALE                col34 #19
source_m19a='~/data/RCEMIP/mn_profiles/SCALE_large295-profiles.nc';
source_m19b='~/data/RCEMIP/mn_profiles/SCALE_large300-profiles.nc';
source_m19c='~/data/RCEMIP/mn_profiles/SCALE_large305-profiles.nc';
%SP-CAM               col34 #20
source_m20a='~/data/RCEMIP/mn_profiles/SP-CAM_large295-profiles.nc';
source_m20b='~/data/RCEMIP/mn_profiles/SP-CAM_large300-profiles.nc';
source_m20c='~/data/RCEMIP/mn_profiles/SP-CAM_large305-profiles.nc';
%SPX-CAM              col34 #21
source_m21a='~/data/RCEMIP/mn_profiles/SPX-CAM_large295-profiles.nc';
source_m21b='~/data/RCEMIP/mn_profiles/SPX-CAM_large300-profiles.nc';
source_m21c='~/data/RCEMIP/mn_profiles/SPX-CAM_large305-profiles.nc';
%UCLA-CRM             col34 #22
source_m22a='~/data/RCEMIP/mn_profiles/UCLA-CRM_large295-profiles.nc';
source_m22b='~/data/RCEMIP/mn_profiles/UCLA-CRM_large300-profiles.nc';
source_m22c='~/data/RCEMIP/mn_profiles/UCLA-CRM_large305-profiles.nc';
%UKMO-GA7             col34 #23
source_m23a='~/data/RCEMIP/mn_profiles/UKMO-GA7.1_large295-profiles.nc';
source_m23b='~/data/RCEMIP/mn_profiles/UKMO-GA7.1_large300-profiles.nc';
source_m23c='~/data/RCEMIP/mn_profiles/UKMO-GA7.1_large305-profiles.nc';
%UKMO-CASIM           col34 #24
source_m24a='~/data/RCEMIP/mn_profiles/UKMO-CASIM_large295-profiles.nc';
source_m24b='~/data/RCEMIP/mn_profiles/UKMO-CASIM_large300-profiles.nc';
source_m24c='~/data/RCEMIP/mn_profiles/UKMO-CASIM_large305-profiles.nc';
%UKMO-RA1-T           col34 #25
source_m25a='~/data/RCEMIP/mn_profiles/UKMO-RA1-T_large295-profiles.nc';
source_m25b='~/data/RCEMIP/mn_profiles/UKMO-RA1-T_large300-profiles.nc';
source_m25c='~/data/RCEMIP/mn_profiles/UKMO-RA1-T_large305-profiles.nc';
%UKMO-RA1-T-nocloud   col34 #26
source_m26a='~/data/RCEMIP/mn_profiles/UKMO-RA1-T-nocloud_large295-profiles.nc';
source_m26b='~/data/RCEMIP/mn_profiles/UKMO-RA1-T-nocloud_large300-profiles.nc';
source_m26c='~/data/RCEMIP/mn_profiles/UKMO-RA1-T-nocloud_large305-profiles.nc';
%WRF-COL-CRM          col34 #27
source_m27a='~/data/RCEMIP/mn_profiles/WRF-COL-CRM_large295-profiles.nc';
source_m27b='~/data/RCEMIP/mn_profiles/WRF-COL-CRM_large300-profiles.nc';
source_m27c='~/data/RCEMIP/mn_profiles/WRF-COL-CRM_large305-profiles.nc';
%WRF-CRM              col34 #28
source_m28a='~/data/RCEMIP/mn_profiles/WRF-CRM_large295-profiles.nc';
source_m28b='~/data/RCEMIP/mn_profiles/WRF-CRM_large300-profiles.nc';
source_m28c='~/data/RCEMIP/mn_profiles/WRF-CRM_large305-profiles.nc';

% 5 variables; 3 SSTs; 11 models...
%vararray=["pa_avg","hur_avg","cldfrac_avg","z_avg","ta_avg"];

pa.m1a   =ncread(source_m1a,'pa_avg');
hur.m1a  =ncread(source_m1a,'hur_avg');
cldf.m1a =ncread(source_m1a,'cldfrac_avg');
z.m1a    =ncread(source_m1a,'z_avg');
ta.m1a   =ncread(source_m1a,'ta_avg');

%pa(1).m1   =ncread(source_m1a,'pa_avg');
%hur.m1(1)  =ncread(source_m1a,'hur_avg');
%cldf.m1(1) =ncread(source_m1a,'cldfrac_avg');
%z.m1(1)    =ncread(source_m1a,'z_avg');
%ta.m1(1)   =ncread(source_m1a,'ta_avg');
%pa(2).m1   =ncread(source_m1b,'pa_avg');
%hur.m1(2)  =ncread(source_m1b,'hur_avg');
%cldf.m1(2) =ncread(source_m1b,'cldfrac_avg');
%z.m1(2)    =ncread(source_m1b,'z_avg');
%ta.m1(2)   =ncread(source_m1b,'ta_avg');
%pa.m1(3)   =ncread(source_m1c,'pa_avg');
%hur.m1(3)  =ncread(source_m1c,'hur_avg');
%cldf.m1(3) =ncread(source_m1c,'cldfrac_avg');
%z.m1(3)    =ncread(source_m1c,'z_avg');
%ta.m1(3)   =ncread(source_m1c,'ta_avg');

% when adding new models, the mindex needs to be increased, and the 
% appropriate number needs to be added to 'modelnum' from the list of
% string labelled e.g. source_m27c

mindex=22;

%% indexing arrays moved to 'create_RCEMIP_colors.m'
%% match modelnum with col34
%modelnum      =[1 2 4 6 8 9 10 11 12 13 16 17 19 20 21 22 23 24 25 26 27 28]; % index numbers for col34 that are used in my study
%% modelnum(mnum_gcm) --> matches indices of gcms with colors in col34
%mnum_gcm     =[1 2 3 4 5 6 11 14 15 17]; % index numbers of modelnum for GCMs so modelnum(mnum_gcm)
%mnum_gcm_cs  =[1 2 3 5 11 14 15 17]; % index numbers of modelnum for GCMs so modelnum(mnum_gcm)
%% modelnum(mnum_crm) --> matches indices of crms with colors in col34
%mnum_crm     =[12 13 7 8 16 22 10 21 18 19 20]; % index numbers of modelnum for CRMs
%% the two WRF CRMs do not have clear sky fluxes
%mnum_crm_cs  =[12 13 7 8 16 10 18 19 20]; % index numbers of modelnum for CRMs

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

% paster here hasn't been updated in months...

ta.m1b   =ncread(source_m1b,'ta_avg');
ta.m1c   =ncread(source_m1c,'ta_avg');
pa.m1b   =ncread(source_m1b,'pa_avg');
hur.m1b  =ncread(source_m1b,'hur_avg');
pa.m1c   =ncread(source_m1c,'pa_avg');
hur.m1c  =ncread(source_m1c,'hur_avg');

pa.m2a   =ncread(source_m2a,'pa_avg');
hur.m2a  =ncread(source_m2a,'hur_avg');
cldf.m2a =ncread(source_m2a,'cldfrac_avg');
z.m2a    =ncread(source_m2a,'z_avg');
ta.m2a   =ncread(source_m2a,'ta_avg');
pa.m2b   =ncread(source_m2b,'pa_avg');
hur.m2b  =ncread(source_m2b,'hur_avg');
pa.m2c   =ncread(source_m2c,'pa_avg');
hur.m2c  =ncread(source_m2c,'hur_avg');

pa.m4a   =ncread(source_m4a,'pa_avg');
hur.m4a  =ncread(source_m4a,'hur_avg');
cldf.m4a =ncread(source_m4a,'cldfrac_avg');
z.m4a    =ncread(source_m4a,'z_avg');
ta.m4a   =ncread(source_m4a,'ta_avg');
pa.m4b   =ncread(source_m4b,'pa_avg');
hur.m4b  =ncread(source_m4b,'hur_avg');
pa.m4c   =ncread(source_m4c,'pa_avg');
hur.m4c  =ncread(source_m4c,'hur_avg');

% for model 6 the surface is at first index, 1
pa.m6a   =ncread(source_m6a,'pa_avg');
hur.m6a  =ncread(source_m6a,'hur_avg');
cldf.m6a =ncread(source_m6a,'cldfrac_avg');
z.m6a    =ncread(source_m6a,'z_avg');
ta.m6a   =ncread(source_m6a,'ta_avg');
pa.m6b   =ncread(source_m6b,'pa_avg');
hur.m6b  =ncread(source_m6b,'hur_avg');
pa.m6c   =ncread(source_m6c,'pa_avg');
hur.m6c  =ncread(source_m6c,'hur_avg');

% for model 8, GEOS the surface is at last index, 72
pa.m8a   =ncread(source_m8a,'pa_avg');
hur.m8a  =ncread(source_m8a,'hur_avg');
cldf.m8a =ncread(source_m8a,'cldfrac_avg');
z.m8a    =ncread(source_m8a,'z_avg');
ta.m8a   =ncread(source_m8a,'ta_avg');
pa.m8b   =ncread(source_m8b,'pa_avg');
hur.m8b  =ncread(source_m8b,'hur_avg');
pa.m8c   =ncread(source_m8c,'pa_avg');
hur.m8c  =ncread(source_m8c,'hur_avg');

% for model 9 the surface is at first index, 1
pa.m9a   =ncread(source_m9a,'pa_avg');
hur.m9a  =ncread(source_m9a,'hur_avg');
cldf.m9a =ncread(source_m9a,'cldfrac_avg');
z.m9a    =ncread(source_m9a,'z_avg');
ta.m9a   =ncread(source_m9a,'ta_avg');
pa.m9b   =ncread(source_m9b,'pa_avg');
hur.m9b  =ncread(source_m9b,'hur_avg');
pa.m9c   =ncread(source_m9c,'pa_avg');
hur.m9c  =ncread(source_m9c,'hur_avg');

% for model 12 the surface is at first index, 1
pa.m12a   =ncread(source_m12a,'pa_avg');
hur.m12a  =ncread(source_m12a,'hur_avg');
cldf.m12a =ncread(source_m12a,'cldfrac_avg');
cldf.m12b =ncread(source_m12b,'cldfrac_avg');
cldf.m12c =ncread(source_m12c,'cldfrac_avg');
z.m12a    =ncread(source_m12a,'z_avg');
ta.m12a   =ncread(source_m12a,'ta_avg');
pa.m12b   =ncread(source_m12b,'pa_avg');
hur.m12b  =ncread(source_m12b,'hur_avg');
pa.m12c   =ncread(source_m12c,'pa_avg');
hur.m12c  =ncread(source_m12c,'hur_avg');

% for model 16 the surface is at first index, 1
pa.m16a   =ncread(source_m16a,'pa_avg');
hur.m16a  =ncread(source_m16a,'hur_avg');
cldf.m16a =ncread(source_m16a,'cldfrac_avg');
z.m16a    =ncread(source_m16a,'z_avg');
ta.m16a   =ncread(source_m16a,'ta_avg');
pa.m16b   =ncread(source_m16b,'pa_avg');
hur.m16b  =ncread(source_m16b,'hur_avg');
pa.m16c   =ncread(source_m16c,'pa_avg');
hur.m16c  =ncread(source_m16c,'hur_avg');

% for model 20 the surface is at first index, 1
pa.m20a   =ncread(source_m20a,'pa_avg');
hur.m20a  =ncread(source_m20a,'hur_avg');
cldf.m20a =ncread(source_m20a,'cldfrac_avg');
z.m20a    =ncread(source_m20a,'z_avg');
ta.m20a   =ncread(source_m20a,'ta_avg');
pa.m20b   =ncread(source_m20b,'pa_avg');
hur.m20b  =ncread(source_m20b,'hur_avg');
pa.m20c   =ncread(source_m20c,'pa_avg');
hur.m20c  =ncread(source_m20c,'hur_avg');

% for model 21 the surface is at first index, 1
pa.m21a   =ncread(source_m21a,'pa_avg');
hur.m21a  =ncread(source_m21a,'hur_avg');
cldf.m21a =ncread(source_m21a,'cldfrac_avg');
z.m21a    =ncread(source_m21a,'z_avg');
ta.m21a   =ncread(source_m21a,'ta_avg');
pa.m21b   =ncread(source_m21b,'pa_avg');
hur.m21b  =ncread(source_m21b,'hur_avg');
pa.m21c   =ncread(source_m21c,'pa_avg');
hur.m21c  =ncread(source_m21c,'hur_avg');

% for model 23 the surface is at first index, 1
pa.m23a   =ncread(source_m23a,'pa_avg');
hur.m23a  =ncread(source_m23a,'hur_avg');
cldf.m23a =ncread(source_m23a,'cldfrac_avg');
z.m23a    =ncread(source_m23a,'z_avg');
ta.m23a   =ncread(source_m23a,'ta_avg');
pa.m23b   =ncread(source_m23b,'pa_avg');
hur.m23b  =ncread(source_m23b,'hur_avg');
pa.m23c   =ncread(source_m23c,'pa_avg');
hur.m23c  =ncread(source_m23c,'hur_avg');

%
%gamma   = zeros(m,n);
%gamma_m = zeros(m,n);
%estar   = zeros(m,n);
%qstar   = zeros(m,n);
%numer   = zeros(m,n);
%denom   = zeros(m,n);
%rho     = zeros(m,n);


%
hrmin_m1a=min(hur.m1a(5:16))
hrmin_m2a=min(hur.m2a(5:18))
hrmin_m4a=min(hur.m4a(5:40))
hrmin_m6a=min(hur.m6a(5:22))
hrmin_m8a=min(hur.m8a(42:65))
hrmin_m9a=min(hur.m9a(5:28))
hrmin_m12a=min(hur.m12a(5:32))
hrmin_m16a=min(hur.m16a(5:18))
hrmin_m20a=min(hur.m20a(5:14))
hrmin_m21a=min(hur.m21a(5:14))
hrmin_m23a=min(hur.m23a(5:42))

hrmin_m1b=min(hur.m1b(5:16))
hrmin_m2b=min(hur.m2b(5:18))
hrmin_m4b=min(hur.m4b(5:40))
hrmin_m6b=min(hur.m6b(5:22))
hrmin_m8b=min(hur.m8b(42:65))
hrmin_m9b=min(hur.m9b(5:28))
hrmin_m12b=min(hur.m12b(5:32))
hrmin_m16b=min(hur.m16b(5:18))
hrmin_m20b=min(hur.m20b(5:14))
hrmin_m21b=min(hur.m21b(5:14))
hrmin_m23b=min(hur.m23b(5:42))

hrmin_m1c=min(hur.m1c(5:16))
hrmin_m2c=min(hur.m2c(5:18))
hrmin_m4c=min(hur.m4c(5:40))
hrmin_m6c=min(hur.m6c(5:22))
hrmin_m8c=min(hur.m8c(42:65))
hrmin_m9c=min(hur.m9c(5:28))
hrmin_m12c=min(hur.m12c(5:32))
hrmin_m16c=min(hur.m16c(5:18))
hrmin_m20c=min(hur.m20c(5:14))
hrmin_m21c=min(hur.m21c(5:14))
hrmin_m23c=min(hur.m23c(5:42))
%%
%LR295=Table295K.LapseRate;
%LR300=Table300K.LapseRate;
%LR305=Table305K.LapseRate;
%%
%LHF295=Table295K.LHF;
%SHF295=Table295K.SHF;
%LHF300=Table300K.LHF;
%SHF300=Table300K.SHF;
%LHF305=Table305K.LHF;
%SHF305=Table305K.SHF;
%%
%bowen295=SHF295./LHF295;
%bowen300=SHF300./LHF300;
%bowen305=SHF305./LHF305;
%
%
sst_a=[295 295 295 295 295 295 295 295 295 295 295];
sst_b=[300 300 300 300 300 300 300 300 300 300 300];
sst_c=[305 305 305 305 305 305 305 305 305 305 305];
sst_10a=[295 295 295 295 295 295 295 295 295 295];
sst_10b=[300 300 300 300 300 300 300 300 300 300];
sst_10c=[305 305 305 305 305 305 305 305 305 305];
sst_5a=[295 295 295 295 295 295 295 295 295 295 295];
sst_5b=[300 300 300 300 300 300 300 300 300 300 300];
sst_5c=[305 305 305 305 305 305 305 305 305 305 305];
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








