%-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
% glbmn_toa_cfmip_fb_driver.m
%
% driver for the computation of feedbacks 
% uses the glbmn_toa_cfmip_fb script
%
% computes feedbacks for the amip p4K, amip m4K, amip future 4K
%
% the amip_control switch is needed because the length of chunks are 
% different in amip
%
% feedbacks also need to be computed for the aqua p4K, abrupt 4xCO2, and
% the 1%CO2
%
% levi silvers                                        October 2019
%-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

% rad_ts_array(toa_R;toa_clr;toa_cre;toa_lwcre;toa_swcre)

% to get the numbers for amip we need to play some games becuase i can't write
% to my own data directory for some u

% compute the change in surface air temperature for the Cess-like experiments
glbmn_tas_cfmip

% compute the actual change in surface temperture which is 
% not exactly 4K.
delT_amip_p4K=amip_p4K_mts-amip_mts
delT_amip_m4K=amip_mts-amip_m4K_mts
delT_amip_fut=amip_F4K_mts-amip_mts
delT_amip_8K=amip_p4K_mts-amip_m4K_mts
delT_aqua=aqua_p4K_mts-aqua_mts

%delT_amip_p4K=4.
%delT_amip_m4K=4.
%delT_amip_fut=4.
%delT_amip_8K=4.
%delT_aqua=4.

% define an array to hold the mean feedback values for each experiment
rad_fb_array=zeros(7,5); % if the running mean is run.

amip_control=true
aqua_control=false

exp_name='amip';

  exp_string=strcat('_Amon_GFDL-CM4_',exp_name,'_r1i1p1f1_gr1_197901-198412');
  glbmn_toa_cfmip_fb
  rad_ts_array_amip1=rad_ts_array;

  exp_string=strcat('_Amon_GFDL-CM4_',exp_name,'_r1i1p1f1_gr1_198501-199012');
  glbmn_toa_cfmip_fb
  rad_ts_array_amip2=rad_ts_array;

  exp_string=strcat('_Amon_GFDL-CM4_',exp_name,'_r1i1p1f1_gr1_199101-199612');
  glbmn_toa_cfmip_fb
  rad_ts_array_amip3=rad_ts_array;

  exp_string=strcat('_Amon_GFDL-CM4_',exp_name,'_r1i1p1f1_gr1_199701-200212');
  glbmn_toa_cfmip_fb
  rad_ts_array_amip4=rad_ts_array;

  exp_string=strcat('_Amon_GFDL-CM4_',exp_name,'_r1i1p1f1_gr1_200301-200812');
  glbmn_toa_cfmip_fb
  rad_ts_array_amip5=rad_ts_array;

  exp_string=strcat('_Amon_GFDL-CM4_',exp_name,'_r1i1p1f1_gr1_200901-201412');
  glbmn_toa_cfmip_fb
  rad_ts_array_amip6=rad_ts_array;

%  rad_ts_array_amip=(rad_ts_array_amip1+rad_ts_array_amip2+rad_ts_array_amip3+...
%                     rad_ts_array_amip4+rad_ts_array_amip5+rad_ts_array_amip6)/6;

  rad_ts_array_amip=cat(2,rad_ts_array_amip1,rad_ts_array_amip2,rad_ts_array_amip3,rad_ts_array_amip4,rad_ts_array_amip5,rad_ts_array_amip6);

amip_control=false

%-=-=-=-=
aqua_control=true
exp_name='aqua-control';
glbmn_toa_cfmip_fb
rad_ts_array_aqua_control=rad_ts_array;

exp_name='aqua-p4K';
glbmn_toa_cfmip_fb
rad_ts_array_aqua_p4K=rad_ts_array;

del_R_aq_p4K      =(mean(rad_ts_array_aqua_p4K(1,:))-mean(rad_ts_array_aqua_control(1,:)))/delT_aqua;
del_Rclr_aq_p4K   =(mean(rad_ts_array_aqua_p4K(2,:))-mean(rad_ts_array_aqua_control(2,:)))/delT_aqua;
del_cre_aq_p4K    =(mean(rad_ts_array_aqua_p4K(3,:))-mean(rad_ts_array_aqua_control(3,:)))/delT_aqua;
del_lwcre_aq_p4K  =(mean(rad_ts_array_aqua_p4K(4,:))-mean(rad_ts_array_aqua_control(4,:)))/delT_aqua;
del_swcre_aq_p4K  =(mean(rad_ts_array_aqua_p4K(5,:))-mean(rad_ts_array_aqua_control(5,:)))/delT_aqua;
del_lwcs_aq_p4K   =(mean(rad_ts_array_aqua_p4K(6,:))-mean(rad_ts_array_aqua_control(6,:)))/delT_aqua;
del_swcs_aq_p4K   =(mean(rad_ts_array_aqua_p4K(7,:))-mean(rad_ts_array_aqua_control(7,:)))/delT_aqua;

%rad_fb_array_str='aqua_p4K;amip_m4K;amip_p4K;amip_p8K;amip_future4K'
% until the aqua p4K is computed, fill the array with amip m4K
rad_fb_array(1,1)=del_R_aq_p4K;
rad_fb_array(2,1)=del_Rclr_aq_p4K;
rad_fb_array(3,1)=del_cre_aq_p4K;
rad_fb_array(4,1)=del_lwcre_aq_p4K;
rad_fb_array(5,1)=del_swcre_aq_p4K;
rad_fb_array(6,1)=-del_lwcs_aq_p4K;
rad_fb_array(7,1)=-del_swcs_aq_p4K;

aqua_control=false

%-=-=-=-=
exp_name='amip-m4K';
glbmn_toa_cfmip_fb
rad_ts_array_m4K=rad_ts_array;

delR_m4K      =(mean(rad_ts_array_amip(1,:))-mean(rad_ts_array_m4K(1,:)))/delT_amip_m4K;
del_clr_m4K   =(mean(rad_ts_array_amip(2,:))-mean(rad_ts_array_m4K(2,:)))/delT_amip_m4K;
del_cre_m4K   =(mean(rad_ts_array_amip(3,:))-mean(rad_ts_array_m4K(3,:)))/delT_amip_m4K;
del_lwcre_m4K =(mean(rad_ts_array_amip(4,:))-mean(rad_ts_array_m4K(4,:)))/delT_amip_m4K;
del_swcre_m4K =(mean(rad_ts_array_amip(5,:))-mean(rad_ts_array_m4K(5,:)))/delT_amip_m4K;
del_lwcs_m4K  =(mean(rad_ts_array_amip(6,:))-mean(rad_ts_array_m4K(6,:)))/delT_amip_m4K;
del_swcs_m4K  =(mean(rad_ts_array_amip(7,:))-mean(rad_ts_array_m4K(7,:)))/delT_amip_m4K;

rad_fb_array(1,2)=delR_m4K;
rad_fb_array(2,2)=del_clr_m4K;
rad_fb_array(3,2)=del_cre_m4K;
rad_fb_array(4,2)=del_lwcre_m4K;
rad_fb_array(5,2)=del_swcre_m4K;
rad_fb_array(6,2)=-del_lwcs_m4K;
rad_fb_array(7,2)=-del_swcs_m4K;

%-=-=-=-=
exp_name='amip-p4K';
glbmn_toa_cfmip_fb
rad_ts_array_p4K=rad_ts_array;

delR_p4K      =(mean(rad_ts_array_p4K(1,:))-mean(rad_ts_array_amip(1,:)))/delT_amip_p4K;
del_clr_p4K   =(mean(rad_ts_array_p4K(2,:))-mean(rad_ts_array_amip(2,:)))/delT_amip_p4K;
del_cre_p4K   =(mean(rad_ts_array_p4K(3,:))-mean(rad_ts_array_amip(3,:)))/delT_amip_p4K;
del_lwcre_p4K =(mean(rad_ts_array_p4K(4,:))-mean(rad_ts_array_amip(4,:)))/delT_amip_p4K;
del_swcre_p4K =(mean(rad_ts_array_p4K(5,:))-mean(rad_ts_array_amip(5,:)))/delT_amip_p4K;
del_lwcs_p4K  =(mean(rad_ts_array_p4K(6,:))-mean(rad_ts_array_amip(6,:)))/delT_amip_p4K;
del_swcs_p4K  =(mean(rad_ts_array_p4K(7,:))-mean(rad_ts_array_amip(7,:)))/delT_amip_p4K;

rad_fb_array(1,3)=delR_p4K;
rad_fb_array(2,3)=del_clr_p4K;
rad_fb_array(3,3)=del_cre_p4K;
rad_fb_array(4,3)=del_lwcre_p4K;
rad_fb_array(5,3)=del_swcre_p4K;
rad_fb_array(6,3)=-del_lwcs_p4K;
rad_fb_array(7,3)=-del_swcs_p4K;

%-=-=-=-=

delR_p8K       =(mean(rad_ts_array_p4K(1,:))-mean(rad_ts_array_m4K(1,:)))/delT_amip_8K;
del_clr_p8K    =(mean(rad_ts_array_p4K(2,:))-mean(rad_ts_array_m4K(2,:)))/delT_amip_8K;
del_cre_p8K    =(mean(rad_ts_array_p4K(3,:))-mean(rad_ts_array_m4K(3,:)))/delT_amip_8K;
del_lwcre_p8K  =(mean(rad_ts_array_p4K(4,:))-mean(rad_ts_array_m4K(4,:)))/delT_amip_8K;
del_swcre_p8K  =(mean(rad_ts_array_p4K(5,:))-mean(rad_ts_array_m4K(5,:)))/delT_amip_8K;
del_lwcs_p8K   =(mean(rad_ts_array_p4K(6,:))-mean(rad_ts_array_m4K(6,:)))/delT_amip_8K;
del_swcs_p8K   =(mean(rad_ts_array_p4K(7,:))-mean(rad_ts_array_m4K(7,:)))/delT_amip_8K;

rad_fb_array(1,4)=delR_p8K;
rad_fb_array(2,4)=del_clr_p8K;
rad_fb_array(3,4)=del_cre_p8K;
rad_fb_array(4,4)=del_lwcre_p8K;
rad_fb_array(5,4)=del_swcre_p8K;
rad_fb_array(6,4)=-del_lwcs_p8K;
rad_fb_array(7,4)=-del_swcs_p8K;

%-=-=-=-=
exp_name='amip-future4K';
glbmn_toa_cfmip_fb
rad_ts_array_future4K=rad_ts_array;

delR_future4K      =(mean(rad_ts_array_future4K(1,:))-mean(rad_ts_array_amip(1,:)))/delT_amip_fut;
%delR_future4K      =(mean(rad_ts_array_future4K(1,:)-rad_ts_array_amip(1,:)))/4;
del_clr_future4K   =(mean(rad_ts_array_future4K(2,:))-mean(rad_ts_array_amip(2,:)))/delT_amip_fut;
del_cre_future4K   =(mean(rad_ts_array_future4K(3,:))-mean(rad_ts_array_amip(3,:)))/delT_amip_fut;
del_lwcre_future4K =(mean(rad_ts_array_future4K(4,:))-mean(rad_ts_array_amip(4,:)))/delT_amip_fut;
del_swcre_future4K =(mean(rad_ts_array_future4K(5,:))-mean(rad_ts_array_amip(5,:)))/delT_amip_fut;
del_lwcs_future4K  =(mean(rad_ts_array_future4K(6,:))-mean(rad_ts_array_amip(6,:)))/delT_amip_fut;
del_swcs_future4K  =(mean(rad_ts_array_future4K(7,:))-mean(rad_ts_array_amip(7,:)))/delT_amip_fut;

rad_fb_array(1,5)=delR_future4K;
rad_fb_array(2,5)=del_clr_future4K;
rad_fb_array(3,5)=del_cre_future4K;
rad_fb_array(4,5)=del_lwcre_future4K;
rad_fb_array(5,5)=del_swcre_future4K;
rad_fb_array(6,5)=-del_lwcs_future4K;
rad_fb_array(7,5)=-del_swcs_future4K;

%-=-=-=-=
rad_fb_array_str='aqua_p4K;amip_m4K;amip_p4K;amip_p8K;amip_future4K'

%-=-=-=-=
exp_name='amip-4xCO2';
glbmn_toa_cfmip_fb
rad_ts_array_4xCO2=rad_ts_array;

delR_4xCO2=(mean(rad_ts_array_4xCO2(1,:))-mean(rad_ts_array_amip(1,:)))/1;

