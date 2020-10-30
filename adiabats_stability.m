%-------------------------------------------------------------------------------------
% trying to figure out how in the dickens to think about adiabatics, static
% stability, and the tropical guiding principles
%
% static stability depends on: temp, hur, press, zfull
%
% much of this was taken from the compTheta.m script
%
% initially depends on functions: lapser.m, moistadiabat.m, satvappres.m
%
% the static stability and its pressure derivative can be computed with: 
% function var = stastap(temp,hur,plot_lat,psfc,press,zfull)
% function [msts,sten,ststp] = stasta_3d(temp,hur,nxg,psfc,press,zfull)
% function var = stastap_3d(statst,nxg,psfc,press)
%
% levi silvers                                      oct 2020
%-------------------------------------------------------------------------------------

phys_constants

% compute both the moist adiabat and the adiabat for a particular experiment

gamma_full  = zeros(160,nlev);
for jx=1:160;
  gamma_full(jx,:)    =lapser(temp_eq_ztmn,rho_25km,jx,tsfc_mn,psurf_zmn,pfull_gen);
end

temp_eq_prof=temp_eq_ztmn(plot_lat,:);
es(:)=satvappres(temp_eq_prof);
qs(:)=qstar(es,pfull_gen);
gamma_m(1,:)=moistadiabat(temp_eq_prof,qs);
