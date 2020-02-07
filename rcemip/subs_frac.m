function var=subs_frac(model_generation,SSTval)
%------------------------------------------------------------------------------
% subs_frac.m
%
% script to compute the subsidence fraction of omega_500
%
% levi silvers                                 jan 2020
%------------------------------------------------------------------------------

var4='wap500';

% create string
%SSTval="300";
source='/Users/silvers/data/CAM/';
source_mod=strcat(source,model_generation,'_GCM_RCE/');
exp_string_2D=strcat(model_generation,'_GCM_RCE_large',SSTval,'_2D_');
s_var4=strcat(source_mod,exp_string_2D,var4,'.nc');

omega_full   =ncread(s_var4,var4);

tiend=size(omega_full,3);

sub_frac_gen=zeros(1,tiend);


for ti=1:tiend;
  omega_temp=squeeze(omega_full(:,:,ti));
  sub_omega=zeros(size(omega_temp,1),size(omega_temp,2));
  sub_omega(omega_temp>=0.0)=1.0;
  sub_frac_gen(ti)=sum(sum(sub_omega))/(size(omega_temp,1)*size(omega_temp,2));
  clear omega_temp;
end

tendindex=tiend;
incoming_ts=sub_frac_gen;
running_mean_30yr;
incoming_ts=idiotbox;

tendindex=tiend-30;
running_mean_30yr
%sub_frac_295_sm=idiotbox;
var=idiotbox;

%figure
%plot(sub_frac_295_sm)
%xlim([0 1000])


%mean(sub_frac_295_cam6(:))
%
%ans =
%
%    0.6936
%
%mean(sub_frac_300_cam6(:))
%
%ans =
%
%    0.7386
%
%mean(sub_frac_305_cam6(:))
%
%ans =
%
%    0.7345
%
%
