%------------------------------------------------------------------------------------------
% feedback_panel.m
%
% 1. read in variables from input files
% 2. compute cosine weighted global mean values
% 3. compute radiative flux at toa and temp diff pattern
% 4. compute feedbacks between two experiments
% 5. compute cloud radiative effects
% 6. compute zonal mean of feedbacks and cre's
% 7. normalize the feedbacks and zonal means
% 8. make figures
%         - zonal mean temp chng
%         - 4 panel plot of global temp change during 20 increments
%         - global mean patterns of cre
%         - zonal mean of cre, basic and normalized
%
% levi silvers                                        Apr 2016
%------------------------------------------------------------------------------------------

dirMing='/archive/Ming.Zhao/awglg/ulm/'; % directory for AM4OM2
%dirMing='/archive/Ming.Zhao/awg/ulm_201505/'; % directory for CM2.1
dirLevi='/archive/Levi.Silvers/awg/ulm_201505/';
basedir=dirMing;

%% Cess type experiments
%exp1name='c96L32_am4g5r11_2000climo_p2K/';
%exp2name='c96L32_am4g5r11_2000climo/';
%expyrs1='ts_all/atmos.000201-001112.';
%expyrs2='ts_all/atmos.000201-001112.';

%%% 1pct increase in CO2 experiment and control
%%% for CM4 model: 
exp1name='AM4OM2F_c96l32_am4g5r11_2000climo_1pct/ts_all/';
exp2name='AM4OM2F_c96l32_am4g5r11_2000climo/ts_all/';
expname='AM4OM2F'
expyrs1='atmos.006101-014012.';
expyrs2='atmos.000101-014012.';
modelname='Model: AM4OM2'
lengthyr=80; % length of time series in years
%latinc=30;
%sonic=1:latinc:180;
% it is possible to have time series of two different lengths
% depending on how the output from the forced vs control run was saved...
iend=960;
iend2=1680;
% endt is the end index for the time series that have been computed
% with a running mean of +/- 6 months so it is 13 months shorter
endt=947; % needs to be iend -1 year and one month
%%
%%%%% for CM2 model: 
%%exp1name='CM2.1U-D4_1PctTo2X_I1/ts_all/';
%%%exp2name='CM2.1U_Control-1990_E1/ts_all/';
%%exp2name='CM2.1U_Control-1860_D4/ts_all/';
%%expyrs1='atmos.000101-010012.';
%%expyrs2='atmos.000101-010012.';
%%modelname='Model: CM2'
%%% for time series 100 years in length:
%%lengthyr=100;
%%iend=1200;
%%iend2=1200; % istart2=iend2-iend+1; 
%%% endt is the end index for the time series that have been computed
%%% with a running mean of +/- 6 months so it is 13 months shorter
%%endt=1187;
%%%istart2=iend2-iend+1;
%%%latinc=15;
%%%sonic=1:latinc:90;
%%%%%% ------------------
%%%%% use below for coupled experiments
exp1=strcat(basedir,exp1name);
exp2=strcat(basedir,exp2name);
%%%%% pstart and pend define the period over which the feedbacks are computed
pstart=720;
%pend=1200;
pend=960;
iarr=[1 120 240 480 720 960];
%%% end coupled block
%%%

%% abrupt 4XCO2 forcing
%exp1name='AM4OM2F_c96l32_am4g5r11_1860climo_4xCO2/ts_all/';
%expyrs1='atmos.006101-015012.';

%%%% from ctl+sst pattern experiments
%%%----- Beginning of block for reg+pattern experiments
%%
%%x1name='c96L32_am4g6_1860climo_ctlpreg_1per_co2_weaker/';
%%modelname='Model: AM4 1860 sst patt 1Pcnt 80yrscale'
%modelname='Model: AM4 2000 sst patt 1Pcnt'
%x1name='c96L32_am4g6_2000climo_ctlpreg_1per_co2/';
%%modelname='Model: AM4 2000 sst patt 1Pcnt'
%%x1name='c96L32_am4g6_1860climo_ctlpreg_4co2/';
%%modelname='Model: AM4 sst patt 4XCO2'
%%x1name='c96L32_am4g6_1860climo_ctl_cess/';
%%modelname='Model: AM4 sst patt p2K'
%x2name='c96L32_am4g6_2000climo_ctl/';
%%x2name='c96L32_am4g6_1860climo_ctl/';
%addpath='gfdl.ncrc3-intel-prod-openmp/pp/atmos/ts/monthly/5yr/';
%years='000201-002112.';
%lengthyr=20; % length of time series in years
%%% it is possible to have time series of two different lengths
%%% depending on how the output from the forced vs control run was saved...
%iend=240;
%iend2=240;
%%% endt is the end index for the time series that have been computed
%%% with a running mean of +/- 6 months so it is 13 months shorter
%endt=227; % needs to be iend -1 year and one month
%
%% use below for reg + pattern experiments
%% pstart and pend define the period over which the feedbacks are computed
%pstart=1;
%pend=239;
%iarr=[1 10 60 120 180 240];
%%%----- End of block for reg+pattern experiments

%%% use below for Ming's cess experiment
%% am4g5r11 p2k  Cess Experiment
%basedir='/archive/Ming.Zhao/awglg/ulm/'
%modelname='Model: c96L32_am4g5r11_2000climo_p2K'
%x1name='c96L32_am4g5r11_2000climo_p2K/';
%x2name='c96L32_am4g5r11_2000climo/';
%addpath='/ts_all/';
%years='000201-001112.';
%lengthyr=10; % length of time series in years
%iend=120;
%iend2=120;
%%% endt is the end index for the time series that have been computed
%%% with a running mean of +/- 6 months so it is 13 months shorter
%endt=107; % needs to be iend -1 year and one month
%%%
%%%% use below for reg + pattern experiments
%%%%% pstart and pend define the period over which the feedbacks are computed
%%pstart=1;
%%pend=119;
%%iarr=[1 10 60 80 100 120];
%%%
%basedir='/archive/Levi.Silvers/awg/verona/'
%%%
%%% p2k  base: hadley center ice and sst
%%modelname='Model: c96L32_am4g10r8_2000climo_p2K'
%%expname='am4p2k'
%%x1name='c96L32_am4g10r8_2000climo_p2K/';
%%%
%%% 2000climo: hadley center ice and sst, ice thickness reduced from 2m to 1m
%modelname='Model: c96L32_am4g10r8_2000climo_1mice'
%expname='am4_p2K_1mice'
%x1name='c96L32_am4g10r8_2000climo_p2K_1mice/';
%%%
%%modelname='Model: c96L32_am4g10r8_2000climo_1mice'
%%expname='am4_1mice'
%%x1name='c96L32_am4g10r8_2000climo_1mice/';
%%
%%modelname='Model: c96L32_am4g10r8_qobs_2000climo'
%%expname='am4_qobs'
%%x1name='c96L32_am4g10r8_qobs_2000climo_p2K/';
%%%
%%%% sst: hadley center base+1%co2 patter      ice: hadley center
%%modelname='Model: c96L32_am4g10r8_haddsstp1pctco2_climo'
%%expname='am4co2sst1pct'
%%x1name='c96L32_am4g10r8_hadsstp1pctco2_climo/';
%%
%%%% sst: hadley center base+1%co2 patern      ice: hadley center base + 1%co2 patern
%%modelname='Model: c96L32_am4g10r8_haddicesstp1pctco2_climo'
%%x1name='c96L32_am4g10r8_hadsstp1pctco2_AM4OM2ice_climo/';
%%expname='am4co2icesst1pct'
%%
%% alternate, and probably correct, attempt on the 1pct pattern:
%%modelname='Model: c96L32_am4g10r8_had_p_1pctco2_climo'
%%x1name='c96L32_am4g10r8_had_p_1pctco2_climo';
%%expname='am4co21pct'
%%%
%%x2name='c96L32_am4g10r8_2000climo_p2K/';
%x2name='c96L32_am4g10r8_2000climo/';
%%x2name='c96L32_am4g10r8_qobs_2000climo/';
%addpath='/ts_all/';
%years='000201-001112.';
%%%%% use below for reg + pattern experiments
%%%%%% pstart and pend define the period over which the feedbacks are computed
%lengthyr=10; % length of time series in years
%iend=120;
%iend2=120;
%pstart=1;
%pend=119;
%iarr=[1 10 60 80 100 120];
%%years='000701-001112.';
%%lengthyr=5; % length of time series in years
%%iend=60;
%%iend2=60;
%%pstart=1;
%%pend=59;
%%iarr=[1 10 30 40 50 60];
%%%%% endt is the end index for the time series that have been computed
%%%%% with a running mean of +/- 6 months so it is 13 months shorter
%%%endt=107; % needs to be iend -1 year and one month
%%%%%
%%%% below is needed both for my experiments and for Ming's cess experiment
%atm='atmos.';
%expyrs1=strcat(atm,years); 
%expyrs2=strcat(atm,years); 
%%%%
%exp1name=strcat(x1name,addpath,expyrs1);
%exp2name=strcat(x2name,addpath,expyrs2);
%exp1=strcat(basedir,x1name,addpath);
%exp2=strcat(basedir,x2name,addpath);
%%%
%%%%% end sst pattern block
%%%%

%------------------------------------------------------------------------------------------
%%fin_sst='/archive/cjg/mdt/cm3/ipcc_ar5/input/common/sst.climo.1981-2000.data.nc'
%%fin='/archive/Ming.Zhao/awglg/ulm/c96L32_am4g5r11_2000climo_p2K/ts_all/atmos.000201-001112.t_surf.nc'
base1=strcat(exp1,expyrs1);
base2=strcat(exp2,expyrs2);
%
%compute a time in months: 
timeindex=0:0.0833:lengthyr-1;
istart=1;
istart2=iend2-iend+1;
%
%%
%landm='/archive/Ming.Zhao/awg/ulm/CM2.1U-D4_1PctTo2X_I1/gfdl.ncrc2-intel-prod-openmp/pp/atmos_scalar/atmos_scalar.static.nc'
landm='/archive/Levi.Silvers/awg/verona/c96L32_am4g10r8_2000climo/gfdl.ncrc3-intel-prod-openmp/pp/atmos/atmos.static.nc'
fland=netcdf(landm,'nowrite');
%------------------------------------------------------------------------------------------

var1='t_surf.nc';
fin=strcat(base1,var1);
fin2=strcat(base2,var1);

% read input file
f =netcdf(fin,'nowrite');
f2 =netcdf(fin2,'nowrite');
%ncid=netcdf.open(fin,'NC_NOWRITE');
% set up a structure(v) to hold info related to variables
%------------------------------------------------------------------------------------------
v.lon=f{'lon'}(:); v.lat =f{'lat'}(:);
v.nlon=length(v.lon); v.nlat=length(v.lat); v.ngrid=v.nlat*v.nlon;
v.latweight=cos(pi/180*v.lat);
v.xs0=1; v.xe0=v.nlon;
v.ys0=1; v.ye0=v.nlat;
v.time=f{'time'}(:); v.nt=length(v.time);
v.sst =f{'t_surf'}(istart:iend,:,:); 
v.sst2 =f2{'t_surf'}(istart2:iend2,:,:); 
v.landm = fland{'land_mask'}(:,:);
landmm=fland{'land_mask'}(:,:);
tend=iend-istart;
v.yr  =f{'yr'} (:);
v.mo  =f{'mo'} (:);
v.dy  =f{'dy'} (:);
v.time = [49354 49385 49413 49444 49474 49505 49535 49566 49597 49627 49658 49688];
v.nt=12;
close(f);
close(f2);
%-----------------------------------------------------%
% compute global means using the cosine weighted latitude
%------------------------------------------------------------------------------------------

glblatweight=v.latweight;
%
%latinc=30;
%sonic=1:30:180;
%sonic=1:15:90;
%tmp_reglatweight=zeros(6,latinc);
%tmp_reglatweight=zeros(6,15);
%for index=1:6;
%  begini=sonic(index);
%  endi=sonic(index)+latinc-1;
%%  endi=sonic(index)+14;
%  tmp_reglatweight(index,:)=v.latweight(begini:endi)';
%end
%testreggarbage=tmp_reglatweight;
%%for ilat=1:6;
%%for ilon=1:v.nlon-1;
%for ilon=1:3;
%    testreggarbage=cat(3,testreggarbage,tmp_reglatweight);
%end
%end
%
for index=1:v.nlon-1;
    glblatweight=horzcat(glblatweight,v.latweight);
end
glbsumweight=sum(glblatweight(:));
%------------------------------------------------------------------------------------------
%startan=1;
%endan=59;
in_var=v.sst;
%wgt_var=zeros(tend,v.nlat,v.nlon);
for ti=1:tend;
  temp_var      = in_var(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight;
  out_var(ti) = sum(wgt_var(:))/glbsumweight;
end
v.sst_mn_ts=out_var;
in_var=v.sst2;
%wgt_var=zeros(tend,v.nlat,v.nlon);
for ti=1:tend;
  temp_var      = in_var(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight;
  out_var(ti) = sum(wgt_var(:))/glbsumweight;
end
v.sst_mn_ts2=out_var;
%% compute the anomaly
%v.sst2=v.sst2-mean(v.sst_mn_ts2,2);
%v.sst=v.sst-mean(v.sst_mn_ts(startan:endan),2);
%------------------------------------------------------------------------------------------

var2='swdn_toa.nc';
%var2='olr.nc';
fin=strcat(base1,var2);
fin2=strcat(base2,var2);

% read input file
f =netcdf(fin,'nowrite');
f2 =netcdf(fin2,'nowrite');
ncid=netcdf.open(fin,'NC_NOWRITE');
v.swdn_toa =f{'swdn_toa'}(istart:iend,:,:); 
v.swdn_toa2 =f2{'swdn_toa'}(istart2:iend2,:,:); 
%v.swdn_toa =f{'olr'}(istart:iend,:,:); 
%v.swdn_toa2 =f2{'olr'}(istart2:iend2,:,:); 
close(f);
close(f2);
%
in_var=v.swdn_toa;
wgt_var=zeros(tend,v.nlat,v.nlon);
for ti=1:tend;
  temp_var      = in_var(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight;
  out_var(ti) = sum(wgt_var(:))/glbsumweight;
end
v.swdn_toa_mn_ts=out_var;
in_var=v.swdn_toa2;
wgt_var=zeros(tend,v.nlat,v.nlon);
for ti=1:tend;
  temp_var      = in_var(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight;
  out_var(ti) = sum(wgt_var(:))/glbsumweight;
end
v.swdn_toa2_mn_ts=out_var;
%% compute the anomaly
%v.swdn_toa2=v.swdn_toa2-mean(v.swdn_toa2_mn_ts,2);
%v.swdn_toa=v.swdn_toa-mean(v.swdn_toa_mn_ts,2);
%------------------------------------------------------------------------------------------
var3='swup_toa.nc';
fin=strcat(base1,var3);
fin2=strcat(base2,var3);

% read input file
f =netcdf(fin,'nowrite');
f2 =netcdf(fin2,'nowrite');
ncid=netcdf.open(fin,'NC_NOWRITE');
v.swup_toa =f{'swup_toa'}(istart:iend,:,:); 
v.swup_toa2 =f2{'swup_toa'}(istart2:iend2,:,:); 
close(f);
close(f2);
%
in_var=v.swup_toa;
wgt_var=zeros(tend,v.nlat,v.nlon);
for ti=1:tend;
  temp_var      = in_var(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight;
  out_var(ti) = sum(wgt_var(:))/glbsumweight;
end
v.swup_toa_mn_ts=out_var;
in_var=v.swup_toa2;
wgt_var=zeros(tend,v.nlat,v.nlon);
for ti=1:tend;
  temp_var      = in_var(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight;
  out_var(ti) = sum(wgt_var(:))/glbsumweight;
end
v.swup_toa2_mn_ts=out_var;
%------------------------------------------------------------------------------------------
var4='swup_toa_clr.nc';
fin=strcat(base1,var4);
fin2=strcat(base2,var4);

% read input file
f =netcdf(fin,'nowrite');
f2 =netcdf(fin2,'nowrite');
ncid=netcdf.open(fin,'NC_NOWRITE');
v.swup_clr =f{'swup_toa_clr'}(istart:iend,:,:); 
v.swup2_clr =f2{'swup_toa_clr'}(istart2:iend2,:,:); 
close(f);
close(f2);
%
in_var=v.swup_clr;
wgt_var=zeros(tend,v.nlat,v.nlon);
for ti=1:tend;
  temp_var      = in_var(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight;
  out_var(ti) = sum(wgt_var(:))/glbsumweight;
end
v.swup_clr_mn_ts=out_var;
in_var=v.swup2_clr;
wgt_var=zeros(tend,v.nlat,v.nlon);
for ti=1:tend;
  temp_var      = in_var(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight;
  out_var(ti) = sum(wgt_var(:))/glbsumweight;
end
v.swup_clr2_mn_ts=out_var;
%------------------------------------------------------------------------------------------
var5='swdn_toa_clr.nc';
fin=strcat(base1,var5);
fin2=strcat(base2,var5);

% read input file
f =netcdf(fin,'nowrite');
f2 =netcdf(fin2,'nowrite');
ncid=netcdf.open(fin,'NC_NOWRITE');
v.swdn_clr =f{'swdn_toa_clr'}(istart:iend,:,:); 
v.swdn2_clr =f2{'swdn_toa_clr'}(istart2:iend2,:,:); 
close(f);
close(f2);
%
in_var=v.swdn_clr;
wgt_var=zeros(tend,v.nlat,v.nlon);
for ti=1:tend;
  temp_var      = in_var(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight;
  out_var(ti) = sum(wgt_var(:))/glbsumweight;
end
v.swdn_clr_mn_ts=out_var;
in_var=v.swdn2_clr;
wgt_var=zeros(tend,v.nlat,v.nlon);
for ti=1:tend;
  temp_var      = in_var(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight;
  out_var(ti) = sum(wgt_var(:))/glbsumweight;
end
v.swdn_clr2_mn_ts=out_var;
%------------------------------------------------------------------------------------------
var6='olr.nc';
fin=strcat(base1,var6);
fin2=strcat(base2,var6);

% read input file
f =netcdf(fin,'nowrite');
f2 =netcdf(fin2,'nowrite');
ncid=netcdf.open(fin,'NC_NOWRITE');
v.olr =f{'olr'}(istart:iend,:,:); 
v.olr2 =f2{'olr'}(istart2:iend2,:,:); 
close(f);
close(f2);
%
in_var=v.olr;
wgt_var=zeros(tend,v.nlat,v.nlon);
for ti=1:tend;
  temp_var      = in_var(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight;
  out_var(ti) = sum(wgt_var(:))/glbsumweight;
end
v.olr_mn_ts=out_var;
in_var=v.olr2;
wgt_var=zeros(tend,v.nlat,v.nlon);
for ti=1:tend;
  temp_var      = in_var(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight;
  out_var(ti) = sum(wgt_var(:))/glbsumweight;
end
v.olr2_mn_ts=out_var;
%------------------------------------------------------------------------------------------
var7='olr_clr.nc';
fin=strcat(base1,var7);
fin2=strcat(base2,var7);

% read input file
f =netcdf(fin,'nowrite');
f2 =netcdf(fin2,'nowrite');
ncid=netcdf.open(fin,'NC_NOWRITE');
v.olr_clr =f{'olr_clr'}(istart:iend,:,:); 
v.olr2_clr =f2{'olr_clr'}(istart2:iend2,:,:); 
close(f);
close(f2);
%
in_var=v.olr_clr;
wgt_var=zeros(tend,v.nlat,v.nlon);
for ti=1:tend;
  temp_var      = in_var(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight;
  out_var(ti) = sum(wgt_var(:))/glbsumweight;
end
v.olr_clr_mn_ts=out_var;
in_var=v.olr2_clr;
wgt_var=zeros(tend,v.nlat,v.nlon);
for ti=1:tend;
  temp_var      = in_var(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight;
  out_var(ti) = sum(wgt_var(:))/glbsumweight;
end
v.olr_clr2_mn_ts=out_var;

%------------------------------------------------------------------------------------------
var8='precip.nc';
fin=strcat(base1,var8);
fin2=strcat(base2,var8);

% read input file
f =netcdf(fin,'nowrite');
f2 =netcdf(fin2,'nowrite');
v.precip =f{'precip'}(istart:iend,:,:); 
v.precip2=f2{'precip'}(istart2:iend2,:,:); 
close(f);
close(f2);

%------------------------------------------------------------------------------------------
var9='ice_mask.nc';
fin=strcat(base1,var9);
fin2=strcat(base2,var9);

% read input file
f =netcdf(fin,'nowrite');
f2 =netcdf(fin2,'nowrite');
v.ice=f{'ice_mask'}(istart:iend,:,:);
v.ice2=f2{'ice_mask'}(istart:iend,:,:);
close(f);
close(f2);

%------------------------------------------------------------------------------------------
var_wvp='WVP.nc';
fin=strcat(base1,var_wvp);
fin2=strcat(base2,var_wvp);

% read input file
f =netcdf(fin,'nowrite');
f2 =netcdf(fin2,'nowrite');
v.wvp=f{'WVP'}(istart:iend,:,:);
v.wvp2=f2{'WVP'}(istart:iend,:,:);
close(f);
close(f2);

%------------------------------------------------------------------------------------------
var_lwp='LWP.nc';
fin=strcat(base1,var_lwp);
fin2=strcat(base2,var_lwp);

% read input file
f =netcdf(fin,'nowrite');
f2 =netcdf(fin2,'nowrite');
v.lwp=f{'LWP'}(istart:iend,:,:);
v.lwp2=f2{'LWP'}(istart:iend,:,:);
close(f);
close(f2);

%------------------------------------------------------------------------------------------
var_t_ref='t_ref.nc';
fin=strcat(base1,var_t_ref);
fin2=strcat(base2,var_t_ref);

% read input file
f =netcdf(fin,'nowrite');
f2 =netcdf(fin2,'nowrite');
v.t_ref=f{'t_ref'}(istart:iend,:,:);
v.t_ref2=f2{'t_ref'}(istart:iend,:,:);
close(f);
close(f2);

%------------------------------------------------------------------------------------------
var_swup_sfc_clr='swup_sfc_clr.nc';
fin=strcat(base1,var_swup_sfc_clr);
fin2=strcat(base2,var_swup_sfc_clr);

% read input file
f =netcdf(fin,'nowrite');
f2 =netcdf(fin2,'nowrite');
v.swup_sfc_clr=f{'swup_sfc_clr'}(istart:iend,:,:);
v.swup_sfc_clr2=f2{'swup_sfc_clr'}(istart:iend,:,:);
close(f);
close(f2);

%------------------------------------------------------------------------------------------
var_lwup_sfc_clr='lwup_sfc_clr.nc';
fin=strcat(base1,var_lwup_sfc_clr);
fin2=strcat(base2,var_lwup_sfc_clr);

% read input file
f =netcdf(fin,'nowrite');
f2 =netcdf(fin2,'nowrite');
v.lwup_sfc_clr=f{'lwup_sfc_clr'}(istart:iend,:,:);
v.lwup_sfc_clr2=f2{'lwup_sfc_clr'}(istart:iend,:,:);
close(f);
close(f2);

%------------------------------------------------------------------------------------------



%% compute the anomalies
%v.sst2=v.sst2-mean(v.sst_mn_ts2,2);
%v.sst=v.sst-mean(v.sst_mn_ts(startan:endan),2);
%v.swup_toa2=v.swup_toa2-mean(v.swup_toa2_mn_ts,2);
%v.swup_toa=v.swup_toa-mean(v.swup_toa_mn_ts,2);
%v.swup2_clr=v.swup2_clr-mean(v.swup_clr2_mn_ts,2);
%v.swup_clr=v.swup_clr-mean(v.swup_clr_mn_ts,2);
%v.swdn_toa2=v.swdn_toa2-mean(v.swdn_toa2_mn_ts,2);
%v.swdn_toa=v.swdn_toa-mean(v.swdn_toa_mn_ts,2);
%v.swdn2_clr=v.swdn2_clr-mean(v.swdn_clr2_mn_ts,2);
%v.swdn_clr=v.swdn_clr-mean(v.swdn_clr_mn_ts,2);
%v.olr2=v.olr2-mean(v.olr2_mn_ts,2);
%v.olr=v.olr-mean(v.olr_mn_ts,2);
%v.olr2_clr=v.olr2_clr-mean(v.olr_clr2_mn_ts,2);
%v.olr_clr=v.olr_clr-mean(v.olr_clr_mn_ts,2);
%-----------------------------------------------------------------------------------------
% compute radiative budget
% feedbacks should be computed with exp1-exp2, and positive values should lead to warming
%-----------------------------------------------------------------------------------------
% all three of these variables are defined as positive
v.radflux=v.swdn_toa-v.olr-v.swup_toa;
v.radflux2=v.swdn_toa2-v.olr2-v.swup_toa2;
toa_net_fdbck=v.radflux-v.radflux2;
olr_fdbck=v.olr-v.olr2;
sw_fdbck=v.swdn_toa-v.swup_toa-v.swdn_toa2+v.swup_toa2;

% compute global mean radiative imbalance
in_var=v.radflux;
in_var2=v.radflux2;
%wgt_var=zeros(tend,v.nlat,v.nlon);
for ti=1:tend;
  temp_var      = in_var(ti,:,:);
  temp_var2      = in_var2(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight;
  wgt_var2       = squeeze(temp_var2).*glblatweight;
  out_var(ti) = sum(wgt_var(:))/glbsumweight;
  out_var2(ti) = sum(wgt_var2(:))/glbsumweight;
end
v.radflux_mn_ts=out_var;
v.radflux2_mn_ts=out_var2;
toa_net_fdbck_mn_ts=v.radflux_mn_ts-v.radflux2_mn_ts;
%
mean_radflux=mean(v.radflux_mn_ts);
mean_radflux2=mean(v.radflux2_mn_ts);
radimb=mean_radflux-mean_radflux2

v.radflux_tmn=mean(v.radflux,1);
v.radflux2_tmn=mean(v.radflux2,1);
%toa_feedback=(v.radflux_tmn-v.radflux2_tmn)/2.;
%toa_feedback_zmn=mean(toa_feedback,3);

% clear sky
lw_clr_fdbck=v.olr_clr-v.olr2_clr;
% the sign should be flipped here because larger olr values correspond to cooling
lw_clr_fdbck=-lw_clr_fdbck;
% swdn_clr=swdn, should swdn_clr be part of the computation for 
% sw_cre?
sw_clr_fdbck=v.swdn_clr-v.swup_clr-v.swdn2_clr+v.swup2_clr;

% cloud radiative effects: clear sky - all sky  
olr_cre1=v.olr_clr-v.olr; % pos means clouds warm
olr_cre2=v.olr2_clr-v.olr2;
sw_cre1=v.swup_clr-v.swup_toa; % pos means clouds cool, so we plot -sw_cre
sw_cre2=v.swup2_clr-v.swup_toa2;
tot_cre1=olr_cre1-sw_cre1; % pos means clouds warm
tot_cre2=olr_cre2-sw_cre2;
% CRE = lw_cre - sw_cre; positive values correspond to warming from clouds
%olr_cre_fdbck=lw_clr_fdbck - olr_fdbck;
%sw_cre_fdbck=sw_clr_fdbck - sw_fdbck;
%toa_cre_fdbck=sw_cre_fdbck+olr_cre_fdbck;
olr_cre_fdbck=olr_cre1-olr_cre2;
sw_cre_fdbck=sw_cre1-sw_cre2;
toa_cre_fdbck=olr_cre_fdbck+sw_cre_fdbck;
%toa_cre_fdbck_test=tot_cre1-tot_cre2;

precip_fdbck=v.precip-v.precip2;
wvp_fdbck=v.wvp-v.wvp2;
lwp_fdbck=v.lwp-v.lwp2;
t_ref_fdbck=v.t_ref-v.t_ref2;
swup_sfc_clr_fdbck=v.swup_sfc_clr-v.swup_sfc_clr2;
lwup_sfc_clr_fdbck=v.lwup_sfc_clr-v.lwup_sfc_clr2;

tempdiff_full=v.sst-v.sst2;  % forced minus control
tempdiff=mean(tempdiff_full,1); % take the time mean
tempdiff_zmn=mean(tempdiff,3); % take the zonal mean

tempdiff_fulla = mean(tempdiff_full(iarr(1):iarr(3),:,:),1);
tempdiffa_zmn=mean(tempdiff_fulla,3); % take the zonal mean
tempdiff_fullb = mean(tempdiff_full(iarr(3):iarr(4),:,:),1);
tempdiffb_zmn=mean(tempdiff_fullb,3); % take the zonal mean
tempdiff_fullc = mean(tempdiff_full(iarr(4):iarr(5),:,:),1);
tempdiffc_zmn=mean(tempdiff_fullc,3); % take the zonal mean
tempdiff_fulld = mean(tempdiff_full(iarr(5):iarr(6),:,:),1);
tempdiffd_zmn=mean(tempdiff_fulld,3); % take the zonal mean

%-----------------------------------------------------%
% select the time section to be analyzized
precip_f_part=precip_fdbck(pstart:pend,:,:);
precip_fdbck_part_mn=mean(precip_f_part,1);
wvp_f_part=wvp_fdbck(pstart:pend,:,:);
wvp_fdbck_part_mn=mean(wvp_f_part,1);
lwp_f_part=lwp_fdbck(pstart:pend,:,:);
lwp_fdbck_part_mn=mean(lwp_f_part,1);
t_ref_f_part=t_ref_fdbck(pstart:pend,:,:);
t_ref_fdbck_part_mn=mean(t_ref_f_part,1);

toa_f_part=toa_net_fdbck(pstart:pend,:,:);
toa_fdbck_part_mn=mean(toa_f_part,1);
toa_fdbck_part_zmn=mean(toa_fdbck_part_mn,3);
%
olr_f_part=olr_fdbck(pstart:pend,:,:);
olr_fdbck_part_mn=mean(olr_f_part,1);
olr_fdbck_part_zmn=mean(olr_fdbck_part_mn,3);
%
sw_f_part=sw_fdbck(pstart:pend,:,:);
sw_fdbck_part_mn=mean(sw_f_part,1);
sw_fdbck_part_zmn=mean(sw_fdbck_part_mn,3);
%
lw_clr_f_part=lw_clr_fdbck(pstart:pend,:,:);
lw_clr_fdbck_part_mn=mean(lw_clr_f_part,1);
lw_clr_fdbck_part_zmn=mean(lw_clr_fdbck_part_mn,3);
%
sw_clr_f_part=sw_clr_fdbck(pstart:pend,:,:);
sw_clr_fdbck_part_mn=mean(sw_clr_f_part,1);
sw_clr_fdbck_part_zmn=mean(sw_clr_fdbck_part_mn,3);
%
toa_cre_f_part=toa_cre_fdbck(pstart:pend,:,:);
toa_cre_fdbck_part_mn=mean(toa_cre_f_part,1);
toa_cre_fdbck_part_zmn=mean(toa_cre_fdbck_part_mn,3);
%
olr_cre_f_part=olr_cre_fdbck(pstart:pend,:,:);
olr_cre_fdbck_part_mn=mean(olr_cre_f_part,1);
olr_cre_fdbck_part_zmn=mean(olr_cre_fdbck_part_mn,3);
%
sw_cre_f_part=sw_cre_fdbck(pstart:pend,:,:);
sw_cre_fdbck_part_mn=mean(sw_cre_f_part,1);
sw_cre_fdbck_part_zmn=mean(sw_cre_fdbck_part_mn,3);

%-----------------------------------------------------%
% compute global mean temp diff
%-----------------------------------------------------%
in_var=tempdiff_full; % in  : v.sst 
wgt_var=zeros(tend,v.nlat,v.nlon);
for ti=1:tend;
  temp_var      = in_var(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight;
  out_var(ti) = sum(wgt_var(:))/glbsumweight;
end
glb_mn_delt=out_var;
%%------------------------------------------------------------------------------------------
%
%Normalize the feedbacks...
% plot one map of normalized by mn_sfc_temp_ch and one normalized
% with the sfc_temp change at every grid point
% glb_mn_delt is global mean temp diff time series
%normfac=mean(glb_mn_delt(pstart-1:pend-1));
% 
%% COUPLED MODEL EXPERIMENTS 
global_tempdiff_end=v.sst_mn_ts(pstart:pend-1)-v.sst_mn_ts2(pstart:pend-1);
mn_sfc_temp_ch=mean(global_tempdiff_end);
normfac=mn_sfc_temp_ch; % this is the global mean temp difference 
%normfac=1.0;
%% old way of normalizing
%tempdiff_first10 = mean(tempdiff_full(1:120,:,:),1);
%tempdiff_60t70 = mean(tempdiff_full(720:840,:,:),1);
%global_tempdiff=tempdiff_60t70-tempdiff_first10;
% compute the lat weighted global mean temp change
%wgt_var       = squeeze(global_tempdiff).*glblatweight;
%mn_sfc_temp_ch   = sum(wgt_var(:))/glbsumweight;
%
%normfac=mn_sfc_temp_ch; % this is the global mean temp difference 
%%normfaclocal=global_tempdiff; % this is the global mean change
%norm_tempdiff_zmn=mean(global_tempdiff,3);
%
%%%% CLIMATOLOGY PLUS SST PATTERN 
%%%%% this is simpler than the coupled runs because we shouldn't have to deal with drift
%normfac=mean(v.sst_mn_ts)-mean(v.sst_mn_ts2);
%normfaclocal=tempdiff;
%norm_tempdiff_zmn=mean(tempdiff,3);
%
% normalized by global mean tsfc diff
toa_fdbck_gnorm=toa_fdbck_part_mn./normfac;
olr_fdbck_gnorm=olr_fdbck_part_mn./normfac;
sw_fdbck_gnorm=sw_fdbck_part_mn./normfac;
lw_clr_fdbck_gnorm=lw_clr_fdbck_part_mn./normfac;
sw_clr_fdbck_gnorm=sw_clr_fdbck_part_mn./normfac;
toa_cre_fdbck_gnorm=toa_cre_fdbck_part_mn./normfac;
olr_cre_fdbck_gnorm=olr_cre_fdbck_part_mn./normfac;
sw_cre_fdbck_gnorm=sw_cre_fdbck_part_mn./normfac;
%
precip_fdbck_gnorm=precip_fdbck_part_mn./normfac;
wvp_fdbck_gnorm=wvp_fdbck_part_mn./normfac;
lwp_fdbck_gnorm=lwp_fdbck_part_mn./normfac;
t_ref_fdbck_gnorm=t_ref_fdbck_part_mn./normfac;
%% normalized by local mean tsfc diff
%toa_fdbck_lnorm=toa_fdbck_part_mn./normfaclocal;
%olr_fdbck_lnorm=olr_fdbck_part_mn./normfaclocal;
%sw_fdbck_lnorm=sw_fdbck_part_mn./normfaclocal;
%lw_clr_fdbck_lnorm=lw_clr_fdbck_part_mn./normfaclocal;
%sw_clr_fdbck_lnorm=sw_clr_fdbck_part_mn./normfaclocal;
%toa_cre_fdbck_lnorm=toa_cre_fdbck_part_mn./normfaclocal;
%olr_cre_fdbck_lnorm=olr_cre_fdbck_part_mn./normfaclocal;
%sw_cre_fdbck_lnorm=sw_cre_fdbck_part_mn./normfaclocal;
%% normalize the zonal means....
%toa_fdbck_part_zmn_norm=toa_fdbck_part_zmn./norm_tempdiff_zmn;
%olr_fdbck_part_zmn_norm=olr_fdbck_part_zmn./norm_tempdiff_zmn;
%sw_fdbck_part_zmn_norm=sw_fdbck_part_zmn./norm_tempdiff_zmn;
%lw_clr_fdbck_part_zmn_norm=lw_clr_fdbck_part_zmn./norm_tempdiff_zmn;
%sw_clr_fdbck_part_zmn_norm=sw_clr_fdbck_part_zmn./norm_tempdiff_zmn;
%toa_cre_fdbck_part_zmn_norm=toa_cre_fdbck_part_zmn./norm_tempdiff_zmn;
%olr_cre_fdbck_part_zmn_norm=olr_cre_fdbck_part_zmn./norm_tempdiff_zmn;
%sw_cre_fdbck_part_zmn_norm=sw_cre_fdbck_part_zmn./norm_tempdiff_zmn;

%%------------------------------------------------------------------------------------------
% compute the global mean values of the fields to be plotted
in_var=tempdiff_full; % in  : v.sst 
%toa_fdbck_gnorm=
wgt_var=zeros(tend,v.nlat,v.nlon);
%for ti=1:tend;
  wgt_var1       = squeeze(toa_fdbck_gnorm(1,:,:)).*glblatweight;
  wgt_var2       = squeeze(olr_fdbck_gnorm(1,:,:)).*glblatweight;
  wgt_var3       = squeeze(sw_fdbck_gnorm(1,:,:)).*glblatweight;
  wgt_var4       = squeeze(lw_clr_fdbck_gnorm(1,:,:)).*glblatweight;
  wgt_var5       = squeeze(sw_clr_fdbck_gnorm(1,:,:)).*glblatweight;
  wgt_var6       = squeeze(toa_cre_fdbck_gnorm(1,:,:)).*glblatweight;
  wgt_var7       = squeeze(olr_cre_fdbck_gnorm(1,:,:)).*glblatweight;
  wgt_var8       = squeeze(sw_cre_fdbck_gnorm(1,:,:)).*glblatweight;
  gmn_toa_fdbck_gnorm = sum(wgt_var1(:))/glbsumweight
  gmn_olr_fdbck_gnorm = sum(wgt_var2(:))/glbsumweight
  gmn_sw_fdbck_gnorm = sum(wgt_var3(:))/glbsumweight
  gmn_lw_clr_fdbck_gnorm = sum(wgt_var4(:))/glbsumweight
  gmn_sw_clr_fdbck_gnorm = sum(wgt_var5(:))/glbsumweight
  gmn_toa_cre_fdbck_gnorm = sum(wgt_var6(:))/glbsumweight
  gmn_olr_cre_fdbck_gnorm = sum(wgt_var7(:))/glbsumweight
  gmn_sw_cre_fdbck_gnorm = sum(wgt_var8(:))/glbsumweight
%end
%glb_mn_delt=out_var;
%%------------------------------------------------------------------------------------------
%%------------------------------------------------------------------------------------------
% Figures
%------------------------------------------------------------------------------------------
%%figure; plot(sin(pi*v.lat'/180.),fdbck_lat);
%%figure; plot(v.lat',toa_feedback_zmn);
%%title('zmn toa feedbck')
%figure; plot(v.lat',tempdiff_zmn,v.lat',tempdiffa_zmn,v.lat',tempdiffb_zmn,v.lat',tempdiffc_zmn,v.lat',tempdiffd_zmn);
%title('tempdiff zonal mean')
%legend('time mean','years 0-20','years 20-40','years 40-60','years 60-80','boxoff','Location','northwest')
%annotation('textbox',[0.0 0.9 1 0.1],'string',modelname, 'EdgeColor', 'none')
%%figure; contourf(yrmn,[-1,0,1,2,3,4]); colorbar;
%figure; contourf(squeeze(v.radflux_tmn(1,:,:))); colorbar;
%annotation('textbox',[0.0 0.9 1 0.1],'string',modelname, 'EdgeColor', 'none')
%% define the periods of interest
%figure;
%periods=[1 20 30 40];
%% create a panneled plot of for different stages of the tmp evolution
%%tempdiff_fulla = mean(tempdiff_full(1:240,:,:),1); first 20 yrs
%%tempdiff_fullb = mean(tempdiff_full(240:480,:,:),1); year 20-40
%%tempdiff_fullc = mean(tempdiff_full(480:720,:,:),1); years 40-60
%%tempdiff_fulld = mean(tempdiff_full(720:960,:,:),1); years 60-80
%
%pplot(1)=subplot(2,2,1);
%contourf(squeeze(tempdiff_fulla),[-1,-0.5,0,0.5,1,1.5,2,2.5,3,3.5,4]);
%caxis([-4 4]);
%title('years 0-20')
%pplot(2)=subplot(2,2,2);
%contourf(squeeze(tempdiff_fullb),[-1,-0.5,0,0.5,1,1.5,2,2.5,3,3.5,4]);
%caxis([-4 4]);
%title('years 20-40')
%pplot(3)=subplot(2,2,3);
%contourf(squeeze(tempdiff_fullc),[-1,-0.5,0,0.5,1,1.5,2,2.5,3,3.5,4]);
%caxis([-4 4]);
%title('years 40-60')
%pplot(4)=subplot(2,2,4);
%contourf(squeeze(tempdiff_fulld),[-1,-0.5,0,0.5,1,1.5,2,2.5,3,3.5,4]);
%caxis([-4 4]);
%title('years 60-80')
%%cmap2=[0 0 1 ; .4 .4 1; .6 .6 1 ; .9 .9 1 ; 1 .9 .9 ; 1 .6 .6 ;1 .4 .4 ;1 0 0 ];
%cmap2=[.6 .6 1;.9 .9 1;1 .9 .9;1 .7 .7;1 .6 .6;1 .5 .5;1 .4 .4 ;1 .3 .3;1 .1 .1 ;1 0 0 ];
%%cmap2=[.6 .6 1 ; .9 .9 1 ; 1 .9 .9 ; 1 .6 .6 ;1 .4 .4 ;1 .2 .2 ;1 0 0 ];
%colormap(cmap2(1:10,:))
%
%h=colorbar('SouthOutside');
%set(h, 'Position', [.1 .05 .8150 .05]);
%for i=1:4
%  pos=get(pplot(i), 'Position');
%  set(pplot(i), 'Position', [pos(1) 0.1+pos(2) pos(3) 0.8*pos(4)]);
%end;
%% try to change colorbar size...
%h_bar = findobj(gcf,'Tag','Colorbar');
%initpos = get(h_bar,'Position');
%initfontsize = get(h_bar,'FontSize');
%set(h_bar, ...
%   'Position',[initpos(1)+initpos(3)*0.25 initpos(2)+initpos(4)*0.25 ...
%         initpos(3)*0.5 initpos(4)*0.5], ...
%	    'FontSize',initfontsize*1)
%annotation('textbox',[0.0 0.9 1 0.1],'string',modelname, 'EdgeColor', 'none')

% feedback panels
%first
%clear pplot;
%clear h; clear h_bar; clear initpos; clear initfontsize;
%figure;
%ppplot(1)=subplot(2,1,1);
%contourf(squeeze(toa_fdbck_gnorm),[-4,-3,-2,-1,0,1,2,3,4]);
%caxis([-4 4]);
%title('TOA fdbck')
%ppplot(2)=subplot(2,1,2);
%contourf(squeeze(toa_cre_fdbck_gnorm),[-4,-3,-2,-1,0,1,2,3,4]);
%caxis([-4 4]);
%title('TOA CRE fdbck')
%cmap2=[0 0 1 ; .4 .4 1; .6 .6 1 ; .9 .9 1 ; 1 .9 .9 ; 1 .6 .6 ;1 .4 .4 ;1 0 0 ];
%colormap(cmap2(1:8,:))
%h=colorbar('SouthOutside');
%set(h, 'Position', [.1 .05 .8150 .05]);
%for i=1:2
%  pos=get(ppplot(i), 'Position');
%  set(ppplot(i), 'Position', [pos(1) 0.1+pos(2) pos(3) 0.8*pos(4)]);
%end;
%% try to change colorbar size...
%h_bar = findobj(gcf,'Tag','Colorbar');
%initpos = get(h_bar,'Position');
%initfontsize = get(h_bar,'FontSize');
%set(h_bar, ...
%   'Position',[initpos(1)+initpos(3)*0.25 initpos(2)+initpos(4)*0.25 ...
%         initpos(3)*0.5 initpos(4)*0.5], ...
%	    'FontSize',initfontsize*1)
%annotation('textbox',[0.0 0.9 1 0.1],'string',modelname, 'EdgeColor', 'none');
%
%% second
%%clear pplot;
%%clear h; clear h_bar; clear initpos; clear initfontsize;
%% because we want to plot warming of system as positive switch sign of lw_clr
%%lw_clr_fdbck_warm=-lw_clr_fdbck_part_mn;
%figure;
%pp3lot(1)=subplot(2,1,1);
%contourf(squeeze(lw_clr_fdbck_gnorm),[-4,-3,-2,-1,0,1,2,3,4]);
%caxis([-4 4]);
%title('LW clr fdbck')
%pp3lot(2)=subplot(2,1,2);
%contourf(squeeze(sw_clr_fdbck_gnorm),[-4,-3,-2,-1,0,1,2,3,4]);
%caxis([-4 4]);
%title('SW clr fdbck')
%cmap2=[0 0 1 ; .4 .4 1; .6 .6 1 ; .9 .9 1 ; 1 .9 .9 ; 1 .6 .6 ;1 .4 .4 ;1 0 0 ];
%colormap(cmap2(1:8,:))
%h2=colorbar('SouthOutside');
%set(h2, 'Position', [.1 .05 .8150 .05]);
%for i=1:2
%  pos=get(pp3lot(i), 'Position');
%  set(pp3lot(i), 'Position', [pos(1) 0.1+pos(2) pos(3) 0.8*pos(4)]);
%end;
%% try to change colorbar size...
%h_bar2 = findobj(gcf,'Tag','Colorbar');
%initpos2 = get(h_bar2,'Position');
%initfontsize2 = get(h_bar2,'FontSize');
%set(h_bar2, ...
%   'Position',[initpos2(1)+initpos2(3)*0.25 initpos2(2)+initpos2(4)*0.25 ...
%         initpos2(3)*0.5 initpos2(4)*0.5], ...
%	    'FontSize',initfontsize2*1)
%annotation('textbox',[0.0 0.9 1 0.1],'string',modelname, 'EdgeColor', 'none');
%%
%% third
%%clear pplot;
%%clear h; clear h_bar; clear initpos; clear initfontsize;
%% because warming from clouds corresponds to a neg sw_cre switch sign
%%sw_cre_warming=-sw_cre_fdbck_part_mn;
%figure;
%pp4lot(1)=subplot(2,1,1);
%contourf(squeeze(olr_cre_fdbck_gnorm),[-4,-3,-2,-1,0,1,2,3,4]);
%caxis([-4 4]);
%title('LW CRE fdbck')
%pp4lot(2)=subplot(2,1,2);
%contourf(squeeze(sw_cre_fdbck_gnorm),[-4,-3,-2,-1,0,1,2,3,4]);
%caxis([-4 4]);
%title('SW CRE fdbck')
%cmap2=[0 0 1 ; .4 .4 1; .6 .6 1 ; .9 .9 1 ; 1 .9 .9 ; 1 .6 .6 ;1 .4 .4 ;1 0 0 ];
%%cmap2=[.6 .6 1;.9 .9 1;1 .9 .9;1 .7 .7;1 .6 .6;1 .5 .5;1 .4 .4 ;1 .3 .3;1 .1 .1 ;1 0 0 ];
%%cmap2=[.6 .6 1 ; .9 .9 1 ; 1 .9 .9 ; 1 .6 .6 ;1 .4 .4 ;1 .2 .2 ;1 0 0 ];
%colormap(cmap2(1:8,:))
%h3=colorbar('SouthOutside');
%set(h3, 'Position', [.1 .05 .8150 .05]);
%for i=1:2
%  pos=get(pp4lot(i), 'Position');
%  set(pp4lot(i), 'Position', [pos(1) 0.1+pos(2) pos(3) 0.8*pos(4)]);
%end;
%% try to change colorbar size...
%h_bar3 = findobj(gcf,'Tag','Colorbar');
%initpos3 = get(h_bar3,'Position');
%initfontsize3 = get(h_bar3,'FontSize');
%set(h_bar3, ...
%   'Position',[initpos3(1)+initpos3(3)*0.25 initpos3(2)+initpos3(4)*0.25 ...
%         initpos3(3)*0.5 initpos3(4)*0.5], ...
%	    'FontSize',initfontsize3*1)
%annotation('textbox',[0.0 0.9 1 0.1],'string',modelname, 'EdgeColor', 'none');

% plot the zonal mean feedback and individual compoenents of feedback
figure; plot(v.lat',toa_fdbck_part_zmn,'k',v.lat',olr_fdbck_part_zmn,'b', ...
v.lat',sw_fdbck_part_zmn,'r',v.lat',lw_clr_fdbck_part_zmn,'b--',v.lat',sw_clr_fdbck_part_zmn,'r--',...
v.lat',toa_cre_fdbck_part_zmn,'k*',v.lat',olr_cre_fdbck_part_zmn,'b*',v.lat',sw_cre_fdbck_part_zmn,'r*');
title('zmn feedbck')
legend('net','olr','sw','lw_{clr}','sw_{clr}','toa_{cre}','olr_{cre}','sw_{cre}','boxoff','Location','southwest')
annotation('textbox',[0.0 0.9 1 0.1],'string',modelname, 'EdgeColor', 'none');
%% plot normalized zonal mean feedback and individual compoenents of feedback
figure; plot(v.lat',toa_fdbck_part_zmn/normfac,'k',v.lat',olr_fdbck_part_zmn/normfac,'b', ...
v.lat',sw_fdbck_part_zmn/normfac,'r',v.lat',lw_clr_fdbck_part_zmn/normfac,'b--',v.lat',sw_clr_fdbck_part_zmn/normfac,'r--',...
v.lat',toa_cre_fdbck_part_zmn/normfac,'k*',v.lat',olr_cre_fdbck_part_zmn/normfac,'b*',v.lat',sw_cre_fdbck_part_zmn/normfac,'r*');
title('norm zmn feedbck')
legend('net','olr','sw','lw_{clr}','sw_{clr}','toa_{cre}','olr_{cre}','sw_{cre}','boxoff','Location','southwest')
annotation('textbox',[0.0 0.9 1 0.1],'string',modelname, 'EdgeColor', 'none');
%-----------------------------------------------------------------------------------------
%% below is an attempt to look at the time evolution of variables at a particular location
%figure;
%lt=150;
%ln=1;
%time=1:119;
%plot(time,sw_cre_f_part(:,lt,ln),'r',time,sw_clr_f_part(:,lt,ln),'r--',time,olr_cre_f_part(:,lt,ln),'b',time,lw_clr_f_part(:,lt,ln),'b--',time,toa_f_part(:,lt,ln),'k',time,toa_cre_f_part(:,lt,ln),'k')
%plot(time,sw_cre_f_part(:,lt,ln),'r',time,olr_cre_f_part(:,lt,ln),'b',time,toa_cre_f_part(:,lt,ln),'k')
%plot(time,sw_cre_f_part(:,lt,ln),'r',time,olr_cre_f_part(:,lt,ln),'b',time,toa_cre_f_part(:,lt,ln),'k',time,15.*v.ice(pstart:pend,lt,ln),'g')
%%
% below is an attempt to mask out the land because we can't control the land and don't like it.  
%
% preparation for reading in to the nanland function...
% i can't get the naming to work correctly, with the string and real array...
sw_expfieldname=strcat(expname,'_mn_sw_cre_f_part') 
%sw_expfieldname=mean(sw_cre_f_part,1);
olr_expfieldname=strcat(expname,'_mn_olr_cre_f_part') 
%olr_expfieldname=mean(olr_cre_f_part,1);
toa_expfieldname=strcat(expname,'_mn_toa_cre_f_part') 
%toa_expfieldname=mean(toa_cre_f_part,1);
%
% to plot profiles using the function nanland, we will need to enter
% commands such as below since the commands strcat commands above
% aren't quite working as hoped...
%am4co2icesst1pct_mn_sw_cre_f_part=mean(sw_cre_f_part,1);
%
arrin=squeeze(sw_cre_f_part(1,:,:));
%
onlyocean=zeros(size(v.landm));
onlyocean(v.landm~=0)=-999.; % shift land points to -999
onlyocean(onlyocean==0)=1.; % shift ocean points to 1.0
onlyocean(onlyocean==-999.)=0.; % shift land points to 0.0

sw_cre_ocean=onlyocean.*arrin; % apply land=0.0 mask to global array...
sw_cre_ocean(sw_cre_ocean==0.)=NaN; % shift land points to NaNs
sw_cre_ocean_znm=nanmean(sw_cre_ocean,2); % the indexing seems strange here...
% it will be useful, and confirming to plot the zonal mean array over oceans, and the zonal mean array for the entire globe. 
full_arr_znm=mean(arrin,2);
%figure;plot(v.lat,full_arr_znm,v.lat,sw_cre_ocean_znm)
figmatrix=[full_arr_znm,sw_cre_ocean_znm];
%call the function that plots the figures
createfigure(v.lat,figmatrix)

%------------------------------------------------
%figure;
%ppplot(1)=subplot(2,1,1);
%contourf(squeeze(toa_cre_fdbck_gnorm),[-4,-3,-2,-1,0,1,2,3,4]);
%title('TOA CRE fdbck global mn norm')
%ppplot(2)=subplot(2,1,2);
%contourf(squeeze(toa_cre_fdbck_lnorm),[-4,-3,-2,-1,0,1,2,3,4]);
%title('TOA CRE fdbck local norm')
%cmap2=[0 0 1 ; .4 .4 1; .6 .6 1 ; .9 .9 1 ; 1 .9 .9 ; 1 .6 .6 ;1 .4 .4 ;1 0 0 ];
%colormap(cmap2(1:8,:))
%h=colorbar('SouthOutside');
%set(h, 'Position', [.1 .05 .8150 .05]);
%for i=1:2
%  pos=get(ppplot(i), 'Position');
%  set(ppplot(i), 'Position', [pos(1) 0.1+pos(2) pos(3) 0.8*pos(4)]);
%end;
%% try to change colorbar size...
%h_bar = findobj(gcf,'Tag','Colorbar');
%initpos = get(h_bar,'Position');
%initfontsize = get(h_bar,'FontSize');
%set(h_bar, ...
%   'Position',[initpos(1)+initpos(3)*0.25 initpos(2)+initpos(4)*0.25 ...
%         initpos(3)*0.5 initpos(4)*0.5], ...
%	    'FontSize',initfontsize*1)
%annotation('textbox',[0.0 0.9 1 0.1],'string',modelname, 'EdgeColor', 'none')
%%-----------------------------------------------------------------------------------------
%figure;
%ppplot(1)=subplot(2,1,1);
%contourf(squeeze(olr_cre_fdbck_gnorm),[-4,-3,-2,-1,0,1,2,3,4]);
%title('LW CRE fdbck global mn norm')
%ppplot(2)=subplot(2,1,2);
%contourf(squeeze(olr_cre_fdbck_lnorm),[-4,-3,-2,-1,0,1,2,3,4]);
%title('LW CRE fdbck local norm')
%cmap2=[0 0 1 ; .4 .4 1; .6 .6 1 ; .9 .9 1 ; 1 .9 .9 ; 1 .6 .6 ;1 .4 .4 ;1 0 0 ];
%colormap(cmap2(1:8,:))
%h=colorbar('SouthOutside');
%set(h, 'Position', [.1 .05 .8150 .05]);
%for i=1:2
%  pos=get(ppplot(i), 'Position');
%  set(ppplot(i), 'Position', [pos(1) 0.1+pos(2) pos(3) 0.8*pos(4)]);
%end;
%% try to change colorbar size...
%h_bar = findobj(gcf,'Tag','Colorbar');
%initpos = get(h_bar,'Position');
%initfontsize = get(h_bar,'FontSize');
%set(h_bar, ...
%   'Position',[initpos(1)+initpos(3)*0.25 initpos(2)+initpos(4)*0.25 ...
%         initpos(3)*0.5 initpos(4)*0.5], ...
%	    'FontSize',initfontsize*1)
%annotation('textbox',[0.0 0.9 1 0.1],'string',modelname, 'EdgeColor', 'none')
%%
%%-----------------------------------------------------------------------------------------
%figure;
%ppplot(1)=subplot(2,1,1);
%contourf(squeeze(sw_cre_fdbck_gnorm),[-4,-3,-2,-1,0,1,2,3,4]);
%title('sw CRE fdbck global mn norm')
%ppplot(2)=subplot(2,1,2);
%contourf(squeeze(sw_cre_fdbck_lnorm),[-4,-3,-2,-1,0,1,2,3,4]);
%title('sw CRE fdbck local norm')
%cmap2=[0 0 1 ; .4 .4 1; .6 .6 1 ; .9 .9 1 ; 1 .9 .9 ; 1 .6 .6 ;1 .4 .4 ;1 0 0 ];
%colormap(cmap2(1:8,:))
%h=colorbar('SouthOutside');
%set(h, 'Position', [.1 .05 .8150 .05]);
%for i=1:2
%  pos=get(ppplot(i), 'Position');
%  set(ppplot(i), 'Position', [pos(1) 0.1+pos(2) pos(3) 0.8*pos(4)]);
%end;
%% try to change colorbar size...
%h_bar = findobj(gcf,'Tag','Colorbar');
%initpos = get(h_bar,'Position');
%initfontsize = get(h_bar,'FontSize');
%set(h_bar, ...
%   'Position',[initpos(1)+initpos(3)*0.25 initpos(2)+initpos(4)*0.25 ...
%         initpos(3)*0.5 initpos(4)*0.5], ...
%	    'FontSize',initfontsize*1)
%annotation('textbox',[0.0 0.9 1 0.1],'string',modelname, 'EdgeColor', 'none')
%%---------------------------------------------------------------------------------
%figure; contourf(squeeze(normfaclocal),[-4,-3,-2,-1,0,1,2,3,4]); colorbar;
%title('normalization factor for local temp change')
%%---------------------------------------------------------------------------------
%% possible predifined colormaps: copper, summer, jet(default)
%% to create a custom colormap
%%cmap=[1 1 1 ; .8 .8 1 ; .6 .6 1 ; .4 .4 1 ; .2 .2 1 ; 0 0 1];
%%colormap(cmap(1:5,:))
%% blue: 0 0 1
%% red : 1 0 0
%% white: 1 1 1
%%cmap2=[1 1 1 ; .9 .9 1 ; .8 .8 1 ; .6 .6 1 ; .4 .4 1 ; .2 .2 1 ; .1 .1 1 ; 0 0 1];
%%cmap2=[1 1 1 ; 1 .9 .9 ; 1 .8 .8 ;1 .6 .6 ;1 .4 .4 ;1 .1 .1 ;1 .2 .2 ;1 0 0 ];
%% cmap2 is a color map ranging from reds to blues.
%%cmap2=[0 0 1 ; .4 .4 1; .6 .6 1 ; .9 .9 1 ; 1 .9 .9 ; 1 .6 .6 ;1 .4 .4 ;1 0 0 ];
%%colormap(cmap2(1:8,:))
%%------------------------------------------------------------------------------------------
% this is the end

