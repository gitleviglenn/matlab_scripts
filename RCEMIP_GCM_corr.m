% after the tables have been imported, I manually switched the omega_up and 
% omega_dn for ICON and the UKMO becuase they use the vertical velocity at 
% 500hPa and this results in the switch.  This should be eventually fixed in 
% the ncl scripts that are computing the omega statistics.

% import tables
import_RCEMIP_table_10GCMs_L295
import_RCEMIP_table_10GCMs_L300
import_RCEMIP_table_10GCMs_L305

%% manually change values due to sign difference between w and omega...
CircSF295.omega_dn(10)=39.4900
CircSF295.omega_up(10)=-91.6500
CircSF300.omega_dn(10)=34.2300
CircSF300.omega_up(10)=-83.6300
CircSF305.omega_dn(10)=35.2900
CircSF305.omega_up(10)=-82.6800

CircSF295.omega_up(6)=-144.7700;
CircSF295.omega_dn(6)=54.0800;
CircSF300.omega_dn(6)=39.7500;
CircSF300.omega_up(6)=-104.53;
CircSF305.omega_dn(6)=32.8800;
CircSF305.omega_up(6)=-69.1700;

m1_omega_dn=[CircSF295.omega_dn(1),CircSF300.omega_dn(1),CircSF305.omega_dn(1)]
m1_omega_up=[CircSF295.omega_up(1),CircSF300.omega_up(1),CircSF305.omega_up(1)]
m1_I=[CircSF295.I(1),CircSF300.I(1),CircSF305.I(1)]

m2_omega_dn=[CircSF295.omega_dn(2),CircSF300.omega_dn(2),CircSF305.omega_dn(2)]
m2_omega_up=[CircSF295.omega_up(2),CircSF300.omega_up(2),CircSF305.omega_up(2)]
m2_I=[CircSF295.I(2),CircSF300.I(2),CircSF305.I(2)]

m3_omega_dn=[CircSF295.omega_dn(3),CircSF300.omega_dn(3),CircSF305.omega_dn(3)]
m3_omega_up=[CircSF295.omega_up(3),CircSF300.omega_up(3),CircSF305.omega_up(3)]
m3_I=[CircSF295.I(3),CircSF300.I(3),CircSF305.I(3)]

m4_omega_dn=[CircSF295.omega_dn(4),CircSF300.omega_dn(4),CircSF305.omega_dn(4)]
m4_omega_up=[CircSF295.omega_up(4),CircSF300.omega_up(4),CircSF305.omega_up(4)]
m4_I=[CircSF295.I(4),CircSF300.I(4),CircSF305.I(4)]

m5_omega_dn=[CircSF295.omega_dn(5),CircSF300.omega_dn(5),CircSF305.omega_dn(5)]
m5_omega_up=[CircSF295.omega_up(5),CircSF300.omega_up(5),CircSF305.omega_up(5)]
m5_I=[CircSF295.I(5),CircSF300.I(5),CircSF305.I(5)]

m6_omega_dn=[CircSF295.omega_dn(6),CircSF300.omega_dn(6),CircSF305.omega_dn(6)]
m6_omega_up=[CircSF295.omega_up(6),CircSF300.omega_up(6),CircSF305.omega_up(6)]
m6_I=[CircSF295.I(6),CircSF300.I(6),CircSF305.I(6)]

m7_omega_dn=[CircSF295.omega_dn(7),CircSF300.omega_dn(7),CircSF305.omega_dn(7)]
m7_omega_up=[CircSF295.omega_up(7),CircSF300.omega_up(7),CircSF305.omega_up(7)]
m7_I=[CircSF295.I(7),CircSF300.I(7),CircSF305.I(7)]

m8_omega_dn=[CircSF295.omega_dn(8),CircSF300.omega_dn(8),CircSF305.omega_dn(8)]
m8_omega_up=[CircSF295.omega_up(8),CircSF300.omega_up(8),CircSF305.omega_up(8)]
m8_I=[CircSF295.I(8),CircSF300.I(8),CircSF305.I(8)]

% actaully, much easier is: 
omega_dn=[CircSF295.omega_dn,CircSF300.omega_dn,CircSF305.omega_dn];
omega_up=[CircSF295.omega_up,CircSF300.omega_up,CircSF305.omega_up];
%omega_I=[CircSF295.omega_I,CircSF300.omega_I,CircSF305.I];
omega_I=[CircSF295.I,CircSF300.I,CircSF305.I];
SST=[CircSF295.SST,CircSF300.SST,CircSF305.SST];



corrcoef(m1_omega_up,m1_I)
corrcoef(m1_omega_dn,m1_I)
