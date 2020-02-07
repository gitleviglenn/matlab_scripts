%-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
% general script to test the new compset for CAM6 RCE.
% 
% CAM6_GCM_RCE_large300.cam.h0.2002-05.nc
%
% Questions: What are the time units?  
%            Why does the precip have units of m/s? multiply by density to get
%            units of: kg / m-2 s-1, which matches the CF compliant units  
%
% these are the units for the CF compliant precip:
% pr_avg:units = "kg m-2 s-1" ;
%
% levi silvers                                                  Jan 2020       
%-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

source='/Users/silvers/data/CAM/';

model_generation='CAM6';
source_mod=strcat(source,model_generation,'_test/');

var1='PRECT';          
var2='U';
var3='T';
plev='lev';

SSTst="300";
%exp_string=strcat(model_generation,'_GCM_RCE_large',SSTst,'.cam.h0.2002-05'); % Pbar = 2.8384
%exp_string=strcat(model_generation,'_GCM_RCE_large',SSTst,'.cam.h0.2001-05'); % Pbar = 2.7479
exp_string=strcat(model_generation,'_GCM_RCE_large',SSTst,'.cam.h0.2002-11'); % Pbar = 2.9603
s_var1=strcat(source_mod,exp_string,'.nc');

h1_string=strcat(source_mod,'CAM6_GCM_RCE_large300.cam.h1.2000-02-06-43200','.nc');
CLDTOT_h1=ncread(h1_string,'CLDTOT');

prect=ncread(s_var1,var1); % --> multiply by 1000*86400 to convert to mm/day (probably?)
uwind=ncread(s_var1,var2);
temp=ncread(s_var1,var3);
plev=ncread(s_var1,plev);

pbar=mean(prect)*1000.*86400

figure
plot(dom_mn_u,plev(:))
set(gca,'Ydir','reverse')
ylabel('[hPa]')
xlabel('u wind [m/s]')
hold on
plot(uwind(4000,:),plev(:))
plot(dom_mn_u,plev(:),'k','LineWidth',1.5)


%        float PRECT(time, ncol) ;
%                PRECT:units = "m/s" ;
%                PRECT:long_name = "Total (convective and large-scale) precipitation rate (liq + ice)" ;
%        float PS(time, ncol) ;
%                PS:units = "Pa" ;
%                PS:long_name = "Surface pressure" ;
%        float Q(time, lev, ncol) ;
%                Q:mdims = 1 ;
%                Q:units = "kg/kg" ;
%                Q:mixing_ratio = "wet" ;
%                Q:long_name = "Specific humidity" ;
%        float T(time, lev, ncol) ;
%                T:mdims = 1 ;
%                T:units = "K" ;
%                T:long_name = "Temperature" ;
%        float U(time, lev, ncol) ;
%                U:mdims = 1 ;
%                U:units = "m/s" ;
%                U:long_name = "Zonal wind" ;
%        float V(time, lev, ncol) ;
%                V:mdims = 1 ;
%                V:units = "m/s" ;
%                V:long_name = "Meridional wind" ;
%        float Z3(time, lev, ncol) ;
%                Z3:mdims = 1 ;
%                Z3:units = "m" ;
%                Z3:long_name = "Geopotential Height (above sea level)" ;
