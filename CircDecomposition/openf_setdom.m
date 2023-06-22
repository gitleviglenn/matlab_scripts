%-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
% openf_setdom.m
%
% script used to choose model, experiment, file paths, and grid-spacing
% related parameters
%
% once the model type is chosen, the appropriate seasonality will need to be 
% chosen as well, in poisson_driver.m the loop that calls poisson.m needs 
% to be adjusted.
%
% written to be used with poisson_driver.m
%
% levi silvers                                                july 2022
%-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

%-------------------------------------------------------------------------------------------
% define the model and paths that point to the data that will be used: 
%-------------------------------------------------------------------------------------------
%% CESM2
%%% amip
%MainTitle='CESM2 amip'
%%%source_file='~/data/CAM/CESM2/cltcalipso_CFmon_CESM2_amip_r1i1p1f1_gn_195001-201412.nc';
%%%clt_full=ncread(source_file,'cltcalipso');
%%%%source_file='~/data/CAM/CESM2/wap500_CFday_CESM2_amip_r1i1p1f1_gn_19800101-20150101_monthly.nc';
%source_file='~/data/CAM/CESM2/wap500_monthly_CESM2_amip_r1i1p1f1_gn_19800101-20150101.nc';
%wap500_full=ncread(source_file,'wap500');
%%timelevelend=420; % should grab values from 3months of each year 
%timelevelend=120; % should grab values from 3months of each year for 10 years
%%timelevelend=12; % should grab values from 3months each year for 3 years
%%%
%%%% these times are specific to CESM2, amip, monthly mean data
%t1_wap=1;
%t2_wap=426;
%t2_clt=779;
%t1_clt=t2_clt-t2_wap+1;

%%%% historical
%MainTitle='CESM2 historical'
%source_file='~/data/CAM/CESM2/wap500_monthly_CESM2_historical_r11i1p1f1_gn_19800101-20150101.nc';
%wap500_full=ncread(source_file,'wap500');
%%timelevelend=424; % should grab values from 3months each year for 3 years
%timelevelend=120; % should grab values from 3months each year for 3 years
%t1_wap=1;
%t2_wap=426;
%t2_clt=779;
%t1_clt=t2_clt-t2_wap+1;

%%% aqua
%MainTitle='CESM2 aqua'
%source_file='~/data/CAM/CESM2/wap500_monthly_CESM2_aqua-control_r1i1p1f1_gn_000101-001012.nc';
%wap500_full=ncread(source_file,'wap500');
%timelevelend=122; % should grab values from 3months each year for 3 years
%t1_wap=1;
%t2_wap=122;
%t2_clt=779;
%t1_clt=t2_clt-t2_wap+1;

%%% mock walker
%MainTitle='CESM2 MW 295'
%%source_file='~/data/CAM/CAM6_mon_MockW_4Period_3K_cos2_295_1yr_2D_wap500.nc';
%source_file='~/data/CAM/wap500_CAM6_monthly_MockW_4Period_3K_cos2_295_3yr_2D.nc';
%wap500_full=ncread(source_file,'wap500');
%wap500_full=wap500_full(:,:,7:36);
%%wap500_full=squeeze(wap_full(:,:,7:37)); % normally 3 year runs, ignore first
%timelevelend=30; % should grab values from 3months each year for 3 years
%t1_wap=1;
%t2_wap=30;
%t2_clt=779;
%t1_clt=t2_clt-t2_wap+1;

%% CESM2-FV2
%% amip
%MainTitle='CESM2-FV2 amip'
%source_file='~/data/CAM/CESM2FV2/wap_Amon_CESM2-FV2_amip_r2i1p1f1_gn_200001-201412.nc';
%wap_full=ncread(source_file,'wap');
%level=6; % this should be the 500 hPa level
%wap500_full=squeeze(wap_full(:,:,level,:));
%timelevelend=12; % should grab values from 3months each year for 3 years
%%timelevelend=420; % should grab values from 3months each year for 3 years

%% historical
%MainTitle='CESM2 hist'
%source_file='~/data/CAM/CESM2FV2/wap500_CFday_CESM2-FV2_historical_r1i1p1f1_gn_20100101-20150101.nc';
%wap_full=ncread(source_file,'wap500');
%wap500_full=squeeze(wap_full(:,:,:));

%% piControl
%MainTitle='CESM2 piCo'
%source_file='~/data/CAM/CESM2FV2/wap500_CFday_CESM2-FV2_piControl_r1i1p1f1_gn_04810101-04901231.nc';
%wap_full=ncread(source_file,'wap500');
%wap500_full=squeeze(wap_full(:,:,:));

%%% RCEMIP experiment
MainTitle='CAM6 RCE 300'
source_file='~/data/RCEMIP/CAM6_GCM_RCE_large300_2D_wap500_monthly.nc';
wap_full=ncread(source_file,'wap500');
wap500_full=squeeze(wap_full(:,:,7:37)); % normally 3 year runs, ignore first
timelevelend=30; % should grab values from 3months each year for 3 years
t1_wap=1;
t2_wap=30;
t2_clt=779;
t1_clt=t2_clt-t2_wap+1;

%%% Rotating RCEMIP experiment
%MainTitle='CAM6 RRCE 295'
%source_file='~/data/CAM/CAM6_GCM_RRCE_large295_2D_wap500_monthly.nc';
%wap_full=ncread(source_file,'wap500');
%wap500_full=squeeze(wap_full(:,:,7:24)); % normally 3 year runs, ignore first
%timelevelend=18; % should grab values from 3months each year for 3 years
%t1_wap=1;
%t2_wap=18;
%t2_clt=779;
%t1_clt=t2_clt-t2_wap+1;


%-------------------------------------------------------------------------------------------
%% GFDL 
%MainTitle='GFDL amip'
%% amip
%source_file='~/data/GFDL/test_monthly_allfs_out.nc';
%%source_file='~/data/GFDL/wap500_CFday_GFDL-CM4_amip_r1i1p1f1_gr2_19790101-19841231.nc';
%wap_full=ncread(source_file,'wap500');
%%level=6; % this should be the 500 hPa level
%wap500_full=squeeze(wap_full(:,:,:));

%MainTitle='historical'
%MainTitle='piControl'
%MainTitle='GFDL amip'

%-------------------------------------------------------------------------------------------
% set indices that define the timesteps to be evaluated

%timelevel=12; % --> timelevel is used in poisson.m
%timelevelend=42; % should grab values from 3months each year for 3 years
%timelevelend=36; % should grab values from 3months each year for 3 years
%timelevelend=72; % should grab values from 3months each year for 3 years
%timelevelend=144; % should grab values from 3months each year for 3 years

%% these parameters are for CAM
%timelevelend=180; % should grab values from 3months each year for 3 years
%timelevelend=120; % should grab values from 3months each year for 3 years
%timelevelend=420; % should grab values from 3months each year for 3 years
%timelevelend=72; % should grab values from 3months each year for 3 years
%timelevelend=36; % should grab values from 3months each year for 3 years
%for timeindex=6:12:timelevelend

% these parameters are for GFDL
%timelevelend=548;% --> all gfdl months
%timelevelend=72;
%for timeindex=6:365:timelevelend

%-------------------------------------------------------------------------------------------
% set indices that define the desired geographical boundaries for particular models
%-----------------------
% CAM/CESM2 --> 192 latitude points, del lat = 0.9424; del lon = 1.25 deg
% 288 longitude points.  longitude(1)=-177.5; longitude(288)=181.25, so the
% prime meridian is at about longitude(143) and 180W would be between longitude(1)
% and longitude(288), which is confusing at best.  
%
%% latitude(96) and latitude(97) straddle the equator.
%% in CESM, 30:51 correspond to +5, -35
%% grab the area (5N:35S) of interest
lat1=59;
lat2=101;
%% grab a more traditional definition of tropics: 
lat_tr1=65;
lat_tr2=128;
%% grab the area (110E:160E) of interest for the regional HC
lon1=231;
lon2=271;
%-----------------------
%% CAM/CESM2-FV2
%%
%%% in CESM, 30:51 correspond to +5, -35
%%% grab the area (5N:35S) of interest
%lat1=30;
%lat2=51;
%%% grab a more traditional definition of tropics: 
%lat_tr1=33;
%lat_tr2=64;
%%% grab the area (110E:160E) of interest for the regional HC
%lon1=45;
%lon2=65;
%-----------------------
% GFDL CM4
%
% in GFDL CM4, there are 90 latitude points, in 2 degree intervals, from -89:89
%              there are 144 longitude points, in 2.5 deg intevals, from -176.25:181.25
%  why does longitude go beyond 180 in longitude?  Is that an output bug? 
%  31:60 corresponds to +-29
%  28:48 corresponds to -35 to +5
%% grab the area (5N:35S) of interest
%lat1=28;
%lat2=48;
%% grab a more traditional definition of tropics: 
%lat_tr1=31;
%lat_tr2=60;
%% grab the area (110E:160E) of interest for the regional HC
%lon1=45; % ???
%lon2=65; % ???



