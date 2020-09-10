%--------------------------------------------------------------------------
% open appropriate files, do basic analysis and create arrays that 
% are ready to be plotted.
%
% source strings for the data are defined in cf_tdtlw_4pan.m
%
% figures are made in cf_tdtlw_4pan.m
%
% levi silvers                                          august 2020
%--------------------------------------------------------------------------

% process data: 

% det K/s; using 'conv' converts to K/day
tdtlw_25_ztmn=conv.*read_1var_ztmn(source_gcm_month,'tdt_lw');
tdtlw_E25_ztmn=conv.*read_1var_ztmn(source_gcm_month_noconv,'tdt_lw');
tdtlw_100_ztmn=conv.*read_1var_ztmn(source_100km_sm_month,'tdt_lw');

tdtlw_2km=ncread(source_2km_month,'tdt_lw');
tdtlw_2km=conv.*tdtlw_2km(:,:,:,t_mid:t_end);
tdtlw_2_tmn=squeeze(mean(tdtlw_2km,4));
tdtlw_2_ztmn=squeeze(mean(tdtlw_2_tmn,2));

tdtlw_1km=ncread(source_1km_month,'tdt_lw');
tdtlw_1km=conv.*tdtlw_1km(:,:,:,t_mid:t_end);
tdtlw_1_tmn=squeeze(mean(tdtlw_1km,4));
tdtlw_1_ztmn=squeeze(mean(tdtlw_1_tmn,2));

% cloud fraction  

clt_2km=ncread(source_2km_month,'cld_amt');
clt_1km=ncread(source_1km_month,'cld_amt');
clt_25km=ncread(source_gcm_month,'cld_amt');
clt_E25km=ncread(source_gcm_month_noconv,'cld_amt');

clt_100km_ztmn = read_1var_ztmn(source_100km_sm_month,'cld_amt');
clt_100km_sm_znm_tmn=cltscale.*clt_100km_ztmn;

clt_100km_lg_ztmn = read_1var_ztmn(source_100km_lg_month,'cld_amt');
clt_100km_lg_znm_tmn=cltscale.*clt_100km_lg_ztmn;

clt_25km_znm=cltscale.*squeeze(mean(clt_25km,2));
clt_25km_znm_2m=clt_25km_znm(:,:,an_t1:an_t2);
clt_25km_znm_2mtmn=squeeze(mean(clt_25km_znm_2m,3));
clt_25km_znm_tmn=mean(clt_25km_znm,3); % this is over a full year...

clt_E25km_znm=cltscale.*squeeze(mean(clt_E25km,2));
clt_E25km_znm_2m=clt_E25km_znm(:,:,an_t1:an_t2);
clt_E25km_znm_2mtmn=squeeze(mean(clt_E25km_znm_2m,3));
clt_E25km_znm_tmn=mean(clt_E25km_znm,3); % this is over a full year...

clt_2km_znm=cltscale.*squeeze(mean(clt_2km,2));
clt_2km_znm_end=clt_2km_znm(:,:,t_mid:t_end);
clt_2km_znm_start=clt_2km_znm(:,:,1:t_mid);
clt_2km_znm_eq=clt_2km_znm(:,:,t_mid:t_end);

clt_2km_znm_st_tmn=mean(clt_2km_znm_start,3);
clt_2km_znm_end_tmn=mean(clt_2km_znm_end,3);
clt_2km_znm_eq_tmn=mean(clt_2km_znm_eq,3);

clt_1km_znm=cltscale.*squeeze(mean(clt_1km,2));
clt_1km_znm_eq=clt_1km_znm(:,:,t_mid:t_end);
clt_1km_znm_eq_tmn=mean(clt_1km_znm_eq,3);

% compute radiative heating in the subsidence region
tdtlw_1km_sub_a=tdtlw_1_ztmn(1:bc_a_1km,:);
tdtlw_1km_sub_prof_a=mean(tdtlw_1km_sub_a,1);
tdtlw_1km_sub_b=tdtlw_1_ztmn(bc_b_1km:bc_c_1km,:);
tdtlw_1km_sub_prof_b=mean(tdtlw_1km_sub_b,1);
tdtlw_1km_sub_prof=(tdtlw_1km_sub_prof_a+tdtlw_1km_sub_prof_b)/2;

tdtlw_2km_sub_a=tdtlw_2_ztmn(1:bc_a_2km,:);
tdtlw_2km_sub_prof_a=mean(tdtlw_2km_sub_a,1);
tdtlw_2km_sub_b=tdtlw_2_ztmn(bc_b_2km:bc_c_2km,:);
tdtlw_2km_sub_prof_b=mean(tdtlw_2km_sub_b,1);
tdtlw_2km_sub_prof=(tdtlw_2km_sub_prof_a+tdtlw_2km_sub_prof_b)/2;

tdtlw_25km_sub_a=tdtlw_25_ztmn(1:bc_a_25km,:);
tdtlw_25km_sub_prof_a=mean(tdtlw_25km_sub_a,1);
tdtlw_25km_sub_b=tdtlw_25_ztmn(bc_b_25km:bc_c_25km,:);
tdtlw_25km_sub_prof_b=mean(tdtlw_25km_sub_b,1);
tdtlw_25km_sub_prof=(tdtlw_25km_sub_prof_a+tdtlw_25km_sub_prof_b)/2;

tdtlw_25km_prof=mean(tdtlw_25_ztmn,1);

tdtlw_E25km_sub_a=tdtlw_E25_ztmn(1:bc_a_25km,:);
tdtlw_E25km_sub_prof_a=mean(tdtlw_E25km_sub_a,1);
tdtlw_E25km_sub_b=tdtlw_E25_ztmn(bc_b_25km:bc_c_25km,:);
tdtlw_E25km_sub_prof_b=mean(tdtlw_E25km_sub_b,1);
tdtlw_E25km_sub_prof=(tdtlw_E25km_sub_prof_a+tdtlw_E25km_sub_prof_b)/2;

tdtlw_E25km_prof=mean(tdtlw_E25_ztmn,1);

tdtlw_100km_sub_a=tdtlw_100_ztmn(1:bc_a_100km,:);
tdtlw_100km_sub_prof_a=mean(tdtlw_100km_sub_a,1);
tdtlw_100km_sub_b=tdtlw_100_ztmn(bc_b_100km:bc_c_100km,:);
tdtlw_100km_sub_prof_b=mean(tdtlw_100km_sub_b,1);
tdtlw_100km_sub_prof=(tdtlw_100km_sub_prof_a+tdtlw_100km_sub_prof_b)/2;

%-----------------------------------------------------------------------
% compute cloud fraction in the domain mean and subsidence regions
%
clt_1km_sub_a=clt_1km_znm_eq_tmn(1:bc_a_1km,:);
clt_1km_sub_prof_a=mean(clt_1km_sub_a,1);
clt_1km_sub_b=clt_1km_znm_eq_tmn(bc_b_1km:bc_c_1km,:);
clt_1km_sub_prof_b=mean(clt_1km_sub_b,1);
clt_1km_sub_prof=(clt_1km_sub_prof_a+clt_1km_sub_prof_b)/2;

clt_1km_prof=mean(clt_1km_znm_eq_tmn,1);

clt_2km_sub_a=clt_2km_znm_eq_tmn(1:bc_a_2km,:);
clt_2km_sub_prof_a=mean(clt_2km_sub_a,1);
clt_2km_sub_b=clt_2km_znm_eq_tmn(bc_b_2km:bc_c_2km,:);
clt_2km_sub_prof_b=mean(clt_2km_sub_b,1);
clt_2km_sub_prof=(clt_2km_sub_prof_a+clt_2km_sub_prof_b)/2;

clt_2km_prof=mean(clt_2km_znm_eq_tmn,1);

clt_25km_sub_a=clt_25km_znm_tmn(1:bc_a_25km,:);
clt_25km_sub_prof_a=mean(clt_25km_sub_a,1);
clt_25km_sub_b=clt_25km_znm_tmn(bc_b_25km:bc_c_25km,:);
clt_25km_sub_prof_b=mean(clt_25km_sub_b,1);
clt_25km_sub_prof=(clt_25km_sub_prof_a+clt_25km_sub_prof_b)/2;

clt_25km_prof=mean(clt_25km_znm_tmn,1);

clt_E25km_sub_a=clt_E25km_znm_tmn(1:bc_a_25km,:);
clt_E25km_sub_prof_a=mean(clt_E25km_sub_a,1);
clt_E25km_sub_b=clt_E25km_znm_tmn(bc_b_25km:bc_c_25km,:);
clt_E25km_sub_prof_b=mean(clt_E25km_sub_b,1);
clt_E25km_sub_prof=(clt_E25km_sub_prof_a+clt_E25km_sub_prof_b)/2;

clt_E25km_prof=mean(clt_E25km_znm_tmn,1);

clt_100km_sub_a=clt_100km_sm_znm_tmn(1:bc_a_100km,:);
clt_100km_sub_prof_a=mean(clt_100km_sub_a,1);
clt_100km_sub_b=clt_100km_sm_znm_tmn(bc_b_100km:bc_c_100km,:);
clt_100km_sub_prof_b=mean(clt_100km_sub_b,1);
clt_100km_sub_prof=(clt_100km_sub_prof_a+clt_100km_sub_prof_b)/2;

clt_100km_prof=mean(clt_100km_sm_znm_tmn,1);

% are we ready to plot?
