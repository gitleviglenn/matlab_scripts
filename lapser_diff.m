function [mn_gam,mn_mgam,diff_gam,gam,mgam]=lapser_diff(ttmp,ptmp,modelnum)

% physical constants:
% these are also defined in create_RCEMIP_colors.m but I don't want 
% to pass them all in here as well...
grav      =9.81;
Rd        =287.;   % J/kg K gas constant for dry air
Rv        =461.;   % J/(kg K) gas constant for water vapor
%latheat   =2.52e6; % J/kg latent heat of vaporization
latheat   =2.501e6; % J/kg latent heat of vaporization recommended by Wing et al. 2018
cpd       =1000.;  % J/kg K cp for dry air
epsilon   =Rd/Rv;
psfc      =1015.0;
tsfc      =295;

[m,n]=size(ttmp);

gamma   = zeros(m,n);
gamma_m = zeros(m,n);
estar   = zeros(m,n);
qstar   = zeros(m,n);
numer   = zeros(m,n);
denom   = zeros(m,n);
rho     = zeros(m,n);

zindex=m-1;
lasti=m;
rho=100.*ptmp./(Rd*ttmp); % kg/m3
% compute the lapse rate (K/km)
for zi=2:zindex;
  gamma(zi)=-1000.*grav*rho(zi)*((ttmp(zi+1)-ttmp(zi-1))/(100.*ptmp(zi+1)-100.*ptmp(zi-1)));
end
%% if TOM is at index 1
%gamma(1)=gamma(2);
%gamma(lasti)=-grav*rho(lasti)*((ttmp(lasti)-tsfc))/(ptmp(lasti)-psfc)));
%% else
gamma(lasti)=gamma(lasti-1);
gamma(1)=-1000.*grav*rho(1)*((ttmp(1)-tsfc)/(100.*(ptmp(1)-psfc)));
% end if

% saturation vapor pressure (estar in Pa) and 
% saturation mixing ratio (qstar)
% take from Randall's notes
for zi=1:lasti
  estar(zi)   = 611*exp((latheat/Rv)*(1/273-1/ttmp(zi))); % Pa
  qstar(zi)   = epsilon*estar(zi)/(100.*ptmp(zi));
%end
% moist adiabatic lapse rate (K/km)
%for zi=1:lasti
  numer(zi)     = -(grav/cpd)*(1+(latheat*qstar(zi)/(Rd*ttmp(zi))));
  denom(zi)     = (1+(qstar(zi)*latheat^2)/(cpd*Rv*ttmp(zi)^2));
end
gamma_m   = 1000.*numer./denom;
% check if ptmp is between 300 and 700 hPa.
% starts at surface for zi=1; integrate from 700hPa up to 300hPa
gam_part=0.;
gamm_part=0.;
index=1;
for zi=1:lasti-1;
  pressure=ptmp(zi);
  if (pressure <= 700.) && (pressure >= 300.);
    plevs(index)=pressure;
    %pressure;
    delp=ptmp(zi)-ptmp(zi+1);
    gam_part=gam_part+gamma(zi)*delp;  % seems like these should be divided by grav?
    gamm_part=gamm_part+gamma_m(zi)*delp;
    index=index+1;
  end
end
[p1,p2]=size(plevs);
%pdepth=plevs(1)-plevs(p2);
% divide by vert distance over which sum is made
mn_gam   = gam_part/(plevs(1)-plevs(p2)); 
mn_mgam  = gamm_part/(plevs(1)-plevs(p2));

diff_gam=mn_gam-mn_mgam;

gam=gamma;
mgam=gamma_m;

figure
%plot(ptmp,gamma_m)
%plot(ptmp,gamma)
plot(gamma,ptmp)
set(gca,'Ydir','reverse')
ylabel('pressure (hPa)')
xlabel('Lapse Rate')
title(modelnum)
set(gca,'FontWeight','bold')
ylim([100,1000])
xlim([-10.,0.0])
hold on
plot(gamma_m,ptmp)

