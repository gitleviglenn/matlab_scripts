function [gam_dtdz,gam_wv,delta_frac]=lapser_wv(tsfc,ttmp,ztmp,rhtmp,modelnum)
%--------------------------------------------------------------------
% function that computes the temperature lapse rate in height coords
% as well as the water vapor (wv) lapse rate
%
% originally written for use with domain mean profiles from RCEMIP
%
% levi silvers                                           Oct 2021
%--------------------------------------------------------------------

grav      =9.81;
Rd        =287.;   % J/kg K gas constant for dry air
Rv        =461.;   % J/(kg K) gas constant for water vapor
%latheat   =2.52e6; % J/kg latent heat of vaporization
latheat   =2.501e6; % J/kg latent heat of vaporization recommended by Wing et al. 2018
cpd       =1000.;  % J/kg K cp for dry air
epsilon   =Rd/Rv;
psfc      =1015.0;
% tsfc      =295;
zsfc      =0;

% first calculate temperature lapse rate

% then use the temperature lapse rate to calculate the water vapor lapse
% rate as shown in Romps 2014
[m,n]=size(ttmp)

gam_dtdz  = zeros(m,n);
gam_wv    = zeros(m,n);

zindex=m-1;
lasti=m;
for zi=2:zindex;
  gam_dtdz(zi)=(ttmp(zi+1)-ttmp(zi-1))/(ztmp(zi+1)-ztmp(zi-1));
end

gam_dtdz(lasti)=gam_dtdz(lasti-1);
gam_dtdz(1)    =(ttmp(1)-tsfc)/(ztmp(1)-zsfc);

%zindex=m-1;
for zi=1:m;
  gam_wv(zi)=(latheat*gam_dtdz(zi)./(Rv.*ttmp(zi).^2))-grav/(Rd*ttmp(zi));
end 

for zi=1:m;
  delta_frac(zi)=gam_wv(zi)*(0.01.*rhtmp(zi)/(1-0.01.*rhtmp(zi)));
end

%figure
%plot(gam_dtdz,ztmp)
%%set(gca,'Ydir','reverse')
%ylabel('height (m)')
%xlabel('Temp Lapse Rate, (K/m)')
%title(modelnum)
%set(gca,'FontWeight','bold')
%
%figure
%plot(gam_wv,ztmp)
%ylabel('height (m)')
%xlabel('WV Lapse Rate, (1/m)')
%title(modelnum)
%set(gca,'FontWeight','bold')

%figure
%subplot(1,2,1)
%plot(0.01.*rhtmp,ttmp)
%set(gca,'Ydir','reverse')
%ylabel('Temp (K)')
%xlabel('RH')
%title(modelnum)
%set(gca,'FontWeight','bold')
%
%%figure
%subplot(1,2,2)
%plot(delta_frac,ttmp)
%set(gca,'Ydir','reverse')
%ylabel('Temp (K)')
%xlabel('delta (1/m)')
%title(modelnum)
%set(gca,'FontWeight','bold')





