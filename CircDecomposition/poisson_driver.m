%-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
% poisson_driver.m
%
% driver script that will run the poisson.m script that performs the psi-
% method decomposition
%
% Model, time bounds, and definition of geographic regions are set in:
%   openf_setdom.m
%
% additional analysis and the creation of plots are done using:
%   omega_plot.m
%   bin_clouds.m
%   omega_plot_maps.m
%
% for the netcdf files that are written at the end of the script, the 
% experiment name and timesteps needs to be set with: expname and ntimesteps 
% 
% levi silvers                                                      july 2022
%-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

% these two strings are used only for the netcdf files that are created at the end.
expname='TEST';
ntimesteps='TEST';
%expname='amip';
%ntimesteps='120';

% choose model, open files, define time and geographic boundaries
% openf_setdom
    % source_file, wap_full, timelevelend, lat1, lat2, lat_tr1, lat_tr2,
    % lon1, lon2 are set in openf_setdom

%------------------------------------------
% define the model and paths that point to the data that will be used: 
%------------------------------------------

%-----------------------------------------------------------------------------
%% GFDL 
%MainTitle='GFDL amip'
%% amip
%source_file='~/data/GFDL/test_monthly_allfs_out.nc';
%%source_file='~/data/GFDL/wap500_CFday_GFDL-CM4_amip_r1i1p1f1_gr2_19790101-19841231.nc';
%wap_full=ncread(source_file,'wap500');
%%level=6; % this should be the 500 hPa level
%wap500_full=squeeze(wap_full(:,:,:));

%source_file='~/data/CAM/wap500_CFday_CESM2-FV2_historical_r1i1p1f1_gn_20100101-20150101.nc';

%MainTitle='historical'
%MainTitle='piControl'
%MainTitle='GFDL amip'

latitude = ncread(source_file,'lat');
longtude = ncread(source_file,'lon');
%press_le = ncread(source_file,'plev');

% is it ok to assume that dlat and dlon are constant? yes it 
% is, lat and lon are evenly spaced(in terms of degrees) in the cesm data I have
dlat=latitude(5)-latitude(4); % assuming latitudes are evenly spaced
dlon=longtude(5)-longtude(4);

slon =size(wap500_full,1);
slat =size(wap500_full,2);

%------------------------------------------
% define various parameters 
%------------------------------------------
conv=864.; % (hPa s)/(Pa day); used to convert Pa/s to hPa/day
%------------------------------------------
% solve the poisson equation at several timesteps
%------------------------------------------
clear omega_lon_t;
clear omega_lat_t;
clear omega_tot_t;

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

%-----------------------------------------------------------------------------
% call poisson.m at each desired timestep,  implement seasonality.
%-----------------------------------------------------------------------------
% RCE, mock-Walker, and aquaplanet simulations have no seasonality
% so we can calculate the decomposition as soon as equilibrium is 
% reached.

specialindex=1;
%timelevelend=36 % set in openf_setdom.m 

%%% Use the loop below for the cases of RCE or Aquaplanet (no seasonal cycle)
for timeindex=1:1:timelevelend
  timelevel = timeindex
  %specialindex=specialindex+1
  poisson % calls the poisson solver
  omega_lon_t(:,:,specialindex)=omega_wc;
  omega_lat_t(:,:,specialindex)=omega_hc;
  omega_tot_t(:,:,specialindex)=omega_total;
  specialindex=specialindex+1
end

%
%% for simulations with seasonality (amip, historical, piControl) calculate
%% the decomposition for a three month season out of each year.
%%%% the loop below calculates statistics for a 3 month season, e.g. DJF
%%for timeindex=6:12:timelevelend % june, july, august
%for timeindex=11:12:timelevelend % dec, jan, feb
%  timelevel = timeindex
%  poisson % calls the poisson solver
%  omega_lon_t(:,:,specialindex)=omega_wc;
%  omega_lat_t(:,:,specialindex)=omega_hc;
%  omega_tot_t(:,:,specialindex)=omega_total;
%  %
%  timelevel=timelevel+1
%  specialindex=specialindex+1
%  poisson % calls the poisson solver
%  omega_lon_t(:,:,specialindex)=omega_wc;
%  omega_lat_t(:,:,specialindex)=omega_hc;
%  omega_tot_t(:,:,specialindex)=omega_total;
%  %
%  timelevel=timelevel+1
%  specialindex=specialindex+1
%  poisson % calls the poisson solver
%  omega_lon_t(:,:,specialindex)=omega_wc;
%  omega_lat_t(:,:,specialindex)=omega_hc;
%  omega_tot_t(:,:,specialindex)=omega_total;
%  %timelevel=timelevel+12
%  %timelevel=timelevel+1
%  %specialindex=specialindex+31;
%  specialindex=specialindex+1
%end

%------------------------------------------

% compute time averages
% used to be omega_tot_678;
omega_tot_mn=squeeze(mean(omega_tot_t,3));
omega_lon_mn=squeeze(mean(omega_lon_t,3));
omega_lat_mn=squeeze(mean(omega_lat_t,3));

% compute zonal and meridional means of the psi-method results:
% omega_lon_678(longitude,latitude)
omega_lon_678_mm=squeeze(mean(omega_lon_mn,2)); % average the lon comp over lat
%omega_lon2_678_mm=squeeze(mean(omega_lon_678,1)); % average the lon comp over lat
omega_lat_678_mm=squeeze(mean(omega_lat_mn,1)); % average the lat comp over lon

% compute the zonal time mean and the meridional time mean of the total 
% circulation that is computed within poisson.m
omega_tot_zm=squeeze(mean(omega_tot_t,1));
omega_tot_mm=squeeze(mean(omega_tot_t,2));
omega_tot_zm_tm=squeeze(mean(omega_tot_zm,2));
omega_tot_mm_tm=squeeze(mean(omega_tot_mm,2));

% these fields, omega_total, omega_wc, and omega_hc are the solutions
% at the last timestep that poisson.m was called for.  
omega_loc_tot_zm=mean(omega_total,1);
omega_loc_lon_zm=mean(omega_wc,1);
omega_loc_lat_zm=mean(omega_hc,1);
omega_loc_tot_mm=mean(omega_total,2);
omega_loc_lon_mm=mean(omega_wc,2);
omega_loc_lat_mm=mean(omega_hc,2);

% write output to netcdf files

%expname='hist';
%ntimesteps='120';
%
v.wap500=omega_lat_mn;
ncfilename=strcat('cesm2_',expname,'_CircDecomp_lat_mn_',ntimesteps,'.nc');
newncfile_CircDecomp
v.wap500=omega_lon_mn;
%ncfilename='cesm2_amip_CircDecomp_lon_mn_120.nc';
ncfilename=strcat('cesm2_',expname,'_CircDecomp_lon_mn_',ntimesteps,'.nc');
newncfile_CircDecomp
v.wap500=omega_tot_mn;
%ncfilename='cesm2_amip_CircDecomp_tot_mn_120.nc';
ncfilename=strcat('cesm2_',expname,'_CircDecomp_tot_mn_',ntimesteps,'.nc');
newncfile_CircDecomp

