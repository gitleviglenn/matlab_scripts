%--------------------------------------------------------
% plots figures that are the result of running poisson.m
%
% levi silvers                               jan 2022
%--------------------------------------------------------

%omega_lon_sch=omega_lon(lon1:lon2,:);

walker             =[0.984313725490196, 0.501960784313725, 0.447058823529412];  
hadley             =[0.807843137254902, 0.427450980392157, 0.741176470588235];
totalc             =[0.549019607843137, 0.427450980392157, 0.192156862745098];  

cmap_blue=[255,255,255;                                      
197,255,255;                                                 
138,255,255;                                                 
82,211,255;                                                  
27,153,255;                                                  
0,96,226;
0,41,167;
0,0,110;
0,0,55;
0,0,0];
cmap_dirtorange=[255,255,255;
255,255,200;
255,240,175;
255,225,150;
255,210,125;
255,195,100;
235,180,75;
205,165,50;
185,133,25;
165,91,10];
cmap_blueorange=[10,50,255;
10,100,255;
10,150,255;
27,200,255;
138,250,255;
255,250,138;
255,200,27;
255,150,10;
255,100,10;
255,50,10];
cmap=cmap_blueorange/256;
%colormap(cmap(1:10,:))
%plotm(latitude,longtude,'k')
%gridm

%conts=[-80,-70,-60,-50,-40,-30,-20,-10,0,10,20,30,40,50,60,70,80]; % hPa/day
conts=[-80,-65,-50,-35,-20,-5,5,20,35,50,65,80]; % hPa/day

%------------------------------------------
% define various parameters 
%------------------------------------------
% grab the regional WC used in Schwendike et al., 2014
% in CESM, 30:51 correspond to +5, -35
%
% grab the area (5N:35S) of interest
lat1=30;
lat2=51;
% grab a more traditional definition of tropics: 
lat_tr1=33;
lat_tr2=64;
% grab the area (110E:160E) of interest for the regional HC
lon1=45;
lon2=65;

load coastlines
Lthick=1;

%------------------------------------------
% solve the poisson equation at several timesteps
%------------------------------------------
clear omega_lon_t;
clear omega_lat_t;
clear omega_tot_t;

%timelevel=12; % --> timelevel is used in poisson.m
timelevelend=42; % should grab values from 3months each year for 3 years
specialindex=1;
%for timeindex=6:12:timelevelend
for timeindex=1:12:timelevelend
  timelevel = timeindex;
  poisson % calls the poisson solver
  omega_lon_t(:,:,specialindex)=omega_wc;
  omega_lat_t(:,:,specialindex)=omega_hc;
  omega_tot_t(:,:,specialindex)=omega_total;
  %
  timelevel=timelevel+1;
  specialindex=specialindex+1;
  poisson % calls the poisson solver
  omega_lon_t(:,:,specialindex)=omega_wc;
  omega_lat_t(:,:,specialindex)=omega_hc;
  omega_tot_t(:,:,specialindex)=omega_total;
  %
  timelevel=timelevel+1;
  specialindex=specialindex+1;
  poisson % calls the poisson solver
  omega_lon_t(:,:,specialindex)=omega_wc;
  omega_lat_t(:,:,specialindex)=omega_hc;
  omega_tot_t(:,:,specialindex)=omega_total;
  %timelevel=timelevel+12
  %timelevel=timelevel+1
  specialindex=specialindex+1;
end
%------------------------------------------
% compute time averages
omega_tot_678=squeeze(mean(omega_tot_t,3));
omega_lon_678=squeeze(mean(omega_lon_t,3));
omega_lat_678=squeeze(mean(omega_lat_t,3));

% compute zonal and meridional means of the psi-method results:
omega_lon_678_mm=squeeze(mean(omega_lon_678,2));
omega_lat_678_mm=squeeze(mean(omega_lat_678,1));

%------------------------------------------
%------------------------------------------

omega_tot_zm=squeeze(mean(omega_tot_t,1));
omega_tot_zm_tm=squeeze(mean(omega_tot_zm,2));

% shift the longitudes so that the Pacific is central in figures
longitude=longtude-177.5;

figure
%subplot(3,1,1)
%contourfm(latitude,longtude,squeeze(omega_total'),conts)
caxis=([-80,80]);
contourfm(latitude,longitude,squeeze(omega_tot_678'),conts)
title('Total Overturning motion')
colorbar
cmap=cmap_blueorange/256;
colormap(cmap(1:10,:))

%ylabel('latitude')

figure
%subplot(3,1,2)
%contourf(omega_lon',conts,caxis)
contourfm(latitude,longtude,squeeze(omega_wc'),conts)
title('Overturning motion in the zonal direction: local WC')
colorbar
ylabel('latitude')
figure
%subplot(3,1,3)
%contourf(omega_lat',conts,caxis)
contourfm(latitude,longtude,squeeze(omega_hc'),conts)
title('Overturning motion in the meridional direction: local HC')
colorbar
ylabel('latitude')
xlabel('longitude')

omega_loc_tot_zm=mean(omega_total,1);
omega_loc_lon_zm=mean(omega_wc,1);
omega_loc_lat_zm=mean(omega_hc,1);
omega_loc_tot_mm=mean(omega_total,2);
omega_loc_lon_mm=mean(omega_wc,2);
omega_loc_lat_mm=mean(omega_hc,2);

figure
subplot(2,1,1)
plot(latitude,omega_loc_tot_zm,'color',totalc)
hold on
plot(latitude,omega_loc_lon_zm,'color',walker)
plot(latitude,omega_loc_lat_zm,'color',hadley)
xlim([-90 90])
ylabel('hPa/day')
xlabel('latitude')
title('Zonal Mean of Local Circulations')
%figure
subplot(2,1,2)
plot(longtude,omega_loc_tot_mm,'color',totalc)
hold on
plot(longtude,omega_loc_lon_mm,'color',walker)
plot(longtude,omega_loc_lat_mm,'color',hadley)
xlim([1 360])
ylabel('hPa/day')
xlabel('longitude')
title('Meridional Mean of Local Circulations')

% this creates pdf's of the whole domain, including more than the tropics
% the values near zero tend to dominate in this case.  
figure
bwide=5;
h1=histogram(omega_total);
h1.Normalization = 'probability';
h1.BinWidth = bwide;
hold on
h2=histogram(omega_hc);
h2.BinWidth = bwide;
h2.Normalization = 'probability';
h3=histogram(omega_wc);
h3.Normalization = 'probability';
h3.BinWidth = bwide;

%numberb=100;
%xlim1=-80;
%bwide=1;
%figure
%subplot(3,1,1)
%h1=histogram(omega_tot);
%h1.Normalization = 'probability';
%h1.BinWidth = bwide;
%%h1.NumBins = numberb;
%xlim([xlim1 80])
%subplot(3,1,2)
%h2=histogram(omega_lat);
%h2.Normalization = 'probability';
%h2.BinWidth = bwide;
%%h2.NumBins = numberb;
%xlim([xlim1 80])
%subplot(3,1,3)
%h3=histogram(omega_lon);
%h3.Normalization = 'probability';
%h3.BinWidth = bwide;
%%h3.NumBins = numberb;
%xlim([xlim1 80])

% grab selected areas from the fields calculated in poisson.m:
clear omega_tot_sch_trop;
clear omega_lon_sch_trop;
clear omega_lat_sch_trop;
% grab the area (5N:35S) of interest -> to histogram
omega_tot_sch_trop=omega_tot_t(:,lat1:lat2,:);
omega_lon_sch_trop=omega_lon_t(:,lat1:lat2,:);
omega_lat_sch_trop=omega_lat_t(:,lat1:lat2,:);
% average over latitudes
omega_tot_sch_trop_mn=mean(omega_tot_sch_trop,2);
omega_lon_sch_trop_mn=mean(omega_lon_sch_trop,2);
omega_lat_sch_trop_mn=mean(omega_lat_sch_trop,2);

% grab a more traditional definition of tropics: 
omega_tot_trop=omega_tot_t(:,lat_tr1:lat_tr2,:);
omega_lon_trop=omega_lon_t(:,lat_tr1:lat_tr2,:);
omega_lat_trop=omega_lat_t(:,lat_tr1:lat_tr2,:);

% grab the area (110E:160E; maritime cont: mc) 
% of interest for the regional HC --> to histogram
omega_tot_sch_mc=omega_tot_t(lon1:lon2,:,:);
omega_lat_sch_mc=omega_lat_t(lon1:lon2,:,:);
omega_lon_sch_mc=omega_lon_t(lon1:lon2,:,:);

% grab the values between 30N and 30S:
omega_tot_hc_mc=omega_tot_sch_mc(:,lat_tr1:lat_tr2,:);
omega_lat_hc_mc=omega_lat_sch_mc(:,lat_tr1:lat_tr2,:);
omega_lon_hc_mc=omega_lon_sch_mc(:,lat_tr1:lat_tr2,:);

% calculate the zonal mean
omega_lon_sch_mc_mn=mean(omega_lon_sch_mc,1);
omega_lat_sch_mc_mn=mean(omega_lat_sch_mc,1);
omega_tot_sch_mc_mn=mean(omega_tot_sch_mc,1);
%omega_tot_sch=omega_total(lon1:lon2,:);
%omega_lat_sch=omega_hc(lon1:lon2,:);
%omega_lon_sch=omega_wc(lon1:lon2,:);
%omega_lon_sch_mn=mean(omega_lon_sch,1);
%omega_lat_sch_mn=mean(omega_lat_sch,1);
%omega_tot_sch_mn=mean(omega_tot_sch,1);

%------------------------------------------
% simple, old-fashioned view of defining the HC and WC as the zonal
% mean (HC) and zonally asymmetric (WC) overturning circulations:
% see Vecchi and Soden, 2007 for example
omega_wc_mm=squeeze(mean(omega_tot_trop,2)); 
omega_hc_zm=squeeze(mean(omega_tot_trop,1));

figure
subplot(2,1,1)
%plot(latitude(lat_tr1:lat_tr2),squeeze(mean(omega_hc_zm,2)),'color',hadley);
plot(latitude,omega_tot_zm_tm,'color',hadley);
%hold on
%plot(latitude(lat_tr1:lat_tr2),squeeze(mean(omega_hc_zm,2)),'color',hadley);
%plot(latitude(lat_tr1:lat_tr2),squeeze(mean(omega_hc_zm,2)),'color',hadley);
%xlim([-30 30])
ylabel('hPa/day')
xlabel('latitude')
title('Zonal Mean HC 30N to 30S')
%figure
subplot(2,1,2)
plot(longtude,squeeze(mean(omega_wc_mm,2)),'color',walker);
%hold on
%plot(longtude,squeeze(mean(omega_wc_mm,2)),'color',walker);
%plot(longtude,squeeze(mean(omega_wc_mm,2)),'color',walker);
xlim([1 360])
ylabel('hPa/day')
xlabel('longitude')
title('Meridional Mean WC, 30N:30S')

% compare old and new methods: 
figure
subplot(2,1,1)
plot(latitude,omega_tot_zm_tm,'color',hadley);
hold on
plot(latitude,omega_lat_678_mm,'color',hadley,'LineWidth',1.5);
ylabel('hPa/day')
xlabel('latitude')
title('Hadley Circulations')
subplot(2,1,2)
plot(longtude,squeeze(mean(omega_wc_mm,2)),'color',walker);
hold on
plot(longtude,omega_lon_678_mm,'color',walker,'LineWidth',1.5);
xlim([1 360])
ylabel('hPa/day')
xlabel('longitude')
title('Walker Circulations')
sgtitle('Comparison of Traditional and Psi-method')

%------------------------------------------

%------------------------------------------
% plot the histograms/PDFs of the omega 500
% velocity over particular domains 

% histograms on limited area domain: 
%numberb=100;
xlim1=-80;
xlim2=80;
bwide=3; % this is the width of the bins..
figure
subplot(3,1,1)
h1=histogram(omega_tot_sch_trop);
title('total Circulation')
h1.Normalization = 'probability';
h1.BinWidth = bwide;
title('total Circulation')
ylim([0 0.12])
xlim([xlim1 xlim2])
subplot(3,1,2)
h2=histogram(omega_lon_sch_trop);
title('longitudinal contribution: local WC')
h2.Normalization = 'probability';
h2.BinWidth = bwide;
ylim([0 0.12])
xlim([xlim1 xlim2])
subplot(3,1,3)
h3=histogram(omega_lat_sch_trop);
title('latitudinal contribution: local HC')
h3.Normalization = 'probability';
h3.BinWidth = bwide;
ylim([0 0.12])
xlim([xlim1 xlim2])

% normalize... calculate the area under the curve: bwide*h1.Values
%h1pdf=(h1.Values)./sum(h1.Values);
bwide=2;
omegax1=-120;
omegax2=100;
xaxis=omegax1:bwide:omegax2;
xax=omegax1:bwide:omegax2-bwide;
xaxismp=xax+bwide/2;
figure
o1=histogram(omega_tot_sch_trop,xaxis);
%o1.Normalization = 'probability';
o1.BinWidth = bwide;
o1vals=o1.Values;
tarea=sum(o1vals.*bwide);
o1valsN=o1vals./tarea;
bar(xaxismp,o1valsN); 
%plot(xaxis,o1 / (o1vals*bwide))
%hold on;

o2=histogram(omega_lon_sch_trop,xaxis);
o2.BinWidth = bwide;
o2vals=o2.Values;
tareao2 = sum(o2vals.*bwide);

o3=histogram(omega_lat_sch_trop,xaxis);
o3.BinWidth = bwide;
o3vals=o3.Values;
tareao3 = sum(o3vals.*bwide);

tareao2o3 = tareao2+tareao3;
o2valsN   = o2vals./tareao2o3;
o3valsN   = o3vals./tareao2o3;

figure
bar(xaxismp,o1valsN); 
hold on;
bar(xaxismp,o3valsN); 
bar(xaxismp,o2valsN); 


plot(h1pdf)

figure
subplot(3,1,1)
plot(h1pdf)
title('total Circulation')
h1and2=sum(h1.Values)+sum(h2.Values);
subplot(3,1,2)
h2pdf=(h2.Values)./h1and2;
plot(h2pdf)
title('longitudinal contribution: local WC')
subplot(3,1,3)
h3pdf=(h3.Values)./h1and2;
plot(h3pdf)
title('latitudinal contribution: local HC')

sgtitle('Regional WC: 5N to 35S')

%--------------------------------

% This was my original way of normalizing... probably wrong 
% for the decomposed omega fields.

% I think the correct way to normalize is to devide each value
% not by the sum of the histogram, but by the total area of the
% histogram.  So the size of the bins matters.  

% it could be that the function 'trapz' is helpful in this regard, 
% but since I will have a constant value for binwidth we probably 
% don't need the 'tropz' function.  

numberb=100;
xlim1=-80;
xlim2=80;
bwide=3
figure
subplot(3,1,1)
h1=histogram(omega_tot_sch_trop);
title('total Circulation')
h1.Normalization = 'probability';
h1.BinWidth = bwide;
%h1.NumBins = numberb;
ylim([0 0.12])
xlim([xlim1 xlim2])
subplot(3,1,2)
h2=histogram(omega_lon_sch_trop);
title('longitudinal contribution: local WC')
h2.Normalization = 'probability';
h2.BinWidth = bwide;
%h2.NumBins = numberb;
ylim([0 0.12])
xlim([xlim1 xlim2])
subplot(3,1,3)
h3=histogram(omega_lat_sch_trop);
title('latitudinal contribution: local HC')
h3.Normalization = 'probability';
h3.BinWidth = bwide;
%h3.NumBins = numberb;
ylim([0 0.12])
xlim([xlim1 xlim2])
sgtitle('Regional WC: 5N to 35S')

% histograms over Maritime Continent region: 
figure
subplot(3,1,1)
h1=histogram(omega_tot_hc_mc);
h1.Normalization = 'probability';
h1.BinWidth = bwide;
xlim([xlim1 xlim2])
subplot(3,1,2)
h2=histogram(omega_lon_hc_mc);
h2.Normalization = 'probability';
h2.BinWidth = bwide;
xlim([xlim1 xlim2])
subplot(3,1,3)
h3=histogram(omega_lat_hc_mc);
h3.Normalization = 'probability';
h3.BinWidth = bwide;
xlim([xlim1 xlim2])
sgtitle('Regional HC: 110E to 160E')

% histograms on limited area domain: 
figure
subplot(3,1,1)
h1=histogram(omega_tot_trop);
title('total Circulation')
h1.Normalization = 'probability';
h1.BinWidth = bwide;
ylim([0 0.1])
xlim([xlim1 xlim2])
subplot(3,1,2)
h2=histogram(omega_lon_trop);
title('longitudinal contribution: local WC')
h2.Normalization = 'probability';
h2.BinWidth = bwide;
ylim([0 0.1])
xlim([xlim1 xlim2])
subplot(3,1,3)
h3=histogram(omega_lat_trop);
title('latitudinal contribution: local HC')
h3.Normalization = 'probability';
h3.BinWidth = bwide;
ylim([0 0.1])
xlim([xlim1 xlim2])
%sgtitle('30N to 30S')
sgtitle('Tropics: 30N to 30S: months 6,7,8')
%------------------------------------------
% regional HC and WC used in Schwendike et al., 2014

figure
subplot(2,1,1)
plot(latitude,squeeze(mean(omega_lon_sch_mc_mn,3)),'color',walker);
hold on
plot(latitude,squeeze(mean(omega_lat_sch_mc_mn,3)),'color',hadley);
plot(latitude,squeeze(mean(omega_tot_sch_mc_mn,3)),'k');
xlim([-90 90])
ylabel('hPa/day')
xlabel('latitude')
title('Regional HC over Maritime Continent')
subplot(2,1,2)
plot(longtude,squeeze(mean(omega_lon_sch_trop_mn,3)),'color',walker);
hold on
plot(longtude,squeeze(mean(omega_lat_sch_trop_mn,3)),'color',hadley);
%plot(longtude,omega_lat_sch_trop_mn(:,1,2),'color',hadley);
%plot(longtude,omega_lat_sch_trop_mn(:,1,3),'color',hadley);
plot(longtude,squeeze(mean(omega_tot_sch_trop_mn,3)),'k');
xlim([1 360])
ylabel('hPa/day')
xlabel('longitude')
title('Regional Walker Circulation, 5N:35S')

