%------------------------------------------------------------------
% scatter_rh_vs_circ.m
%
% script to produce a scatter plot of rh vs circulation metrics
%
% levi silvers                                feb 26, 2021
%------------------------------------------------------------------

%%[red green blue]
%c1=[0.4940 0.1840 0.5560]; % purple
%c2=[0.25 0.32 0.65]; % 
%%c3=[0 0.4470 0.7410]; % darkish blue
%c4=[0.42 0.38 0.4]; % 
%%c5=[0.3010 0.7450 0.9330]; % light blue
%c6=[0.9290 0.6940 0.1250]; % gentle yellow
%c7=[0.70 0.68 0.16]; % gentle yellow
%c8=[0.8500 0.3250 0.0980]; % rusty
%c9=[0.4660 0.6740 0.1880]; % green
%c10=[0.6500 0.48 0.14]; % 
%c11=[0.6350 0.0780 0.1840];

%------------------------------------------
%% from the ncl colortable file: cb_9step.rgb
% ncolors=78
%# r   g   b
%        255     0       0
%        255     128     0
%        255     255     0
%        0       255     0
%        0       0       255
%        128     0       255
%        219     219     255
%        194     194     250
%        158     158     247
%        130     130     255
%        97      97      255
%        64      64      232
%        0       0       194
%        0       0       148
%        222     250     245
%        194     245     237
%        156     230     217
%        112     204     191
c2=[43 184 163]/255;               % CAM6
%        0       156     133
%        0       120     102
%        0       92      79
%        219     255     219
%        186     245     186
%        140     235     140
%        92      209     92
%        0       184     0
%        0       145     0
%        0       105     0
%        0       77      0
%        235     204     255
%        222     176     255
%        199     148     237
%        186     112     237
c3=[171 77 237]/255;               % GEOS
%        138     51      199
%        107     0       186
%        84      0       145
%        250     227     240
%        247     204     230
%        245     173     214
%        240     138     194
%        217     92      163
%        189     0       130
%        153     0       107
%        117     0       82
%        255     219     219
%        255     189     189
%        255     145     145
%        250     97      97
c4=[214 26 26]/255;               % SPCAM
%        163     0       0
%        125     0       0
%        92      0       0
%        255     252     214
%        252     242     168
%        252     237     128
%        227     209     0
c5=[199 186 43]/255; 
%c5=[161 150 0]/255;             % SPXCAM
%        120     112     0
%        84      82      0
%        255     222     199
%        252     199     161
%        250     176     125
%        232     143     79
c1=[209 105 31]/255;             % CAM5
%        186     77      0
%        153     64      0
%        115     48      0
%        240     240     240
%        222     222     222
%        199     199     199
%        171     171     171
%        145     145     145
%        120     120     120
%        94      94      94
%        74      74      74
%%------------------------------------------

% convert rgb values to matlab form: 
%c3=c3_a/255;
%c5=c5_a/255;


clear col

clr(1,:)   =c1;  % cam5
clr(2,:)   =c1;
clr(3,:)   =c1;
clr(4,:)   =c2;  % cam6
clr(5,:)   =c2;
clr(6,:)   =c2;
clr(7,:)   =c3;  % GEOS
clr(8,:)   =c3;
clr(9,:)   =c3;
clr(10,:)  =c4;  % SPCAM
clr(11,:)  =c4;
clr(12,:)  =c4;
clr(13,:)  =c5;  % SPCAM
clr(14,:)  =c5;
clr(15,:)  =c5;


rh_min   = zeros(12);
circ_in  = zeros(12);
omega_db = zeros(12);
omega_dn = zeros(12);
omega_up = zeros(12);

%rh_min(1:3)   -> cam5 295K, 300K, 305K
%rh_min(4:6)   -> cam6
%rh_min(7:9)   -> GEOS
%rh_min(10:12) -> SPCAM 
%rh_min(13:15) -> SPCAM 

rh_min   = [42.5,35.8,30.3,48.2,39.9,36.8,54.6,50.2,18.9,34.2,32.9,34.4,33.21,28.98,32.65];
omega_db = [28.37,24.16,20.94,29.79,26.71,18.11,37.60,30.54,19.24,28.46,24.32,19.82,27.48,21.41,17.49];
circ_in  = [126.41,114.45,99.30,160.44,156.19,110.56,122.34,105.72,129.37,156.41,132.02,107.16,136.46,120.00,111.69];
omega_dn = [37.31,31.51,29.41,48.90,39.75,30.85,41.59,35.72,38.77,39.30,31.46,26.46,32.78,25.77,25.34];
omega_up = [89.10,82.94,69.89,111.54,116.44,79.71,80.76,70.00,90.60,117.10,100.56,80.71,103.68,94.23,86.35];

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










