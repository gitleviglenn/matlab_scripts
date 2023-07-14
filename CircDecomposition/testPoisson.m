%---------------------------------------------------------
% to be run with poisson.m
%
% levi silvers                                  jul 2023
%---------------------------------------------------------

% a generic test following: 
% https://stackoverflow.com/questions/41376305/how-to-plot-using-surf-gird-in-2d-using-function-value

%figure
%xstart=1;
%ystart=1;
%yend=192;
%xend=288;
%y=latitude(ystart):4*dlat:latitude(yend);
%x=longtude(xstart):4*dlon:longtude(xend);
%[X,Y]=meshgrid(x,y);
%Z=sin(X*(pi/180)).^2+cos(Y*(pi/180)).^2;
%surf(X,Y,Z);
%xlim([0 360])
%ylim([-90 90])
%title('generic test')
%view(2);
%colorbar

% test Legendre polynomials
figure
xstart=1;
ystart=1;
yend=192;
xend=288;
phi=latitude(ystart):4*dlat:latitude(yend);
lamb=longtude(xstart):4*dlon:longtude(xend);
[Lam,Phi]=meshgrid(lamb,phi);
%Z=sin(Phi*(pi/180));
%Z=sin(Phi*(pi/180)).*cos(Lam*(pi/180));
Z=cos(Phi*(pi/180)).*sin(Lam*(pi/180));
surf(Lam,Phi,Z);
xlim([0 360])
ylim([-90 90])
title('Legendre Ps')
view(2);
colorbar

%----------------------------------------------------------------------------------
% generate random arrays to test the poisson solver with
%
% 1. Create an omega field to test: 
% from what I can tell the best functions to use will be either rand(), or randn()

w5size=55296;
w5d2=reshape(w5d,latlon);
latlon=[192,288];
histogram(w5d,50)


test=histogram(w5d,40);
counts=test.Values

testn=w5d./counts;
figure
histogram(testn,40)
testn=w5d./sum(counts);

w5e=reshape(w5d,latlon);

% 2. Plot a histogram and contour plot of the omega field that we want to test:

figure
histogram(w5e,40)
figure
contourf(w5e)

% 3. Calculate the decomposition of the test omega field using poisson.m

% 4. Plot the output from poisson.m including histograms and contour plots 
%    of omega_wc, omega_hc, and omega_total

% create histogram plots to test the output of poisson.m
walker             =[0.984313725490196, 0.501960784313725, 0.447058823529412];
hadley             =[0.807843137254902, 0.427450980392157, 0.741176470588235];
totalc             =[0.549019607843137, 0.427450980392157, 0.192156862745098];

inc=5;
bins=-100:inc:100;
binmidv=-97.5:inc:97.5;
%h1=histogram(wap500_pm30,'Normalization','probability','BinEdges',bins);
h1=histogram(omega_tot_sch_trop,'Normalization','probability','BinEdges',bins);
h1val=h1.Values;
h2=histogram(omega_lat_sch_trop,'Normalization','probability','BinEdges',bins);
h2val=h2.Values;
h3=histogram(omega_lon_sch_trop,'Normalization','probability','BinEdges',bins);
h3val=h3.Values;

figure
plot(binmidv',h1val,'Color','k','LineWidth',2)
hold on
plot(binmidv',h2val,'Color',hadley,'LineWidth',2)
plot(binmidv',h3val,'Color',walker,'LineWidth',2)
xlim([xlim1 xlim2])



