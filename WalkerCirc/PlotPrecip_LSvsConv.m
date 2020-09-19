%--------------------------------------------------------------------------
% plot the time evolution of the domain mean precipitation field.  
%
% produce large scale vs convective plot used in Walker Circ paper
%
% levi silvers                                   april 2020
%--------------------------------------------------------------------------
path_new='/Users/silvers/data/WalkerCell/testing_20181203';

source_gcm_l_mly           =strcat(path_new,'/c8x640L33_am4p0_25km_wlkr_ent0p9/1980th1983.atmos_month_tmn.nc');
source_gcm_l_mly_lwoff     =strcat(path_new,'/c8x640L33_am4p0_25km_wlkr_ent0p9_lwoff/1980th1983.atmos_month_tmn.nc');

source_gcm_mly             =strcat(path_new,'/c8x160L33_am4p0_25km_wlkr_ent0p9/1980th1983.atmos_month_tmn.nc');
source_gcm_mly_lwoff       =strcat(path_new,'/c8x160L33_am4p0_25km_wlkr_ent0p9_lwoff/1980th1983.atmos_month_tmn.nc');

source_100km_l_mly         =strcat(path_new,'/c8x160L33_am4p0_100km_wlkr_ent0p9/1980th1983.atmos_month_tmn.nc');
source_100km_l_mly_lwoff   =strcat(path_new,'/c8x160L33_am4p0_100km_wlkr_ent0p9_lwoff/1980th1983.atmos_month_tmn.nc');

source_100km_s_mly         =strcat(path_new,'/c8x40L33_am4p0_100km_wlkr_ent0p9/1980th1983.atmos_month_tmn.nc');
source_100km_s_mly_lwoff   =strcat(path_new,'/c8x40L33_am4p0_100km_wlkr_ent0p9_lwoff/1980th1983.atmos_month_tmn.nc');

  tit_25='lwcre on for 25km '
  tit_100='lwcre on for 100km '
  [cv_25km,ls_25km,f_ls_25km]=precip_largesc_vs_conv(source_gcm_mly,1,4);
  [cv_25km_l,ls_25km_l,f_ls_25km_l]=precip_largesc_vs_conv(source_gcm_l_mly,1,4);
  [cv_100km,ls_100km,f_ls_100km]=precip_largesc_vs_conv(source_100km_s_mly,1,4);
  [cv_100km_l,ls_100km_l,f_ls_100km_l]=precip_largesc_vs_conv(source_100km_l_mly,1,4);

%----------------
figure
thickness=2;
thick2=2;

boo=25:25:16000;

subplot(2,2,1)
plot(boo,cv_25km_l,'k','LineWidth',thickness);
xlim([0 16000])
ylim([0 25])
hold on
plot(boo,ls_25km_l,'b','LineWidth',thickness);
  [cv_25km_l_lwo,ls_25km_l_lwo,f_ls_25km_l_lwoff]=precip_largesc_vs_conv(source_gcm_l_mly_lwoff,1,4);
plot(boo,ls_25km_l_lwo,'--b','LineWidth',thick2);
plot(boo,cv_25km_l_lwo,'--k','LineWidth',thick2);
ylabel('mm/d','FontSize',20)
xlabel('km','FontSize',20)
yt=get(gca,'YTick');
set(gca,'FontWeight','bold')
set(gca,'FontSize',16)
title('P25L')

boo=25:25:4000;

subplot(2,2,2)
plot(boo,cv_25km,'k','LineWidth',thickness);
xlim([0 4000])
ylim([0 25])
hold on
plot(boo,ls_25km,'b','LineWidth',thickness);
  [cv_25km_lwo,ls_25km_lwo,f_ls_25km_lwo]=precip_largesc_vs_conv(source_gcm_mly_lwoff,1,4);
plot(boo,ls_25km_lwo,'--b','LineWidth',thick2);
plot(boo,cv_25km_lwo,'--k','LineWidth',thick2);
ylabel('mm/d','FontSize',20)
xlabel('km','FontSize',20)
yt=get(gca,'YTick');
set(gca,'FontWeight','bold')
set(gca,'FontSize',16)
title('P25')
%title('conv (black) and ls (blue)')

boo=100:100:16000;

subplot(2,2,3)
plot(boo,cv_100km_l,'k','LineWidth',thickness);
xlim([0 16000])
hold on
plot(boo,ls_100km_l,'b','LineWidth',thickness);
  [cv_100km_l_lwo,ls_100km_l_lwo,f_ls_100km_l_lwoff]=precip_largesc_vs_conv(source_100km_l_mly_lwoff,1,4);
plot(boo,ls_100km_l_lwo,'--b','LineWidth',thick2);
plot(boo,cv_100km_l_lwo,'--k','LineWidth',thick2);
ylabel('mm/d','FontSize',20)
xlabel('km','FontSize',20)
yt=get(gca,'YTick');
set(gca,'FontWeight','bold')
set(gca,'FontSize',16)
%title('conv (black) and ls (blue)')
title('P100L')

boo=100:100:4000;

subplot(2,2,4)
plot(boo,cv_100km,'k','LineWidth',thickness);
xlim([0 4000])
ylim([0 25])
hold on
plot(boo,ls_100km,'b','LineWidth',thickness);
  [cv_100km_lwo,ls_100km_lwo,f_ls_100km_lwoff]=precip_largesc_vs_conv(source_100km_s_mly_lwoff,1,4);
plot(boo,ls_100km_lwo,'--b','LineWidth',thick2);
plot(boo,cv_100km_lwo,'--k','LineWidth',thick2);
title('P100')
%title('conv (black) and ls (blue)')
ylabel('mm/d','FontSize',20)
xlabel('km','FontSize',20)
yt=get(gca,'YTick');
set(gca,'FontWeight','bold')
set(gca,'FontSize',16)
%sgtitle('Large-Scale vs Convective Precipitation')

