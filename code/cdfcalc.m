%% This function calculates a gaussian cummulative distribution function (cdf)
% in terms of an arbitrary unitless variable. In order to generate a random
% number use "randomvalue" function, where mean and standard deviation 
% can be specified

function cdfcalc
% use global cummulative distribution function at discrete points (cdf)
global cdf
% xvalues for normalized cdf in terms of unitless variable
global xval

%generate xvalues (use maximally 5times the maximal value
xval=-5:0.0001:5;

%calculate the non normalized distribution function
f=exp(-xval.^2);

%calculate the cummulative distribution function
cdf=f;
for i=2:length(cdf)
    cdf(i)=cdf(i)+cdf(i-1);
end

%normalize the cdf
cdf=cdf/cdf(end);
