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

BLACK     =[0., 0., 0.]; % for models not yet analyzed

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


cSAM             =[0.67843137254902, 0.286274509803922, 0.290196078431373];  % SAM CRM       
cSCALE           =[0.105882352941176, 0.619607843137255, 0.466666666666667]; % SCALE-CRM
cICON_LEM        =[0.741176470588235, 0.619607843137255, 0.223529411764706]; % ICON-LEM-CRM
cICON_NWP        =[0.549019607843137, 0.427450980392157, 0.192156862745098]; % ICON-NWP-CRM
cUCLA            =[1, 0.929411764705882, 0.435294117647059]; % UCLS CRM 
cDAM             =[0.4, 0.76078431372549, 0.647058823529412]; % DAM
cWRFCRM          =[0.32156862745098, 0.329411764705882, 0.63921568627451]; % WRF-CRM
cWRFCOLCRM       =[0.223529411764706, 0.231372549019608, 0.474509803921569]; % WRF-COL-CRM
cUKMOCASIM       =[0.647058823529412, 0.317647058823529, 0.580392156862745]; % UKMO-CASIM
cUKMORA1T        =[0.807843137254902, 0.427450980392157, 0.741176470588235];
cUKMORA1Tnocloud =[0.890196078431372, 0.466666666666667, 0.76078431372549];
cFV3             =[0.737254901960784, 0.741176470588235, 0.133333333333333];
cSAMGCRM         =[0.517647058823529, 0.235294117647059, 0.223529411764706];
cMPAS            =[0.501960784313725, 0.694117647058824, 0.827450980392157];
cNICAM           =[1, 1, 0.2]; 
cWRF_GCM_cps6    =[0.854901960784314, 0.854901960784314, 0.92156862745098];
cWRF_GCM_cps4    =[0.737254901960784, 0.741176470588235, 0.862745098039216];
cWRF_GCM_cps3    =[0.619607843137255, 0.603921568627451, 0.784313725490196];
cWRF_GCM_cps2    =[0.458823529411765, 0.419607843137255, 0.694117647058824];
cWRF_GCM_cps1    =[0.611764705882353, 0.619607843137255, 0.870588235294118];
cWRF_GCM_cps0    =[0.419607843137255, 0.431372549019608, 0.811764705882353];
cCM1             =[0.192156862745098, 0.509803921568627, 0.741176470588235];
cMESONH          =[0.901960784313726, 0.333333333333333, 0.0509803921568627];


colCRM(1,:)  =cSAM;
colCRM(2,:)  =cSCALE;
colCRM(3,:)  =cICON_LEM;
colCRM(4,:)  =cICON_NWP;
colCRM(5,:)  =cUCLA;
colCRM(6,:)  =cWRFCRM;
colCRM(7,:)  =cMESONH;
colCRM(8,:)  =cWRFCOLCRM;
colCRM(9,:)  =cUKMOCASIM;
colCRM(10,:) =cUKMORA1T;
colCRM(11,:) =cUKMORA1Tnocloud;

colortest(1,:)  =cUCLA;
colortest(2,:)  =cUCLA;
colortest(3,:)  =cICON_LEM;
colortest(4,:)  =cUCLA;
colortest(5,:)  =cUCLA;
colortest(6,:)  =cWRFCRM;
colortest(7,:)  =cMESONH;


colCRM4(1,:)  =cSAM;
colCRM4(2,:)  =cSCALE;
colCRM4(3,:)  =cICON_LEM;
colCRM4(4,:)  =cICON_NWP;

% match modelnum with col34
modelnum      =[1 2 4 6 8 9 10 11 12 13 16 17 19 20 21 22 23 24 25 26 27 28]; % index numbers for col34 that are used in my study
% modelnum(mnum_gcm) --> matches indices of gcms with colors in col34
mnum_gcm     =[1 2 3 4 5 6 11 14 15 17]; % index numbers of modelnum for GCMs so modelnum(mnum_gcm)
mnum_gcm_cs  =[1 2 3 5 11 14 15 17]; % index numbers of modelnum for GCMs so modelnum(mnum_gcm)
% modelnum(mnum_crm) --> matches indices of crms with colors in col34
mnum_crm     =[12 13 7 8 16 22 10 21 18 19 20]; % index numbers of modelnum for CRMs
% the two WRF CRMs do not have clear sky fluxes
mnum_crm_cs  =[12 13 7 8 16 10 18 19 20]; % index numbers of modelnum for CRMs

col34(1,:)   = CAM5;  % CAM5         
col34(2,:)   = CAM6;  % CAM6         
col34(3,:)   = cCM1;  % CM1         
col34(4,:)   = CNRM;  % CNRM         
col34(5,:)   = cDAM;  % DAM         
col34(6,:)   = ECHAM;  % ECHAM6         
col34(7,:)   = cFV3;  % FV3         
col34(8,:)   = GEOS;  % GEOS-GCM         
col34(9,:)   = ICON;  % ICON-GCM
col34(10,:)  = cICON_LEM;  % ICON-LEM-CRM
col34(11,:)  = cICON_NWP;  % ICON-NWP-CRM
col34(12,:)  = BLACK;  % IPSL-CM6
col34(13,:)  = cMESONH;  % MESONH
col34(14,:)  = cMPAS;  % MPAS
col34(15,:)  = cNICAM;  % NICAM
col34(16,:)  = SAM0_UNI;  % SAM0-UNICON
col34(17,:)  = cSAM;  % SAM-CRM
col34(18,:)  = BLACK;  % SAM-GCRM
col34(19,:)  = cSCALE;  % SCALE
col34(20,:)  = SPCAM;  % SP-CAM
col34(21,:)  = SPXCAM;  % SPX-CAM
col34(22,:)  = cUCLA;  % UCLA-CRM
col34(23,:)  = UKMO;  % UKMO-GA7.1
col34(24,:)  = cUKMOCASIM;  % UKMO-CASIM 
col34(25,:)  = cUKMORA1T;  % UKMO-RA1-T
col34(26,:)  = cUKMORA1Tnocloud;  % UKMO-RA1-T-nocloud
col34(27,:)  = cWRFCOLCRM;  % WRF-COL-CRM
col34(28,:)  = cWRFCRM;  % WRF-CRM
col34(29,:)  = cWRF_GCM_cps0;  % WRF-GCM-cps0
col34(30,:)  = cWRF_GCM_cps1;  % WRF-GCM-cps1
col34(31,:)  = cWRF_GCM_cps2;  % WRF-GCM-cps2
col34(32,:)  = cWRF_GCM_cps3;  % WRF-GCM-cps3
col34(33,:)  = cWRF_GCM_cps4;  % WRF-GCM-cps4
col34(34,:)  = cWRF_GCM_cps6;  % WRF-GCM-cps5

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


