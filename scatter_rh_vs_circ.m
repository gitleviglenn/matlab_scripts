%------------------------------------------------------------------
% scatter_rh_vs_circ.m
%
% script to produce a scatter plot of rh vs circulation metrics
%
% levi silvers                                feb 26, 2021
%------------------------------------------------------------------

%[red green blue]
c1=[0.4940 0.1840 0.5560]; % purple
c2=[0.25 0.32 0.65]; % 
c3=[0 0.4470 0.7410]; % darkish blue
c4=[0.42 0.38 0.4]; % 
c5=[0.3010 0.7450 0.9330]; % light blue
c6=[0.9290 0.6940 0.1250]; % gentle yellow
c7=[0.70 0.68 0.16]; % gentle yellow
c8=[0.8500 0.3250 0.0980]; % rusty
c9=[0.4660 0.6740 0.1880]; % green
c10=[0.6500 0.48 0.14]; % 
c11=[0.6350 0.0780 0.1840];

clear col

clr(1,:)   =c5;
clr(2,:)   =c5;
clr(3,:)   =c5;
clr(4,:)   =c3;
clr(5,:)   =c3;
clr(6,:)   =c3;
clr(7,:)   =c6;
clr(8,:)   =c6;
clr(9,:)   =c6;
clr(10,:)  =c8;
clr(11,:)  =c8;
clr(12,:)  =c8;


rh_min   = zeros(12);
circ_in  = zeros(12);
omega_db = zeros(12);
omega_dn = zeros(12);
omega_up = zeros(12);

%rh_min(1:3)   -> cam5 295K, 300K, 305K
%rh_min(4:6)   -> cam6
%rh_min(7:9)   -> GEOS
%rh_min(10:12) -> SPCAM 

rh_min   = [42.5,35.8,30.3,48.2,39.9,36.8,54.6,50.2,18.9,34.2,32.9,34.4];
omega_db = [28.37,24.16,20.94,29.79,26.71,18.11,37.60,30.54,19.24,28.46,24.32,19.82];
circ_in  = [126.41,114.45,99.30,160.44,156.19,110.56,122.34,105.72,129.37,156.41,132.02,107.16];
omega_dn = [37.31,31.51,29.41,48.90,39.75,30.85,41.59,35.72,38.77,39.30,31.46,26.46];
omega_up = [89.10,82.94,69.89,111.54,116.44,79.71,80.76,70.00,90.60,117.10,100.56,80.71];

%rh_min=[42.5,35.8,30.3,48.2,39.9,36.8];
%omega_d2=[38.0,27.3,21.5,41.8,32.8,21.9];

figure
%scatter(rh_min,omega_d2,[],col,'filled','SizeData',100)
scatter(omega_db,circ_in,[],clr,'filled','SizeData',100)
xlabel('diabatic omega')
ylabel('circulation intensity')

figure
scatter(omega_db,rh_min,[],clr,'filled','SizeData',100)
xlabel('diabatic omega')
ylabel('min RH')

figure
scatter(circ_in,rh_min,[],clr,'filled','SizeData',100)
xlabel('circulation intensity')
ylabel('min RH')

figure
scatter(omega_up,rh_min,[],clr,'filled','SizeData',100)
xlabel('omega bar up')
ylabel('min RH')

figure
scatter(omega_db,omega_dn,[],clr,'filled','SizeData',100)
xlabel('diabatic omega')
ylabel('omega bar dn')










