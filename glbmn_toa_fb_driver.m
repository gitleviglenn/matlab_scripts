model_generation='CAM6';

source='/Users/silvers/data/CAM/';

ts_length=26257;
equilt   =2400; % 50 days for hourly output
cess_eq=zeros(4,ts_length-equilt);

source_mod=strcat(source,model_generation,'_GCM_RCE/');
exp_string=strcat(model_generation,'_GCM_RCE_large295_0D_'); 
glbmn_toa_fb
rad_295_array=rad_ts_array;

exp_string=strcat(model_generation,'_GCM_RCE_large300_0D_'); 
glbmn_toa_fb
rad_300_array=rad_ts_array;

exp_string=strcat(model_generation,'_GCM_RCE_large305_0D_'); 
glbmn_toa_fb
rad_305_array=rad_ts_array;

% compute a Cess-style sensitivity
cess_a=zeros(5,ts_length);
cess_b=zeros(5,ts_length);
cess_a=-(3.7*5)./(rad_300_array-rad_295_array);
cess_b=-(3.7*5)./(rad_305_array-rad_300_array);

% comppute the mean equilibrated(neglect 50 days) Cess sensitivity 
cess_eq(3,:)=cess_a(1,equilt+1:ts_length);
cess_eq(4,:)=cess_b(1,equilt+1:ts_length);

figure
subplot(3,1,1)
plot(rad_295_array(3,:),'LineWidth',2);
hold on
ylabel('W/m2')
plot(rad_300_array(3,:));
plot(rad_305_array(3,:));
title('TOA CRE')
subplot(3,1,2)
plot(rad_295_array(1,:),'LineWidth',2);
hold on
ylabel('W/m2')
plot(rad_300_array(1,:));
plot(rad_305_array(1,:));
title('TOA R')
subplot(3,1,3)
plot(cess_a(1,:));
ylim([0 3])
hold on
ylabel('K')
plot(cess_b(1,:));
title('Cess Sensitivity CAM6')

%figure
%plot(cess_a(1,1:2400))
%hold on
%ylim([-7 0])
%plot(cess_b(1,1:2400),'k')
%title('Cess Sensitivity CAM6 over first 100 days')


model_generation='CAM5';

source_mod=strcat(source,model_generation,'_GCM_RCE/');
exp_string=strcat(model_generation,'_GCM_RCE_large295_0D_'); 
glbmn_toa_fb
rad_295_array=rad_ts_array;

exp_string=strcat(model_generation,'_GCM_RCE_large300_0D_'); 
glbmn_toa_fb
rad_300_array=rad_ts_array;

exp_string=strcat(model_generation,'_GCM_RCE_large305_0D_'); 
glbmn_toa_fb
rad_305_array=rad_ts_array;

% compute a Cess-style sensitivity
cess_a=zeros(5,ts_length);
cess_b=zeros(5,ts_length);
cess_a=-(3.7*5)./(rad_300_array-rad_295_array);
cess_b=-(3.7*5)./(rad_305_array-rad_300_array);

% comppute the mean equilibrated(neglect 50 days) Cess sensitivity 
cess_eq(1,:)=cess_a(1,equilt+1:ts_length);
cess_eq(2,:)=cess_b(1,equilt+1:ts_length);

mean_cess=mean(cess_eq,2);

figure
subplot(3,1,1)
plot(rad_295_array(3,:),'LineWidth',2);
hold on
plot(rad_300_array(3,:),'LineWidth',2);
plot(rad_305_array(3,:));
title('TOA CRE')
ylabel('W/m2')
subplot(3,1,2)
plot(rad_295_array(1,:),'LineWidth',2);
hold on
plot(rad_300_array(1,:),'LineWidth',2);
plot(rad_305_array(1,:));
ylabel('W/m2')
title('TOA R')
subplot(3,1,3)
plot(cess_a(1,:));
hold on
ylim([0 3])
plot(cess_b(1,:));
ylabel('K')
title('Cess Sensitivity CAM5')

%figure
%plot(cess_a(1,1:2400))
%ylim([-7 0])
%hold on
%plot(cess_b(1,1:2400),'k')
%title('Cess Sensitivity CAM5 over first 100 days')

mean_cess

