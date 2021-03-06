%function out_var=global_wmean(fieldin,vlon,vlat)
%------------------------------------------------------------
% computes the latitude weighted global mean value of 
% the 'fullfield' variable
%
% for some reason I am having problems getting the functional
% for of this to work which would have 'out_var' as the 
% output of the function.  it could be an issue with the way 
% that functions work in the 2009 version of matlab or it 
% could be some other pathological behavior of matlab.
%
% gives same answer as glb_mean.ncl
%
% levi silvers                                 dec 2016
%
% e.g. 
% filepath='/archive/Levi.Silvers/awg/warsaw_201710/c96L33_am4p0_cmip6_cosp_ModisISCCP_bugfix2/gfdl.ncrc3-intel-prod-openmp-modisbugfix/pp/atmos_cmip/av/monthly_5yr/atmos_cmip.2005-2009.12.nc'
% fin=netcdf(filepath,'nowrite');
% vlon               = fin{'lon'}(:);
% vlat               = fin{'lat'}(:);
% vtas               = fin{'tas'};  near surface temperature
% fullfield=tas;
% global_wmean_script
%
% filepath='/net2/Levi.Silvers/data/modisdata/MCD08_M3_NC.2008.07.C051.V02.nc'
% ctptau   = fin{'Optical_Thickness_vs_Cloud_Top_Pressure'}(:,:,:,:); %(lat,lon,Cloud_Top_Pressure, Cloud_Optical_Thickness)
%
% if the missing values are something other than NaN's replace them with:
% ctptauNaN(ctptau == -999) = NaN;
%
%------------------------------------------------------------

longit=vlon;
%nlongit=size(longit,1);
latit=vlat;
%nlatit=size(latit,1);
% compute the weights
latitweight=cos(double(pi)/180*latit);
glblatweight=cos(double(pi)/180*latit);
%latitweight=1.*latit;
%glblatweight=1.*latit;
nlongit=length(longit);
for index=1:nlongit-1;
  glblatweight=horzcat(glblatweight,latitweight);
end
%glbsumweight=sum(glblatweight(:));
%
glbsumweight=nansum(glblatweight(:));
%glbsumweight=nlongit*nlatit;

%
%siff=size(fullfield)
%sigl=size(glblatweight)
wgt_var       = fullfield.*glblatweight;

% wgt_mean is the cosine weighted global mean value of fullfield
%out_var = sum(wgt_var(:))/glbsumweight
wgt_mean = nansum(wgt_var(:))/glbsumweight;



