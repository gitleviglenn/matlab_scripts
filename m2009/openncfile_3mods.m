%----------------------------------------------------------------
% scripts to read and open data from a netcdf files from 
% 3 different sources and open them into Matlab
%
% this should work for Matlab 2009 
%
% levi silvers                     jan 2017
%----------------------------------------------------------------
'you are using a script in m2009'

% AM2 long amip run
%path='/archive/fjz/AM2.1_1870-2004/AM2.1_1870-2004-HGlob-SST-ICE-1860RAD_A10/pp/atmos/ts/monthly/135yr/';
path2='/net2/Levi.Silvers/data/amip_long/AM2.1_1870-2004/AM2.1_1870-2004-HGlob-SST-ICE-1860RAD_A3/';
years2='atmos.187001-200412'; % 1620 months
endtime_am2=1620;
modtitle_am2='am2longamip';
piece=strcat(path2,years2);

source_tsurf_ts    = strcat(piece,'.t_surf.nc')
source_temp_ts     = strcat(piece,'.temp.nc')
source_tref_ts     = strcat(piece,'.t_ref.nc')
source_rh_ts       = strcat(piece,'.rh.nc')
source_swdn_ts     = strcat(piece,'.swdn_toa.nc')
source_swup_ts     = strcat(piece,'.swup_toa.nc')
source_swup_clr_ts = strcat(piece,'.swup_toa_clr.nc')
source_olr_ts      = strcat(piece,'.olr.nc')
source_olr_clr_ts  = strcat(piece,'.olr_clr.nc')
source_hght_ts     = strcat(piece,'.hght.nc')
source_lcloud_ts   = strcat(piece,'.low_cld_amt.nc')
source_lwp_ts      = strcat(piece,'.LWP.nc')

fin_tsurf     = netcdf(source_tsurf_ts,'nowrite');
fin_temp      = netcdf(source_temp_ts,'nowrite');
fin_tref      = netcdf(source_tref_ts,'nowrite');
fin_hght      = netcdf(source_hght_ts,'nowrite');
fin_rh        = netcdf(source_rh_ts,'nowrite');
fin_swdn      = netcdf(source_swdn_ts,'nowrite');
fin_swup      = netcdf(source_swup_ts,'nowrite');
fin_swup_clr  = netcdf(source_swup_clr_ts,'nowrite');
fin_olr       = netcdf(source_olr_ts,'nowrite');
fin_olr_clr   = netcdf(source_olr_clr_ts,'nowrite');
fin_lcloud    = netcdf(source_lcloud_ts,'nowrite');
fin_lwp       = netcdf(source_lwp_ts,'nowrite');

% grab entire time series 
v.lon_am2ts                   = fin_temp{'lon'}(:); 
v.lat_am2ts                   = fin_temp{'lat'}(:);
v.level_am2ts                 = fin_temp{'level'}(:);
v.hght_am2ts             = fin_hght{'hght'}(:,4,:,:);
v.tsurf_am2ts           = fin_tsurf{'t_surf'}(:,:,:); 
v.temp_am2ts            = fin_temp{'temp'}(:,:,:,:); 
v.tref_am2ts            = fin_tref{'t_ref'}(:,:,:); 
v.rh_am2ts              = fin_rh{'rh'}(:,1,:,:); 
v.lon_am2               = fin_tref{'lon'}(:); 
v.lat_am2               = fin_tref{'lat'}(:);
v.swdn_toa_am2ts        = fin_swdn{'swdn_toa'}(:,:,:,:);
v.swup_toa_am2ts        = fin_swup{'swup_toa'}(:,:,:,:);
v.swup_toa_clr_am2ts    = fin_swup_clr{'swup_toa_clr'}(:,:,:,:);
v.olr_toa_am2ts         = fin_olr{'olr'}(:,:,:,:);
v.olr_toa_clr_am2ts     = fin_olr_clr{'olr_clr'}(:,:,:,:);

v.lcloud_am2ts          = fin_lcloud{'low_cld_amt'}(:,:,:);
v.lwp_am2ts             = fin_lwp{'LWP'}(:,:,:);

%% AM3 long amip
path3='/net2/Levi.Silvers/data/amip_long/AM3/c48L48_am3p9_1860_ext3/';
years3='atmos.187001-200512'; % 1632 months
endtime_am3=1632;
modtitle_am3='am3p9longamip';
piece=strcat(path3,years3);

source_tsurf_ts    = strcat(piece,'.t_surf.nc')
source_temp_ts     = strcat(piece,'.temp.nc')
source_tref_ts     = strcat(piece,'.t_ref.nc')
source_rh_ts       = strcat(piece,'.rh.nc')
source_swdn_ts     = strcat(piece,'.swdn_toa.nc')
source_swup_ts     = strcat(piece,'.swup_toa.nc')
source_swup_clr_ts = strcat(piece,'.swup_toa_clr.nc')
source_olr_ts      = strcat(piece,'.olr.nc')
source_olr_clr_ts  = strcat(piece,'.olr_clr.nc')
source_hght_ts     = strcat(piece,'.hght.nc')
source_lcloud_ts   = strcat(piece,'.low_cld_amt.nc')

fin_tsurf     = netcdf(source_tsurf_ts,'nowrite');
fin_temp      = netcdf(source_temp_ts,'nowrite');
fin_tref      = netcdf(source_tref_ts,'nowrite');
fin_hght      = netcdf(source_hght_ts,'nowrite');
fin_rh        = netcdf(source_rh_ts,'nowrite');
fin_swdn      = netcdf(source_swdn_ts,'nowrite');
fin_swup      = netcdf(source_swup_ts,'nowrite');
fin_swup_clr  = netcdf(source_swup_clr_ts,'nowrite');
fin_olr       = netcdf(source_olr_ts,'nowrite');
fin_olr_clr   = netcdf(source_olr_clr_ts,'nowrite');
fin_lcloud    = netcdf(source_lcloud_ts,'nowrite');

% grab entire time series 
stime=1;
etime=1620;
v.lon_am3ts             = fin_temp{'lon'}(:); 
v.lat_am3ts             = fin_temp{'lat'}(:);
v.level_am3ts           = fin_temp{'level'}(:);
v.hght_am3ts            = fin_hght{'hght'}(stime:etime,5,:,:);
v.tsurf_am3ts           = fin_tsurf{'t_surf'}(stime:etime,:,:); 
v.temp_am3ts            = fin_temp{'temp'}(stime:etime,:,:,:); 
v.tref_am3ts            = fin_tref{'t_ref'}(stime:etime,:,:); 
v.rh_am3ts              = fin_rh{'rh'}(stime:etime,1,:,:); 
v.lon_am3               = fin_tref{'lon'}(:); 
v.lat_am3               = fin_tref{'lat'}(:);
v.swdn_toa_am3ts        = fin_swdn{'swdn_toa'}(stime:etime,:,:,:);
v.swup_toa_am3ts        = fin_swup{'swup_toa'}(stime:etime,:,:,:);
v.swup_toa_clr_am3ts    = fin_swup_clr{'swup_toa_clr'}(stime:etime,:,:,:);
v.olr_toa_am3ts         = fin_olr{'olr'}(stime:etime,:,:,:);
v.olr_toa_clr_am3ts     = fin_olr_clr{'olr_clr'}(stime:etime,:,:,:);

v.lcloud_am3ts          = fin_lcloud{'low_cld_amt'}(stime:etime,:,:);

% AM4 long amip
path4='/net2/Levi.Silvers/data/amip_long/c96L32_am4g10r8_longamip_1860rad/'
years4='atmos.187101-201512';
endtime_am4=1620;
modtitle_am4='am4g10r8longamip: ';
piece=strcat(path4,years4);

source_tsurf_ts    = strcat(piece,'.t_surf.nc')
source_temp_ts     = strcat(piece,'.temp.nc')
source_tref_ts     = strcat(piece,'.t_ref.nc')
source_rh_ts       = strcat(piece,'.rh.nc')
source_swdn_ts     = strcat(piece,'.swdn_toa.nc')
source_swup_ts     = strcat(piece,'.swup_toa.nc')
source_swup_clr_ts = strcat(piece,'.swup_toa_clr.nc')
source_olr_ts      = strcat(piece,'.olr.nc')
source_olr_clr_ts  = strcat(piece,'.olr_clr.nc')
source_hght_ts     = strcat(piece,'.hght.nc')
source_lwp_ts      = strcat(piece,'.LWP.nc')
source_lcloud_ts   = strcat(piece,'.low_cld_amt.nc')

fin_tsurf     = netcdf(source_tsurf_ts,'nowrite');
fin_temp      = netcdf(source_temp_ts,'nowrite');
fin_rh        = netcdf(source_rh_ts,'nowrite');
fin_tref      = netcdf(source_tref_ts,'nowrite');
fin_swdn      = netcdf(source_swdn_ts,'nowrite');
fin_swup      = netcdf(source_swup_ts,'nowrite');
fin_swup_clr  = netcdf(source_swup_clr_ts,'nowrite');
fin_olr       = netcdf(source_olr_ts,'nowrite');
fin_olr_clr   = netcdf(source_olr_clr_ts,'nowrite');
fin_hght      = netcdf(source_hght_ts,'nowrite');
fin_lcloud    = netcdf(source_lcloud_ts,'nowrite');
fin_lwp       = netcdf(source_lwp_ts,'nowrite');

% grab entire time series 
v.lon_am4ts             = fin_temp{'lon'}(:); 
v.lat_am4ts             = fin_temp{'lat'}(:);
v.level_am4ts           = fin_temp{'level'}(:);
v.hght_am4ts            = fin_hght{'hght'}(:,5,:,:);
v.tsurf_am4ts           = fin_tsurf{'t_surf'}(:,:,:); 
v.temp_am4ts            = fin_temp{'temp'}(:,:,:,:); 
v.tref_am4ts            = fin_tref{'t_ref'}(:,:,:); 
v.rh_am4ts              = fin_rh{'rh'}(:,1,:,:); 
v.lon_am4               = fin_tref{'lon'}(:); 
v.lat_am4               = fin_tref{'lat'}(:);
v.swdn_toa_am4ts        = fin_swdn{'swdn_toa'}(:,:,:,:);
v.swup_toa_am4ts        = fin_swup{'swup_toa'}(:,:,:,:);
v.swup_toa_clr_am4ts    = fin_swup_clr{'swup_toa_clr'}(:,:,:,:);
v.olr_toa_am4ts         = fin_olr{'olr'}(:,:,:,:);
v.olr_toa_clr_am4ts     = fin_olr_clr{'olr_clr'}(:,:,:,:);

v.lcloud_am4ts          = fin_lcloud{'low_cld_amt'}(:,:,:);
v.lwp_am4ts             = fin_lwp{'LWP'}(:,:,:);
