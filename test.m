%------------------------------------------------------------------
% compute the potential temperature using temperature and pressure
% compute the static stability
%
% goal: compute and plot the change of temp with height.  do I want 
% do plot dT/dz, dtheta/dz, dT/dp, or dtheta/dp?
%
% the intention is to make this general enough to use with 1km, 2km, 
% 25km, or 100km grid-spacing experiments
%
% why are we using p0=1000 instead of the actual surface pressure?
%------------------------------------------------------------------

clear gamma_d;

theta_gcm   = zeros(nlat,nlev);
theta_e_gcm = zeros(nlat,nlev);
theta_crm1  = zeros(4000,nlev);
theta_e_crm1  = zeros(4000,nlev);
theta_crm2  = zeros(2000,nlev);
theta_e_crm2  = zeros(2000,nlev);
lts_f       = zeros(nlat,nlon);
rh_sfc      = zeros(nlat,nlon);
theta_temp  = zeros(nlat,nlon);
%staticst    = zeros(nlat,nlev);
gamma_d     = zeros(1,nlev);
gamma_m     = zeros(3,nlev);
gamma       = zeros(3,nlev);
stastapar   = zeros(3,nlev);
es          = zeros(1,nlev);
qs          = zeros(1,nlev);
sten        = zeros(nlat,nlev);

gamma_d = gamma_d+grav/cp;

% first compute theta at the surface
tsurf_zmn=squeeze(mean(tsfc_mn,2));
tsurf_crm1_zmn=squeeze(mean(tsurf_crm1,2));
tsurf_crm1_ztmn=squeeze(mean(tsurf_crm1_zmn,2));
tsurf_crm2_zmn=squeeze(mean(tsurf_crm,2));
tsurf_crm2_ztmn=squeeze(mean(tsurf_crm2_zmn,2));
% compute theta at the surface
theta_sfc=tsurf_zmn.*(p0./psurf_zmn).^kappa;

% assume psurf are the same for all models and experiments

% now compute theta throughout the atmospheric depth
%theta_temp=tsfc_mn.*((p0/pfull_gen(33))^kappa);
%theta_f(:,:,33)=theta_temp(:,:);

%temp_gen=ncread(source_gcm_month,'temp');
%temp_equil=temp_gen(:,:,:,1:4);
%temp_eq_tmn=squeeze(mean(temp_equil,4));
%temp_eq_ztmn=squeeze(mean(temp_eq_tmn,2));
temp_eq_ztmn=read_1var_ztmn(source_gcm_month,'temp');
temp_crm_ztmn=read_1var_ztmn(source_2km_month,'temp');
temp_crm1_ztmn=read_1var_ztmn(source_1km_month,'temp');

for lev=1:nlev; % compute the 3d potential temperature field
   theta_gcm(:,lev)=temp_eq_ztmn(:,lev).*(p0/pfull_gen(lev))^kappa;
   theta_crm2(:,lev)=temp_crm_ztmn(:,lev).*(p0/pfull_gen(lev))^kappa;
   theta_crm1(:,lev)=temp_crm1_ztmn(:,lev).*(p0/pfull_gen(lev))^kappa;
end

theta_e_gcm=theta_gcm.*exp((q_25km_ztmn*latheat)./(cp*temp_25km_ztmn));
theta_e_crm1=theta_crm1.*exp((q_1km_ztmn*latheat)./(cp*temp_crm1_ztmn));
theta_e_crm2=theta_crm2.*exp((q_2km_ztmn*latheat)./(cp*temp_crm_ztmn));

theta_e_gcm_mid=mean(theta_e_gcm(80:120,:));
theta_e_crm1_mid=mean(theta_e_crm1(1500:2500,:));
theta_e_crm2_mid=mean(theta_e_crm2(750:1250,:));

% compute the virtual temperature and density
Tv_25km=temp_25km_ztmn.*(1+q_25km_ztmn./epsilon)./(1+q_25km_ztmn);
Tv_2km=temp_crm_ztmn.*(1+q_2km_ztmn./epsilon)./(1+q_2km_ztmn);
Tv_1km=temp_crm1_ztmn.*(1+q_1km_ztmn./epsilon)./(1+q_1km_ztmn);

%clear rho_25km;
%clear rho_2km;
%clear rho_1km;
%
%rho_25km=rho_2d_gen(temp_25km_ztmn,q_25km_ztmn,pfull_25km,160);
%rho_2km=rho_2d_gen(temp_crm_ztmn,q_2km_ztmn,pfull_2km,2000);
%rho_1km=rho_2d_gen(temp_crm1_ztmn,q_1km_ztmn,pfull_1km,2000);

% lev 1 is the at the top of the domain, lev 33 is the lowest atmospheric level
% gamma = -g*rho*delT/delp
plot_lat=80;
%plot_lat=1;
gamma(1,:)=lapser(temp_eq_ztmn,rho_25km,plot_lat,tsfc,psurf_zmn,pfull_gen);
%gamma(1,:)=lapser(temp_eq_ztmn_midmn,rho_25km_midmn,plot_lat,tsfc,psurf_zmn,pfull_gen);
temp_eq_prof=temp_eq_ztmn(plot_lat,:);
es(:)=satvappres(temp_eq_prof);
qs(:)=qstar(es,pfull_gen);
gamma_m(1,:)=moistadiabat(temp_eq_prof,qs);

plot_lat=1000;
%plot_lat=1;
gamma(2,:)=lapser(temp_crm_ztmn,rho_2km,plot_lat,tsurf_crm2_ztmn,psurf_2km_zmn,pfull_gen);
temp_crm_prof=temp_crm_ztmn(plot_lat,:);
es(:)=satvappres(temp_crm_prof); % compute sat vapor pressure
qs(:)=qstar(es,pfull_gen); % compute saturation mixing ratio
gamma_m(2,:)=moistadiabat(temp_eq_prof,qs);

gamma_2d_cen=zeros(500,nlev);
gamma_2d_edg=zeros(500,nlev);
for i=750:1250;
gamma_2d_cen(i-749,:)=lapser(temp_crm_ztmn,rho_2km,i,tsurf_crm2_ztmn,psurf_2km_zmn,pfull_gen);
gamma_2d_edg(i-749,:)=lapser(temp_crm_ztmn,rho_2km,i-749,tsurf_crm2_ztmn,psurf_2km_zmn,pfull_gen);
end 

plot_lat=2000;
%plot_lat=1;
gamma(3,:)=lapser(temp_crm1_ztmn,rho_1km,plot_lat,tsurf_crm1_ztmn,psurf_1km_zmn,pfull_gen);
temp_crm1_prof=temp_crm1_ztmn(plot_lat,:);
es(:)=satvappres(temp_crm1_prof);
qs(:)=qstar(es,pfull_gen);
gamma_m(3,:)=moistadiabat(temp_eq_prof,qs);

% compute the average over the middle quarter of the domain: 
temp_eq_ztmn_mid=mean(temp_eq_ztmn(60:100,:));
temp_crm_ztmn_mid=mean(temp_crm_ztmn(750:1250,:));
temp_crm1_ztmn_mid=mean(temp_crm1_ztmn(1500:2500,:));

top_2plot=18;
zzfull=squeeze(zfull_2km_zmn(500,:,1));

temp_crm_zmn=squeeze(mean(temp_2km,2));
temp_crm_zmn=temp_crm_zmn(:,:,3:6);
temp_crm_ztmn=squeeze(mean(temp_crm_zmn,3));
temp_crm_ztzmn=squeeze(mean(temp_crm_ztmn,1));

% compute the lcl lifting condensation level (m)
lcl_gcm=lcl_romps(pfull_25km(33),temp_eq_ztmn(80,33),0.01*hur_25km_ztmn(80,33),false,false)
lcl_crm2=lcl_romps(pfull_2km(33),temp_crm_ztmn(1000,33),0.01*hur_2km_ztmn(1000,33),false,false)
lcl_crm1=lcl_romps(pfull_2km(33),temp_crm1_ztmn(2000,33),0.01*hur_1km_ztmn(2000,33),false,false)

% s=cp*T+g*z  % dry static energy
% the output is only a function of height
plot_lat=80;
zfull_prof=squeeze(zfull_25km_ztmn(plot_lat,:));
stastapar(1,:)=stastap(temp_eq_ztmn,plot_lat,psurf_zmn,pfull_gen,zfull_prof);
plot_lat=1000;
%zfull_prof=squeeze(zfull_2km_ztmn(plot_lat,:));
stastapar(2,:)=stastap(temp_crm_ztmn,plot_lat,psurf_2km_zmn,pfull_gen,zfull_prof);
plot_lat=2000;
%zfull_prof=squeeze(zfull_1km_ztmn(plot_lat,:));
stastapar(3,:)=stastap(temp_crm1_ztmn,plot_lat,psurf_1km_zmn,pfull_gen,zfull_prof);

%compute the static stability throughout the domain
staticst_25km             = zeros(160,nlev);
staticst_par_25km         = zeros(160,nlev);
%vvel_d_25km               = zeros(160,nlev);
div_d_25km                = zeros(160,nlev);
staticst_25km=stasta_3d(temp_eq_ztmn,160,psurf_zmn,pfull_gen,zfull_prof);
staticst_par_25km=stastap_3d(staticst_25km,160,psurf_zmn,pfull_gen);

staticst_2km              = zeros(2000,nlev);
staticst_par_2km          = zeros(2000,nlev);
%vvel_d_2km                = zeros(2000,nlev);
staticst_2km=stasta_3d(temp_crm_ztmn,2000,psurf_2km_zmn,pfull_gen,zfull_prof);
staticst_par_2km=stastap_3d(staticst_2km,2000,psurf_2km_zmn,pfull_gen);

staticst_1km              = zeros(4000,nlev);
staticst_par_1km          = zeros(4000,nlev);
%vvel_d_1km                = zeros(4000,nlev);
staticst_1km=stasta_3d(temp_crm1_ztmn,4000,psurf_1km_zmn,pfull_gen,zfull_prof);
staticst_par_1km=stastap_3d(staticst_1km,4000,psurf_1km_zmn,pfull_gen);

% location of updraft:
gcm1=80;
gcm2=120;

%% compute the diabatic vertical velocity
%vvel_d_25km=rad_heating_25./staticst_par_25km;
%vvel_d_2km=rad_heating_2./staticst_par_2km;
%vvel_d_1km=rad_heating_1./staticst_par_1km;

w_d_25km_asc_int=squeeze(mean(vvel_d_25km(gcm1:gcm2,:),1));
rho_25km_dmn=squeeze(mean(rho_25km,1));
w_d_25km_asc_int2=w_d_25km_asc_int/8640.;
w_d_25km_asc=w_d_25km_asc_int2./rho_25km_dmn;

% compute the domain mean total vertical velocity
w_25km_dmn=squeeze(mean(w_25km_ztmn,1));
w_25km_asc=squeeze(mean(w_25km_ztmn(gcm1:gcm2,:),1));
w_25km_des=squeeze(mean(w_25km_ztmn(1:gcm1,:),1))+squeeze(mean(w_25km_ztmn(gcm2+1:160,:),1));
w_2km_dmn=squeeze(mean(w_2km_ztmn,1));
w_2km_asc=squeeze(mean(w_2km_ztmn(750:1250,:),1));
w_2km_des=squeeze(mean(w_2km_ztmn(1:749,:),1))+squeeze(mean(w_2km_ztmn(1251:2000,:),1));
w_1km_dmn=squeeze(mean(w_1km_ztmn,1));
w_1km_asc=squeeze(mean(w_1km_ztmn(1500:2500,:),1));
w_1km_des=squeeze(mean(w_1km_ztmn(1:1499,:),1))+squeeze(mean(w_1km_ztmn(2501:4000,:),1));

%% compute the diabatic divergence
%div_d_25km=diabdiv(vvel_d_25km,160,psurf_zmn,pfull_gen);
%div_d_2km=diabdiv(vvel_d_2km,2000,psurf_2km_zmn,pfull_gen);
%div_d_1km=diabdiv(vvel_d_1km,4000,psurf_1km_zmn,pfull_gen);

% compute an approximate lower tropospheric stability
lts=theta_gcm(:,21)-theta_sfc(:);

fr_line=zeros(1,33)+273.15;

