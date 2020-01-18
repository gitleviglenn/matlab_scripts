%-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
% general script to list and possibly tabulate statistics from rce runs.
% 
% variables with the _avg suffix indicate a domain mean has been taken         
%
% it looks like I still haven't downloaded the data for 295K pr in CAM5
% an example of where the data is on glade: 
% /glade/p/univ/ufsu0014/RCEMIP_CAM/CAM5_GCM/RCE_large295/0D/
%
% levi silvers                                                  Dec 2019       
%-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

source='/Users/silvers/data/CAM/';

mean_array=zeros(3,4);

model_generation='CAM6';
source_mod=strcat(source,model_generation,'_GCM_RCE/');

var1='pr_avg';          
var2='prw_avg';
var3='rlut_avg';
var4='wap500';

% create string          
SSTst="295";
exp_string=strcat(model_generation,'_GCM_RCE_large',SSTst,'_0D_');
exp_string_2D=strcat(model_generation,'_GCM_RCE_large',SSTst,'_2D_');
s_var1=strcat(source_mod,exp_string,var1,'.nc') 
s_var2=strcat(source_mod,exp_string,var2,'.nc') 
s_var3=strcat(source_mod,exp_string,var3,'.nc') 
s_var4=strcat(source_mod,exp_string_2D,var4,'.nc') 

% read data
pr_295      =ncread(s_var1,var1);
prw_295     =ncread(s_var2,var2);
rlut_295    =ncread(s_var3,var3);
omega_295   =ncread(s_var4,var4);
SSTst="300";
exp_string=strcat(model_generation,'_GCM_RCE_large',SSTst,'_0D_');
exp_string_2D=strcat(model_generation,'_GCM_RCE_large',SSTst,'_2D_');
s_var1=strcat(source_mod,exp_string,var1,'.nc') 
s_var2=strcat(source_mod,exp_string,var2,'.nc') 
s_var3=strcat(source_mod,exp_string,var3,'.nc') 
s_var4=strcat(source_mod,exp_string_2D,var4,'.nc') 
pr_300      =ncread(s_var1,var1);
prw_300     =ncread(s_var2,var2);
rlut_300    =ncread(s_var3,var3);
omega_300   =ncread(s_var4,var4);
SSTst="305";
exp_string=strcat(model_generation,'_GCM_RCE_large',SSTst,'_0D_');
exp_string_2D=strcat(model_generation,'_GCM_RCE_large',SSTst,'_2D_');
s_var1=strcat(source_mod,exp_string,var1,'.nc') 
s_var2=strcat(source_mod,exp_string,var2,'.nc') 
s_var3=strcat(source_mod,exp_string,var3,'.nc') 
s_var4=strcat(source_mod,exp_string_2D,var4,'.nc') 
pr_305      =ncread(s_var1,var1);
prw_305     =ncread(s_var2,var2);
rlut_305    =ncread(s_var3,var3);
omega_305   =ncread(s_var4,var4);

% scale precip to mm/day
p295=86400*mean(pr_295)
p300=86400*mean(pr_300)
p305=86400*mean(pr_305)

pw295=mean(prw_295);
pw300=mean(prw_300);
pw305=mean(prw_305);
olr295=mean(rlut_295);
olr300=mean(rlut_300);
olr305=mean(rlut_305);

mean_array(1,1)=295;
mean_array(2,1)=300;
mean_array(3,1)=305;
mean_array(1,2)=p295;
mean_array(2,2)=p300;
mean_array(3,2)=p305;
mean_array(1,3)=pw295;
mean_array(2,3)=pw300;
mean_array(3,3)=pw305;
mean_array(1,4)=olr295;
mean_array(2,4)=olr300;
mean_array(3,4)=olr305;

% compute subsidence fraction at 500 hPa
% fraction of grid points with subsiding air (positive omega)

tiend=size(omega_305,3);
sub_frac_295=zeros(1,tiend);
sub_frac_300=zeros(1,tiend);
sub_frac_305=zeros(1,tiend);

for ti=1:tiend;
  omega_temp=squeeze(omega_295(:,:,ti));
  sub_omega=zeros(size(omega_temp,1),size(omega_temp,2));
  sub_omega(omega_temp>=0.0)=1.0;
  sub_frac_295(ti)=sum(sum(sub_omega))/(size(omega_temp,1)*size(omega_temp,2));
  clear omega_temp
  %
  omega_temp=squeeze(omega_300(:,:,ti));
  sub_omega=zeros(size(omega_temp,1),size(omega_temp,2));
  sub_omega(omega_temp>=0.0)=1.0;
  sub_frac_300(ti)=sum(sum(sub_omega))/(size(omega_temp,1)*size(omega_temp,2));
  clear omega_temp
  %
  omega_temp=squeeze(omega_305(:,:,ti));
  sub_omega=zeros(size(omega_temp,1),size(omega_temp,2));
  sub_omega(omega_temp>=0.0)=1.0;
  sub_frac_305(ti)=sum(sum(sub_omega))/(size(omega_temp,1)*size(omega_temp,2));
  clear omega_temp
end

tendindex=tiend;

incoming_ts=sub_frac_295;
running_mean_30yr
sub_frac_295_sm=idiotbox;

incoming_ts=sub_frac_300;
running_mean_30yr
sub_frac_300_sm=idiotbox;

incoming_ts=sub_frac_305;
running_mean_30yr
sub_frac_305_sm=idiotbox;





