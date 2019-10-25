%-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
% driver for the computation of feedbacks 
% uses the glbmn_toa_cfmip_fb script
%
% levi silvers                                        October 2019
%-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

% rad_ts_array(toa_R;toa_clr;toa_cre;toa_lwcre;toa_swcre)

% to get the numbers for amip we need to play some games becuase i can't write
% to my own data directory for some u

amip_control=true

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
exp_name='amip-m4K';
glbmn_toa_cfmip_fb
rad_ts_array_m4K=rad_ts_array;

%delR_m4K     =(mean(rad_ts_array_amip(1,:))-mean(rad_ts_array_m4K(1,:)))/4;
delR_m4K      =(mean(rad_ts_array_amip(1,:))-mean(rad_ts_array_m4K(1,:)))/4;
del_clr_m4K   =(mean(rad_ts_array_amip(2,:))-mean(rad_ts_array_m4K(2,:)))/4;
del_cre_m4K   =(mean(rad_ts_array_amip(3,:))-mean(rad_ts_array_m4K(3,:)))/4;
del_lwcre_m4K =(mean(rad_ts_array_amip(4,:))-mean(rad_ts_array_m4K(4,:)))/4;
del_swcre_m4K =(mean(rad_ts_array_amip(5,:))-mean(rad_ts_array_m4K(5,:)))/4;

%-=-=-=-=
exp_name='amip-p4K';
glbmn_toa_cfmip_fb
rad_ts_array_p4K=rad_ts_array;

delR_p4K      =(mean(rad_ts_array_p4K(1,:))-mean(rad_ts_array_amip(1,:)))/4;
del_clr_p4K   =(mean(rad_ts_array_p4K(2,:))-mean(rad_ts_array_amip(2,:)))/4;
del_cre_p4K   =(mean(rad_ts_array_p4K(3,:))-mean(rad_ts_array_amip(3,:)))/4;
del_lwcre_p4K =(mean(rad_ts_array_p4K(4,:))-mean(rad_ts_array_amip(4,:)))/4;
del_swcre_p4K =(mean(rad_ts_array_p4K(5,:))-mean(rad_ts_array_amip(5,:)))/4;

%delR_p8K      =(mean(rad_ts_array_p4K(1,:))-mean(rad_ts_array_m4K(1,:)))/8;
delR_p8K      =(mean(rad_ts_array_p4K(1,:))-mean(rad_ts_array_m4K(1,:)))/8;
del_clr_p8K   =(mean(rad_ts_array_p4K(2,:))-mean(rad_ts_array_m4K(2,:)))/8;
del_cre_p8K   =(mean(rad_ts_array_p4K(3,:))-mean(rad_ts_array_m4K(3,:)))/8;
del_lwcre_p8K =(mean(rad_ts_array_p4K(4,:))-mean(rad_ts_array_m4K(4,:)))/8;
del_swcre_p8K =(mean(rad_ts_array_p4K(5,:))-mean(rad_ts_array_m4K(5,:)))/8;

%-=-=-=-=
exp_name='amip-future4K';
glbmn_toa_cfmip_fb
rad_ts_array_future4K=rad_ts_array;

delR_future4K      =(mean(rad_ts_array_future4K(1,:))-mean(rad_ts_array_amip(1,:)))/4;
del_clr_future4K   =(mean(rad_ts_array_future4K(2,:))-mean(rad_ts_array_amip(2,:)))/4;
del_cre_future4K   =(mean(rad_ts_array_future4K(3,:))-mean(rad_ts_array_amip(3,:)))/4;
del_lwcre_future4K =(mean(rad_ts_array_future4K(4,:))-mean(rad_ts_array_amip(4,:)))/4;
del_swcre_future4K =(mean(rad_ts_array_future4K(5,:))-mean(rad_ts_array_amip(5,:)))/4;

%-=-=-=-=
exp_name='amip-4xCO2';
glbmn_toa_cfmip_fb
rad_ts_array_4xCO2=rad_ts_array;

delR_4xCO2=(mean(rad_ts_array_4xCO2(1,:))-mean(rad_ts_array_amip(1,:)))/1;





