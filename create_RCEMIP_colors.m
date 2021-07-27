%-----------------------------------------------------------
% 
% - create colors that are used for RCEMIP plots
% - define physical constants
%
% colors are based on the NCL colortable cb_9step
%
% called by openRCEprofiles.m
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

CAM5      =[0.709803921568627, 0.811764705882353, 0.419607843137255]; % CAM5
CAM6      =[0.807843137254902, 0.858823529411765, 0.611764705882353]; % CAM6
CNRM      =[0.905882352941176, 0.16078431372549, 0.541176470588235]; % CNRM
ECHAM     =[0.83921568627451, 0.152941176470588, 0.156862745098039]; % ECHAM
GEOS      =[0.984313725490196, 0.501960784313725, 0.447058823529412]; % GEOS
ICON      =[0.549019607843137, 0.337254901960784, 0.294117647058824]; % ICON-GCM 
IPSL      =[0., 0., 0.]; % IPSL
SAM0_UNI  =[0.549019607843137, 0.635294117647059, 0.32156862745098]; % SAM0-UNICON
SPXCAM    =[0.619607843137255, 0.854901960784314, 0.898039215686275]; % SPX-CAM
SPCAM     =[0.0901960784313725, 0.745098039215686, 0.811764705882353]; % SP-CAM
UKMO      =[0.482352941176471, 0.254901960784314, 0.450980392156863]; % UKMO

colGCM(1,:)  =CAM5;  % CAM5         % 67
colGCM(2,:)  =CAM6;  % CAM6         % 19
colGCM(3,:)  =CNRM;  % CNRM
colGCM(4,:)  =ECHAM;  % ECHAM        % 44
colGCM(5,:)  =GEOS;  % GEOS         % 35
colGCM(6,:)  =ICON;  % ICON
colGCM(7,:)  =SAM0_UNI; % SAM0-UNICON
colGCM(8,:)  =SPXCAM;  % SPCAM        % 51
colGCM(9,:)  =SPCAM;  % SPXCAM       % 60
colGCM(10,:) =UKMO; % UKMO

colGCMfull(1,:)  =CAM5;  % CAM5         % 67
colGCMfull(2,:)  =CAM6;  % CAM6         % 19
colGCMfull(3,:)  =CNRM;  % CNRM
colGCMfull(4,:)  =ECHAM;  % ECHAM        % 44
colGCMfull(5,:)  =GEOS;  % GEOS         % 35
colGCMfull(6,:)  =ICON;  % ICON
colGCMfull(7,:)  =IPSL;  % IPSL
colGCMfull(8,:)  =SAM0_UNI; % SAM0-UNICON
colGCMfull(9,:)  =SPXCAM;  % SPCAM        % 51
colGCMfull(10,:)  =SPCAM;  % SPXCAM       % 60
colGCMfull(11,:) =UKMO; % UKMO


cSAM      =[0.67843137254902, 0.286274509803922, 0.290196078431373];  % SAM CRM       
cSCALE    =[0.105882352941176, 0.619607843137255, 0.466666666666667]; % SCALE-CRM
cICON_LEM =[0.741176470588235, 0.619607843137255, 0.223529411764706]; % ICON-LEM-CRM
cICON_NWP =[0.549019607843137, 0.427450980392157, 0.192156862745098]; % ICON-NWP-CRM
cUCLA     =[1, 0.929411764705882, 0.435294117647059]; % UCLS CRM 

colCRM(1,:)  =cSAM;
colCRM(2,:)  =cSCALE;
colCRM(3,:)  =cICON_LEM;
colCRM(4,:)  =cICON_NWP;
colCRM(5,:)  =cUCLA;

colCRM4(1,:)  =cSAM;
colCRM4(2,:)  =cSCALE;
colCRM4(3,:)  =cICON_LEM;
colCRM4(4,:)  =cICON_NWP;

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


