% The rows of correlation coefficients correspond to the following models, starting 
% with the first row
%
% GCMs: General Circulation Models
% Row in correlationCs                                          # in col34
%    1                      "CAM5"                                 1
%    2                      "CAM6"                                 2
%    3                      "CNRM"                                 4
%    4                      "ECHAM"                                6
%    5                      "GEOS"                                 8
%    6                      "ICON"                                 9
%    7                      "SAM0-UNICON"                          16
%    8                      "SP-CAM"                               20
%    9                      "SPX-CAM"                              21
%    10                     "UKMO-GA7.1"                           23
%
% CRMs: Cloud Resolving Models
%    11                     "SAM-CRM"                              17
%    12                     "SCALE-CRM"                            19
%    13                     "ICON_LEM-CRM"                         10
%    14                     "ICON_NWP-CRM"                         11
%    15                     "UCLA-CRM"                             22
%    16                     "WRF-CRM"                              28
%    17                     "MESONH"                               13
%    18                     "WRF_COL_CRM"                          27
%    19                     "UKMOi_CASIM"                          24
%    20                     "UKMOi-vn11.0-RA1-T"                   25
%    21                     "UKMOi-vn11.0-RA1-T-nocloud"           26
%
% colors are taken from the array col34

GCM_I    =[CircSF295.I CircSF300.I CircSF305.I]
GCM_om   =[CircSF295.omega_db CircSF300.omega_db CircSF305.omega_db]
GCM_omup =[-CircSF295.omega_up -CircSF300.omega_up -CircSF305.omega_up]
GCM_omdn =[CircSF295.omega_dn CircSF300.omega_dn CircSF305.omega_dn]

GCM_index=[1 2 3 4 5 6 7 8 9 10];
CRM_index=[1 2 3 4 5 6 7 8 9 10 11];

CRM_I    =[Circ_omega_CRMs_295.I Circ_omega_CRMs_300.I Circ_omega_CRMs_305.I];
CRM_om   =[-Circ_omega_CRMs_295.omega_db -Circ_omega_CRMs_300.omega_db -Circ_omega_CRMs_305.omega_db];
CRM_omup =[Circ_omega_CRMs_295.omega_up Circ_omega_CRMs_300.omega_up Circ_omega_CRMs_305.omega_up];
CRM_omdn =[-Circ_omega_CRMs_295.omega_dn -Circ_omega_CRMs_300.omega_dn -Circ_omega_CRMs_305.omega_dn];

for mi=1:10;
  tempvar=corrcoef(GCM_I(GCM_index(mi),:),GCM_om(GCM_index(mi),:));
  GCM_Ivom(mi)=tempvar(2,1);
  tempvar=corrcoef(GCM_I(GCM_index(mi),:),GCM_omup(GCM_index(mi),:));
  GCM_Ivomup(mi)=tempvar(2,1);
  tempvar=corrcoef(GCM_I(GCM_index(mi),:),GCM_omdn(GCM_index(mi),:));
  GCM_Ivomdn(mi)=tempvar(2,1);
end

% calculate correlations with I
for mi=1:11;
  tempvar=corrcoef(CRM_I(CRM_index(mi),:),CRM_om(CRM_index(mi),:));
  CRM_Ivom(mi)=tempvar(2,1);
  tempvar=corrcoef(CRM_I(CRM_index(mi),:),CRM_omup(CRM_index(mi),:));
  CRM_Ivomup(mi)=tempvar(2,1);
  tempvar=corrcoef(CRM_I(CRM_index(mi),:),CRM_omdn(CRM_index(mi),:));
  CRM_Ivomdn(mi)=tempvar(2,1);
end

% calculate correlations with and among omega's
for mi=1:11;
  tempvar=corrcoef(CRM_om(CRM_index(mi),:),CRM_omup(CRM_index(mi),:));
  CRM_omvomup(mi)=tempvar(2,1);
  tempvar=corrcoef(CRM_om(CRM_index(mi),:),CRM_omdn(CRM_index(mi),:));
  CRM_omvomdn(mi)=tempvar(2,1);
end
for mi=1:10;
  tempvar=corrcoef(GCM_om(GCM_index(mi),:),GCM_omup(GCM_index(mi),:));
  GCM_omvomup(mi)=tempvar(2,1);
  tempvar=corrcoef(GCM_om(GCM_index(mi),:),GCM_omdn(GCM_index(mi),:));
  GCM_omvomdn(mi)=tempvar(2,1);
end

% nullify the values of omega_d from models that do not have clear sky fluxes
% so far that is 4 models, ECHAM, ICON-GCM, WRF-CRM, and WRF-COL-CRM
%CircSF295.model % 4,6
%Circ_omega_CRMs_295.model % 6,8,

% nullify the 3, 4, and 5 entries

GCM_corrs=[GCM_Ivomup' GCM_Ivomdn' GCM_Ivom' GCM_omvomup' GCM_omvomdn'];
CRM_corrs=[CRM_Ivomup' CRM_Ivomdn' CRM_Ivom' CRM_omvomup' CRM_omvomdn'];

%ECHAM
GCM_corrs(4,3)=NaN;
GCM_corrs(4,4)=NaN;
GCM_corrs(4,5)=NaN;
% ICON GCM
GCM_corrs(6,3)=NaN;
GCM_corrs(6,4)=NaN;
GCM_corrs(6,5)=NaN;
% WRF-CRM
CRM_corrs(6,3)=NaN;
CRM_corrs(6,4)=NaN;
CRM_corrs(6,5)=NaN;
% WRF-COL-CRM
CRM_corrs(8,3)=NaN;
CRM_corrs(8,4)=NaN;
CRM_corrs(8,5)=NaN;


correlationCs=[GCM_corrs' CRM_corrs'];

% calculate the mean of the correlations across the multi-model ensemble
meanCorr=nanmean(correlationCs,2);
% r^2 values: 
r2corr=correlationCs.^2;

% what is the range of mean values?
mn_gcm_I=mean(GCM_I,2);
mn_crm_I=mean(CRM_I,2);
mn_I=[mn_gcm_I' mn_crm_I'];
min_mn_I=min(mn_I)
max_mn_I=max(mn_I)

figure
scatter(modelnumber,correlationCs(1,:),[],col34(messy_num,:),'filled','^','SizeData',100)
hold on
scatter(modelnumber-0.2,correlationCs(2,:),[],col34(messy_num,:),'filled','v','SizeData',100)
scatter(modelnumber+0.2,correlationCs(3,:),[],col34(messy_num,:),'filled','>','SizeData',100)
scatter(modelnumber-0.4,correlationCs(4,:),[],col34(messy_num,:),'*','SizeData',100)
scatter(modelnumber+0.4,correlationCs(5,:),[],col34(messy_num,:),'filled','p','SizeData',100)
xlim([0 22])
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)
ylabel('Correlation Coefficient')
xlabel('Model Number (GCMs: 1-10), (CRMs: 11-21)')

figure
scatter(modelnumber,correlationCs(1,:),[],col34(messy_num,:),'filled','^','SizeData',100)
hold on
scatter(modelnumber,correlationCs(2,:),[],col34(messy_num,:),'filled','v','SizeData',100)
scatter(modelnumber,correlationCs(3,:),[],col34(messy_num,:),'filled','>','SizeData',100)
scatter(modelnumber,correlationCs(4,:),[],col34(messy_num,:),'*','LineWidth',2,'SizeData',100)
scatter(modelnumber,correlationCs(5,:),[],col34(messy_num,:),'filled','p','SizeData',140)
xlim([0 22])
set(gca,'FontWeight','bold')
set(gca,'FontSize',14)
ylabel('Correlation Coefficient')
xlabel('Model Number (GCMs: 1-10), (CRMs: 11-21)')



