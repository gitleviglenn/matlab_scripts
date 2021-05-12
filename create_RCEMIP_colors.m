%-----------------------------------------------------------
% 
% - create colors that are used for RCEMIP plots
% - define physical constants
%
% colors are based on the NCL colortable cb_9step
%
% levi silvers                         april 2021
%-----------------------------------------------------------

%[red green blue]
c6_a=[189 0 130]; % 44; ECHAM 
c6=c6_a/255;

c8_a=[171 77 237]; % 35; GEOS 
c8=c8_a/255;

c2_a=[43 184 163]; % 19; cam6
c2=c2_a/255;

c20_a=[214 26 26]; % 51; SPCAM
c20=c20_a/255;

c1_a=[209 105 31]; % 67 cam5 NCL colortable cb_9step
c1=c1_a/255;

c21_a=[161 150 0]; % 60 SPXCAM
c21=c21_a/255;

c4_a=[255 100 0]; % CNRM-CM6
c4=c4_a/255;

c9_a=[0 255 0]; % ICON-GCM 
c9=c9_a/255;

c12_a=[0 0 255]; % IPSL
c12=c12_a/255;

c16_a=[128 0 255]; % SAM0-UNICON
c16=c16_a/255;

c23_a=[0 105 0]; % UKMO
c23=c23_a/255;

col(1,:)  =c1;  % CAM5         % 67
col(2,:)  =c2;  % CAM6         % 19
col(3,:)  =c4;  % CNRM
col(4,:)  =c6;  % ECHAM        % 44
col(5,:)  =c8;  % GEOS         % 35
col(6,:)  =c9;  % ICON
col(7,:)  =c12;  % IPSL
col(8,:)  =c16; % SAM0-UNICON
col(9,:)  =c20;  % SPCAM        % 51
col(10,:) =c21;  % SPXCAM       % 60
col(11,:) =c23; % UKMO

col9(1,:)  =c1;  % CAM5         % 67
col9(2,:)  =c2;  % CAM6         % 19
col9(3,:)  =c20;  % SPCAM 
col9(4,:)  =c21;  % SPXCAM % 44
col9(5,:)  =c6;  % ECHAM % 35
col9(6,:)  =c8; % GEOS
col9(7,:)  =c4;  % CNRM  % 51
col9(8,:) =c16;  % SAM0-UNICON       % 60
col9(9,:) =c23; % UKMO

col8(1,:)  =c1;  % CAM5         % 67
col8(2,:)  =c2;  % CAM6         % 19
col8(3,:)  =c20;  % SPCAM 
col8(4,:)  =c21;  % SPXCAM % 44
col8(5,:)  =c6;  % ECHAM % 35
col8(6,:)  =c8; % GEOS
col8(7,:) =c16;  % SAM0-UNICON       % 60
col8(8,:) =c23; % UKMO


col10(1,:)  =c1;  % CAM5         % 67
col10(2,:)  =c2;  % CAM6         % 19
col10(3,:)  =c4;  % CNRM
col10(4,:)  =c6;  % ECHAM        % 44
col10(5,:)  =c8;  % GEOS         % 35
col10(6,:)  =c9;  % ICON
col10(7,:)  =c16; % SAM0-UNICON
col10(8,:)  =c20;  % SPCAM        % 51
col10(9,:) =c21;  % SPXCAM       % 60
col10(10,:) =c23; % UKMO


% physical constants:
grav      =9.81;
Rd        =287.;   % J/kg K gas constant for dry air 
Rv        =461.;   % J/(kg K) gas constant for water vapor
%latheat   =2.52e6; % J/kg latent heat of vaporization
latheat   =2.501e6; % J/kg latent heat of vaporization recommended by Wing et al. 2018
cpd       =1000.;  % J/kg K cp for dry air 
epsilon   =Rd/Rv;
psfc      =1015.0;
tsfc      =295;

