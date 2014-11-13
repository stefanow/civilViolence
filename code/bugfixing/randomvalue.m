%% This function generates a random value distributed according to a cdf

function [val]=randomvalue(mean,std)
%load cdf and corresponding xvalues
global cdf
global xval

%generate random number in (0,1)
iy=rand(1);

%set initial position to 0
posy=0;

%loop over all xvalues and find position in cdf where iy lies in between
for i=1:length(cdf)
    if (iy>cdf(i)) 
        posy=i;
    end
end

%calculate gradient of the cdf
m=(cdf(posy+1)-cdf(posy))/(xval(posy+1)-xval(posy));

%calculate inverse xvalue for the random number
val=(iy-cdf(posy))/m+xval(posy);

%adjust value for the standarddeviation and mean
val=val*std*sqrt(2);
val=val+mean;