%------------------------------------------------------------------
% compute the subsidence fraction for the WalkerCell experiments
%
% to be used in coordination with WalkerCell.m
%
% wether the experiments are the control experiments or LWCRE-off
% is determined in WalkerCell.m with the exception of E25, for 
% which both control and LWCRE-off paths are explicitly set here.
%
% levi silvers                                   april 2020
%------------------------------------------------------------------

% use the same paths as defined in WalkerCell.m

source_e25lwoff_month=strcat('/Users/silvers/data/WalkerCell/testing_20181203/c8x160L33_am4p0_25km_wlkr_ent0p9_noconv_lwoff/',yearstr,'.atmos_month_tmn.nc');

source_e25_month=strcat('/Users/silvers/data/WalkerCell/testing_20181203/c8x160L33_am4p0_25km_wlkr_ent0p9_noconv/',yearstr,'.atmos_month_tmn.nc');

w_25km_e        = ncread(source_e25_month,'w');
w_25km_e_lwoff  = ncread(source_e25lwoff_month,'w');

% grab w at or near 500 mb
w_1km        = ncread(source_1km_month,'w');
w_2km        = ncread(source_2km_month,'w');
w_25km       = ncread(source_gcm_month,'w');
w_25km_lg    = ncread(source_25km_lg_month,'w');
w_100km_lg   = ncread(source_100km_lg_month,'w');
w_100km_sm   = ncread(source_100km_sm_month,'w');

% select vertical level 
vlev=18;

w_1km_f    =squeeze(w_1km(:,:,vlev,:)); 
w_2km_f    =squeeze(w_2km(:,:,vlev,:)); 
w_25km_s   =squeeze(w_25km(:,:,vlev,:)); 
w_25km_e   =squeeze(w_25km_e(:,:,vlev,:)); 
w_25km_elwoff   =squeeze(w_25km_e_lwoff(:,:,vlev,:)); 
w_25km_l   =squeeze(w_25km_lg(:,:,vlev,:)); 
w_100km_s  =squeeze(w_100km_sm(:,:,vlev,:)); 
w_100km_l  =squeeze(w_100km_lg(:,:,vlev,:)); 

;clear sub_25km_s;
;clear sub_25km_l;

sub_100km_s=zeros(size(w_100km_s));
sub_100km_s(w_100km_s>0.0)=1;
m1=mean(sub_100km_s);
m2=squeeze(mean(m1));
1-m2
sf_100_s=1-mean(m2)

sub_100km_l=zeros(size(w_100km_l));
sub_100km_l(w_100km_l>0.0)=1;
m1=mean(sub_100km_l);
m2=squeeze(mean(m1));
1-m2
sf_100_l=1-mean(m2)

sub_25km_s=zeros(size(w_25km_s));
sub_25km_s(w_25km_s>0.0)=1;
m1=mean(sub_25km_s);
m2=squeeze(mean(m1));
1-m2
sf_25_s=1-mean(m2)

sub_25km_e=zeros(size(w_25km_e));
sub_25km_e(w_25km_e>0.0)=1;
m1=mean(sub_25km_e);
m2=squeeze(mean(m1));
1-m2
sf_25_e=1-mean(m2)

sub_25km_e_lwoff=zeros(size(w_25km_elwoff));
sub_25km_e_lwoff(w_25km_elwoff>0.0)=1;
m1=mean(sub_25km_e_lwoff);
m2=squeeze(mean(m1));
1-m2
sf_25_e_lwoff=1-mean(m2)

sub_25km_l=zeros(size(w_25km_l));
sub_25km_l(w_25km_l>0.0)=1;
m1=mean(sub_25km_l);
m2=squeeze(mean(m1));
1-m2
sf_25_l=1-mean(m2)

sub_2km=zeros(size(w_2km_f));
sub_2km(w_2km_f>0.0)=1;
m1=mean(sub_2km);
m2=squeeze(mean(m1));
1-m2(3:6)
sf_2=1-mean(m2(3:6))

sub_1km=zeros(size(w_1km_f));
sub_1km(w_1km_f>0.0)=1;
m1=mean(sub_1km);
m2=squeeze(mean(m1));
1-m2(3:6)
sf_1=1-mean(m2(3:6))



sf_100_s
sf_100_l
sf_25_s
sf_25_l
sf_25_e
sf_25_e_lwoff
sf_2
sf_1
