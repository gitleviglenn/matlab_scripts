%--------------------------------------------------------------------
% make a scatter plot of the RH min and the diabatically driven omega
%
% levi silvers                                        feb 2021
%--------------------------------------------------------------------

rh_min=[42.5,35.8,30.3,48.2,39.9,36.8];
omega_d2=[38.0,27.3,21.5,41.8,32.8,21.9];

figure
scatter(rh_min,omega_d2,'filled','SizeData',100)
%scatter(rh_min,omega_d2,'MarkerFaceColor',[0.4940 0.1840 0.5560],[0.4940 0.1840 0.5560],[0.4940 0.1840 0.5560],[0.8500 0.3250 0.0980],[0.8500 0.3250 0.0980],[0.8500 0.3250 0.0980],'SizeData',100)
xlabel('min RH')
ylabel('diabatic omega')

