%----------------------------------------------------------------------------
% make_icesst.m
%
% This script opens files with historical sst data starting at 1860 and 
% a control run with forcing from 1860
% a simple linear regression to compute the change of temperature between 
% 1860 and 2010 is computed.  
% these patterns of sst due to warming can then be added
% to a baseline sst pattern computed from the control experiment
%
% The same is done for ice. 
%
% a few modifactions are needed for basic quality control due to the use of
% t_surf to derive the sst.  t_surf = sst over ocean, but over land and ice
% it is equal to the surface temperature of land or ice.  this is a problem 
% for the sst directly under sea ice.  
%
% the simple linear regression can be computed as 
% reg=corrcoef*(standard dev of y/standard dev of x)
% or the function polyfit can be used from matlab.  They give the same 
% result
%
% input: fin, fin_ice, fin_sst_ctl, fin_ice_ctl
%
% final product: fnout_sst and fnout_ice
%
% levi silvers                                        Feb 2016
%----------------------------------------------------------------------------
%
% the two files below are from the historical run...
fin='/net2/Levi.Silvers/data/AM4OM2F_c96l32_am4g6_1860climo_hist0/ts_all/atmos.186101-201012.t_surf.nc'
fin_ice='/net2/Levi.Silvers/data/AM4OM2F_c96l32_am4g6_1860climo_hist0/ts_all/atmos.186101-201012.ice_mask.nc'
lengthmon=1800;
tend=1800;
tm1=1:150;
%
% the two files below are from the an experiment with 4xco2
%fin='/net2/Levi.Silvers/data/AM4OM2F_c96l32_am4g5r11_1860climo_4xCO2/ts_all/atmos.006101-015012_t_surf.nc'
%fin_ice='/net2/Levi.Silvers/data/AM4OM2F_c96l32_am4g5r11_1860climo_4xCO2/ts_all/atmos.006101-015012_ice_mask.nc'
%lengthmon=1080;
%tm1=1:90;
%
% the two files below are from the 1860 control run....
fin_sst_ctl='/archive/Ming.Zhao/awgom2/ulm_201505/AM4OM2F_c96l32_am4g6_1860climo/ts_all/atmos.000101-014012.t_surf.nc'
fin_ice_ctl='/archive/Ming.Zhao/awgom2/ulm_201505/AM4OM2F_c96l32_am4g6_1860climo/ts_all/atmos.000101-014012.ice_mask.nc'

% we also may need the land sea mask...
fstatic='/archive/Ming.Zhao/awgom2/ulm_201505/AM4OM2F_c96l32_am4g6_1860climo/atmos.static.nc'

% the    switch determines if the output sst and ice files will be
% for the control case, or for the control + reg case.
% default: control + reg

% output files
sst_type=0;    % 0 ctl
               % 1 ctl+reg only compute regression for this case
	       % 2 ctl+4k
  if (sst_type > 0 & sst_type < 2 ) % 1
     'sst_type is(1):'
     sst_type
     fnout_sst='sst_1860_ctlpreg_4co2.nc'
     fnout_ice='ice_1860_ctlpreg_4co2.nc'
  elseif (sst_type > 1) % 2
     'sst_type is(2):'
     sst_type
     fnout_sst='sst_1860_ctl_p4k_land.nc'
     fnout_ice='ice_1860_ctl_p4k_land.nc'
  else % default case is the ctl sst from 1860
     'sst_type is(0):'
     sst_type
     fnout_sst='sst_1860_ctl_land.nc'
     fnout_ice='ice_1860_ctl_land.nc'
  end

% read input file
f =netcdf(fin,'nowrite');
f_ice =netcdf(fin_ice,'nowrite');
f_static =netcdf(fstatic,'nowrite');
ncid=netcdf.open(fin,'NC_NOWRITE');
[ndim,nvar,natt,unlim]=netcdf.inq(ncid);
%-------------------------------------------------
% set up a structure(v) to hold info related to variables
v.lon=f{'lon'}(:); v.lat =f{'lat'}(:);
v.nlon=length(v.lon); v.nlat=length(v.lat); v.ngrid=v.nlat*v.nlon;
v.latweight=cos(pi/180*v.lat);
v.xs0=1; v.xe0=v.nlon;
v.ys0=1; v.ye0=v.nlat;
v.time=f{'time'}(:); v.nt=length(v.time);
% here we read in only the first 10 years
v.sst =f{'t_surf'} (1:120,:,:); 
v.sst_full =f{'t_surf'} (:,:,:); 
v.ice_full =f_ice{'ice_mask'} (:,:,:); 
v.landmask =f_static{'land_mask'} (:,:);
v.yr  =f{'yr'} (:);
v.mo  =f{'mo'} (:);
v.dy  =f{'dy'} (:);
v.average_T1 =f{'average_T1'} (:);
v.average_T2 =f{'average_T2'} (:);
v.average_DT =f{'average_DT'} (:);
v.time = [49354 49385 49413 49444 49474 49505 49535 49566 49597 49627 49658 49688];
v.nt=12;
v.yr=[0 0 0 0 0 0 0 0 0 0 0 0];
v.mo=[1 2 3 4 5 6 7 8 9 10 11 12];
v.dy=[1 1 1 1 1 1 1 1 1 1 1 1] ;
v.average_T1=[40223 40254 40282 40313 40343 40374 ...
	     40404 40435 40466 40496 40527 40557];
v.average_T2=[49354 49385 49413 49444 49474 49505 ...
	     49535 49566 49597 49627 49658 49688];
v.average_DT=[9125 9125 9125 9125 9125 9125 9125 9125 9125 9125 9125 9125];
%-------------------------------------------------
close(f);
close(f_ice);
%-------------------------------------------------
% read input file
% this is the control data, used for the baseline which the reg will be added to
f_sst =netcdf(fin_sst_ctl,'nowrite');
f_ice =netcdf(fin_ice_ctl,'nowrite');

v.lon=f_sst{'lon'}(:); v.lat =f_sst{'lat'}(:);
v.nlon=length(v.lon); v.nlat=length(v.lat); v.ngrid=v.nlat*v.nlon;
tstart=720; % exclude the first 60 years (720)
tend_ctl=1679; % 1679-720=960 about 80 years
tint=tend_ctl-tstart+1;
v.sst_full_ctl =f_sst{'t_surf'} (tstart:tend_ctl,:,:); 
v.ice_full_ctl =f_ice{'ice_mask'} (tstart:tend_ctl,:,:); 

close(f_sst);
close(f_ice);

clear monarray;
for ti=1:12;
  monarray=v.sst_full_ctl(ti:12:tint,:,:);
  monarray_ice=v.ice_full_ctl(ti:12:tint,:,:);
  v.sst_mnthlymn(ti,:,:)=mean(monarray,1);
  v.ice_mnthlymn(ti,:,:)=mean(monarray_ice,1);
end
%-------------------------------------------------

%tsurf=netcdf.getVar(ncid,7);
%'second_sea_surf_temp'
%size(tsurf)
%timearr=netcdf.getVar(ncid,8);
% the reshape command below should group the data by year, as apposed to month
% to get one year t_surf(:,:,:,year);
% to get all occurances of one month: t_surf(:,:,month,:)
% assumes all months are present in tsurf
%t_surf_yr=reshape(tsurf,[288,180,12,150]);

% define lat/lon which will be used for the timeslice
latfull=1:1:180;
lonfull=1:1:288;
lat=90.;
lon=100.;
% indexing end points
nlon=288;
nlat=180;
nyr=150;
nmon=12;

% tm1 values are spaced by 12 to mimic 
% the goal is to grab each instance of each month
% tm1 -> jan
% tm1+1 -> feb etc. 
%tm1=1:12:length(timeslicesqueeze);
%tm1=1:150;

% pre allocate needed arrays
months=zeros(12,150);
sigmay=zeros(nlon,nlat,nmon);
sigmay2=zeros(nmon,nlat,nlon);
corrcoeff=zeros(nlon,nlat,nmon);
corrcoeff2=zeros(nmon,nlat,nlon);

%-------------------------------------------------
% compute lat weights for the global mean 
% sum(array(:)) returns sum of all elements in A
glblatweight=v.latweight;
for index=1:287;
    glblatweight=horzcat(glblatweight,v.latweight);
end
glbsumweight=sum(glblatweight(:));

% generate a time series of global mean mnthly values
sst_ts_wgt=zeros(tend,v.nlat,v.nlon);
v.sst_prime=zeros(tend,v.nlat,v.nlon);
sst_ts=zeros(tend,1);
for ti=1:tend;
  sst_temp=v.sst_full(ti,:,:);
  sst_ts_wgt2 = squeeze(sst_temp).*glblatweight;
  mn_sst_ts(ti)=sum(sst_ts_wgt2(:))/glbsumweight;
end
% save global mean time series in v
v.sst_mn_ts=mn_sst_ts;
v.sst_mn_t=sum(mn_sst_ts(:))/tend;
% compute temperature perturbations at each point
% from global mean temper
for ilon=1:1:v.nlon
  for ilat=1:1:v.nlat
    for ti=1:tend
      v.sst_prime(ti,ilat,ilon)=v.sst_full(ti,ilat,ilon)-v.sst_mn_ts(ti);
      v.sst_prime2(ti,ilat,ilon)=v.sst_full(ti,ilat,ilon)-v.sst_mn_t;
    end
  end 
end
for ti=1:tend
  v.temp_pert(ti)=v.sst_mn_ts(ti)-v.sst_mn_t;
end
%%-------------------------------------------------
lowbndlandmask=.25
regarray=zeros(nmon,nlat,nlon);
regarray_test=zeros(nmon,nlat,nlon);
reg_v_mnsst=zeros(nmon,nlat,nlon);
regarray_ice=zeros(nmon,nlat,nlon);
regarray_ice_test=zeros(nmon,nlat,nlon);
if (sst_type > 0 & sst_type < 2 )
'computing regression array'
  for ilon=1:1:nlon
    for ilat=1:1:nlat
      for imonth=1:1:nmon
	      % how much of a difference do the land points make in the reg?
        if (v.landmask(ilat,ilon) < lowbndlandmask) % only take points over water
          p=polyfit(tm1',squeeze(v.sst_full(imonth:12:tend,ilat,ilon)),1);
          p2=polyfit(tm1',squeeze(v.ice_full(imonth:12:tend,ilat,ilon)),1);
            regarray(imonth,ilat,ilon)=p(1); %[K/yr]
            regarray_ice(imonth,ilat,ilon)=p2(1);
          p3=polyfit(v.temp_pert(imonth:12:tend)',squeeze(v.sst_full(imonth:12:tend,ilat,ilon)),1);
          p4=polyfit(v.temp_pert(imonth:12:tend)',squeeze(v.ice_full(imonth:12:tend,ilat,ilon)),1);
            regarray_test(imonth,ilat,ilon)=p3(1); %[K/yr]
            regarray_ice_test(imonth,ilat,ilon)=p4(1);
          p5=polyfit(v.sst_mn_ts(imonth:12:tend)',squeeze(v.sst_prime(imonth:12:tend,ilat,ilon)),1);
            reg_v_mnsst(imonth,ilat,ilon)=p5(1); %[K/K]
        end
      end 
    end 
  end 
end 
% plot some figures
figure; contourf(v.lon,v.lat,squeeze(reg_v_mnsst(1,:,:)));colorbar;
%
sst_general=v.sst_mnthlymn;
ice_general=v.ice_mnthlymn;
if (sst_type > 0 & sst_type < 2 ) 
  'regscaled by: '
  regscale=150.
  regscaletemp=1.5 % warming over the historical period [K]
  sst_general=regscale*regarray+sst_general;
  sst_reg_vmnsst=regscaletemp*reg_v_mnsst+sst_general;
  ice_general=regscale*regarray_ice+ice_general;
end
  regarray=regscale*regarray;
  regarray_ice=regscale*regarray_ice; 
  sst_reg_vs_mnsst=regscaletemp*reg_v_mnsst;
%-------------------------------------------------
% because t_surf is not sst over land or ice a bit 
% of data masaging is necessary....
% -never allow negative sea ice fractions
% -never allow sst to drop below lowbndsst
% -adjust for cells with partial ice cover
%-------------------------------------------------
%lowbndsst=271.25 % Kelvin low bound for sst
lowbndsst=273.15; % 0 deg C
%zeroc=273.15 % Kelvin
delT=1.9; % app diff btwn 0C & freezing point of sea water
lowbndice=0.0; % low bound for ice (fraction)
upbndice=1.0; % upper bound for ice (fraction)
% deal with ice problems
% only necessary for ctl+reg
if (sst_type > 0 & sst_type < 2 )
  'sst_type is(1):'
  for ilon=1:1:nlon
    for ilat=1:1:nlat
      for imonth=1:1:nmon
        if (ice_general(imonth,ilat,ilon) < lowbndice)
          ice_general(imonth,ilat,ilon) = lowbndice;
        end
        if (ice_general(imonth,ilat,ilon) > upbndice)
          ice_general(imonth,ilat,ilon) = upbndice;
        end
      end
    end	       
  end
end
% deal with sst problems
'why are you always such an ignoramous?'
for ilon=1:1:nlon
  for ilat=1:1:nlat
    if (v.landmask(ilat,ilon) < lowbndlandmask)
      for imonth=1:1:nmon
        if (sst_general(imonth,ilat,ilon) < lowbndsst)
          sst_general(imonth,ilat,ilon) = lowbndsst;
        end
      end
    end	       
  end
end
'how far did you go?'
% account for fractionally ice-covered cells 
% should this go after or before the sst block? i think after
sst_general=sst_general-delT*ice_general;
sst_pattern=sst_general;

% if sst+4k is desired, compute it here
if (sst_type > 1)
  'sst_type is(2):'
  sst_type
  for ilon=1:1:nlon
    for ilat=1:1:nlat
      for imonth=1:1:nmon
        if (v.landmask(ilat,ilon) < lowbndlandmask) % only take points over water
          if (ice_general(imonth,ilat,ilon) < 0.25) % ignore regions with sea ice
            sst_general(imonth,ilat,ilon)=sst_general(imonth,ilat,ilon)+4.;
          end
        end
      end
    end
  end
end

%-------------------------------------------------
% normalize the sst values so the global mean of 
% both patterns is the same
%-------------------------------------------------
%% generate a time series of global mean mnthly values
for ti=1:nmon; % for first file
  sst_temp=v.sst_full(ti,:,:);
  sst_ts_wgt = squeeze(sst_temp).*glblatweight;
  mn_sst_ts(ti)=sum(sst_ts_wgt(:))/glbsumweight;
end
clear sst_temp
for ti=1:nmon; % for second file
  sst_temp=v.sst_full2(ti,:,:);
  sst_ts_wgt2 = squeeze(sst_temp).*glblatweight;
  mn_sst2_ts(ti)=sum(sst_ts_wgt2(:))/glbsumweight;
end
%-------------------------------------------------
% compute the scale factor for normalizing
scalerx=zeros(nmon);
scalerx=mn_sst_ts./mn_sst2_ts;
% the following simply expands scalerx to a global redundant array
arrayx=zeros(nmon,v.nlat,v.nlon);
for ti=1:nmon;
  scalerxtemp=scalerx(ti);
  scalercat=scalerxtemp;
  for index=1:v.nlon-1;
    scalercat=horzcat(scalercat,scalerxtemp);
  end
  scalerarray=scalercat;
  for index=1:v.nlat-1;
    scalerarray=vertcat(scalerarray,scalercat);
  end
  arrayx(ti,:,:)=scalerarray;
end
%-------------------------------------------------
% now apply the scaling to one data set and check 
% if the mean of both is now the same

% unscaled_sst is the final, normalized sst pattern
% that has the same global mean as the reference 
% sst data set.
unscaled_sst=arrayx.*v.sst_full2;
for ti=1:tend; 
  sst_temp=unscaled_sst(ti,:,:);
  sst_ts_wgt = squeeze(sst_temp).*glblatweight;
  mn_weighted_sstnew(ti)=sum(sst_ts_wgt(:))/glbsumweight;
end
%-------------------------------------------------
%% compute the diff from the masaging
%%sst_diff=v.sst_1860plusregsimple-v.sst_1860plusreg;
%%sst_diff0=squeeze(mean(sst_diff,1));
%%figure; contourf(v.lon,v.lat,sst_diff0);colorbar
%%-------------------------------------------------
%'global mean of 1860 plus 150x regression after masaging'
%v.sst_1860plusreg0=squeeze(mean(v.sst_1860plusreg,1));
%glbdatareg=v.sst_1860plusreg0.*glblatweight;
%glbsum=sum(glbdatareg(:));
%globmean_ctlpreg=glbsum/glbsumweight
%%-------------------------------------------------
%'global mean of simple 1860 plus 150x regression after masaging'
%v.sst_1860plusregs0=squeeze(mean(v.sst_1860plusreg,1));
%glbdataregs=v.sst_1860plusregs0.*glblatweight;
%glbsums=sum(glbdataregs(:));
%globmean_ctlpregs=glbsums/glbsumweight
%%%-------------------------------------------------
%% create a few figures to see what we are doing
%%v.sst_10yrmn0=squeeze(mean(v.sst_10yrmn,1));
%%figure; contourf(v.lon,v.lat,v.sst_10yrmn0);colorbar;
%figure; contourf(v.lon,v.lat,v.sst_1860ctl0);colorbar
%%v.sst_1860plusreg0=squeeze(mean(v.sst_1860plusreg,1));
%figure; contourf(v.lon,v.lat,v.sst_1860plusreg0);colorbar;
%figure; contourf(v.lon,v.lat,v.sst_1860plusregs0);colorbar;
%% look at the spacial pattern of the regression values....
%regarray_ice_janj=regarray_ice(1,:,:);
%regarray_ice_jan=squeeze(regarray_ice_janj);
%figure; contourf(v.lon,v.lat,regarray_ice_jan);colorbar;
%regarray_sst_janj=regarray(1,:,:);
%regarray_sst_jan=squeeze(regarray_sst_janj);
%figure; contourf(v.lon,v.lat,regarray_sst_jan);colorbar;
%-------------------------------------------------
% create a new netcdf file
nc = netcdf(fnout_sst,'clobber'); 
if isempty(nc) error('NetCDF File Not Opened.'); end
nc.Conventions = 'CF-1.0';
nc.title = 'Modified SST pattern from Monthly version of HadISST sea surface temperature component';
nc.institution = 'GFDL' ;
nc.source      = 'HadISST';
nc.history     = '09/11/2006 HadISST converted to NetCDF from pp format by John Kennedy; 31/12/2015 modified by Levi Silvers';

nc('time')  = 0; nc('nv')  = 2; nc('idim') = 12; 
nc{'time'}  = ncdouble('time'); nc{'time'}(1:v.nt) = v.time(:); 
nc('lat') = v.nlat;          nc('lon')     = v.nlon;
nc{'lat'} = ncfloat('lat');  nc{'lat'} (:) = v.lat; 
nc{'lon'} = ncfloat('lon');  nc{'lon'} (:) = v.lon; 

nc{'sst'}=ncfloat('time','lat','lon'); nc{'sst'}(:,:,:)=sst_general(:,:,:);
%nc{'climatology_bounds'} = ncdouble('time','nv'); 
%nc{'climatology_bounds'}(:,:)=v.climatology_bounds(:,:);
nc{'yr'} = ncint('idim'); nc{'yr'}(:)=v.yr;
nc{'mo'} = ncint('idim'); nc{'mo'}(:)=v.mo;
nc{'dy'} = ncint('idim'); nc{'dy'}(:)=v.dy;
nc{'average_T1'} = ncdouble('time'); nc{'average_T1'}(:)=v.average_T1;
nc{'average_T2'} = ncdouble('time'); nc{'average_T2'}(:)=v.average_T2;
nc{'average_DT'} = ncdouble('time'); nc{'average_DT'}(:)=v.average_DT;
nc{'nrecords'} = ncint();  nc{'nrecords'}(:)=12;

nc{'time'}.long_name     ='Time';      
%nc{'time'}.climatology   ='climatology_bounds';      
nc{'time'}.standard_name ='time';
nc{'time'}.calendar      ='gregorian';
nc{'time'}.units         ='days since 1869-12-1 00:00:00';      
nc{'time'}.delta_t       ='0000-00-01 00:00:00';      
nc{'time'}.modulo        =' ';      

nc{'lat'}.standard_name  = 'latitude' ;    nc{'lat'}.units  = 'degrees_north' ;
nc{'lon'}.standard_name  = 'longitude';    nc{'lon'}.units  = 'degrees_east' ;

nc{'yr'}.long_name    ='year';      
nc{'mo'}.long_name    ='month';      
nc{'dy'}.long_name    ='day';      

nc{'sst'}.long_name     ='Monthly 1 degree resolution sst';
nc{'sst'}.standard_name ='sea_surface_temperature';
nc{'sst'}.units         ='degK';      
nc{'sst'}.add_offset    = 0.e0;
nc{'sst'}.scale_factor  = 1.e0;
nc{'sst'}.FillValue_    =-1.e+30;
nc{'sst'}.missing_value =-1.e+30;
nc{'sst'}.description   ='HadIsst 1.1 monthly average sea surface temperature';
nc{'sst'}.cell_methods  ='time: lat: lon: mean within months time: mean over years';
nc{'sst'}.time_avg_info ='average_T1,average_T2,average_DT';

nc{'average_T1'}.long_name ='Start time for average period';
nc{'average_T1'}.units     ='days since 1869-12-1 00:00:00';      

nc{'average_T2'}.long_name ='End time for average period';
nc{'average_T2'}.units     ='days since 1869-12-1 00:00:00';      

nc{'average_DT'}.long_name ='Length of average period';
nc{'average_DT'}.units     ='days';      

close(nc); 

'finished first nc file'
% create a new netcdf file

nc = netcdf(fnout_ice,'clobber'); 
if isempty(nc) error('NetCDF File Not Opened.'); end
nc.Conventions = 'CF-1.0';
nc.title = 'Modified ice pattern from Monthly version of HadISST sea surface temperature component';
nc.institution = 'GFDL' ;
nc.source      = 'HadISST';
nc.history     = '09/11/2006 HadISST converted to NetCDF from pp format by John Kennedy; 31/12/2015 modified by Levi Silvers';

nc('time')  = 0; nc('nv')  = 2; nc('idim') = 12; 
nc{'time'}  = ncdouble('time'); nc{'time'}(1:v.nt) = v.time(:); 
nc('lat') = v.nlat;          nc('lon')     = v.nlon;
nc{'lat'} = ncfloat('lat');  nc{'lat'} (:) = v.lat; 
nc{'lon'} = ncfloat('lon');  nc{'lon'} (:) = v.lon; 

nc{'ice'}=ncfloat('time','lat','lon'); nc{'ice'}(:,:,:)=ice_general(:,:,:);
%nc{'climatology_bounds'} = ncdouble('time','nv'); 
%nc{'climatology_bounds'}(:,:)=v.climatology_bounds(:,:);
nc{'yr'} = ncint('idim'); nc{'yr'}(:)=v.yr;
nc{'mo'} = ncint('idim'); nc{'mo'}(:)=v.mo;
nc{'dy'} = ncint('idim'); nc{'dy'}(:)=v.dy;
nc{'average_T1'} = ncdouble('time'); nc{'average_T1'}(:)=v.average_T1;
nc{'average_T2'} = ncdouble('time'); nc{'average_T2'}(:)=v.average_T2;
nc{'average_DT'} = ncdouble('time'); nc{'average_DT'}(:)=v.average_DT;
nc{'nrecords'} = ncint();  nc{'nrecords'}(:)=12;

nc{'time'}.long_name     ='Time';      
%nc{'time'}.climatology   ='climatology_bounds';      
nc{'time'}.standard_name ='time';
nc{'time'}.calendar      ='gregorian';
nc{'time'}.units         ='days since 1869-12-1 00:00:00';      
nc{'time'}.delta_t       ='0000-00-01 00:00:00';      
nc{'time'}.modulo        =' ';      

nc{'lat'}.standard_name  = 'latitude' ;    nc{'lat'}.units  = 'degrees_north' ;
nc{'lon'}.standard_name  = 'longitude';    nc{'lon'}.units  = 'degrees_east' ;

nc{'yr'}.long_name    ='year';      
nc{'mo'}.long_name    ='month';      
nc{'dy'}.long_name    ='day';      

nc{'ice'}.long_name     ='fractional amount of sea ice';
nc{'ice'}.standard_name ='ice_mask';
nc{'ice'}.units         ='none';      
nc{'ice'}.add_offset    = 0.e0;
nc{'ice'}.scale_factor  = 1.e0;
nc{'ice'}.FillValue_    =-1.e+20;
% matlab for some reason doesn't like the notation below...
%nc{'ice'}.valid_range   =-0.01f, +1.01f;
nc{'ice'}.missing_value =-1.e+20;
nc{'ice'}.description   ='HadIice_mask 1.1 monthly average sea surface temperature';
nc{'ice'}.cell_methods  ='time: mean';
nc{'ice'}.time_avg_info ='average_T1,average_T2,average_DT';

nc{'average_T1'}.long_name ='Start time for average period';
nc{'average_T1'}.units     ='days since 1869-12-1 00:00:00';      

nc{'average_T2'}.long_name ='End time for average period';
nc{'average_T2'}.units     ='days since 1869-12-1 00:00:00';      

nc{'average_DT'}.long_name ='Length of average period';
nc{'average_DT'}.units     ='days';      

close(nc); 

'finished second nc file'

% create a new netcdf file
% this is just for the reg array
nc = netcdf('reg_pattern.nc','clobber'); 
if isempty(nc) error('NetCDF File Not Opened.'); end
nc.Conventions = 'CF-1.0';
nc.title = 'regression pattern of warming';
nc.institution = 'GFDL' ;
nc.source      = 'HadISST';
nc.history     = 'created on 01/03/2016' ;

nc('time')  = 0; nc('nv')  = 2; nc('idim') = 12; 
nc{'time'}  = ncdouble('time'); nc{'time'}(1:v.nt) = v.time(:); 
nc('lat') = v.nlat;          nc('lon')     = v.nlon;
nc{'lat'} = ncfloat('lat');  nc{'lat'} (:) = v.lat; 
nc{'lon'} = ncfloat('lon');  nc{'lon'} (:) = v.lon; 

nc{'reg_arr'}=ncfloat('time','lat','lon'); nc{'reg_arr'}(:,:,:)=regarray(:,:,:);
nc{'reg_arr_ice'}=ncfloat('time','lat','lon'); nc{'reg_arr_ice'}(:,:,:)=regarray_ice(:,:,:);
nc{'yr'} = ncint('idim'); nc{'yr'}(:)=v.yr;
nc{'mo'} = ncint('idim'); nc{'mo'}(:)=v.mo;
nc{'dy'} = ncint('idim'); nc{'dy'}(:)=v.dy;
nc{'average_T1'} = ncdouble('time'); nc{'average_T1'}(:)=v.average_T1;
nc{'average_T2'} = ncdouble('time'); nc{'average_T2'}(:)=v.average_T2;
nc{'average_DT'} = ncdouble('time'); nc{'average_DT'}(:)=v.average_DT;
nc{'nrecords'} = ncint();  nc{'nrecords'}(:)=12;

nc{'time'}.long_name     ='Time';      
nc{'time'}.standard_name ='time';
nc{'time'}.calendar      ='gregorian';
nc{'time'}.units         ='days since 1869-12-1 00:00:00';      
nc{'time'}.delta_t       ='0000-00-01 00:00:00';      
nc{'time'}.modulo        =' ';      

nc{'lat'}.standard_name  = 'latitude' ;    nc{'lat'}.units  = 'degrees_north' ;
nc{'lon'}.standard_name  = 'longitude';    nc{'lon'}.units  = 'degrees_east' ;

nc{'yr'}.long_name    ='year';      
nc{'mo'}.long_name    ='month';      
nc{'dy'}.long_name    ='day';      

nc{'reg_arr'}.long_name     ='linear reg values';
nc{'reg_arr'}.standard_name ='reg';
nc{'reg_arr'}.units         ='degK per yr';      
nc{'reg_arr'}.add_offset    = 0.e0;
nc{'reg_arr'}.scale_factor  = 1.e0;
nc{'reg_arr'}.FillValue_    =-1.e+30;
nc{'reg_arr'}.missing_value =-1.e+30;
nc{'reg_arr'}.description   ='reg pattern from 150 yr historical run';
nc{'reg_arr'}.cell_methods  ='time: lat: lon: mean within months time: mean over years';
nc{'reg_arr'}.time_avg_info ='average_T1,average_T2,average_DT';

nc{'reg_arr_ice'}.long_name     ='linear reg values for sea ice';
nc{'reg_arr_ice'}.standard_name ='reg';
nc{'reg_arr_ice'}.units         ='percent change per yr';      
nc{'reg_arr_ice'}.add_offset    = 0.e0;
nc{'reg_arr_ice'}.scale_factor  = 1.e0;
nc{'reg_arr_ice'}.FillValue_    =-1.e+30;
nc{'reg_arr_ice'}.missing_value =-1.e+30;
nc{'reg_arr_ice'}.description   ='reg pattern of sea ice from 150 yr historical run';
nc{'reg_arr_ice'}.cell_methods  ='time: lat: lon: mean within months time: mean over years';
nc{'reg_arr_ice'}.time_avg_info ='average_T1,average_T2,average_DT';

nc{'average_T1'}.long_name ='Start time for average period';
nc{'average_T1'}.units     ='days since 1869-12-1 00:00:00';      

nc{'average_T2'}.long_name ='End time for average period';
nc{'average_T2'}.units     ='days since 1869-12-1 00:00:00';      

nc{'average_DT'}.long_name ='Length of average period';
nc{'average_DT'}.units     ='days';      

close(nc); 

'finished third nc file'

% create a new netcdf file
% this is just for the reg array
nc = netcdf('reg_pattern_mnsst.nc','clobber'); 
if isempty(nc) error('NetCDF File Not Opened.'); end
nc.Conventions = 'CF-1.0';
nc.title = 'regression pattern of warming';
nc.institution = 'GFDL' ;
nc.source      = 'HadISST';
nc.history     = 'created on 01/03/2016' ;

nc('time')  = 0; nc('nv')  = 2; nc('idim') = 12; 
nc{'time'}  = ncdouble('time'); nc{'time'}(1:v.nt) = v.time(:); 
nc('lat') = v.nlat;          nc('lon')     = v.nlon;
nc{'lat'} = ncfloat('lat');  nc{'lat'} (:) = v.lat; 
nc{'lon'} = ncfloat('lon');  nc{'lon'} (:) = v.lon; 

nc{'reg_arr'}=ncfloat('time','lat','lon'); nc{'reg_arr'}(:,:,:)=sst_reg_vs_mnsst(:,:,:);
%nc{'reg_arr_ice'}=ncfloat('time','lat','lon'); nc{'reg_arr_ice'}(:,:,:)=regarray_ice(:,:,:);
nc{'yr'} = ncint('idim'); nc{'yr'}(:)=v.yr;
nc{'mo'} = ncint('idim'); nc{'mo'}(:)=v.mo;
nc{'dy'} = ncint('idim'); nc{'dy'}(:)=v.dy;
nc{'average_T1'} = ncdouble('time'); nc{'average_T1'}(:)=v.average_T1;
nc{'average_T2'} = ncdouble('time'); nc{'average_T2'}(:)=v.average_T2;
nc{'average_DT'} = ncdouble('time'); nc{'average_DT'}(:)=v.average_DT;
nc{'nrecords'} = ncint();  nc{'nrecords'}(:)=12;

nc{'time'}.long_name     ='Time';      
nc{'time'}.standard_name ='time';
nc{'time'}.calendar      ='gregorian';
nc{'time'}.units         ='days since 1869-12-1 00:00:00';      
nc{'time'}.delta_t       ='0000-00-01 00:00:00';      
nc{'time'}.modulo        =' ';      

nc{'lat'}.standard_name  = 'latitude' ;    nc{'lat'}.units  = 'degrees_north' ;
nc{'lon'}.standard_name  = 'longitude';    nc{'lon'}.units  = 'degrees_east' ;

nc{'yr'}.long_name    ='year';      
nc{'mo'}.long_name    ='month';      
nc{'dy'}.long_name    ='day';      

nc{'reg_arr'}.long_name     ='linear reg values';
nc{'reg_arr'}.standard_name ='reg';
nc{'reg_arr'}.units         ='degK per yr';      
nc{'reg_arr'}.add_offset    = 0.e0;
nc{'reg_arr'}.scale_factor  = 1.e0;
nc{'reg_arr'}.FillValue_    =-1.e+30;
nc{'reg_arr'}.missing_value =-1.e+30;
nc{'reg_arr'}.description   ='reg pattern from 150 yr historical run';
nc{'reg_arr'}.cell_methods  ='time: lat: lon: mean within months time: mean over years';
nc{'reg_arr'}.time_avg_info ='average_T1,average_T2,average_DT';

%nc{'reg_arr_ice'}.long_name     ='linear reg values for sea ice';
%nc{'reg_arr_ice'}.standard_name ='reg';
%nc{'reg_arr_ice'}.units         ='percent change per yr';      
%nc{'reg_arr_ice'}.add_offset    = 0.e0;
%nc{'reg_arr_ice'}.scale_factor  = 1.e0;
%nc{'reg_arr_ice'}.FillValue_    =-1.e+30;
%nc{'reg_arr_ice'}.missing_value =-1.e+30;
%nc{'reg_arr_ice'}.description   ='reg pattern of sea ice from 150 yr historical run';
%nc{'reg_arr_ice'}.cell_methods  ='time: lat: lon: mean within months time: mean over years';
%nc{'reg_arr_ice'}.time_avg_info ='average_T1,average_T2,average_DT';

nc{'average_T1'}.long_name ='Start time for average period';
nc{'average_T1'}.units     ='days since 1869-12-1 00:00:00';      

nc{'average_T2'}.long_name ='End time for average period';
nc{'average_T2'}.units     ='days since 1869-12-1 00:00:00';      

nc{'average_DT'}.long_name ='Length of average period';
nc{'average_DT'}.units     ='days';      

close(nc); 

