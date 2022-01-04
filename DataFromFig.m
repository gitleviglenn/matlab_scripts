%-----------------------------------------------------------------------
% DataFromFig.m
%
% open a figure, save the data from it into arrays and then 
% remake an improved figure
%
% levi silvers                                june, 2021
%-----------------------------------------------------------------------

fig1=openfig('ROSES_greg_fig1.fig');
fig1=gcf;
axObjs=fig1.Children
dataObjs=axObjs.Children


%blah=findobj(fig1,'-property','YData');
%blah(1).YData;
%blah(4).YData;

fig2=openfig('ROSES_greg_fig2.fig');
data_fig2=findobj(fig2,'-property','YData');

omega_xaxis=-67.5:5:67.5;
cfscale=100.;

figure
plot(omega_xaxis,cfscale.*data_fig2(1).YData,'b','LineWidth',2)
hold on
plot(omega_xaxis,cfscale.*data_fig2(2).YData,'-.b','LineWidth',2)
plot(omega_xaxis,cfscale.*data_fig2(3).YData,':b','LineWidth',2)
plot(omega_xaxis,cfscale.*data_fig2(4).YData,'--b','LineWidth',2)
yyaxis right
ylabel('PDF')
ylim([0 0.03])
plot(omega_xaxis,data_fig2(9).YData,'k','LineWidth',2)
yyaxis left
ylabel('cloud fraction (%)')
ylim([0 60])
xlabel('\omega_{500} (hPa/day)','FontName','times');
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)


figure
plot(omega_xaxis,cfscale.*data_fig2(5).YData,'r','LineWidth',2)
hold on
plot(omega_xaxis,cfscale.*data_fig2(6).YData,'-.r','LineWidth',2)
plot(omega_xaxis,cfscale.*data_fig2(7).YData,':r','LineWidth',2)
plot(omega_xaxis,cfscale.*data_fig2(8).YData,'--r','LineWidth',2)
yyaxis right
ylabel('PDF')
ylim([0 0.03])
plot(omega_xaxis,data_fig2(9).YData,'k','LineWidth',2)
yyaxis left
ylabel('cloud fraction (%)')
ylim([0 60])
xlabel('\omega_{500} (hPa/day)','FontName','times');
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)





