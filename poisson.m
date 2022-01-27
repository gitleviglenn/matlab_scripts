%--------------------------------------------------
% solve a poisson equation: Delta*u = f
%
% given f we want to solve for u
%
% I am attempting to compute the partitioning of the 
% vertical pressure velocity as described by 
% Schwendike et al., 2014 
%
% The atmospheric vertical motion is decomposed into 
% the vertical motion associated with the overturning in 
% the zonal direction, and the vertical motion associated
% with the meridional direction.  
%
% The solution of the Poisson equation uses a successive over
% relaxation technique to solve the poisson equation
% see Fulton et al., 1986 for details of SOR. 
%
% I don't understand how best to apply the boundary conditions..
%
% is this only solvable up to an arbitrary sign or 
% additive constant?
%
% in matlab, it looks like the function solvepde could 
% work well, is there a good equivalent in python?
%
% levi silvers                       jan 2022
%--------------------------------------------------

% this controls how many times the solution is 
% itterated, the number of times needed depends
% on the desired degree of accuracy and on r.
errend=30000; % number of itterations for the loop

% input file(s)
% source_file='~/data/CAM/wap500_CFday_CESM2-FV2_historical_r1i1p1f1_gn_20100101-20150101.nc';
%wap500_full=ncread(source_file,'wap500');

% below is a file with 3D wap output monthly.
source_file='~/data/CAM/wap_Amon_CESM2-FV2_amip_r2i1p1f1_gn_200001-201412.nc';
wap_full=ncread(source_file,'wap');
level=6; % this should be the 500 hPa level
wap500_full=squeeze(wap_full(:,:,level,:));


latitude = ncread(source_file,'lat');
longtude = ncread(source_file,'lon');
press_le = ncread(source_file,'plev');

dlat=latitude(5)-latitude(4); % assuming latitudes are evenly spaced
dlon=longtude(5)-longtude(4);


%grab a particular time...
%wap500=wap500_full(:,:,10);
% below for time mean of monthly mean data
%wap500=mean(wap500_full,3);
% below is grabbing data from just one month

%timelevel=13
wap500=squeeze(wap500_full(:,:,timelevel));


slon =size(wap500,1);
slat =size(wap500,2);
% parameter
a_earth=6350000;
rad = pi/180.;
r=1.5 % relaxation parameter, if r=1, SOR reduces to Gauss-Seidel method
conv=864.; % (hPa s)/(Pa day); used to convert Pa/s to hPa/day

wap500=conv.*wap500;

% these will need to be modified for use on a sphere, and will then depend on lat
%h1=1; 
h1=ones(size(wap500,2),1);
%h2=ones(size(wap500,1),1);
h1=cos(latitude*rad);
%h2=2; 

% these will need modification depending on the domain being used.
j0=1;
jend=slat;
k0=1;
kend=slon;

% define fields --> eventually f should be an input to the script
% if we determine that 0 is an appropriate boundary condition (bc), then this 
% initial array definition also defines bc's.
u           = zeros(kend,jend); % old values
un          = zeros(kend,jend); % new values
omega_wc    = zeros(kend,jend); % new values
omega_hc    = zeros(kend,jend); % new values
omega_total = zeros(kend,jend); % new values
diff = zeros(kend,jend);
%f    = zeros(kend,jend)+5.;
f = wap500;

% maybe we should determine the j range here, rather than in the loop below?
for j=j0:1:jend/2;
  if abs(latitude(j))<80; % this is probably where BC should be applied
  %'inside domain'
  else 
  %'outside domain'
  index=j;
  end
end

for err=1:errend;
  for k=k0+1:1:kend-1; % loop over longitudes
    %un(k+1,j0+index-1)=un(k+1,j0+index); % BC at (k+1,j0+index-1)
    for j=j0+index:1:jend-index; % loop over latitudes
      un(k,j)=(1-r)*u(k,j)+(r/4.)*((h1(j)*dlat*dlon*a_earth*a_earth)*f(k,j)+un(k-1,j)+u(k+1,j)+un(k,j-1)+u(k,j+1));
      diff(k,j)=un(k,j)-u(k,j);
    end
    % what are the correct BCs at the polar latitudes?  
    % the solution blows up if we set the value at jend+1 equal to jend
    %un(k+1,jend-index+1)=un(k0,jend-index); % BC at (k+1,jend-index+1)
    %un(k+1,j0+index-1)=un(k0,j0+index); % BC at (k+1,j0+index-1)
    un(k+1,jend-index+1)=0; % BC at (k+1,jend-index+1)
    un(k+1,j0+index-1)=0; % BC at (k+1,j0+index-1)
  end
  %un(k+1,j0+index-1)=un(k+1,j0+index); % BC at (k+1,j0+index-1)
  % calculate kend value and apply doubly periodic BC to find values at k0
  for j=j0+index:1:jend-index;
    un(kend,j)=(1-r)*u(kend,j)+(r/4.)*((h1(j)*dlat*dlon*a_earth*a_earth)*f(kend,j)+un(kend-1,j)+u(k0,j)+un(kend,j-1)+u(kend,j+1));
    un(k0,j)  =un(kend,j);
  end
  % save new approximation for next iteration.  
  u=un;
end 

% print the error at one arbitrary point
diff(40,40)
maxerr=max(max(diff))
minerr=min(min(diff))

% calculate the longitudinal omega omega_lon(k,j) or (lon,lat)
% k is the zonal index, j is the meridional index
% omega_lon(k,j)=(1/(a_earth^2*h1(j)^2))*(partial^2 mu/partial lambda^2)
for k=k0+1:1:kend-1;
  %for j=j0+1:1:jend-1; 
  for j=j0+index:1:jend-index; % loop over latitudes
    omega_wc(k,j)=(-1/(a_earth^2*h1(j)^2))*((un(k+1,j)-2*un(k,j)+un(k-1,j))/dlon^2);
    omega_hc(k,j)=(-1/(a_earth^2*h1(j)))*((h1(j+1)*un(k,j+1)-2*h1(j)*un(k,j)+h1(j-1)*un(k,j-1))/dlat^2);
  end
end
% BCs at k0 and kend
for j=j0+index:1:jend-index; % loop over latitudes
  omega_wc(kend,j)=(-1/(a_earth^2*h1(j)^2))*((un(k0,j)-2*un(kend,j)+un(kend-1,j))/dlon^2);
  omega_hc(kend,j)=(-1/(a_earth^2*h1(j)))*((h1(j+1)*un(kend,j+1)-2*h1(j)*un(kend,j)+h1(j-1)*un(kend,j-1))/dlat^2);
  omega_wc(k0,j)=omega_wc(kend,j);
  omega_hc(k0,j)=omega_hc(kend,j);
end

omega_total=omega_wc+omega_hc;





