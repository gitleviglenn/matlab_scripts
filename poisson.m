%--------------------------------------------------
% solve a poisson equation: Delta*u = f
%
% given f we want to solve for u
%
% I am attempting to compute the partitioning of the 
% vertical pressure velocity as described by 
% Schwendike et al., 2014 using the successive over
% relaxation technique to solve the poisson equation
% see Fulton et al., 1986 for details of SOR. 
%
% starting out very simple on a 10x10 domain
%
% levi silvers                       jan 2022
%--------------------------------------------------

% input file(s)
source_file='~/data/CAM/wap500_CFday_CESM2-FV2_historical_r1i1p1f1_gn_20100101-20150101.nc';
wap500_full=ncread(source_file,'wap500');
latitude = ncread(source_file,'lat');
longtude = ncread(source_file,'lon');

wap500=wap500_full(:,:,10);


slon =size(wap500,1);
slat =size(wap500,2);
% parameter
a_earth=6350000;
rad = pi/180.
r=1.5 % relaxation parameter, if r=1, SOR reduces to Gauss-Seidel method
errend=100; % number of itterations for the loop

% these will need to be modified for use on a sphere, and will then depend on lat
%h1=1; 
h1=ones(size(wap500,2));
h2=ones(size(wap500,1));
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
u    = zeros(kend,jend); % old values
un   = zeros(kend,jend); % new values
diff = zeros(kend,jend);
%f    = zeros(kend,jend)+5.;
f = wap500;

% boundary conditions

% Loop
for err=1:errend;
  for k=k0+1:1:kend-1;
    for j=j0+1:1:jend-1;
      un(k,j)=(1-r)*u(k,j)+(r/4.)*((h1(j)*h2(k))*f(k,j)+un(k-1,j)+u(k+1,j)+un(k,j-1)+u(k,j+1));
      diff(k,j)=un(k,j)-u(k,j);
    end
  end
  diff(3,3)
  u=un;
end



