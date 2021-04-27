%-------------------------------------------------------------------------
%
% create plots using data and statistics that have been created/opened
% in the scripts: 
% openRCEprofiles.m
% lapser_diff.m
% lapser_diff_driver.m
% surface_fluxes.m
%
% levi silvers                                          april 2021
%-------------------------------------------------------------------------

%figure
%plot(pa.m1a,gamma_m)
%plot(pa.m1a,gamma)
%plot(gamma,pa.m1a)
%set(gca,'Ydir','reverse')
%ylabel('pressure (hPa)')
%xlabel('Lapse Rate')
%set(gca,'FontWeight','bold')
%ylim([100,1000])
%xlim([-10.,0.0])
%hold on
%plot(gamma_m,pa.m1a)

figure
plot(hur.m1a(5:16),pa.m1a(5:16),'Color',c1)
hold on
plot(hur.m2a(5:18),pa.m2a(5:18),'Color',c2)
plot(hur.m4a(5:40),pa.m4a(5:40),'Color','k')  % m4 has91 vertical levels! CNRM
plot(hur.m6a(5:22),pa.m6a(5:22),'Color',c6) % ECHAM 
plot(hur.m8a(42:65),pa.m8a(42:65),'Color',c8) % GOES has 72 levels
plot(hur.m9a(5:28),pa.m9a(5:28),'Color','r')
plot(hur.m12a(5:32),pa.m12a(5:32),'Color','g')
plot(hur.m16a(5:18),pa.m16a(5:18),'Color','b')
plot(hur.m20a(5:14),pa.m20a(5:14),'Color',c20)  % SP CAM
plot(hur.m21a(5:14),pa.m21a(5:14),'Color',c21)  % SPX CAM
plot(hur.m23a(5:42),pa.m23a(5:42),'--','Color','k')


figure
scatter(mLR_a,hrmin_a,[],col,'filled','o','SizeData',70)
fig=gca;
hold on
scatter(mLR_b,hrmin_b,[],col,'filled','o','SizeData',120)
scatter(mLR_c,hrmin_c,[],col,'filled','o','SizeData',170)
fig.FontSize = 14;
fig.FontWeight = 'bold';
xlabel('Lapse Rate, K/km')
ylabel('min RH, %')

% min RH vs. SST
figure
scatter(sst_a,hrmin_a,[],col,'filled','o','SizeData',70)
fig=gca;
hold on
scatter(sst_b,hrmin_b,[],col,'filled','o','SizeData',120)
scatter(sst_c,hrmin_c,[],col,'filled','o','SizeData',170)
fig.FontSize = 14;
fig.FontWeight = 'bold';
xlabel('SST, K')
fig.XTick = [295 300 305]
xlim([294 306])
ylabel('min RH, %')

% calculate the mean BR of the 300K experiments: 
mBR_300K=mean(mBR_b);
% calcualte anomalies relative to mBR_300K;
anomBR_a=mBR_a-mBR_b;
anomBR_b=mBR_b-mBR_b;
anomBR_c=mBR_c-mBR_b;

% Bowen ratio vs. min RH
figure
scatter(mBR_a,hrmin_a,[],col,'filled','o','SizeData',70)
fig=gca;
hold on
scatter(mBR_b,hrmin_b,[],col,'filled','o','SizeData',120)
scatter(mBR_c,hrmin_c,[],col,'filled','o','SizeData',170)
fig.FontSize = 14;
fig.FontWeight = 'bold';
xlabel('Bowen Ratio')
ylabel('min RH, %')

% anomalous BR 
figure
scatter(anomBR_a,hrmin_a-hrmin_b,[],col,'filled','o','SizeData',70)
fig=gca;
hold on
scatter(anomBR_b,hrmin_b-hrmin_b,[],col,'filled','o','SizeData',120)
scatter(anomBR_c,hrmin_c-hrmin_b,[],col,'filled','o','SizeData',170)
fig.FontSize = 14;
xlim([-0.06 0.06])
ylim([-15 15])
fig.FontWeight = 'bold';
xlabel('Bowen Ratio')
ylabel('min RH, %')


figure
scatter(mBR_a,mLR_a,[],col,'filled','o','SizeData',70)
fig=gca;
hold on
scatter(mBR_b,mLR_b,[],col,'filled','o','SizeData',120)
scatter(mBR_c,mLR_c,[],col,'filled','o','SizeData',170)
fig.FontSize = 14;
fig.FontWeight = 'bold';
xlabel('Bowen Ratio')
ylabel('Lapse Rate, K/kM')

% requires surface_fluxes.m to have been run...
figure
scatter(mBR_a,delT_a,[],col,'filled','o','SizeData',70)
fig=gca;
hold on
scatter(mBR_b,delT_b,[],col,'filled','o','SizeData',120)
scatter(mBR_c,delT_c,[],col,'filled','o','SizeData',170)
fig.FontSize = 14;
fig.FontWeight = 'bold';
xlabel('Bowen Ratio')
ylabel('delT, K')

figure
scatter(mBR_a,delq_a,[],col,'filled','o','SizeData',70)
fig=gca;
hold on
scatter(mBR_b,delq_b,[],col,'filled','o','SizeData',120)
scatter(mBR_c,delq_c,[],col,'filled','o','SizeData',170)
fig.FontSize = 14;
fig.FontWeight = 'bold';
xlabel('Bowen Ratio')
ylabel('delq, kg/kg')

% scatter of bowen ratio vs change in temperature
figure
scatter(mBR_a,delT_a./(1000.*delq_a),[],col,'filled','o','SizeData',70)
fig=gca;
hold on
scatter(mBR_b,delT_b./(1000.*delq_b),[],col,'filled','o','SizeData',120)
scatter(mBR_c,delT_c./(1000.*delq_c),[],col,'filled','o','SizeData',170)
fig.FontSize = 14;
fig.FontWeight = 'bold';
xlabel('Bowen Ratio')
ylabel('delT/delq, K kg/kg')

% scatter of sensible heat vs latent heat flux
figure
scatter(mshf_a,mlhf_a,[],col,'filled','o','SizeData',70)
fig=gca;
hold on
scatter(mshf_b,mlhf_b,[],col,'filled','o','SizeData',120)
scatter(mshf_c,mlhf_c,[],col,'filled','o','SizeData',170)
fig.FontSize = 14;
fig.FontWeight = 'bold';
xlabel('sensible heat flux')
ylabel('latent heat flux')


% SHF vs. SST
figure
scatter(sst_a,mshf_a,[],col,'filled','o','SizeData',70)
fig=gca;
hold on
scatter(sst_b,mshf_b,[],col,'filled','o','SizeData',120)
scatter(sst_c,mshf_c,[],col,'filled','o','SizeData',170)
fig.FontSize = 14;
fig.FontWeight = 'bold';
xlabel('SST, K')
fig.XTick = [295 300 305]
xlim([294 306])
ylabel('Sensible Heat Flux, W/m2')

% LHF vs. SST
figure
scatter(sst_a,mlhf_a,[],col,'filled','o','SizeData',70)
fig=gca;
hold on
scatter(sst_b,mlhf_b,[],col,'filled','o','SizeData',120)
scatter(sst_c,mlhf_c,[],col,'filled','o','SizeData',170)
fig.FontSize = 14;
fig.FontWeight = 'bold';
xlabel('SST, K')
fig.XTick = [295 300 305]
xlim([294 306])
ylabel('Latent Heat Flux, W/m2')

% Sfc Enthalpy Flux vs. SST
figure
scatter(hrmin_a,mlhf_a+mshf_a,[],col,'filled','o','SizeData',70)
fig=gca;
hold on
scatter(hrmin_b,mlhf_b+mshf_b,[],col,'filled','o','SizeData',120)
scatter(hrmin_c,mlhf_c+mshf_c,[],col,'filled','o','SizeData',170)
fig.FontSize = 14;
fig.FontWeight = 'bold';
xlabel('min RH, %')
ylabel('Sfc Enthalpy Flux, W/m2')

% Sfc Enthalpy Flux vs. lapse rate 
figure
scatter(mLR_a,mlhf_a+mshf_a,[],col,'filled','o','SizeData',70)
fig=gca;
hold on
scatter(mLR_b,mlhf_b+mshf_b,[],col,'filled','o','SizeData',120)
scatter(mLR_c,mlhf_c+mshf_c,[],col,'filled','o','SizeData',170)
fig.FontSize = 14;
fig.FontWeight = 'bold';
xlabel('Lapse Rate, K/km')
ylabel('Sfc Enthalpy Flux, W/m2')

% Cloud Fraction
% IPSL
figure
plot(cldf.m12a,pa.m12a)
set(gca,'Ydir','reverse')
ylabel('pressure (hPa)')
xlabel('cloud fraction')
set(gca,'FontWeight','bold')
ylim([100,1000])
hold on
plot(cldf.m12b,pa.m12a)
plot(cldf.m12c,pa.m12a)

% CAM5 
figure
plot(cldfr(1).first,pres(1).first)
set(gca,'Ydir','reverse')
ylabel('pressure (hPa)')
xlabel('cloud fraction')
set(gca,'FontWeight','bold')
ylim([100,1000])
hold on
plot(cldfr(1).second,pres(1).first)
plot(cldfr(1).third,pres(1).first)
title('CldFrac CAM5')

% ECHAM
figure
plot(cldfr(6).first,pres(6).first)
set(gca,'Ydir','reverse')
ylabel('pressure (hPa)')
xlabel('cloud fraction')
set(gca,'FontWeight','bold')
ylim([100,1000])
hold on
plot(cldfr(6).second,pres(6).first)
plot(cldfr(6).third,pres(6).first)

% GEOS 
figure
plot(cldfr(8).first,pres(8).first)
set(gca,'Ydir','reverse')
ylabel('pressure (hPa)')
xlabel('cloud fraction')
set(gca,'FontWeight','bold')
ylim([100,1000])
hold on
plot(cldfr(8).second,pres(8).first)
plot(cldfr(8).third,pres(8).first)

% ICON 
figure
plot(cldfr(9).first,pres(9).first)
set(gca,'Ydir','reverse')
ylabel('pressure (hPa)')
xlabel('cloud fraction')
set(gca,'FontWeight','bold')
ylim([100,1000])
hold on
plot(cldfr(9).second,pres(9).first)
plot(cldfr(9).third,pres(9).first)


% Relative humidity
figure
plot(rh(1).first,pres(1).first,'Color',col(1,:),'LineWidth',2)
set(gca,'Ydir','reverse')
hold on
plot(rh(2).first,pres(2).first,'Color',col(2,:),'LineWidth',2)
plot(rh(3).first,pres(3).first,'Color',col(3,:),'LineWidth',2)
plot(rh(4).first,pres(4).first,'Color',col(4,:),'LineWidth',2)
plot(rh(5).first,pres(5).first,'Color',col(5,:),'LineWidth',2)
plot(rh(6).first,pres(6).first,'Color',col(6,:),'LineWidth',2)
plot(rh(7).first,pres(7).first,'Color',col(7,:),'LineWidth',2)
plot(rh(8).first,pres(8).first,'Color',col(8,:),'LineWidth',2)
plot(rh(9).first,pres(9).first,'Color',col(9,:),'LineWidth',2)
plot(rh(10).first,pres(10).first,'Color',col(10,:),'LineWidth',2)
plot(rh(11).first,pres(11).first,'Color',col(11,:),'LineWidth',2)
set(gca,'FontWeight','bold')
ylim([100 1000])

% Relative humidity
figure1=figure;
subplot1=subplot(1,3,1,'Parent',figure1);
hold(subplot1,'on');
plot(rh(1).first,temp(1).first,'Parent',subplot1,'Color',col(1,:),'LineWidth',2)
set(subplot1,'Ydir','reverse')
%hold on
set(subplot1,'FontWeight','bold')
plot(rh(2).first,temp(2).first,'Parent',subplot1,'Color',col(2,:),'LineWidth',2)
plot(rh(3).first,temp(3).first,'Parent',subplot1,'Color',col(3,:),'LineWidth',2)
plot(rh(4).first,temp(4).first,'Parent',subplot1,'Color',col(4,:),'LineWidth',2)
plot(rh(5).first,temp(5).first,'Parent',subplot1,'Color',col(5,:),'LineWidth',2)
plot(rh(6).first,temp(6).first,'Parent',subplot1,'Color',col(6,:),'LineWidth',2)
plot(rh(7).first,temp(7).first,'Parent',subplot1,'Color',col(7,:),'LineWidth',2)
plot(rh(8).first,temp(8).first,'Parent',subplot1,'Color',col(8,:),'LineWidth',2)
plot(rh(9).first,temp(9).first,'Parent',subplot1,'Color',col(9,:),'LineWidth',2)
plot(rh(10).first,temp(10).first,'Parent',subplot1,'Color',col(10,:),'LineWidth',2)
plot(rh(11).first,temp(11).first,'Parent',subplot1,'Color',col(11,:),'LineWidth',2)
set(subplot1,'FontWeight','bold')
ylim(subplot1,[200 305])
xlim(subplot1,[1 100])

subplot2=subplot(1,3,2,'Parent',figure1)
plot(rh(1).second,temp(1).second,'Parent',subplot2,'Color',col(1,:),'LineWidth',2)
hold(subplot2,'on');
set(subplot2,'Ydir','reverse')
plot(rh(2).second,temp(2).second,'Parent',subplot2,'Color',col(2,:),'LineWidth',2)
plot(rh(3).second,temp(3).second,'Parent',subplot2,'Color',col(3,:),'LineWidth',2)
plot(rh(4).second,temp(4).second,'Parent',subplot2,'Color',col(4,:),'LineWidth',2)
plot(rh(5).second,temp(5).second,'Parent',subplot2,'Color',col(5,:),'LineWidth',2)
plot(rh(6).second,temp(6).second,'Parent',subplot2,'Color',col(6,:),'LineWidth',2)
plot(rh(7).second,temp(7).second,'Parent',subplot2,'Color',col(7,:),'LineWidth',2)
plot(rh(8).second,temp(8).second,'Parent',subplot2,'Color',col(8,:),'LineWidth',2)
plot(rh(9).second,temp(9).second,'Parent',subplot2,'Color',col(9,:),'LineWidth',2)
plot(rh(10).second,temp(10).second,'Parent',subplot2,'Color',col(10,:),'LineWidth',2)
plot(rh(11).second,temp(11).second,'Parent',subplot2,'Color',col(11,:),'LineWidth',2)
axis(subplot2,'ij');
set(subplot2,'FontWeight','bold');
ylim(subplot2,[200 305]);
xlim(subplot2,[1 100]);
box(subplot2,'off');

subplot3=subplot(1,3,3,'Parent',figure1);
hold(subplot3,'on');
plot(rh(1).third,temp(1).third,'DisplayName','CAM5','Parent',subplot3,'Color',col(1,:),'LineWidth',2)
set(subplot3,'Ydir','reverse')
plot(rh(2).third,temp(2).third,'DisplayName','CAM6','Parent',subplot3,'Color',col(2,:),'LineWidth',2)
plot(rh(3).third,temp(3).third,'DisplayName','CNRM','Parent',subplot3,'Color',col(3,:),'LineWidth',2)
plot(rh(4).third,temp(4).third,'DisplayName','ECHAM6','Parent',subplot3,'Color',col(4,:),'LineWidth',2)
plot(rh(5).third,temp(5).third,'DisplayName','GEOS','Parent',subplot3,'Color',col(5,:),'LineWidth',2)
plot(rh(6).third,temp(6).third,'DisplayName','ICON','Parent',subplot3,'Color',col(6,:),'LineWidth',2)
plot(rh(7).third,temp(7).third,'DisplayName','IPSL','Parent',subplot3,'Color',col(7,:),'LineWidth',2)
plot(rh(8).third,temp(8).third,'DisplayName','SAM0-UNICON','Parent',subplot3,'Color',col(8,:),'LineWidth',2)
plot(rh(9).third,temp(9).third,'DisplayName','SP-CAM','Parent',subplot3,'Color',col(9,:),'LineWidth',2)
plot(rh(10).third,temp(10).third,'DisplayName','SPX-CAM','Parent',subplot3,'Color',col(10,:),'LineWidth',2)
plot(rh(11).third,temp(11).third,'DisplayName','UKMO-GA7.1','Parent',subplot3,'Color',col(11,:),'LineWidth',2)
axis(subplot3,'ij');
set(subplot3,'FontWeight','bold');
ylim(subplot3,[200 305]);
xlim(subplot3,[1 100]);
legend1=legend(subplot3,'show');
box(legend1,'off');
title(subplot1,'SST=295K')
title(subplot2,'SST=300K')
title(subplot3,'SST=305K')
ylabel(subplot1,'Temperature K')
xlabel(subplot1,'Relative Humidity %')
xlabel(subplot2,'Relative Humidity %')
xlabel(subplot3,'Relative Humidity %')


