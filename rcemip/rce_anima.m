%-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
% rce_anima.m
%
% at the moment this simply open a file from CAM6 RCE with an 
% SST = 305 and plots an animation of the vertical velocity
% at 500 hPa.  The plan is to further generalize this script
% so that it can easily be used with different experiments or 
% variables.
%
% levi silvers  				dec 17, 2019
%-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-



% model to use
source='/Users/silvers/data/CAM/';
model_generation='CAM6'
source_mod=strcat(source,model_generation,'_GCM_RCE/');

% experiment specific
exp_string='CAM6_GCM_RCE_large305_2D_';

% variable to read
var_w500='wap500';


s_var_wap500=strcat(source_mod,exp_string,var_w500,'.nc')
w500_305=ncread(s_var_wap500,var_w500);

lat=1:1:192;
lon=1:1:288;

ncont=[1.2,0.9,0.6,0.3,0.1,0.08,0.06,0.04,0.02,0.0,-0.02,-0.04,-0.06,-0.08,-0.1,-0.3,-0.6,-0.9,-1.2];

figure
for k=1:100
contourf(lat,lon,w500_305(:,:,k),ncont);
colorbar
hold all
pause(0.2);
end


