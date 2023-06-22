% function to calculate solve the poisson equation
% based on the poisson.m script 
%
% how do i want to specify the geometry of the problem?  in this function or 
% elsewhere? 
%
% input:  timelevel, wap500, conv, errend, slat, slon
% output: omega_wc, omega_hc, and omega_total
%
%------------------------------------------------------------------------------
% solve a poisson equation: Delta*u = f
%
% given f we want to solve for u
%
% called from poisson_driver.m
%
% wap500 is created from a timeslice of wap500_full
% wap500_full is set in openf_setdom.m
%
% the value of timelevel is used to read wap500 from a different time with each
% call from poisson_driver.m
%
% levi silvers                                                   june 2022
%------------------------------------------------------------------------------
%
%        [omega_hc,omega_wc,omega_total] = poisson_fun(timelevel,wap500_full,conv,errend,slat,slon,dlat,dlon,latitude)
function [var1,var2,var3]=poisson_fun(tl,wap500_all,convert,errlim,slt,sln,d1,d2,latude)
%
delete var1;
delete var2;
delete var3;
%
'error limit is:',errlim
%
wap500=squeeze(wap500_all(:,:,tl));
%
%slon =size(wap500,1);
%slat =size(wap500,2);

% basic parameters
a_earth=6350000;
rad = pi/180.;
r=1.5; % relaxation parameter, if r=1, SOR reduces to Gauss-Seidel method
%convert=864.; % (hPa s)/(Pa day); used to convert Pa/s to hPa/day

% convert is set in the omega_plot.m script
wap500=convert.*wap500;

%h1=ones(size(wap500,2),1);
h1=cos(latude*rad);
sn=sin(latude*rad);
cs=cos(latude*rad);

% these will need modification depending on the domain being used.
j0=1;
jend=slt;
k0=1;
kend=sln;
% errlim defines the number of times that the Gauss-Seidel Relaxation scheme is run.
% errlim=3000;

% define fields --> eventually f should be an input to the script
% if we determine that 0 is an appropriate boundary condition (bc), then this 
% initial array definition also defines bc's.
u           = zeros(kend,jend); % old values
un          = zeros(kend,jend); % new values
omega_wc    = zeros(kend,jend); % new values
omega_hc    = zeros(kend,jend); % new values
omega_total = zeros(kend,jend); % new values
var1        = zeros(kend,jend); % new values
var2        = zeros(kend,jend); % new values
var3        = zeros(kend,jend); % new values
diff        = zeros(kend,jend);
rmsdiff     = zeros(errlim,1);
%f    = zeros(kend,jend)+5.;
f = wap500;

index=1;

% define the coefficients
for j=j0:1:jend; % loop over latitudes
  c1(j)=-(a_earth*cs(j))^2;
  c2(j)=-2*((cs(j)/d1)^2+1/d2^2);
  c3(j)=((cs(j)/d1)^2+(sn(j)*cs(j))/d1^2);
  c4(j)=((cs(j)/d1)^2-(sn(j)*cs(j))/d1^2);
  c5(j)=(1/d2^2);
end

%-----------------------------------------------------------------------------

% define the j (latitude) boundary conditions, at the poles on global domain
% boundary conditions need to be updated for each sweep
for k=k0:1:kend; % loop over longitudes
  u(k,j0)=0;
  u(k,jend)=0;
end
for j=j0:1:jend;
  u(k0,j)=u(kend,j);
end

% begin the sweeps that will converge on the solution
% Gauss-Seidel Relaxation; un are the new values, u are the old values
%relax=0.7; --> used for amip
%relax=0.7;
relax=0.9;
for err=1:errlim;
  for k=k0+1:1:kend-1; % loop over longitudes
    for j=j0+index:1:jend-index; % loop over latitudes
      un(k,j)=(1-relax)*u(k,j)+relax/(c2(j))*(c1(j)*f(k,j)-c3(j)*u(k,j+1)-c4(j)*un(k,j-1)-c5(j)*u(k+1,j)-c5(j)*un(k-1,j));
    end
  end

  %--------------------------
  % Boundary Conditions 
  % update BCs for the corner points using old values
  un(k0,j0)=u(k0,j0);
  un(kend,j0)=un(k0,j0);
  un(k0,jend)=u(k0,jend);
  un(kend,jend)=un(k0,jend);

  %%% update the k (longitude) boundary conditions, periodic on global domain
  for j=j0+1:1:jend-1;
    un(k0,j)=1/(c2(j))*(c1(j)*f(k0,j)-c3(j)*u(k0,j+1)-c4(j)*un(k0,j-1)-c5(j)*u(k0+1,j)-c5(j)*un(kend,j));
  %%    %un(k0,j)=u(kend,j);
  %%    %un(kend,j)=u(k0,j);
    un(kend,j)=1/(c2(j))*(c1(j)*f(kend,j)-c3(j)*u(kend,j+1)-c4(j)*un(kend,j-1)-c5(j)*un(k0,j)-c5(j)*un(kend-1,j));
  %    un(kend,j)=un(k0,j);
  end

  % update the j (latitude boundary conditions)
  % disregard the point that is out of bounds for the calculation at the pole, then
  % calclute the mean of all the pole values and set all of them to that constant value.
  % is this crazy?
  for k=k0+1:1:kend-1;
    j=jend;
    un(k,jend)=1/(c2(j))*(c1(j)*(f(k,j)-c4(j)*un(k,j-1)-c5(j)*u(k+1,j)-c5(j)*un(k-1,j)));
    j=j0;
    un(k,j0)=1/(c2(j))*(c1(j)*(f(k,j)-c3(j)*u(k,j+1)-c5(j)*u(k+1,j)-c5(j)*un(k-1,j)));
  end

  % set the j values at the poles to a constant 
  un_zmn=mean(un,1);
  for k=k0:1:kend
    %un(k,jend)=un_zmn(jend); % at the north pole
    %un(k,j0)=un_zmn(j0);     % at the south pole
    un(k,jend)=100; %un_zmn(jend); % at the north pole
    un(k,j0)=100; %un_zmn(j0);     % at the south pole
  end
%--------------------------

% calculate error
  diff        =un-u;
  rmsdiff(err)=sqrt(sum(diff.^2,'all')/(slt*sln)); 
 
%--------------------------
  % save new approximation for next iteration.  
  u=un;
%--------------------------
end

'rmsdiff at 100:',rmsdiff(100)
'rmsdiff at end:',rmsdiff(errlim)

% calculate the longitudinal omega omega_lon(k,j) or (lon,lat)
% k is the zonal index, j is the meridional index
for k=k0+1:1:kend-1;
  for j=j0+index:1:jend-index; % loop over latitudes
    omega_wc(k,j)=(-1/(a_earth^2*cs(j)^2))*((un(k+1,j)-2*un(k,j)+un(k-1,j))/d2^2);
    omega_hc(k,j)=(-1/(a_earth*cs(j))^2)*((cs(j)/d1)^2*(un(k,j+1)-2*un(k,j)+un(k,j-1))+cs(j)*sn(j)*((un(k,j+1)-un(k,j-1))/(2*d1))+(1/d2)^2*(un(k+1,j)-2*un(k,j)+un(k-1,j)));  
  end
end
% BCs at k0 and kend
for j=j0+index:1:jend-index; % loop over latitudes
  omega_wc(kend,j)=(-1/(a_earth^2*cs(j)^2))*((un(k0,j)-2*un(kend,j)+un(kend-1,j))/d2^2);
  omega_hc(kend,j)=(-1/(a_earth*cs(j))^2)*((cs(j)/d1)^2*(un(kend,j+1)-2*un(kend,j)+un(kend,j-1))+cs(j)*sn(j)*((un(kend,j+1)-un(kend,j-1))/(2*d1))+(1/d2)^2*(un(k0,j)-2*un(kend,j)+un(kend-1,j)));  
  omega_wc(k0,j)=omega_wc(kend,j);
  omega_hc(k0,j)=omega_hc(kend,j);
end

var1=omega_hc;
var2=omega_wc;
%omega_total=omega_wc+omega_hc;
var3=omega_wc+omega_hc;


end 
