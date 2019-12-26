%-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
% glbmn_tas_cfmip
%
% reads tas values from several amip like cfmip experiments.
% computes global mean cosine weighted time series
% averages in time
%
% levi silvers                                       Dec 2019
%-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

source='/Users/silvers/data/cfmip_toafluxes/';

var_tas='tas';

exp_string_amip    ='_Amon_GFDL-AM4_amip_r1i1p1f1_gr1_198001-201412';
exp_string_amip_p4K='_Amon_GFDL-CM4_amip-p4K_r1i1p1f1_gr1_197901-201412';
exp_string_amip_F4K='_Amon_GFDL-CM4_amip-future4K_r1i1p1f1_gr1_197901-201412';
exp_string_amip_m4K='_Amon_GFDL-CM4_amip-m4K_r1i1p1f1_gr1_197901-201412';
exp_string_aqua_c  ='_Amon_GFDL-CM4_aqua-control_r1i1p1f1_gr1_198001-198912';
exp_string_aqua_p4K='_Amon_GFDL-CM4_aqua-p4K_r1i1p1f1_gr1_198001-198912';

s_var_amip_tas     =strcat(source,var_tas,exp_string_amip,'.nc');
s_var_amip_p4K_tas =strcat(source,var_tas,exp_string_amip_p4K,'.nc');
s_var_amip_F4K_tas =strcat(source,var_tas,exp_string_amip_F4K,'.nc');
s_var_amip_m4K_tas =strcat(source,var_tas,exp_string_amip_m4K,'.nc');
s_var_aqua_c_tas   =strcat(source,var_tas,exp_string_aqua_c,'.nc');
s_var_aqua_p4K_tas =strcat(source,var_tas,exp_string_aqua_p4K,'.nc');

amip_amip_tas  = ncread(s_var_amip_tas,var_tas);
amip_p4K_tas   = ncread(s_var_amip_p4K_tas,var_tas);
amip_F4K_tas   = ncread(s_var_amip_F4K_tas,var_tas);
amip_m4K_tas   = ncread(s_var_amip_m4K_tas,var_tas);
aqua_c_tas     = ncread(s_var_aqua_c_tas,var_tas);
aqua_p4K_tas   = ncread(s_var_aqua_p4K_tas,var_tas);


for ti=1:420;
  fullfield=squeeze(amip_tas(:,:,ti));
  glblatweight_gen=glblatweight_new; % this switches the dimensions used in m2009
  global_wmean_quick;
  amip_gmn_tas(ti)=wgt_mean;
end
for ti=1:432;
  fullfield=squeeze(amip_p4K_tas(:,:,ti));
  glblatweight_gen=glblatweight_new; % this switches the dimensions used in m2009
  global_wmean_quick;
  amip_gmn_p4K_tas(ti)=wgt_mean;
  fullfield=squeeze(amip_m4K_tas(:,:,ti));
  glblatweight_gen=glblatweight_new; % this switches the dimensions used in m2009
  global_wmean_quick;
  amip_gmn_m4K_tas(ti)=wgt_mean;
  fullfield=squeeze(amip_F4K_tas(:,:,ti));
  glblatweight_gen=glblatweight_new; % this switches the dimensions used in m2009
  global_wmean_quick;
  amip_gmn_F4K_tas(ti)=wgt_mean;
end
for ti=1:120;
  fullfield=squeeze(aqua_c_tas(:,:,ti));
  glblatweight_gen=glblatweight_new; % this switches the dimensions used in m2009
  global_wmean_quick;
  aqua_gmn_c_tas(ti)=wgt_mean;
  fullfield=squeeze(aqua_p4K_tas(:,:,ti));
  glblatweight_gen=glblatweight_new; % this switches the dimensions used in m2009
  global_wmean_quick;
  aqua_gmn_p4K_tas(ti)=wgt_mean;
end

amip_mts=mean(amip_gmn_tas)
amip_p4K_mts=mean(amip_gmn_p4K_tas)
amip_F4K_mts=mean(amip_gmn_F4K_tas)
amip_m4K_mts=mean(amip_gmn_m4K_tas)
aqua_mts=mean(aqua_gmn_c_tas)
aqua_p4K_mts=mean(aqua_gmn_p4K_tas)


