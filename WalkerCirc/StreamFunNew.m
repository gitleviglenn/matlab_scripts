%----------------------------------------------------------------------
% StreamFun.m
%
% computes mass streamfunction (psi_3, psi_crm_3) for 25km and 2km data
%
% psi depends on: w,u,sphum,temp, and pfull
%
% psi is computed as: psi(rho,w,u)=dx*rho(i,j)*w_ztmn(i,j)+u_bc_p;
% 
% The density rho is computed with the virtual temperature Tv
% rho(i,j)=pfull(j)/(r_dry*Tv(i,j));
% Tv=temp_ztmn.*(1+sphum_ztmn./epsilon)./(1+sphum_ztmn);
% where sphum referes to the specific humidity
%
% The boundary condition in u is: 
%      u_bc_p=sum(u_bc); --> sum over vertical levels where u_bc is:
%      u_bc(jj)=(1/grav)*u_ztmn(i,jj)*(pfull(jj)-pfull(jj-1));
%
% It is likely that for the 25km experiments there will be an additional 
% time dimension compared to the 1km and 2km experiments.  Create a 
% driver script that calls this one.  
% In the driver before calling StreamFunNew define the following:
%   source_psi
%   con_stream
%   dx_gen
%   x_ngp_gen
%   title ; to indicate which resolution streamfunction is being plotted
%
% for the 6 variables below it is likely that a time average will
% need to be done before StreamFunNew is called
%   w_gen
%   u_gen
%   sphum_gen
%   temp_gen
%   pfull_gen
%
% levi silvers                                               june 2018
%----------------------------------------------------------------------
%path_base='/Users/silvers/data/WalkerCell/'

% constant added to the streamfunction
%con_stream=2000.;

%% specific parameters
%%%source_psi=strcat('/Users/silvers/data/WalkerCell/gauss_d/c96L33_am4p0_10x4000_nh_1km_wlkr_4K/19790601.atmos_month_psivars.nc');
%%source_psi=strcat('/Users/silvers/data/WalkerCell/gauss_d/c96L33_am4p0_10x4000_nh_1km_wlkr_4K/1979.mn3456.atmos_month_psivars.tmn.nc');
%source_psi=strcat('/Users/silvers/data/WalkerCell/gauss_d/c10x4000L33_am4p0_1km_wlkr_4K/1979.mn3456.atmos_month_psivars.tmn.nc');
%dx_gen=1000.; % grid cell size in meters
%x_ngp_gen=4000; % width of domain in grid points

%source_psi=strcat('/Users/silvers/data/WalkerCell/gauss_d/c50x2000L33_am4p0_2km_wlkr_4K/1979.mn3456.atmos_month_psivars.tmn.nc');
%dx_gen=2000.; % grid cell size in meters
%x_ngp_gen=2000; % width of domain in grid points
%tit_id=' 2km'

%% dimensions for the 1km run are: xdim,ydim,zdim, no time dimension
%w_gen=ncread(source_psi,'w');
%u_gen=ncread(source_psi,'ucomp');
%sphum_gen=ncread(source_psi,'sphum');
%temp_gen=ncread(source_psi,'temp');
%pfull_gen=ncread(source_psi,'pfull');
%pfull_gen=100.*pfull_gen;

% this generalization will not work if the incoming data has not already been time averaged...

%gridspac=2

% if using a 1km or 2km resolution...
if gridspac < 10
% incoming data should have xdim ydim zdim
  w_gen=ncread(source_psi,'w');
  u_gen=ncread(source_psi,'ucomp');
  sphum_gen=ncread(source_psi,'sphum');
  temp_gen=ncread(source_psi,'temp');
  pfull_gen=ncread(source_psi,'pfull');
% else if using a 25km resolution...
  'grid spacing is less than 10km '
else % grid spacing is greater than 10 km 
  an_t1=3;
  an_t2=12;
  w_25km=ncread(source_psi,'w');
  u_25km=ncread(source_psi,'ucomp');
  sphum_25km=ncread(source_psi,'sphum');
  temp_25km=ncread(source_psi,'temp');
  pfull_25km=ncread(source_psi,'pfull');
% incoming data should have xdim ydim zdim tdim
% compute the time average...
% the _gen variables should have xdim ydim zdim
% w_gen=w_25km_zmn
  u_25km_eq=u_25km(:,:,:,an_t1:an_t2); % grab equilibrated period
  u_25km_tmn=squeeze(mean(u_25km_eq,4)); % time mean
  u_gen=u_25km_tmn;

  w_25km_eq=w_25km(:,:,:,an_t1:an_t2); % grab equilibrated period
  w_25km_tmn=squeeze(mean(w_25km_eq,4)); % time mean
  w_gen=w_25km_tmn;

  sphum_25km_eq=sphum_25km(:,:,:,an_t1:an_t2); % grab equilibrated period
  sphum_25km_tmn=squeeze(mean(sphum_25km_eq,4)); % time mean
  sphum_gen=sphum_25km_tmn;

  temp_25km_eq=temp_25km(:,:,:,an_t1:an_t2); % grab equilibrated period
  temp_25km_tmn=squeeze(mean(temp_25km_eq,4)); % time mean
  temp_gen=temp_25km_tmn;

  pfull_gen=pfull_25km;
  'grid spacing is more than 10km '
end 

pfull_gen=100.*pfull_gen;

% compute the zonal mean of incoming data
temp_gen_ztmn=squeeze(mean(temp_gen,2));
sphum_gen_ztmn=squeeze(mean(sphum_gen,2));
u_gen_ztmn=squeeze(mean(u_gen,2));
w_gen_ztmn=squeeze(mean(w_gen,2));

%pfull_25km=100.*pfull_25km; % convert to Pa
%pfull_2km=100.*pfull_2km; % convert to Pa

r_dry=287.; % J/kg K
epsilon=0.622;
grav=9.81; % m/s2
a_earth=6350000; % m   lower bound on Earth's radius

clear rho_gen
Tv_gen=temp_gen_ztmn.*(1+sphum_gen_ztmn./epsilon)./(1+sphum_gen_ztmn);
for j=33:-1:1
    for i=1:x_ngp_gen
        rho_gen(i,j)=pfull_gen(j)/(r_dry*Tv_gen(i,j));
    end
end

%psi_gen=zeros(x_ngp_gen,33);
%
%u_bc(1)=(1/grav)*u_gen_ztmn(1,1)*(pfull_gen(2)-pfull_gen(1));
%
%for j=33:-1:2
%    psi_gen(1,j)=psi_gen(x_ngp_gen,j)-dx_gen.*rho_gen(1,j)*w_gen_ztmn(1,j);
%    for i=2:x_ngp_gen
%        % compute the boundary condition u_bc_p
%      u_bc=zeros(33,1);
%      for jj=33:-1:j 
%         %u_bc(jj)=(1/grav)*u_gen_ztmn(i,jj)*(pfull_gen(jj)-pfull_gen(jj-1));
%         u_bc(jj)=(1/(grav*rho_gen(i,j)))*u_gen_ztmn(i,jj)*(pfull_gen(jj)-pfull_gen(jj-1));
%      end
%      u_bc_p=sum(u_bc);
%        %%psi_crm_3(i+1,j)=psi_crm_3(i-1,j)-2*dx_crm.*rho_2km(i,j)*w_2km_ztmn(i,j);
%        %psi_gen(i,j)=dx_gen*rho_gen(i,j)*w_gen_ztmn(i,j)...
%        %    +u_bc_p;
%        psi_gen(i,j)=dx_gen*rho_gen(i,j)*w_gen_ztmn(i,j)...
%            +u_bc_p;
%    end
%end

% compute streamfunction by integrating the zonal velocity
clear psi_gen
psi_gen=zeros(x_ngp_gen,33)+con_stream;
for i=1:x_ngp_gen
    for jj=1:32
        %psi_gen(i,jj+1)=psi_gen(i,jj)-(u_gen_ztmn(i,jj+1)/(grav*rho_gen(i,jj+1)))*(pfull_gen(jj+1)-pfull_gen(jj));
        psi_gen(i,jj+1)=psi_gen(i,jj)-u_gen_ztmn(i,jj+1)*(pfull_gen(jj+1)-pfull_gen(jj));
    end
end

%%% % 
%figure
%subplot(1,3,3)
%%stream_cons=[-6000.,-5000.,-4000.,-3000.,-2000.,-1000.,0.0,1000.,2000.,3000.,4000.,5000.,6000.];
%stream_cons=[-9000.,-8000.,-7000.,-6000.,-5000.,-4000.,-3000.,-2000.,-1000.,0.0,1000.,2000.,3000.,4000.,5000.,6000.,7000.,8000.,9000.];
%[C,h]=contourf(1:xgcm_ngp,pfull_25km,psi_3',stream_cons);
%v=[-7000,-5000,-3000,-2000,-1000,0,1000,3000,5000,7000]; % if labels are desired on contours
%clabel(C,h,v);
%title('GCM mass streamfunction')
%set(gca,'Ydir','reverse')
%
%subplot(1,3,2)
%[C,h]=contourf(1:xcrm_ngp,pfull_2km,psi_crm_3',stream_cons);
%clabel(C,h,v);
%title('2km CRM mass streamfunction')
%set(gca,'Ydir','reverse')
%
%subplot(1,3,1)
%[C,h]=contourf(1:x_ngp_gen,pfull_gen,psi_gen',stream_cons);
%clabel(C,h,v);
%title('1km CRM mass streamfunction')
%set(gca,'Ydir','reverse')
%
%
%tit_str=strcat('Streamfunction: ',tit_st);
%suptitle(tit_str)

figure
%scale2m2=625e6;
scale2mass=a_earth*grav;
psi_gen=scale2mass.*psi_gen;
scale_cons=1e11;
%stream_cons=[-6000.,-5000.,-4000.,-3000.,-2000.,-1000.,0.0,1000.,2000.,3000.,4000.,5000.,6000.];
%stream_cons=[-6.,-5.,-4.,-3.,-2.,-1.,0.0,1.,2.,3.,4.,5.,6.];
%stream_cons=[-30.,-25.,-20.,-15.,-10.,-5.,0.0,5.,10.,15.,20.,25.,-30.];
stream_cons=[-50.,-45.,-40.,-35.,-30.,-25.,-20.,-15.,-10.,-5.,0.0,5.,10.,15.,20.,25.,30.,35.,40.,45.,50.];
%stream_cons=[-3.,-2.5,-2.,-1.5,-1.,-0.5,0.0,0.5,1.,1.5,2.,2.5,3.];
stream_cons=scale_cons.*stream_cons;
[C,h]=contourf(1:x_ngp_gen,pfull_gen,psi_gen',stream_cons);
%v=[-3000,-2000,-1000,0,1000,2000,3000]; % if labels are desired on contours
v=stream_cons;
clabel(C,h,v);
tit_str=strcat('mass Streamfunction: ',tit_id);
title(tit_str)
set(gca,'Ydir','reverse')
