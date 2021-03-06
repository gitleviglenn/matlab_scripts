%-------------------------------------------------------------------------------
% computes global mean radiative fluxes at toa 
%
% should be general enough to easily use with multiple experimens
%
% levi silvers                                              july 2018
%-------------------------------------------------------------------------------

%% needed: 
%% tref_ts, olr_clr_ts, swup_clr_ts, olr_ts, swdn_ts, swup_ts, lcloud_ts
%

%pathbase='/net2/Levi.Silvers/data/amip_long/';

% for DECK amip
%pathbase='/archive/oar.gfdl.cmip6/CM4/warsaw_201803/';
%path='/CM4_amip/gfdl.ncrc4-intel16-prod-openmp/pp/atmos_cmip/ts/monthly/36yr/';
% for amip plus 4K
%pathbase='/archive/Oar.Gfdl.Mgrp-account/CMIP6/CM4/CFMIP/warsaw_201803/';
%path='/amip-p4K-a/gfdl.ncrc4-intel-prod-openmp/pp/atmos_cmip/ts/monthly/36yr/';

timest=1;  % timest and timeend are used in readvars_radflux
if (do_aqua > 0)
  %aqua_hack = 1;
  timeend=120; % for aquaplanet experiments of 10 years
  years2='atmos_cmip.198001-198912'; % for aqua experiments
else
  aqua_hack = 0;
  timeend=432;
  years2='atmos_cmip.197901-201412'; % for amip experiments
end

%path='/c96L33_am4p0_longamip_1850rad/ts_all/';
% for DECK amip
%path='/CM4_amip/gfdl.ncrc4-intel16-prod-openmp/pp/atmos_cmip/ts/monthly/36yr/';
% for amip plus 4K
%path='/amip-p4K-a/gfdl.ncrc4-intel-prod-openmp/pp/atmos_cmip/ts/monthly/36yr/';

%years2='atmos_cmip.197901-201412'; % for amip experiments
%years2='atmos_cmip.198001-198912'; % for aqua experiments

cmip_format='true';

% call script to open files and read radiative flux data to variable arrays
readvars_radflux % this creates a timeseries of the global mean values
global_weights

%tindex=size(olr_ts,1);
tindex=timeend;
nyears=tindex/12;

if (aqua_hack < 1)
  tref_gmn_ts    =zeros(1,tindex);
else
  tref_aquap4k = tref_gmn_ts;
end
olr_gmn_ts     =zeros(1,tindex);
olr_clr_gmn_ts =zeros(1,tindex);
swdn_gmn_ts    =zeros(1,tindex);
swup_gmn_ts    =zeros(1,tindex);
swup_clr_gmn_ts=zeros(1,tindex);

for ti=1:tindex;

if (aqua_hack < 1)
  fullfield=squeeze(tref_ts(ti,:,:));
  global_wmean_quick;
  tref_gmn_ts(ti)=wgt_mean;
end

  fullfield=squeeze(olr_ts(ti,:,:));
  global_wmean_quick;
  olr_gmn_ts(ti)=wgt_mean;
  
  fullfield=squeeze(olr_clr_ts(ti,:,:));
  global_wmean_quick;
  olr_clr_gmn_ts(ti)=wgt_mean;

  fullfield=squeeze(swdn_ts(ti,:,:));
  global_wmean_quick;
  swdn_gmn_ts(ti)=wgt_mean;

  fullfield=squeeze(swup_clr_ts(ti,:,:));
  global_wmean_quick;
  swup_clr_gmn_ts(ti)=wgt_mean;
  
  fullfield=squeeze(swup_ts(ti,:,:));
  global_wmean_quick;
  swup_gmn_ts(ti)=wgt_mean;

end

clear monthsbyyears
monthsbyyears=reshape(tref_gmn_ts,[12 nyears]);
tref_yearlymean=mean(monthsbyyears,1);

monthsbyyears=reshape(olr_gmn_ts,[12 nyears]);
olr_yearlymean=mean(monthsbyyears,1);

monthsbyyears=reshape(olr_clr_gmn_ts,[12 nyears]);
olr_clr_yearlymean=mean(monthsbyyears,1);

mothsbyyears=reshape(swdn_gmn_ts,[12 nyears]);
swdn_yearlymean=mean(monthsbyyears,1);

monthsbyyears=reshape(swup_gmn_ts,[12 nyears]);
swup_yearlymean=mean(monthsbyyears,1);

monthsbyyears=reshape(swup_clr_gmn_ts,[12 nyears]);
swup_clr_yearlymean=mean(monthsbyyears,1);

% compute the net radiative flux
% these are the yearly mean timeseries
toa_R=swdn_yearlymean-swup_yearlymean-olr_yearlymean;
%toa_R_lw=-olr_yearlymean;
%toa_R_sw=swdn_yearlymean-swup_yearlymean;
toa_clr_R=swdn_yearlymean-swup_clr_yearlymean-olr_clr_yearlymean;
toa_cre_R=toa_clr_R-toa_R;
toa_lwcre=olr_clr_yearlymean-olr_yearlymean; % clear sky - all sky
toa_swcre=swup_clr_yearlymean-swup_yearlymean; 

% these are the monthly time series
% R_net is the net downwelling radiation, positive down
R_net=swdn_gmn_ts-swup_gmn_ts-olr_gmn_ts;
%clr_R=swdn_gmn_ts-swup_gmn_ts-olr_clr_gmn_ts;% mistake in swup?should be clr?
clr_R=swdn_gmn_ts-swup_clr_gmn_ts-olr_clr_gmn_ts;% mistake in swup?should be clr?
% CRE is the cloud radiative effect, usually clear sky minus all 
cre_net=clr_R-R_net;
lwcre=olr_clr_gmn_ts-olr_gmn_ts;
swcre=swup_clr_gmn_ts-swup_gmn_ts;

flux_array=zeros(1,7);

mnR    =mean(R_net)
mncre  =mean(cre_net)
mncrelw=mean(lwcre)
mncresw=mean(swcre)
mnclrlw=mean(olr_clr_gmn_ts)
mnclrsw=mean(swup_clr_gmn_ts)
if (aqua_hack < 1)
  mntas  =mean(tref_gmn_ts)
else
  mntas  =mean(tref_gmn_ts)+4.;
end

flux_array(1)=mnR;
flux_array(2)=mncre;
flux_array(3)=mncrelw;
flux_array(4)=mncresw;
flux_array(5)=mnclrlw; % sign should probably be flipped
flux_array(6)=mnclrsw;
flux_array(7)=mntas;
%flux_array(7)=mntas+4.;


