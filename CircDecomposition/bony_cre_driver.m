%-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
% bony_cre_driver.m
%
% driver script to perform analysis following bony et al., 2004
%
% calls glbmn_toa_fb.m --> Why?  Are the results used somewhere else?
%
% Calls bin_clouds.m which creates 'pdfstruct' and 'pdfvals' arrays.
%
% levi                                                                oct 2022
%-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

% define colors
col_amip = [0.709803921568627, 0.811764705882353, 0.419607843137255]; % CAM5           % green
col_hist = [0.549019607843137, 0.635294117647059, 0.32156862745098]; % SAM0-UNICON     % dark green
col_aqua = [0.984313725490196, 0.501960784313725, 0.447058823529412]; % GEOS           % salmon
col_rce  = [0.619607843137255, 0.854901960784314, 0.898039215686275]; % SPX-CAM    % light bl
col_rrce = [0.0901960784313725, 0.745098039215686, 0.811764705882353]; % SP-CAM    % dark bl
col_mw   = [0.741176470588235, 0.619607843137255, 0.223529411764706]; % ICON-LEM-CRM % light br

% define data paths, variable names, and basic parameters
source='/Users/silvers/data/CAM/';
data_config='_CAM6_monthly_';

tindex=24;

figure

% experiment 1
exp_name   ='GCM_RCE_large295';
%exp_name   ='GCM_RCE_large305';
tit1=exp_name;
time1=7;
time2=36;
wtime2=36;
w_exp_string=strcat(data_config,exp_name,'_2D');
exp_string=strcat(data_config,exp_name,'_2D');

% call other mathlab scripts
glbmn_toa_fb
bin_clouds
rce295_lwcre=lwcre_binned;
rce295_swcre=swcre_binned;
rce295_pdf  =pdfvals;

% experiment 2
exp_name   ='GCM_RCE_large305';
tit1=exp_name;
time1=7;
time2=36;
wtime2=36;
w_exp_string=strcat(data_config,exp_name,'_2D');
exp_string=strcat(data_config,exp_name,'_2D');
% call scripts
glbmn_toa_fb
bin_clouds
rce305_lwcre=lwcre_binned;
rce305_swcre=swcre_binned;
rce305_pdf  =pdfvals;
rce_diff=rce305_pdf-rce295_pdf;

% experiment 3
exp_name   ='GCM_RRCE_large295';
tit1=exp_name;
time1=7; % drop the first 6 months
time2=24;
wtime2=24;
w_exp_string=strcat(data_config,exp_name,'_2D');
exp_string=strcat(data_config,exp_name,'_2D');
% call scripts
glbmn_toa_fb
bin_clouds
rrce295_lwcre=lwcre_binned;
rrce295_swcre=swcre_binned;
rrce295_pdf  =pdfvals;

% experiment 4
exp_name   ='GCM_RRCE_large305';
tit1=exp_name;
time1=7; % drop the first 6 months
time2=24;
wtime2=24;
w_exp_string=strcat(data_config,exp_name,'_2D');
exp_string=strcat(data_config,exp_name,'_2D');
% call scripts
glbmn_toa_fb
bin_clouds
rrce305_lwcre=lwcre_binned;
rrce305_swcre=swcre_binned;
rrce305_pdf  =pdfvals;
rrce_diff=rrce305_pdf-rrce295_pdf;

% experiment 5
exp_name   ='MockW_4Period_3K_cos2_295';
tit1=exp_name;
time1=7;
time2=36;
wtime2=36;
w_exp_string=strcat(data_config,exp_name,'_3yr_2D');
exp_string=strcat(data_config,exp_name,'_3yr_2D');
% call scripts
glbmn_toa_fb
bin_clouds
mw_295_lwcre=lwcre_binned;
mw_295_swcre=swcre_binned;
mw_295_pdf  =pdfvals;

% experiment 6
exp_name   ='MockW_4Period_3K_cos2_305';
tit1=exp_name;
time1=7;
time2=36;
wtime2=36;
w_exp_string=strcat(data_config,exp_name,'_3yr_2D');
exp_string=strcat(data_config,exp_name,'_3yr_2D');
% call scripts
glbmn_toa_fb
bin_clouds
mw_305_lwcre=lwcre_binned;
mw_305_swcre=swcre_binned;
mw_305_pdf  =pdfvals;
mw_diff=mw_305_pdf-mw_295_pdf;

%exp_name   ='GCM_RRCE_large305';
%tit1=exp_name;
%time1=7;
%time2=24;
%wtime2=24;
%w_exp_string=strcat(data_config,exp_name,'_2D');
%exp_string=strcat(data_config,exp_name,'_2D');
%% call scripts
%glbmn_toa_fb
%bin_clouds
%rrce305_lwcre=lwcre_binned;
%rrce305_pdf  =pdfvals;

source='/Users/silvers/data/CAM/CESM2/';
data_config='_Amon_CESM2_';

time1=1;
exp_name   ='aqua-p4K';
tit1=exp_name;
time2=120;
wtime2=120;
member_id  ='_r1i1p1f1_gn_';
years      ='000101-001012';
wyears      ='000101-001012';
w_exp_string=strcat('_monthly_CESM2_',exp_name,member_id,wyears);
exp_string=strcat(data_config,exp_name,member_id,years);
% call scripts
glbmn_toa_fb
bin_clouds
aqua4K_lwcre=lwcre_binned;
aqua4K_swcre=swcre_binned;
aqua4K_pdf  =pdfvals;

%
exp_name   ='aqua-control';
tit1=exp_name;
time2=120;
wtime2=120;
member_id  ='_r1i1p1f1_gn_';
years      ='000101-001012';
wyears      ='000101-001012';
w_exp_string=strcat('_monthly_CESM2_',exp_name,member_id,wyears);
exp_string=strcat(data_config,exp_name,member_id,years);
% call scripts
glbmn_toa_fb
bin_clouds
aqua_lwcre=lwcre_binned;
aqua_swcre=swcre_binned;
aqua_pdf  =pdfvals;
aquadiff=aqua4K_pdf-aqua_pdf;
%
exp_name   ='amip';
tit1=exp_name;
time2=779;
wtime2=426;
member_id  ='_r1i1p1f1_gn_';
years      ='195001-201412';
wyears      ='19800101-20150101';
w_exp_string=strcat('_monthly_CESM2_',exp_name,member_id,wyears);
exp_string=strcat(data_config,exp_name,member_id,years);
% call scripts
glbmn_toa_fb
bin_clouds
amip_lwcre =lwcre_binned;
amip_swcre =swcre_binned;
amip_pdf   =pdfvals;
%
exp_name   ='amip-p4K';
tit1=exp_name;
time2=420;
wtime2=420;
member_id  ='_r1i1p1f1_gn_';
wyears      ='19790101-20140101'; 
years      ='197901-201312';
w_exp_string=strcat('_monthly_CESM2_',exp_name,member_id,wyears);
exp_string=strcat(data_config,exp_name,member_id,years);
% call scripts
glbmn_toa_fb
bin_clouds
amip4K_lwcre =lwcre_binned;
amip4K_swcre =swcre_binned;
amip4K_pdf   =pdfvals;
amipdiff=amip4K_pdf-amip_pdf;
%
exp_name   ='historical';
tit1=exp_name;
time2=587;
wtime2=426;
member_id  ='_r11i1p1f1_gn_';
years      ='195001-199912';
wyears      ='19800101-20150101';
w_exp_string=strcat('_monthly_CESM2_',exp_name,member_id,wyears);
exp_string=strcat(data_config,exp_name,member_id,years);
%years      ='200001-201412';
% call scripts
glbmn_toa_fb
bin_clouds
hist_lwcre =lwcre_binned;
hist_swcre =swcre_binned;
hist_pdf   =pdfvals;

%---------------------------------------------------------------------
% create figures

figure
plot(bins(1:nbin),hist_lwcre,'LineWidth',2,'Color',col_hist)
hold on
plot(bins(1:nbin),amip_lwcre,'LineWidth',3,'Color',col_amip)
plot(bins(1:nbin),amip4K_lwcre,'Color',col_amip)
plot(bins(1:nbin),aqua_lwcre,'LineWidth',2,'Color',col_aqua)
plot(bins(1:nbin),aqua4K_lwcre,'Color',col_aqua)
plot(bins(1:nbin),rce295_lwcre,'LineWidth',2,'Color',col_rce)
plot(bins(1:nbin),rce305_lwcre,'Color',col_rce)
plot(bins(1:nbin),rrce295_lwcre,'LineWidth',2,'Color',col_rrce)
plot(bins(1:nbin),rrce305_lwcre,'Color',col_rrce)
plot(bins(1:nbin),mw_295_lwcre,'LineWidth',2,'Color',col_mw)
plot(bins(1:nbin),mw_305_lwcre,'Color',col_mw)
title('LWCRE across CAM6 configurations')
ylabel('$\rm{W \, m}^{-2}$','interpreter','latex','FontSize',14,'FontWeight','bold')
xlabel('Circulation regime ($\omega$500, \rm{hPa} \,$\rm{d}^{-1}$)','interpreter','latex','FontSize',14)

figure
plot(bins(1:nbin),hist_swcre,'LineWidth',2,'Color',col_hist)
hold on
plot(bins(1:nbin),amip_swcre,'LineWidth',3,'Color',col_amip)
plot(bins(1:nbin),amip4K_swcre,'Color',col_amip)
plot(bins(1:nbin),aqua_swcre,'LineWidth',2,'Color',col_aqua)
plot(bins(1:nbin),aqua4K_swcre,'Color',col_aqua)
plot(bins(1:nbin),rce295_swcre,'LineWidth',2,'Color',col_rce)
plot(bins(1:nbin),rce305_swcre,'Color',col_rce)
plot(bins(1:nbin),rrce295_swcre,'LineWidth',2,'Color',col_rrce)
plot(bins(1:nbin),rrce305_swcre,'Color',col_rrce)
plot(bins(1:nbin),mw_295_swcre,'LineWidth',2,'Color',col_mw)
plot(bins(1:nbin),mw_305_swcre,'Color',col_mw)
title('SWCRE across CAM6 configurations')
ylabel('$\rm{W \, m}^{-2}$','interpreter','latex','FontSize',14,'FontWeight','bold')
xlabel('Circulation regime ($\omega$500, \rm{hPa} \,$\rm{d}^{-1}$)','interpreter','latex','FontSize',14)

% compute differences: delta CRE
amipdiff_swcre =amip4K_swcre-amip_swcre;
aquadiff_swcre =aqua4K_swcre-aqua_swcre;
rcediff_swcre  =rce305_swcre-rce295_swcre;
rrcediff_swcre =rrce305_swcre-rrce295_swcre;
mwdiff_swcre   =mw_305_swcre-mw_295_swcre;

amipdiff_lwcre =amip4K_lwcre-amip_lwcre;
aquadiff_lwcre =aqua4K_lwcre-aqua_lwcre;
rcediff_lwcre  =rce305_lwcre-rce295_lwcre;
rrcediff_lwcre =rrce305_lwcre-rrce295_lwcre;
mwdiff_lwcre   =mw_305_lwcre-mw_295_lwcre;

figure
plot(bins(1:nbin),amipdiff_swcre,'LineWidth',2,'Color',col_amip)
hold on
plot(bins(1:nbin),aquadiff_swcre,'LineWidth',2,'Color',col_aqua)
plot(bins(1:nbin),rcediff_swcre,'LineWidth',2,'Color',col_rce)
plot(bins(1:nbin),rrcediff_swcre,'LineWidth',2,'Color',col_rrce)
%plot(bins(1:nbin),mwdiff_swcre,'LineWidth',2,'Color',col_mw)
title('Change of SW CRE from warming')

figure
plot(bins(1:nbin),amipdiff_lwcre,'LineWidth',2,'Color',col_amip)
hold on
plot(bins(1:nbin),aquadiff_lwcre,'LineWidth',2,'Color',col_aqua)
plot(bins(1:nbin),rcediff_lwcre,'LineWidth',2,'Color',col_rce)
plot(bins(1:nbin),rrcediff_lwcre,'LineWidth',2,'Color',col_rrce)
%plot(bins(1:nbin),mwdiff_lwcre,'LineWidth',2,'Color',col_mw)
title('Change of LW CRE from warming')


figure
plot(bins(1:nbin),hist_pdf,'LineWidth',2,'Color',col_hist)
hold on
plot(bins(1:nbin),amip_pdf,'LineWidth',2,'Color',col_amip)
%plot(bins(1:nbin),amip4K_pdf,'LineWidth',1,'Color',col_amip)
plot(bins(1:nbin),aqua_pdf,'LineWidth',2,'Color',col_aqua)
%plot(bins(1:nbin),aqua4K_pdf,'LineWidth',1,'Color',col_aqua)
plot(bins(1:nbin),rce295_pdf,'LineWidth',2,'Color',col_rce)
%plot(bins(1:nbin),rce305_pdf,'LineWidth',1,'Color',col_rce)
plot(bins(1:nbin),rrce295_pdf,'LineWidth',2,'Color',col_rrce)
%plot(bins(1:nbin),rrce305_pdf,'LineWidth',1,'Color',col_rrce)
plot(bins(1:nbin),mw_295_pdf,'LineWidth',2,'Color',col_mw)
%plot(bins(1:nbin),mw_305_pdf,'LineWidth',1,'Color',col_mw)
title('PDFs across CAM6 configurations')
ylabel('$\rm{normalized}$','interpreter','latex','FontSize',14,'FontWeight','bold')
xlabel('Circulation regime ($\omega$500, \rm{hPa} \,$\rm{d}^{-1}$)','interpreter','latex','FontSize',14)

figure
plot(bins(1:nbin),rce_diff,'LineWidth',2.5,'Color',col_rce)
hold on 
plot(bins(1:nbin),rrce_diff,'LineWidth',2.5,'Color',col_rrce)
%plot(bins(1:nbin),mw_diff,'LineWidth',2.5)
plot(bins(1:nbin),aquadiff,'LineWidth',2.5,'Color',col_aqua)
plot(bins(1:nbin),amipdiff,'LineWidth',2.5,'Color',col_amip)
title('Change of PDF from warming')


% we need to plot CwdPw, PwdCw, and dPwdCw 

% the Cw terms: 
% amip_swcre+amip_lwcre, aquadiff_lwcre+aquadiff_swcre
% rcediff_lwcre+rcediff_swcre, rrcediff_lwcre+rrcediff_swcre

% the Pw terms: 
% amip_pdf, amip_pdf, rce295_pdf, rrce295_pdf

% the dPw terms: 
% rce_diff, rrce_diff, aquadiff, amipdiff

% the dCw terms: 
% amipdiff_lwcre, aquadiff_lwcre, rcediff_lwcre, rrcediff_lwcre
% amipdiff_swcre, aquadiff_swcre, rcediff_swcre, rrcediff_swcre

% The two figures below begin the process of reproducing systematically the results
% in Bony et al., 2004.  the goal of this analysis is to apply the methodology in 
% Bony et al., 2004 to the decomposition of the vertical pressure velocity field into 
% orthogonal representations of the Hadley and Walker Cells...

figure
plot(bins(1:nbin),amip_pdf.*amip_lwcre,'LineWidth',1,'LineStyle','--','Color',col_amip)
hold on
plot(bins(1:nbin),amip_pdf.*amip_swcre,'LineWidth',1,'Color',col_amip)
plot(bins(1:nbin),amip_pdf.*(amip_swcre+amip_lwcre),'LineWidth',2,'Color',col_amip)
title('Dynamically Sampled Average CRE: CwPw')

figure
subplot(3,1,1)
plot(bins(1:nbin),amipdiff.*(amip_lwcre+amip_swcre),'LineWidth',1,'Color',col_amip)
hold on
plot(bins(1:nbin),amip_pdf.*(amipdiff_lwcre+amipdiff_swcre),'LineWidth',1,'Color',col_amip)
plot(bins(1:nbin),amipdiff.*(amipdiff_lwcre+amipdiff_swcre),'LineWidth',1,'Color',col_amip)
title('All Three Components')
subplot(3,1,2)
plot(bins(1:nbin),amip_pdf.*(amipdiff_lwcre+amipdiff_swcre),'LineWidth',2,'Color',col_amip)
hold on
plot(bins(1:nbin),amip_pdf.*(amipdiff_lwcre),'LineWidth',1,'LineStyle','--','Color',col_amip)
plot(bins(1:nbin),amip_pdf.*(amipdiff_swcre),'LineWidth',1,'Color',col_amip)
title('D Sampled Thermodynamic: PwdCw')
subplot(3,1,3)
plot(bins(1:nbin),amipdiff.*(amip_lwcre+amip_swcre),'LineWidth',2,'Color',col_amip)
hold on
plot(bins(1:nbin),amipdiff.*(amip_lwcre),'LineWidth',1,'LineStyle','--','Color',col_amip)
plot(bins(1:nbin),amipdiff.*(amip_swcre),'LineWidth',1,'Color',col_amip)
title('D Sampled Dynamic: PwdCw')
sgtitle('Decomposition of delta C: dynamic, thermodynamic, and residual')


